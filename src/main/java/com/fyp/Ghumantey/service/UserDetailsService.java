package com.fyp.Ghumantey.service;

import java.util.List;

import com.fyp.Ghumantey.entity.UserDetails;
public interface UserDetailsService {
 public void saveUser(UserDetails userDetails);
 public UserDetails getUserById(int id);
 public UserDetails getUserEmail(String email);
 public UserDetails getUserNumber(long number);
 public UserDetails getUserByUsername(String username);	
 public void updateUser(UserDetails userDetails);
 public void deletUser(UserDetails userDetails);
 
 void deleteUser(UserDetails userDetails);


	UserDetails getUserByEmail(String email);


	List<UserDetails> getAllUsers();


	UserDetails getUserByNumber(long number);

 
}
