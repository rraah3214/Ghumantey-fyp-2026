package com.fyp.Ghumantey.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fyp.Ghumantey.dao.UserDetailDao;
import com.fyp.Ghumantey.entity.UserDetails;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserDetailDao userDetailDao;

    @Override
    public void saveUser(UserDetails userDetails) {
        userDetailDao.save(userDetails);
    }

    @Override
    public UserDetails getUserById(int id) {
        return userDetailDao.findById(id);
    }

    @Override
    public UserDetails getUserEmail(String email) {
        return userDetailDao.findByEmail(email);
    }

    @Override
    public UserDetails getUserNumber(long number) {
        return userDetailDao.findByNumber(number);
    }

    @Override
    public UserDetails getUserByUsername(String username) {
        return userDetailDao.findByUsername(username);
    }

    @Override
    public void updateUser(UserDetails userDetails) {
        userDetailDao.save(userDetails); // same as saveUser — JPA auto-updates
    }

    @Override
    public void deletUser(UserDetails userDetails) {
        userDetailDao.delete(userDetails);
    }

    @Override
    public void deleteUser(UserDetails userDetails) {
        userDetailDao.delete(userDetails);
    }

    @Override
    public UserDetails getUserByEmail(String email) {
        return userDetailDao.findByEmail(email);
    }

    @Override
    public List<UserDetails> getAllUsers() {
        return userDetailDao.findAll();
    }

    @Override
    public UserDetails getUserByNumber(long number) {
        return userDetailDao.findByNumber(number);
    }
}
