package com.example.schoolapi.Service;

import com.example.schoolapi.Repository.TextbookRepository;
import com.example.schoolapi.entity.TextbookEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TextbookService {
    @Autowired
    private TextbookRepository textbookRepository;

    public List<TextbookEntity> getAllTextbooks() {
        return textbookRepository.findAll();
    }

    public Optional<TextbookEntity> getTextbookById(Long id) {
        return textbookRepository.findById(id);
    }

    public TextbookEntity createTextbook(TextbookEntity textbook) {
        return textbookRepository.save(textbook);
    }

    public void deleteTextbook(Long id) {
        textbookRepository.deleteById(id);
    }

    public TextbookEntity updateTextbook(Long id, TextbookEntity textbookDetails) {
        TextbookEntity textbook = textbookRepository.findById(id).orElseThrow(() -> new RuntimeException("Textbook not found"));
        textbook.setClassName(textbookDetails.getClassName());
        textbook.setSubjectName(textbookDetails.getSubjectName());
        textbook.setPdfFile(textbookDetails.getPdfFile());

        return textbookRepository.save(textbook);
    }
}
