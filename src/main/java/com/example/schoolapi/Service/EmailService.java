package com.example.schoolapi.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
    @Autowired
    private JavaMailSender emailSender;

    public void sendAbsenceNotification(String studentName, String className, String emailAddress) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(emailAddress);
        message.setSubject("Thông báo vắng mặt lớp học");
        message.setText("Chào " + studentName + ",\n\nBạn đã vắng mặt trong lớp " + className + " hôm nay.");

        emailSender.send(message);
    }
}
