package com.ht.services;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ht.beans.GoogleUserData;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import org.springframework.stereotype.Service;
import java.io.IOException;

@Service
public class GoogleAuthService {
    private static final String GG_CLIENT_ID = "942381609422-p0eidu7hma345q9irleotbgogub4i9pl.apps.googleusercontent.com";
    private static final String GG_CLIENT_SECRET = "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";
    private static final String GG_REDIRECT_URI = "http://localhost:8081/SocialX/auth/google-auth";
    private static final String GG_GRANT_TYPE = "authorization_code";
    private static final String GG_GET_TOKEN_ENDPOINT = "https://accounts.google.com/o/oauth2/token";
    private static final String GG_GET_USER_INFO_ENDPOINT = "https://www.googleapis.com/oauth2/v1/userinfo";

    public String getAccessToken(String code) throws ClientProtocolException, IOException {
        String response = Request.Post(GG_GET_TOKEN_ENDPOINT)
                .bodyForm(Form.form().add("client_id", GG_CLIENT_ID)
                        .add("client_secret", GG_CLIENT_SECRET)
                        .add("redirect_uri", GG_REDIRECT_URI)
                        .add("code", code)
                        .add("grant_type", GG_GRANT_TYPE).build())
                .execute().returnContent().asString();

        ObjectMapper mapper = new ObjectMapper();
        JsonNode node = mapper.readTree(response).get("access_token");
        return node.textValue();
    }

    public GoogleUserData getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = GG_GET_USER_INFO_ENDPOINT + "?access_token=" + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        ObjectMapper mapper = new ObjectMapper();
        GoogleUserData googleUserData = mapper.readValue(response, GoogleUserData.class);
        return googleUserData;
    }
}
