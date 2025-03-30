package com.example.schoolapi.Controller;

import com.example.schoolapi.Service.FirebaseUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/firebase")
public class FirebaseUserController {
    @Autowired
    private FirebaseUserService firebaseUserService;
    @PostMapping("/syncUsers")
    public String syncUsers() {
        try {
            firebaseUserService.syncUsersToDatabase();
            return "Users synced successfully!";
        } catch (Exception e) {
            return "Error syncing users: " + e.getMessage();
        }
    }
}
