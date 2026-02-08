package com.fyp.Ghumantey.service;

public interface SecurePayment {
	public String generateSecretMessage(String message, String key);

}
