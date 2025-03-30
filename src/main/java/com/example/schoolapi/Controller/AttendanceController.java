package com.example.schoolapi.Controller;

import com.example.schoolapi.Repository.AttendanceRepository;
import com.example.schoolapi.Service.EmailService;
import com.example.schoolapi.entity.AttendanceEntiry;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@RestController
@RequestMapping("/attendance")
public class AttendanceController {

    @Autowired
    private AttendanceRepository attendanceRepository;
    private EmailService emailService;
    private String savedCode;
    private long savedExpirationTime;

    // Tạo mã điểm danh
    @PostMapping("/generateCode")
    public ResponseEntity<Map<String, Object>> generateCode() {
        String code = generateRandomCode();
        long expirationTime = System.currentTimeMillis() + 30000;  // 30 giây
        savedCode = code;
        savedExpirationTime = expirationTime;

        Map<String, Object> response = new HashMap<>();
        response.put("code", code);
        response.put("expirationTime", expirationTime);

        return ResponseEntity.ok(response);
    }

    // Kiểm tra mã điểm danh và lưu kết quả
    @PostMapping("/validateCode")
    public ResponseEntity<String> validateCode(@RequestBody Map<String, String> request) {
        String code = request.get("code");
        long currentTime = System.currentTimeMillis();

        if (savedCode != null && savedCode.equals(code) && currentTime <= savedExpirationTime) {
            // Lưu kết quả điểm danh vào cơ sở dữ liệu
            AttendanceEntiry attendance = new AttendanceEntiry();
            attendance.setStudentName(request.get("studentName"));
            attendance.setClassId(Integer.parseInt(request.get("classId")));
            attendance.setPresent(true);
            attendanceRepository.save(attendance);
            return ResponseEntity.ok("Điểm danh thành công");
        } else {
            // Lưu kết quả vắng mặt
            AttendanceEntiry attendance = new AttendanceEntiry();
            attendance.setStudentName(request.get("studentName"));
            attendance.setClassId(Integer.parseInt(request.get("classId")));
            attendance.setPresent(false);
            attendanceRepository.save(attendance);
            emailService.sendAbsenceNotification(request.get("studentName"), "Lớp học " + request.get("classId"), "student-email@example.com");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Mã điểm danh không hợp lệ hoặc hết thời gian");
        }
    }

    private String generateRandomCode() {
        int codeLength = 6;
        StringBuilder code = new StringBuilder();
        for (int i = 0; i < codeLength; i++) {
            code.append((int)(Math.random() * 10));
        }
        return code.toString();
    }
}
