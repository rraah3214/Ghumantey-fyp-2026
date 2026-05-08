package com.fyp.Ghumantey.entity;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "hotel_bookings")
@Data
public class HotelBooking {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserDetails user;

   @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "hotel_id")
    private Hotels hotels; // Uses your existing Hotel entity

    private LocalDate checkInDate;
    private LocalDate checkOutDate;
    private Double totalAmount;
    private String status; // "PENDING" or "PAID"
    private String transactionUuid;
	public HotelBooking(Long id, UserDetails user, Hotels hotels, LocalDate checkInDate, LocalDate checkOutDate,
			Double totalAmount, String status, String transactionUuid) {
		super();
		this.id = id;
		this.user = user;
		this.hotels = hotels;
		this.checkInDate = checkInDate;
		this.checkOutDate = checkOutDate;
		this.totalAmount = totalAmount;
		this.status = status;
		this.transactionUuid = transactionUuid;
	}
	public HotelBooking() {
		super();
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public UserDetails getUser() {
		return user;
	}
	public void setUser(UserDetails user) {
		this.user = user;
	}
	public Hotels getHotels() {
		return hotels;
	}
	public void setHotels(Hotels hotels) {
		this.hotels = hotels;
	}
	public LocalDate getCheckInDate() {
		return checkInDate;
	}
	public void setCheckInDate(LocalDate checkInDate) {
		this.checkInDate = checkInDate;
	}
	public LocalDate getCheckOutDate() {
		return checkOutDate;
	}
	public void setCheckOutDate(LocalDate checkOutDate) {
		this.checkOutDate = checkOutDate;
	}
	public Double getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(Double totalAmount) {
		this.totalAmount = totalAmount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTransactionUuid() {
		return transactionUuid;
	}
	public void setTransactionUuid(String transactionUuid) {
		this.transactionUuid = transactionUuid;
	}
	public Object getBookingDate() {
		// TODO Auto-generated method stub
		return null;
	}
	public void setBookingDate(LocalDate now) {
		// TODO Auto-generated method stub

	}

 }