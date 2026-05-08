package com.fyp.Ghumantey.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.fyp.Ghumantey.entity.UserRole;

@Repository
public interface UserRoleDao extends JpaRepository<UserRole, Integer> {
}