package com.ht.services;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.ht.entities.*;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;
import java.util.concurrent.CompletableFuture;

@Service
@Transactional
public class PostService {
    private final Cloudinary cloudinary;
    private final SessionFactory sessionFactory;
    private final NotificationService notificationService;
    private final FriendService friendService;

    @Autowired
    public PostService(Cloudinary cloudinary, SessionFactory sessionFactory, NotificationService notificationService, FriendService friendService) {
        this.cloudinary = cloudinary;
        this.sessionFactory = sessionFactory;
        this.notificationService = notificationService;
        this.friendService = friendService;
    }

    public List<Post> findAllByUserFriends(Long userId) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("""
                    from Post where user.id in (select toUser.id from Friend where fromUser.id = :userId and status = 1)
                    or user.id in (select fromUser.id from Friend where toUser.id = :userId and status = 1)
                    order by createdAt desc
                """);
        query.setParameter("userId", userId);
        return query.list();
    }

    public List<Post> findAllByUserId(Long userId) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("""
                    from Post where user.id = :userId
                    order by createdAt desc
                """);
        query.setParameter("userId", userId);
        return query.list();
    }

    public void like(User authUser, Long postId) throws Exception {
        Session session = sessionFactory.getCurrentSession();

        Query checkLikedQuery = session.createQuery("""
                    select count(*) from Like where user.id = :userId and post.id = :postId
                """);
        checkLikedQuery.setParameter("userId", authUser.getId());
        checkLikedQuery.setParameter("postId", postId);
        Long count = (Long) checkLikedQuery.uniqueResult();

        if (count > 0) {
            throw new Exception("Bạn đã thích bài viết này");
        }

        var post = (Post) session.get(Post.class, postId);

        if (post == null) {
            throw new Exception("Bài viết không tồn tại");
        }

        Like like = new Like();
        like.setUser(authUser);
        like.setPost(post);
        like.setCreatedAt(new Date());

        session.save(like);

        if (!authUser.getId().equals(post.getUser().getId())) {
            CompletableFuture.runAsync(() -> {
                try {
                    notificationService.createPostLikedNotification(post, authUser);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            });
        }
    }

    public void unlike(Long userId, Long postId) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("""
                    delete from Like where user.id = :userId and post.id = :postId
                """);
        query.setParameter("userId", userId);
        query.setParameter("postId", postId);
        query.executeUpdate();
    }

    public Post getPost(Long id) {
        Session session = sessionFactory.getCurrentSession();
        return (Post) session.get(Post.class, id);
    }

    public Comment createComment(User user, Long postId, String content, Long authorId) {
        Session session = sessionFactory.getCurrentSession();
        var comment = new Comment();
        var post = new Post();
        post.setId(postId);
        comment.setUser(user);
        comment.setPost(post);
        comment.setContent(content);
        comment.setCreatedAt(new Date());
        session.save(comment);

        if (authorId.equals(user.getId())) {
            return comment;
        }

        CompletableFuture.runAsync(() -> {
            try {
                notificationService.createCommentCreatedNotification(comment, authorId);
            } catch (Exception e) {
                e.printStackTrace();
            }
        });

        return comment;
    }

    public void deletePost(User authUser, Long id) throws Exception {
        Session session = sessionFactory.getCurrentSession();
        var post = (Post) session.get(Post.class, id);
        if (post.getUser().getId().equals(authUser.getId())) {
            session.delete(post);
        } else {
            throw new Exception("Bạn không có quyền xóa bài viết này");
        }
    }

    public void deleteComment(Long id) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("delete from Comment where id = :id");
        query.setParameter("id", id);
        query.executeUpdate();
    }

    public void editComment(User authUser, Long commentId, String content) throws Exception {
        Session session = sessionFactory.getCurrentSession();
        Comment comment = (Comment) session.get(Comment.class, commentId);
        if (comment.getUser().getId().equals(authUser.getId())) {
            comment.setContent(content);
            session.update(comment);
        } else {
            throw new Exception("Bạn không có quyền chỉnh sửa bình luận này");
        }
    }

    public Post createPost(User authUser, String title, String content, List<PostFile> postFiles) {
        Session session = sessionFactory.getCurrentSession();
        var post = new Post();
        post.setUser(authUser);
        post.setTitle(title);
        post.setContent(content);
        post.setStatus(true);
        post.setCreatedAt(new Date());
        session.save(post);

        for (PostFile postFile : postFiles) {
            postFile.setPost(post);
            session.save(postFile);
        }

        var friends = friendService.findAllByUserId(authUser.getId());
        CompletableFuture.runAsync(() -> {
            try {
                notificationService.createPostCreatedNotification(post, friends);
            } catch (Exception e) {
                e.printStackTrace();
            }
        });

        return post;
    }

    public void editPost(User authUser, Long id, String title, String content, MultipartFile[] files) throws Exception {
        Post post = getPost(id);
        if (!post.getUser().getId().equals(authUser.getId())) {
            throw new Exception("Bạn không có quyền chỉnh sửa bài viết này");
        }

        List<PostFile> filesToBeDeleted = new ArrayList<>();
        List<PostFile> newFiles = new ArrayList<>();

        for (PostFile file : post.getFiles()) {
            if (Arrays.stream(files).noneMatch(f -> Objects.equals(f.getOriginalFilename(), file.getId()))) {
                filesToBeDeleted.add(file);
            }
        }

        for (MultipartFile file : files) {
            if (post.getFiles().stream().noneMatch(f -> Objects.equals(f.getId(), file.getOriginalFilename())) && !file.isEmpty()) {
                boolean isVideo = file.getContentType().contains("video");
                Map videoParams = ObjectUtils.asMap(
                        "folder", "",
                        "resource_type", "video"
                );
                Map uploadResult = cloudinary.uploader().upload(file.getBytes(), isVideo ? videoParams : ObjectUtils.emptyMap());
                String fileUrl = (String) uploadResult.get("url"); // PostFile.fileUrl
                String signature = (String) uploadResult.get("signature"); // PostFile.id
                String resourceType = (String) uploadResult.get("resource_type"); // PostFile.mimeType
                String originalFilename = (String) uploadResult.get("public_id"); // PostFile.fileName
                int fileSize = (int) uploadResult.get("bytes"); // PostFile.fileSize
                PostFile postFile = new PostFile(signature, originalFilename, resourceType, fileSize, fileUrl, null);
                newFiles.add(postFile);
            }
        }

        Session session = sessionFactory.getCurrentSession();
        post.setTitle(title);
        post.setContent(content);
        session.update(post);

        if (!filesToBeDeleted.isEmpty()) {
            session.createQuery("delete from PostFile where id in :ids")
                    .setParameterList("ids", filesToBeDeleted.stream().map(PostFile::getId).toList())
                    .executeUpdate();

            for (PostFile file : filesToBeDeleted) {
                cloudinary.api().deleteResources(Arrays.asList(file.getFileName()), ObjectUtils.asMap("type", "upload", "resource_type", file.getMimeType()));
            }
        }

        for (PostFile file : newFiles) {
            file.setPost(post);
            session.save(file);
        }
    }
}
