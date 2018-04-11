package sun.moviemgr.utils;

import java.util.List;
import sun.moviemgr.pojo.Member;

public final class MemberDataUtils {

	private MemberDataUtils() {}
	
	public static final String pojoToJson(Member member) {
		
		String member_Id = member.getMember_Id();
		String member_Email = member.getMember_Email();
		String member_Pwd = member.getMember_Pwd();
		String member_Name = member.getMember_Name();
		String member_Phone = member.getMember_Phone();
		String member_Money = member.getMember_Money();
		String member_Gender = member.getMember_Gender();
		String member_Photo = member.getMember_Photo();
		
		StringBuilder json = new StringBuilder();
		json.append("{\"member_Id\":\"").append(member_Id).append("\",");
		json.append("\"member_Email\":\"").append(member_Email).append("\",");
		json.append("\"member_Pwd\":\"").append(member_Pwd).append("\",");
		json.append("\"member_Name\":\"").append(member_Name).append("\",");
		json.append("\"member_Phone\":\"").append(member_Phone).append("\",");
		json.append("\"member_Money\":\"").append(member_Money).append("\",");
		json.append("\"member_Gender\":\"").append(member_Gender).append("\",");
		json.append("\"member_Photo\":\"").append(member_Photo).append("\"}");
		
		return json.toString();
	}

	public static final String listToJson(List<Member> list) {
		
		StringBuilder json = new StringBuilder();
		
		for(Member me : list) {
			if(json.length() != 0) {
				json.append(",");
			}
			
			String str = pojoToJson(me);
			json.append(str);
		}
		
		return "[" + json + "]";
	}
}