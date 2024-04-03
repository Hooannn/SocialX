package com.ht.services;

import com.ht.configs.AppConfig;
import com.ht.entities.User;
import com.ht.enums.UserRole;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;

@Service
public class JwtService {
    private final AppConfig appConfig;

    @Autowired
    public JwtService(AppConfig appConfig) {
        this.appConfig = appConfig;
    }

    private Claims extractAllClaims(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(getSigningKey(appConfig.getAccessSecretKey()))
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    public <T> T extractClaim(String token, Function<Claims, T> claimsResolver) {
        final Claims claims = extractAllClaims(token);
        return claimsResolver.apply(claims);
    }
    private Key getSigningKey(String secretKey) {
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    public String extractSub(String jwt) {
        return extractClaim(jwt, Claims::getSubject);
    }
    public String extractRole(String jwt) {
        return extractClaim(jwt, claims -> claims.get("role")).toString();
    }

    public User extractUser(String jwt) {
        Map<String, Object> userMap = (Map) extractClaim(jwt, claims -> claims.get("user"));
        return new User(
                Long.parseLong(userMap.get("id").toString()),
                userMap.get("email").toString(),
                null,
                userMap.get("first_name").toString(),
                userMap.get("last_name").toString(),
                userMap.get("avatar").toString(),
                null,
                new Date((Long) userMap.get("created_at")),
                userMap.get("date_of_birth") == "" ? null : new Date((Long) userMap.get("date_of_birth")),
                (boolean) userMap.get("sex"),
                userMap.get("address").toString(),
                false,
                UserRole.valueOf(userMap.get("role").toString())
        );
    }

    public String generateAccessToken(User user) {
        Map<String, Object> claims = Map.of(
                "user", Map.of(
                        "avatar", user.getAvatar(),
                        "first_name", user.getFirstName(),
                        "last_name", user.getLastName(),
                        "id", user.getId(),
                        "role", user.getRole(),
                        "address", user.getAddress() == null ? "" : user.getAddress(),
                        "date_of_birth", user.getDateOfBirth() == null ? "" : user.getDateOfBirth(),
                        "sex", user.isSex(),
                        "email", user.getEmail(),
                        "created_at", user.getCreatedAt()
                )
        );
        return buildToken(claims, user.getId().toString(), appConfig.getJwtExpiration(), appConfig.getAccessSecretKey());
    }

    public String generateResetPasswordToken(String email) {
        return buildToken(new HashMap<>(), email, appConfig.getResetPasswordExpiration(), appConfig.getPasswordSecretKey());
    }

    private Date extractExpiration(String token) {
        return extractClaim(token, Claims::getExpiration);
    }

    public boolean isTokenValid(String token) {
        return !isTokenExpired(token);
    }

    private boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }

    private String buildToken(
            Map<String, Object> extraClaims,
            String subject,
            long expiration,
            String secret
    ) {
        return Jwts
                .builder()
                .setClaims(extraClaims)
                .setSubject(subject)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + expiration))
                .signWith(getSigningKey(secret), SignatureAlgorithm.HS256)
                .compact();
    }
}