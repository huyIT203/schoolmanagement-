package com.example.schoolapi.Controller;

import com.example.schoolapi.Service.TeacherService;
import com.example.schoolapi.entity.TeacherEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/teachers")
public class TeacherController {
    @Autowired
    private TeacherService teacherService;

    // Lấy danh sách giáo viên
    @GetMapping
    public List<TeacherEntity> getAllTeachers() {
        return teacherService.getAllTeachers();
    }

    // Lấy thông tin giáo viên theo ID
    @GetMapping("/{id}")
    public Optional<TeacherEntity> getTeacherById(@PathVariable Long id) {
        return teacherService.getTeacherById(id);
    }

    // Tạo giáo viên mới
    @PostMapping
    public TeacherEntity createTeacher(@RequestBody TeacherEntity teacher) {
        return teacherService.createTeacher(teacher);
    }

    // Cập nhật thông tin giáo viên
    @PutMapping("/{id}")
    public TeacherEntity updateTeacher(@PathVariable Long id, @RequestBody TeacherEntity teacherDetails) {
        return teacherService.updateTeacher(id, teacherDetails);
    }

    // Xóa giáo viên
    @DeleteMapping("/{id}")
    public void deleteTeacher(@PathVariable Long id) {
        teacherService.deleteTeacher(id);
    }
}
