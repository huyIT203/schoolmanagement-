package com.example.schoolapi.Repository;

import com.example.schoolapi.entity.AttendanceEntiry;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;

@Repository
public interface AttendanceRepository extends JpaRepository<AttendanceEntiry, Long> {
    List<AttendanceEntiry> findByClassIdAndAttendanceTimeBetween(Integer classId, Timestamp startTime, Timestamp endTime);
}
