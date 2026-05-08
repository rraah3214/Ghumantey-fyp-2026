package com.fyp.Ghumantey.entity;

import java.io.Serializable;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "notification")
public class Notification implements Serializable {

    /**
	 *
	 */
	private static final long serialVersionUID = 1L;

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String title;

    @Column(length = 500)
    private String message;

    private String type; // HOTEL or GUIDE

    private boolean seen = false;

    private LocalDateTime createdAt;

    @ManyToOne
    @JoinColumn(name = "admin_id")
    private UserDetails admin;

	public Notification() {
		super();
	}

	public Notification(int id, String title, String message, String type, boolean seen, LocalDateTime createdAt,
			UserDetails admin) {
		super();
		this.id = id;
		this.title = title;
		this.message = message;
		this.type = type;
		this.seen = seen;
		this.createdAt = createdAt;
		this.admin = admin;
	}
	 // Getters & Setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public boolean isSeen() {
		return seen;
	}

	public void setSeen(boolean seen) {
		this.seen = seen;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public UserDetails getAdmin() {
		return admin;
	}

	public void setAdmin(UserDetails admin) {
		this.admin = admin;
	}
}
