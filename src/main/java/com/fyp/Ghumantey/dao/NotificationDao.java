package com.fyp.Ghumantey.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.fyp.Ghumantey.entity.Notification;
import com.fyp.Ghumantey.entity.UserDetails;

@Repository
public interface NotificationDao extends JpaRepository<Notification, Integer> {

    List<Notification> findByAdminAndSeenFalse(UserDetails admin);
}


