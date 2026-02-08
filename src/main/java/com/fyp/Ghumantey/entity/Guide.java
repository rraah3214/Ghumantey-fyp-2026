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
@Table(name="Guide_table")
public class Guide implements Serializable {

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

	@Column(name="firstname")
	private String firstname;
	@Column(name="lastname")
	private String lastname;
	@Column(name="email")
	private String email;
	
	@Column(name="address")
	private String address;
	@Column(name="number")
	private long number;
	
	// default constructor
	public Guide() {
		super();
	}

// Parameterize constructor
	public Guide(int id, String firstname, String lastname, String email, String address, long number) {
		super();
		this.id = id;
		this.firstname = firstname;
		this.lastname = lastname;
		this.email = email;
		this.address = address;
		this.number = number;
	}
// Generating getter and setter

	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getFirstname() {
		return firstname;
	}


	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}


	public String getLastame() {
		return lastname;
	}


	public void setLastame( String lastname) {
		this.lastname = lastname;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
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
	
	
	
	
	
}
