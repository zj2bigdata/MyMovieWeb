package sun.moviemgr.utils;

import java.util.List;
import sun.moviemgr.pojo.Admin;

public final class AdminDataUtils {

	private AdminDataUtils() {}
	
	public static final String pojoToJson(Admin admin) {
		
		String admin_Id = admin.getAdmin_Id();
		String admin_Name = admin.getAdmin_Name();
		String admin_Pwd = admin.getAdmin_Pwd();
		String admin_Privilege = admin.getAdmin_Privilege();
		
		StringBuilder json = new StringBuilder();
		json.append("{\"admin_Id\":\"").append(admin_Id).append("\",");
		json.append("\"admin_Name\":\"").append(admin_Name).append("\",");
		json.append("\"admin_Pwd\":\"").append(admin_Pwd).append("\",");
		json.append("\"admin_Privilege\":\"").append(admin_Privilege).append("\"}");
		
		return json.toString();
	}

	public static final String listToJson(List<Admin> list) {
		
		StringBuilder json = new StringBuilder();
		
		for(Admin ad : list) {
			if(json.length() != 0) {
				json.append(",");
			}
			
			String str = pojoToJson(ad);
			json.append(str);
		}
		
		return "[" + json + "]";
	}
}