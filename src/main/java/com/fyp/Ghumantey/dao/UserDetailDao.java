package com.fyp.Ghumantey.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.fyp.Ghumantey.entity.UserDetails;

@Repository
public interface UserDetailDao extends JpaRepository<UserDetails, Integer> {

	public UserDetails findByUsername(String username);
	public UserDetails findByNumber(long number);
	public UserDetails findByAddress(String address);
	public UserDetails findByEmail(String email);
	public UserDetails findById(int id);
	
	
	
}
