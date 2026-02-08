package com.fyp.Ghumantey.service;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.tomcat.util.codec.binary.Base64;

public class SecurePaymentImpl implements SecurePayment {
	@SuppressWarnings({"deprecation"})
	@Override
	public String generateSecretMessage(String message, String key) {
		// TODO Auto-generated method stub
		String hash = null;
		try {
			Mac sha256_HMAC = Mac.getInstance("HmacSHA256");
			 SecretKeySpec secret_key = new SecretKeySpec(key.getBytes(),"HmacSHA256");
			 sha256_HMAC.init(secret_key);
			 hash = Base64.encodeBase64String(sha256_HMAC.doFinal(message.getBytes()));
		} catch(Exception e) {
			e.printStackTrace();
		}
		return hash;
	}

}
