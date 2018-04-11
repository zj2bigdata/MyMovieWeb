package com.movie.utils;

import java.util.List;

import com.movie.pojo.Member;
import com.movie.pojo.Ticket;

public class MemberDataUtils {

	
public static final String movieToJson(Member member) {
		if(member==null){
			return "1";
		}
		
		String member_id = member.getMember_id();
		String member_email = member.getMember_email();
		String member_pwd = member.getMember_pwd();
		String member_name = member.getMember_name();
		String member_phone = member.getMember_phone();
		String member_money = member.getMember_money();
		String member_gender = member.getMember_gender();
		String member_photo = member.getMember_photo();

		
		StringBuilder json = new StringBuilder();
		json.append("{\"member_id\":\"").append(member_id).append("\",");
		json.append("\"member_email\":\"").append(member_email).append("\",");
		json.append("\"member_pwd\":\"").append(member_pwd).append("\",");
		json.append("\"member_name\":\"").append(member_name).append("\",");
		json.append("\"member_phone\":\"").append(member_phone).append("\",");
		json.append("\"member_money\":\"").append(member_money).append("\",");
		json.append("\"member_gender\":\"").append(member_gender).append("\",");
		json.append("\"member_photo\":\"").append(member_photo).append("\"}");
		
		return json.toString();
	}

	public static final String ticketsToJson(List<Ticket> tickets) {
			StringBuffer sb=new StringBuffer();
			for(Ticket t: tickets){
				if(sb.length()!=0){
					sb.append(",");
				}
				sb.append("{\"ticket_id\":\"").append(t.getTicket_id()).append("\",");
				sb.append("\"movie_name\":\"").append(t.getPlay().getMovie().getMovie_name()).append("\",");
				sb.append("\"play_time\":\"").append(t.getPlay().getPlay_time()).append("\",");
				sb.append("\"ticket_seat\":\"").append(t.getTicket_seat()).append("\",");
				sb.append("\"ticket_price\":\"").append(t.getTicket_price()).append("\"}");
			}
			
		
		return "["+sb+"]";
	}
}
