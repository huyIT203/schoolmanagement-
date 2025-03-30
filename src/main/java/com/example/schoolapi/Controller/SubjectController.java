package com.example.schoolapi.Controller;

import com.example.schoolapi.Service.SubjectService;
import com.example.schoolapi.entity.SubjectEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/subjects")
public class SubjectController {
    @Autowired
    private SubjectService subjectService;

    // Lấy danh sách tất cả môn học
    @GetMapping
    public List<SubjectEntity> getAllSubjects() {
        return subjectService.getAllSubjects();
    }

    // Lấy thông tin môn học theo ID
    @GetMapping("/{id}")
    public Optional<SubjectEntity> getSubjectById(@PathVariable Long id) {
        return subjectService.getSubjectById(id);
    }

    // Tạo môn học mới
    @PostMapping
    public SubjectEntity createSubject(@RequestBody SubjectEntity subject) {
        return subjectService.createSubject(subject);
    }

    // Cập nhật thông tin môn học
    @PutMapping("/{id}")
    public SubjectEntity updateSubject(@PathVariable Long id, @RequestBody SubjectEntity subjectDetails) {
        return subjectService.updateSubject(id, subjectDetails);
    }

    // Xóa môn học
    @DeleteMapping("/{id}")
    public void deleteSubject(@PathVariable Long id) {
        subjectService.deleteSubject(id);
    }
}
