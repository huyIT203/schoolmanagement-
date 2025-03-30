package com.example.schoolapi.Service;

import com.example.schoolapi.Repository.UserRepository;
import com.example.schoolapi.entity.UserEntity;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.ListUsersPage;
import com.google.firebase.auth.UserRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class FirebaseUserService {
    @Autowired
    private FirebaseAuth firebaseAuth;
    @Autowired
    private UserRepository userRepository;

    public void syncUsersToDatabase() throws Exception {
        List<UserRecord> users = getAllUsers();

        for (UserRecord user : users) {
            UserEntity userEntity = new UserEntity();
            userEntity.setUid(user.getUid());
            userEntity.setEmail(user.getEmail());
            userEntity.setDisplayName(user.getDisplayName());
            userEntity.setPhotoUrl(user.getPhotoUrl());

            // Lưu vào cơ sở dữ liệu
            userRepository.save(userEntity);
        }
    }

    public List<UserRecord> getAllUsers() throws Exception {
        List<UserRecord> users = new ArrayList<>();
        ListUsersPage page = firebaseAuth.listUsers(null);

        while (page != null) {
            for (UserRecord user : page.getValues()) {
                users.add(user); // Thêm người dùng vào danh sách
            }
            if (page.hasNextPage()) {
                page = page.getNextPage();
            } else {
                break;
            }
        }

        return users;
    }
}
