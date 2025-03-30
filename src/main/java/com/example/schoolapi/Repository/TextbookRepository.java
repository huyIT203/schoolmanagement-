package com.example.schoolapi.Repository;

import com.example.schoolapi.entity.TextbookEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TextbookRepository extends JpaRepository<TextbookEntity,Long> {
}
