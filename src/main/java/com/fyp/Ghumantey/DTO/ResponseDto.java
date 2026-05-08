package com.fyp.Ghumantey.DTO;

import java.util.List;
import com.fyp.Ghumantey.entity.Guide;
import com.fyp.Ghumantey.entity.Hotels;

public class ResponseDto {

    private String message;
    private List<Guide> guides;
    private List<Hotels> hotels;

    public ResponseDto() {}

    public ResponseDto(String message, List<Guide> guides, List<Hotels> hotels) {
        this.message = message;
        this.guides = guides;
        this.hotels = hotels;
    }

    public String getMessage() {
        return message;
    }

    public List<Guide> getGuides() {
        return guides;
    }

    public List<Hotels> getHotels() {
        return hotels;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setGuides(List<Guide> guides) {
        this.guides = guides;
    }

    public void setHotels(List<Hotels> hotels) {
        this.hotels = hotels;
    }
}