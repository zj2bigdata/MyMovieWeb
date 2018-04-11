package sun.moviemgr.pojo;

import java.util.List;

public class Member {
	private String member_Id;
	private String member_Email;
	private String member_Pwd;
	private String member_Name;
	private String member_Phone;
	private String member_Money;
	private String member_Gender;
	private String member_Photo;
	private List<Ticket> tickets;
	
	
	public Member() {
	}
	
	
	public Member(String member_Id, String member_Email, String member_Pwd, String member_Name, String member_Phone,
			String member_Money, String member_Gender, String member_Photo) {
		super();
		this.member_Id = member_Id;
		this.member_Email = member_Email;
		this.member_Pwd = member_Pwd;
		this.member_Name = member_Name;
		this.member_Phone = member_Phone;
		this.member_Money = member_Money;
		this.member_Gender = member_Gender;
		this.member_Photo = member_Photo;
	}


	public String getMember_Id() {
		return member_Id;
	}
	public void setMember_Id(String member_Id) {
		this.member_Id = member_Id;
	}
	public String getMember_Email() {
		return member_Email;
	}
	public void setMember_Email(String member_Email) {
		this.member_Email = member_Email;
	}
	public String getMember_Pwd() {
		return member_Pwd;
	}
	public void setMember_Pwd(String member_Pwd) {
		this.member_Pwd = member_Pwd;
	}
	public String getMember_Name() {
		return member_Name;
	}
	public void setMember_Name(String member_Name) {
		this.member_Name = member_Name;
	}
	public String getMember_Phone() {
		return member_Phone;
	}
	public void setMember_Phone(String member_Phone) {
		this.member_Phone = member_Phone;
	}
	public String getMember_Money() {
		return member_Money;
	}
	public void setMember_Money(String member_Money) {
		this.member_Money = member_Money;
	}
	public String getMember_Gender() {
		return member_Gender;
	}
	public void setMember_Gender(String member_Gender) {
		this.member_Gender = member_Gender;
	}
	public String getMember_Photo() {
		return member_Photo;
	}
	public void setMember_Photo(String member_Photo) {
		this.member_Photo = member_Photo;
	}


	public List<Ticket> getTickets() {
		return tickets;
	}


	public void setTickets(List<Ticket> tickets) {
		this.tickets = tickets;
	}
	
	
}
