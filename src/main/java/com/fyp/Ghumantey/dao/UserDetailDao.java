package com.fyp.Ghumantey.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.fyp.Ghumantey.entity.UserDetails;


@Repository
public interface UserDetailDao extends JpaRepository<UserDetails, Integer> {

	public UserDetails findByUsername(String username);
	public List<UserDetails> findByNumber(long number);
	public List <UserDetails> findByAddress(String address);
	public UserDetails findByEmail(String email);
	public UserDetails findById(int id);
	public List<UserDetails> findUserDetailsByUserRoleRole(@Param("role") String role);
	UserDetails findByResetToken(String token); // New for Password Reset


}
