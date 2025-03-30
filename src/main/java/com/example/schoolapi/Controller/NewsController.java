package com.example.schoolapi.Controller;

import com.example.schoolapi.Repository.NewsRepository;
import com.example.schoolapi.Service.NewsService;
import com.example.schoolapi.entity.NewsEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/news")
public class NewsController {
    @Autowired
    private NewsService newsService;

    @GetMapping
    public List<NewsEntity> getAllNews() {
        return newsService.getAllNews();
    }

    @GetMapping("/{id}")
    public ResponseEntity<NewsEntity> getNewsById(@PathVariable Long id) {
        Optional<NewsEntity> news = newsService.getNewsById(id);
        return news.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<NewsEntity> createNews(@RequestBody NewsEntity news) {
        NewsEntity newNews = newsService.createNews(news);
        return ResponseEntity.status(HttpStatus.CREATED).body(newNews);
    }

    @PutMapping("/{id}")
    public ResponseEntity<NewsEntity> updateNews(@PathVariable Long id, @RequestBody NewsEntity news) {
        NewsEntity updatedNews = newsService.updateNews(id, news);
        return updatedNews != null ? ResponseEntity.ok(updatedNews) : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteNews(@PathVariable Long id) {
        newsService.deleteNews(id);
        return ResponseEntity.noContent().build();
    }
    @DeleteMapping("/all")
    public ResponseEntity<Void> deleteAllNews() {
        newsService.deleteAllNews();
        return ResponseEntity.noContent().build();
    }
}
