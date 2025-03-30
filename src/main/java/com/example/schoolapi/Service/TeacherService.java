package com.example.schoolapi.Service;

import com.example.schoolapi.Repository.TeacherRepository;
import com.example.schoolapi.entity.TeacherEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TeacherService {
    @Autowired
    private TeacherRepository teacherRepository;

    public List<TeacherEntity> getAllTeachers() {
        return teacherRepository.findAll();
    }

    public Optional<TeacherEntity> getTeacherById(Long id) {
        return teacherRepository.findById(id);
    }

    public TeacherEntity createTeacher(TeacherEntity teacher) {
        return teacherRepository.save(teacher);
    }

    public void deleteTeacher(Long id) {
        teacherRepository.deleteById(id);
    }

    public TeacherEntity updateTeacher(Long id, TeacherEntity teacherDetails) {
        TeacherEntity teacher = teacherRepository.findById(id).orElseThrow(() -> new RuntimeException("Teacher not found"));
        teacher.setFullName(teacherDetails.getFullName());
        teacher.setNickname(teacherDetails.getNickname());
        teacher.setClassName(teacherDetails.getClassName());
        teacher.setSection(teacherDetails.getSection());
        teacher.setSubject(teacherDetails.getSubject());
        teacher.setGender(teacherDetails.getGender());
        teacher.setBirthDate(teacherDetails.getBirthDate());
        teacher.setPhoneNumber(teacherDetails.getPhoneNumber());
        teacher.setEmail(teacherDetails.getEmail());
        teacher.setAddress(teacherDetails.getAddress());
        teacher.setCity(teacherDetails.getCity());
        teacher.setGuardianName(teacherDetails.getGuardianName());
        teacher.setGuardianPhone(teacherDetails.getGuardianPhone());
        teacher.setRelationship(teacherDetails.getRelationship());

        return teacherRepository.save(teacher);
    }
}
