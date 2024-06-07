package com.ht.services;

import com.ht.beans.UserWithFriendStatus;
import com.ht.dtos.ChangePasswordDto;
import com.ht.entities.User;
import com.ht.enums.FriendStatus;
import com.ht.utils.SearchResponse;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigInteger;
import java.util.List;
import java.util.Objects;

@Service
@Transactional
public class UserService {
    private final SessionFactory sessionFactory;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserService(SessionFactory sessionFactory, PasswordEncoder passwordEncoder) {
        this.sessionFactory = sessionFactory;
        this.passwordEncoder = passwordEncoder;
    }

    public User getUserById(Long userId) {
        Session session = sessionFactory.getCurrentSession();
        Query getUserQuery = session.createQuery("FROM User WHERE id = :userId AND disabled = 0");
        getUserQuery.setParameter("userId", userId);

        return (User) getUserQuery.uniqueResult();
    }

    public void saveOrUpdateUser(User authUser) {
        Session session = sessionFactory.getCurrentSession();
        Query getUserQuery = session.createQuery("""
                        UPDATE User u
                        SET first_name = :first_name, last_name = :last_name, date_of_birth = :date_of_birth, sex = :sex, address = :address, avatar = :avatar, cover_image = :coverImage
                        WHERE id = :userId
                """);
        getUserQuery.setParameter("first_name", authUser.getFirstName())
                .setParameter("last_name", authUser.getLastName())
                .setParameter("date_of_birth", authUser.getDateOfBirth())
                .setParameter("sex", authUser.isSex())
                .setParameter("address", authUser.getAddress())
                .setParameter("avatar", authUser.getAvatar())
                .setParameter("userId", authUser.getId())
                .setParameter("coverImage", authUser.getCoverImage())
                .executeUpdate();
    }

    public void changePassword(Long id, ChangePasswordDto changePasswordDto) throws Exception {
        User user = getUserById(id);
        if (user == null) {
            throw new Exception("Không tìm thấy người dùng");
        }
        if (!passwordEncoder.matches(changePasswordDto.getCurrentPassword(), user.getPassword())) {
            throw new Exception("Mật khẩu hiện tại không đúng");
        }
        String encodedPassword = passwordEncoder.encode(changePasswordDto.getNewPassword());
        user.setPassword(encodedPassword);
        Session session = sessionFactory.getCurrentSession();
        session.update(user);
    }

    public SearchResponse<UserWithFriendStatus> searchUser(User authUser, String query, int page, int size) {
        Session session = sessionFactory.getCurrentSession();

        if (query.isBlank() || query.isEmpty()) {
            Query getUserQuery = session.createSQLQuery("""
                            select u.*, f.created_at as f_created_at, f.status as f_status, f.to_uid as f_to_uid, f.from_uid as f_from_uid
                            from users u left join friends f on ((f.from_uid = :userId and f.to_uid = u.id) or (f.from_uid = u.id and f.to_uid = :userId))
                            where u.disabled = 0
                    """);
            getUserQuery.setFirstResult((page - 1) * size);
            getUserQuery.setMaxResults(size);
            getUserQuery.setParameter("userId", authUser.getId());

            Query countUserQuery = session.createQuery("""
                            SELECT COUNT(*)
                            FROM User
                            WHERE disabled = 0
                    """);

            return getUserWithFriendStatusSearchResponse(authUser, getUserQuery, countUserQuery);
        } else {
            Query searchUserQuery = session.createSQLQuery("""
                            select u.*, f.created_at as f_created_at, f.status as f_status, f.to_uid as f_to_uid, f.from_uid as f_from_uid
                            from users u left join friends f on ((f.from_uid = :userId and f.to_uid = u.id) or (f.from_uid = u.id and f.to_uid = :userId))
                            where concat(u.first_name, ' ', u.last_name) like :query and u.disabled = 0
                    """);
            searchUserQuery.setParameter("query", "%" + query + "%");
            searchUserQuery.setParameter("userId", authUser.getId());
            searchUserQuery.setFirstResult((page - 1) * size);
            searchUserQuery.setMaxResults(size);

            Query countSearchUserQuery = session.createQuery("""
                            SELECT COUNT(*)
                            FROM User
                            WHERE CONCAT(firstName, ' ', lastName) LIKE :query
                            AND disabled = 0
                    """);
            countSearchUserQuery.setParameter("query", "%" + query + "%");

            return getUserWithFriendStatusSearchResponse(authUser, searchUserQuery, countSearchUserQuery);
        }
    }

    private SearchResponse<UserWithFriendStatus> getUserWithFriendStatusSearchResponse(User authUser, Query query, Query countQuery) {
        var total = (Long) countQuery.uniqueResult();
        var rows = query.list();

        List usersWithFriendStatus = rows.stream().map(row -> {
            Object[] rowArray = (Object[]) row;
            User user = new User();
            user.setId(Long.valueOf(String.valueOf((BigInteger) rowArray[0])));
            user.setAddress((String) rowArray[1]);
            user.setAvatar((String) rowArray[2]);
            user.setFirstName((String) rowArray[7]);
            user.setLastName((String) rowArray[8]);

            FriendStatus status = null;
            if (rowArray[14] == null) {
                status = FriendStatus.NOT_FRIENDS;
            } else {
                boolean friendStatus = (boolean) rowArray[14];
                var sendFrom = Long.valueOf(String.valueOf((BigInteger) rowArray[16]));

                if (friendStatus) {
                    status = FriendStatus.ARE_FRIENDS;
                } else {
                    status = Objects.equals(sendFrom, authUser.getId()) ? FriendStatus.PENDING_SENT_REQUEST : FriendStatus.PENDING_RECEIVED_REQUEST;
                }
            }

            return new UserWithFriendStatus(user, status);
        }).toList();

        return new SearchResponse<>(usersWithFriendStatus, total);
    }
}
