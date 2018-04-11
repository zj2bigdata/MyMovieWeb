package com.ssma.movie.pojo;

public class Ticket {
	private String ticket_Id;
	private String ticket_Play;
	private String ticket_Member;
	private String ticket_Code;
	private String ticket_Seat;
	private String ticket_Price;
	private String ticket_Date;
	private String ticket_Flag;
	public String getTicket_Id() {
		return ticket_Id;
	}
	public void setTicket_Id(String ticket_Id) {
		this.ticket_Id = ticket_Id;
	}
	public String getTicket_Play() {
		return ticket_Play;
	}
	public void setTicket_Play(String ticket_Play) {
		this.ticket_Play = ticket_Play;
	}
	public String getTicket_Member() {
		return ticket_Member;
	}
	public void setTicket_Member(String ticket_Member) {
		this.ticket_Member = ticket_Member;
	}
	public String getTicket_Code() {
		return ticket_Code;
	}
	public void setTicket_Code(String ticket_Code) {
		this.ticket_Code = ticket_Code;
	}
	public String getTicket_Seat() {
		return ticket_Seat;
	}
	public void setTicket_Seat(String ticket_Seat) {
		this.ticket_Seat = ticket_Seat;
	}
	public String getTicket_Price() {
		return ticket_Price;
	}
	public void setTicket_Price(String ticket_Price) {
		this.ticket_Price = ticket_Price;
	}
	public String getTicket_Date() {
		return ticket_Date;
	}
	public void setTicket_Date(String ticket_Date) {
		this.ticket_Date = ticket_Date;
	}
	public String getTicket_Flag() {
		return ticket_Flag;
	}
	public void setTicket_Flag(String ticket_Flag) {
		this.ticket_Flag = ticket_Flag;
	}
	@Override
	public String toString() {
		return "Ticket [ticket_Id=" + ticket_Id + ", ticket_Play=" + ticket_Play + ", ticket_Member=" + ticket_Member
				+ ", ticket_Code=" + ticket_Code + ", ticket_Seat=" + ticket_Seat + ", ticket_Price=" + ticket_Price
				+ ", ticket_Date=" + ticket_Date + ", ticket_Flag=" + ticket_Flag + "]";
	}
	
		
	
}
