package com.example.schoolapi.Service;

import com.example.schoolapi.Repository.SubjectRepository;
import com.example.schoolapi.entity.SubjectEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SubjectService {
    @Autowired
    private SubjectRepository subjectRepository;

    public List<SubjectEntity> getAllSubjects() {
        return subjectRepository.findAll();
    }

    public Optional<SubjectEntity> getSubjectById(Long id) {
        return subjectRepository.findById(id);
    }

    public SubjectEntity createSubject(SubjectEntity subject) {
        return subjectRepository.save(subject);
    }

    public void deleteSubject(Long id) {
        subjectRepository.deleteById(id);
    }

    public SubjectEntity updateSubject(Long id, SubjectEntity subjectDetails) {
        SubjectEntity subject = subjectRepository.findById(id).orElseThrow(() -> new RuntimeException("Subject not found"));
        subject.setClassName(subjectDetails.getClassName());
        subject.setSubjectName(subjectDetails.getSubjectName());
        return subjectRepository.save(subject);
    }
}
