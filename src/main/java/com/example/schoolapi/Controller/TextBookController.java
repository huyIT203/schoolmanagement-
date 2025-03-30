package com.example.schoolapi.Controller;

import com.example.schoolapi.Service.TextbookService;
import com.example.schoolapi.entity.TextbookEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/textbooks")
public class TextBookController {
    @Autowired
    private TextbookService textbookService;

    // Lấy danh sách tất cả giáo trình
    @GetMapping
    public List<TextbookEntity> getAllTextbooks() {
        return textbookService.getAllTextbooks();
    }

    // Lấy thông tin giáo trình theo ID
    @GetMapping("/{id}")
    public Optional<TextbookEntity> getTextbookById(@PathVariable Long id) {
        return textbookService.getTextbookById(id);
    }

    // Tạo giáo trình mới (bao gồm tệp PDF)
    @PostMapping
    public ResponseEntity<TextbookEntity> createTextbook(
            @RequestParam String className,
            @RequestParam String subjectName,
            @RequestParam("pdfFile") MultipartFile pdfFile) throws IOException {

        if (pdfFile.getSize() > 200 * 1024 * 1024) {
            return ResponseEntity.badRequest().body(null); // Nếu kích thước tệp quá lớn
        }

        TextbookEntity textbook = new TextbookEntity();
        textbook.setClassName(className);
        textbook.setSubjectName(subjectName);
        textbook.setPdfFile(pdfFile.getBytes());

        TextbookEntity createdTextbook = textbookService.createTextbook(textbook);

        return ResponseEntity.ok(createdTextbook);
    }

    // Cập nhật giáo trình
    @PutMapping("/{id}")
    public TextbookEntity updateTextbook(
            @PathVariable Long id,
            @RequestParam String className,
            @RequestParam String subjectName,
            @RequestParam("pdfFile") MultipartFile pdfFile) throws IOException {

        TextbookEntity textbook = new TextbookEntity();
        textbook.setId(id);
        textbook.setClassName(className);
        textbook.setSubjectName(subjectName);
        textbook.setPdfFile(pdfFile.getBytes());

        return textbookService.updateTextbook(id, textbook);
    }

    // Xóa giáo trình
    @DeleteMapping("/{id}")
    public void deleteTextbook(@PathVariable Long id) {
        textbookService.deleteTextbook(id);
    }
}
