package com.fyp.Ghumantey.DTO;



import java.io.Serializable;

public class PaymentDTO implements Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	private double amount;
	private double tax_amount;
	private double total_amount;
	private String transaction_uuid1;
	private String product_code1;

	private String transaction_uuid;
	private String product_code;
	private double psc;		// product service charge
	private double pdc;		//product delivery charge
	private String success_url;
	private String failure_url;
	private String signed_field_names;
	private String signature;

	public PaymentDTO() {
		super();
	}


	public PaymentDTO(double amount, double tax_amount, double total_amount, String transaction_uuid1,
			String product_code1, String transaction_uuid, String product_code, double psc, double pdc,
			String success_url, String failure_url, String signed_field_names, String signature) {
		super();
		this.amount = amount;
		this.tax_amount = tax_amount;
		this.total_amount = total_amount;
		this.transaction_uuid1 = transaction_uuid1;
		this.product_code1 = product_code1;
		this.transaction_uuid = transaction_uuid;
		this.product_code = product_code;
		this.psc = psc;
		this.pdc = pdc;
		this.success_url = success_url;
		this.failure_url = failure_url;
		this.signed_field_names = signed_field_names;
		this.signature=signature;
	}


	public String getSignature() {
		return signature;
	}


	public void setSignature(String signature) {
		this.signature = signature;
	}


	public double getAmount() {
		return amount;
	}


	public void setAmount(double amount) {
		this.amount =Math.ceil(amount);
	}


	public double getTax_amount() {
		return tax_amount;
	}


	public void setTax_amount(double tax_amount) {
		this.tax_amount = Math.ceil(tax_amount);
	}


	public double getTotal_amount() {
		return total_amount;
	}


	public void setTotal_amount(double total_amount) {
		this.total_amount = Math.ceil(total_amount);
	}


	public String getTransaction_uuid1() {
		return transaction_uuid1;
	}


	public void setTransaction_uuid1(String transaction_uuid1) {
		this.transaction_uuid1 = transaction_uuid1;
	}


	public String getProduct_code1() {
		return product_code1;
	}


	public void setProduct_code1(String product_code1) {
		this.product_code1 = product_code1;
	}


	public String getTransaction_uuid() {
		return transaction_uuid;
	}


	public void setTransaction_uuid(String transaction_uuid) {
		this.transaction_uuid = transaction_uuid;
	}


	public String getProduct_code() {
		return product_code;
	}


	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}


	public double getPsc() {
		return psc;
	}


	public void setPsc(double psc) {
		this.psc =Math.ceil(psc);
	}


	public double getPdc() {
		return pdc;
	}


	public void setPdc(double pdc) {
		this.pdc =Math.ceil(pdc);
	}


	public String getSuccess_url() {
		return success_url;
	}


	public void setSuccess_url(String success_url) {
		this.success_url = success_url;
	}


	public String getFailure_url() {
		return failure_url;
	}


	public void setFailure_url(String failure_url) {
		this.failure_url = failure_url;
	}


	public PaymentDTO(String signature) {
		super();
		this.signature = signature;
	}


	public String getSigned_field_names() {
		return signed_field_names;
	}


	public void setSigned_field_names(String signed_field_names) {
		this.signed_field_names = signed_field_names;
	}


	@Override
	public String toString() {
		return "PaymentDTO [amount=" + amount + ", tax_amount=" + tax_amount + ", total_amount=" + total_amount
				+ ", transaction_uuid1=" + transaction_uuid1 + ", product_code1=" + product_code1
				+ ", transaction_uuid=" + transaction_uuid + ", product_code=" + product_code + ", psc=" + psc
				+ ", pdc=" + pdc + ", success_url=" + success_url + ", failure_url=" + failure_url
				+ ", signed_field_names=" + signed_field_names + ", signature=" + signature + "]";
	}







}

