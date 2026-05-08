package com.fyp.Ghumantey.entity;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "adventure_bookings")
public class AdventureBooking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserDetails user;

    @ManyToOne
    @JoinColumn(name = "adventure_id")
    private Adventure adventure;

    private Double amount;
    private Integer persons;
    private LocalDate bookingDate;
    private String timeSlot; // e.g., "Morning", "Afternoon"

    private String status; // "PENDING", "PAID"
    private String transactionUuid; // Used for eSewa verification

    // Default Constructor
    public AdventureBooking() {}



    public AdventureBooking(Long id, UserDetails user, Adventure adventure, Double amount, Integer persons,
			LocalDate bookingDate, String timeSlot, String status, String transactionUuid) {
		super();
		this.id = id;
		this.user = user;
		this.adventure = adventure;
		this.amount = amount;
		this.persons = persons;
		this.bookingDate = bookingDate;
		this.timeSlot = timeSlot;
		this.status = status;
		this.transactionUuid = transactionUuid;
	}



	// Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public UserDetails getUser() { return user; }
    public void setUser(UserDetails user) { this.user = user; }

    public Adventure getAdventure() { return adventure; }
    public void setAdventure(Adventure adventure) { this.adventure = adventure; }

    public Double getAmount() { return amount; }
    public void setAmount(Double amount) { this.amount = amount; }

    public Integer getPersons() { return persons; }
    public void setPersons(Integer persons) { this.persons = persons; }

    public LocalDate getBookingDate() { return bookingDate; }
    public void setBookingDate(LocalDate bookingDate) { this.bookingDate = bookingDate; }

    public String getTimeSlot() { return timeSlot; }
    public void setTimeSlot(String timeSlot) { this.timeSlot = timeSlot; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getTransactionUuid() { return transactionUuid; }
    public void setTransactionUuid(String transactionUuid) { this.transactionUuid = transactionUuid; }
}