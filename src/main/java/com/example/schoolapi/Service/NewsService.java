package com.example.schoolapi.Service;

import com.example.schoolapi.Repository.NewsRepository;
import com.example.schoolapi.entity.NewsEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class NewsService {
    @Autowired
    private NewsRepository newsRepository;

    public List<NewsEntity> getAllNews() {
        return newsRepository.findAll();
    }

    public Optional<NewsEntity> getNewsById(Long id) {
        return newsRepository.findById(id);
    }

    public NewsEntity createNews(NewsEntity news) {
        return newsRepository.save(news);
    }

    public NewsEntity updateNews(Long id, NewsEntity newsDetails) {
        Optional<NewsEntity> existingNews = newsRepository.findById(id);
        if (existingNews.isPresent()) {
            NewsEntity news = existingNews.get();
            news.setTitle(newsDetails.getTitle());
            news.setContent(newsDetails.getContent());
            news.setAuthor(newsDetails.getAuthor());
            news.setPublishedDate(newsDetails.getPublishedDate());
            news.setImageUrl(newsDetails.getImageUrl());
            return newsRepository.save(news);
        }
        return null;
    }

    public void deleteNews(Long id) {
        newsRepository.deleteById(id);
    }
    public void deleteAllNews() {
        newsRepository.deleteAll();
    }
}
