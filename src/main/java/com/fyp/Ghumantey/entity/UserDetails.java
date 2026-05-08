package com.fyp.Ghumantey.entity;

import java.io.Serializable;
import java.time.LocalDateTime;

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

    private String address;

    @Column(unique = true)
    private long number;

    @Column(unique = true)
    private String email;

    @Column(unique = true)
    private String username;

    private String password;

    private String active;

    // --- FORGOT PASSWORD FIELDS ---
    private String resetToken;
    private LocalDateTime tokenExpiration;

    // --- 2FA FIELDS ---
    private String twoFactorCode;
    private boolean is2faEnabled = false;

    @Transient
    private String authority;

    @Transient
    private String cpassword;

    @OneToOne(mappedBy = "userDetails", cascade = CascadeType.ALL)
    private UserRole userRole;




    public UserDetails(int id, String address, long number, String email, String username, String password,
			String active, String resetToken, LocalDateTime tokenExpiration, String twoFactorCode, boolean is2faEnabled,
			String authority, String cpassword, UserRole userRole) {
		super();
		this.id = id;
		this.address = address;
		this.number = number;
		this.email = email;
		this.username = username;
		this.password = password;
		this.active = active;
		this.resetToken = resetToken;
		this.tokenExpiration = tokenExpiration;
		this.twoFactorCode = twoFactorCode;
		this.is2faEnabled = is2faEnabled;
		this.authority = authority;
		this.cpassword = cpassword;
		this.userRole = userRole;
	}

	public UserDetails() {


    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public long getNumber() { return number; }
    public void setNumber(long number) { this.number = number; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getActive() { return active; }
    public void setActive(String active) { this.active = active; }

    public String getResetToken() { return resetToken; }
    public void setResetToken(String resetToken) { this.resetToken = resetToken; }
    public LocalDateTime getTokenExpiration() { return tokenExpiration; }
    public void setTokenExpiration(LocalDateTime tokenExpiration) { this.tokenExpiration = tokenExpiration; }

    public String getTwoFactorCode() { return twoFactorCode; }
    public void setTwoFactorCode(String twoFactorCode) { this.twoFactorCode = twoFactorCode; }
    public boolean isIs2faEnabled() { return is2faEnabled; }
    public void setIs2faEnabled(boolean is2faEnabled) { this.is2faEnabled = is2faEnabled; }

    public String getAuthority() { return authority; }
    public void setAuthority(String authority) { this.authority = authority; }
    public String getCpassword() { return cpassword; }
    public void setCpassword(String cpassword) { this.cpassword = cpassword; }
    public UserRole getUserRole() { return userRole; }
    public void setUserRole(UserRole userRole) { this.userRole = userRole; }
}