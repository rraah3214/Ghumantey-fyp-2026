package com.fyp.Ghumantey.entity;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="Hotel_Details")
public class Hotels implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	
	
	@Column(name="id")
	private int id;
	
	@OneToOne
	@JoinColumn(name = "user_id", nullable = false)
	private UserDetails user;
	@Column(name="username")
	private String username;
	@Column(name="location")
	private String location;
	@Column(name="discription")
	private String discription;
	@Column(name="ratings")
	private int ratings;
	//Default constructor
	public Hotels() {
		super();
	}
	public Hotels(int id, String username, String location, String discription, int ratings) {
		super();
		this.id = id;
		this.username = username;
		this.location = location;
		this.discription = discription;
		this.ratings = ratings;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getDiscription() {
		return discription;
	}
	public void setDiscription(String discription) {
		this.discription = discription;
	}
	public int getRatings() {
		return ratings;
	}
	public void setRatings(int ratings) {
		this.ratings = ratings;
	}
	
}
