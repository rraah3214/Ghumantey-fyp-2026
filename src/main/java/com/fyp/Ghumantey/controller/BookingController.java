package com.fyp.Ghumantey.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.util.Base64;
import java.util.UUID;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fyp.Ghumantey.DTO.PaymentDTO;
import com.fyp.Ghumantey.entity.Guide;
import com.fyp.Ghumantey.entity.GuideBooking;
import com.fyp.Ghumantey.entity.HotelBooking;
import com.fyp.Ghumantey.entity.Hotels;
import com.fyp.Ghumantey.entity.UserDetails;
import com.fyp.Ghumantey.service.BookingService;
import com.fyp.Ghumantey.service.EsewaService;
import com.fyp.Ghumantey.service.GuideService;
import com.fyp.Ghumantey.service.HotelService;
import com.fyp.Ghumantey.service.UserDetailsService;

@Controller
@RequestMapping("/booking")
public class BookingController {

    @Autowired private BookingService bookingService;
    @Autowired private UserDetailsService userDetailsService;
    @Autowired private GuideService guideService;
    @Autowired private HotelService hotelService;
    @Autowired private EsewaService esewaService;

    // ---------------- GUIDE BOOKING ----------------
    @PostMapping("/initiate-guide")
    public String initiateGuideBooking(
            @RequestParam("guideId") Integer guideId,
            @RequestParam("startDate") String startDate,
            @RequestParam("endDate") String endDate,
            @RequestParam("amount") Double amount,
            Principal principal,
            Model model) {

        UserDetails traveler = userDetailsService.getUserByUsername(principal.getName());
        Guide guide = guideService.getGuideById(guideId);

        GuideBooking booking = new GuideBooking();
        booking.setUser(traveler);
        booking.setGuide(guide);
        booking.setStartDate(LocalDate.parse(startDate));
        booking.setEndDate(LocalDate.parse(endDate));
        booking.setAmount(amount);
        booking.setStatus("PENDING");

        String uuid = UUID.randomUUID().toString();
        booking.setTransactionUuid(uuid);

        bookingService.saveGuideBooking(booking);

        prepareEsewaModel(model, amount, uuid);
        return "e-sewa";
    }

    // ---------------- HOTEL BOOKING ----------------
    @PostMapping("/initiate-hotel")
    public String initiateHotelBooking(
            @RequestParam("hotelId") int hotelId,
            @RequestParam("checkIn") String checkIn,
            @RequestParam("checkOut") String checkOut,
            @RequestParam("totalAmount") Double totalAmount,
            Principal principal,
            Model model) {

        UserDetails traveler = userDetailsService.getUserByUsername(principal.getName());
        Hotels hotel = hotelService.getHotelById(hotelId);

        HotelBooking booking = new HotelBooking();
        booking.setUser(traveler);
        booking.setHotels(hotel);
        booking.setCheckInDate(LocalDate.parse(checkIn));
        booking.setCheckOutDate(LocalDate.parse(checkOut));
        booking.setTotalAmount(totalAmount);
        booking.setStatus("PENDING");

        String uuid = UUID.randomUUID().toString();
        booking.setTransactionUuid(uuid);

        bookingService.saveHotelBooking(booking);

        prepareEsewaModel(model, totalAmount, uuid);
        return "e-sewa";
    }

    // ---------------- ESEWA PREP ----------------
    private void prepareEsewaModel(Model model, Double amount, String uuid) {

        String formattedAmount = String.valueOf(amount.intValue());
        String productCode = "EPAYTEST";

        String signatureData =
                "total_amount=" + formattedAmount +
                ",transaction_uuid=" + uuid +
                ",product_code=" + productCode;

        String signature = esewaService.generateSignature(signatureData);

        PaymentDTO payment = new PaymentDTO();
        payment.setTransaction_uuid(uuid);
        payment.setProduct_code(productCode);
        payment.setSuccess_url("http://localhost:9090/payment-success");
        payment.setFailure_url("http://localhost:9090/payment-failure");
        payment.setSigned_field_names("total_amount,transaction_uuid,product_code");
        payment.setSignature(signature);
        payment.setTotal_amount(amount);

        model.addAttribute("formattedAmount", formattedAmount);
        model.addAttribute("payment", payment);
    }

    

    // ---------------- FAILURE ----------------
    @GetMapping("/payment-failure")
    public String handlePaymentFailure() {
        return "payment-failed";
    }
}