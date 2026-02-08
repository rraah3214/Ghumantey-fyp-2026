package com.fyp.Ghumantey.entity;

import java.io.Serializable;



import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "user_detail_table")
public class UserDetails implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "address")
    private String address;

    @Column(name = "number")
    private long number;

    @Column(name = "email", unique = true)
    private String email;

    @Transient
    private String authority; // "USER" or "ADMIN" selected during signup

    private String active;

    @Column(unique = true)
    private String username;

    private String password;

    @Transient
    private String cpassword;

    // Add one-to-one mapping with UserRole
    @OneToOne(mappedBy = "userDetails", cascade = CascadeType.ALL)
   
    private UserRole userRole;

    // Default constructor
    public UserDetails() {
        super();
    }

    // Parameterized constructor
    public UserDetails(int id, String address, long number, String email, String authority, String active,
                       String username, String password, String cpassword) {
        super();
        this.id = id;
        this.address = address;
        this.number = number;
        this.email = email;
        this.authority = authority;
        this.active = active;
        this.username = username;
        this.password = password;
        this.cpassword = cpassword;
    }

    // Getters and Setters

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public long getNumber() {
        return number;
    }
    public void setNumber(long number) {
        this.number = number;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getAuthority() {
        return authority;
    }
    public void setAuthority(String authority) {
        this.authority = authority;
    }
    public String getActive() {
        return active;
    }
    public void setActive(String active) {
        this.active = active;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getCpassword() {
        return cpassword;
    }
    public void setCpassword(String cpassword) {
        this.cpassword = cpassword;
    }

    public UserRole getUserRole() {
        return userRole;
    }
    public void setUserRole(UserRole userRole) {
        this.userRole = userRole;
    }
}
