package com.example.schoolapi.Service;

import com.example.schoolapi.Repository.StudentRepository;
import com.example.schoolapi.entity.StudentEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StudentService {
    @Autowired
    private StudentRepository studentRepository;

    public List<StudentEntity> getAllStudents() {
        return studentRepository.findAll();
    }

    public Optional<StudentEntity> getStudentById(Long id) {
        return studentRepository.findById(id);
    }

    public StudentEntity createStudent(StudentEntity student) {
        return studentRepository.save(student);
    }

    public void deleteStudent(Long id) {
        studentRepository.deleteById(id);
    }

    public StudentEntity updateStudent(Long id, StudentEntity studentDetails) {
        StudentEntity student = studentRepository.findById(id).orElseThrow(() -> new RuntimeException("Student not found"));
        student.setFullName(studentDetails.getFullName());
        student.setNickname(studentDetails.getNickname());
        student.setBirthDate(studentDetails.getBirthDate());
        student.setGender(studentDetails.getGender());
        student.setClassName(studentDetails.getClassName());
        student.setSection(studentDetails.getSection());
        student.setPhoto(studentDetails.getPhoto());
        student.setPhoneNumber(studentDetails.getPhoneNumber());
        student.setEmail(studentDetails.getEmail());
        student.setAddress(studentDetails.getAddress());
        student.setCity(studentDetails.getCity());
        student.setHometown(studentDetails.getHometown());
        student.setGuardianName(studentDetails.getGuardianName());
        student.setGuardianPhone(studentDetails.getGuardianPhone());
        student.setRelationship(studentDetails.getRelationship());

        return studentRepository.save(student);
    }
}
