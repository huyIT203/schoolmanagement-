package com.example.schoolapi.Controller;

import com.example.schoolapi.Repository.ClassRepository;
import com.example.schoolapi.entity.ClassEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/classes")
public class ClassController {

    @Autowired
    private ClassRepository classRepository;

    @GetMapping
    public List<ClassEntity> getAllClasses() {
        return classRepository.findAll();
    }
    @PostMapping
    public ClassEntity createClass(@RequestBody ClassEntity newClass) {
        return classRepository.save(newClass);
    }
    @PutMapping("/{id}")
    public ClassEntity updateClass(@PathVariable Long id, @RequestBody ClassEntity classDetails) {
        ClassEntity classEntity = classRepository.findById(id).orElseThrow();
        classEntity.setClassName(classDetails.getClassName());
        classEntity.setSubject(classDetails.getSubject());
        classEntity.setTeacher(classDetails.getTeacher());
        classEntity.setSchedule(classDetails.getSchedule());
        classEntity.setRoom(classDetails.getRoom());
        return classRepository.save(classEntity);
    }
    @DeleteMapping("/{id}")
    public String deleteClass(@PathVariable Long id) {
        classRepository.deleteById(id);
        return "Lớp học đã bị xóa";
    }
}
