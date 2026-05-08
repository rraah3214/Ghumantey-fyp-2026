package com.fyp.Ghumantey.entity;

import java.time.LocalDate;
import java.time.LocalTime;

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
@Table(name = "guide_bookings")
@Data
public class GuideBooking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private UserDetails user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "guide_id", nullable = false)
    private Guide guide;

    private LocalDate bookingDate; // Date when the booking was made

    // NEW: Travel Duration
    private LocalDate startDate;
    private LocalDate endDate;

    // NEW: Logistics Details
    private String location;     // Guide's base location at time of booking
    private String meetingPoint;  // Specific pickup location (e.g., Hotel Name)
    private LocalTime meetingTime;

    private Double amount;
    private String status; // e.g., "PENDING", "PAID", "APPROVED", "REJECTED"
    private String transactionUuid;

    // Standard Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public UserDetails getUser() { return user; }
    public void setUser(UserDetails user) { this.user = user; }

    public Guide getGuide() { return guide; }
    public void setGuide(Guide guide) { this.guide = guide; }

    public LocalDate getBookingDate() { return bookingDate; }
    public void setBookingDate(LocalDate bookingDate) { this.bookingDate = bookingDate; }

    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }

    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getMeetingPoint() { return meetingPoint; }
    public void setMeetingPoint(String meetingPoint) { this.meetingPoint = meetingPoint; }

    public LocalTime getMeetingTime() { return meetingTime; }
    public void setMeetingTime(LocalTime meetingTime) { this.meetingTime = meetingTime; }

    public Double getAmount() { return amount; }
    public void setAmount(Double amount) { this.amount = amount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getTransactionUuid() { return transactionUuid; }
    public void setTransactionUuid(String transactionUuid) { this.transactionUuid = transactionUuid; }

    // Updated Constructor
    public GuideBooking(Long id, UserDetails user, Guide guide, LocalDate bookingDate, LocalDate startDate,
                        LocalDate endDate, String location, String meetingPoint, LocalTime meetingTime,
                        Double amount, String status, String transactionUuid) {
        this.id = id;
        this.user = user;
        this.guide = guide;
        this.bookingDate = bookingDate;
        this.startDate = startDate;
        this.endDate = endDate;
        this.location = location;
        this.meetingPoint = meetingPoint;
        this.meetingTime = meetingTime;
        this.amount = amount;
        this.status = status;
        this.transactionUuid = transactionUuid;
    }

    public GuideBooking() {
        super();
    }
}