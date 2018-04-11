package com.movie.pojo;

import java.util.List;

public class Member {
	private String member_id;
	private String member_email;
	private String member_pwd;
	private String member_name;
	private String member_phone;
	private String member_money;
	private String member_gender;
	private String member_photo;
	private List<Ticket> tickets;
	
	public Member() {
	}

	
	public List<Ticket> getTickets() {
		return tickets;
	}


	public void setTickets(List<Ticket> tickets) {
		this.tickets = tickets;
	}


	public String getMember_id() {
		return member_id;
	}


	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}


	public String getMember_email() {
		return member_email;
	}


	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}


	public String getMember_pwd() {
		return member_pwd;
	}


	public void setMember_pwd(String member_pwd) {
		this.member_pwd = member_pwd;
	}


	public String getMember_name() {
		return member_name;
	}


	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}


	public String getMember_phone() {
		return member_phone;
	}


	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}


	public String getMember_money() {
		return member_money;
	}


	public void setMember_money(String member_money) {
		this.member_money = member_money;
	}


	public String getMember_gender() {
		return member_gender;
	}


	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}


	public String getMember_photo() {
		return member_photo;
	}


	public void setMember_photo(String member_photo) {
		this.member_photo = member_photo;
	}
	
	
	
	
}
