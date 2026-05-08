package com.fyp.Ghumantey.entity;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "guide_table")
public class Guide implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    // CRITICAL: Added @JsonIgnore to prevent infinite recursion during JSON serialization
    @JsonIgnore
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private UserDetails userDetails;

    private String firstname;
    private String lastname;
    private String email;
    private String address;
    private Long number;

    @Column(name = "notifications", columnDefinition = "TEXT")
    private String notifications;

    @Column(nullable = false)
    private String status;   // PENDING / APPROVED / REJECTED

    private Double price;

    @Column(name = "license_no")
    private String licenseNo;

    @Column(name = "photo")
    private String photo;

    public Guide() {}

    public Guide(UserDetails userDetails, String firstname, String lastname, String email,
                 String address, Long number, String status, Double price,
                 String notifications, String licenseNo, String photo) {
        this.userDetails = userDetails;
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
        this.address = address;
        this.number = number;
        this.status = status;
        this.price = price;
        this.notifications = notifications;
        this.licenseNo = licenseNo;
        this.photo = photo;
    }

    // Getters and Setters
    public Integer getId() { return id; }

    public UserDetails getUserDetails() { return userDetails; }
    public void setUserDetails(UserDetails userDetails) { this.userDetails = userDetails; }

    public String getFirstname() { return firstname; }
    public void setFirstname(String firstname) { this.firstname = firstname; }

    public String getLastname() { return lastname; }
    public void setLastname(String lastname) { this.lastname = lastname; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public Long getNumber() { return number; }
    public void setNumber(Long number) { this.number = number; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public String getNotifications() { return notifications; }
    public void setNotifications(String notifications) { this.notifications = notifications; }

    public String getLicenseNo() { return licenseNo; }
    public void setLicenseNo(String licenseNo) { this.licenseNo = licenseNo; }

    public String getPhoto() { return photo; }
    public void setPhoto(String photo) { this.photo = photo; }
}