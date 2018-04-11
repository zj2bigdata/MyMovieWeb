package sun.moviemgr.utils;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

public class PlayDataUtils {
public static final String pojoToJson(Map<String,Object>map) {
		
		Object c=(Object) map.get("PLAY_ID");
		BigDecimal d=(BigDecimal) c;
		DecimalFormat df = new DecimalFormat("00");
		String play_Id = df.format(d);
		Object o=(Object) map.get("MOVIE_LONG");
		BigDecimal b=(BigDecimal) o;
		DecimalFormat df2 = new DecimalFormat("00");
		String movie_Long = df2.format(b);
		String play_Time =(String)map.get("PLAY_TIME");
		String movie_Name =(String)map.get("MOVIE_NAME");
		String movie_Date =(String)map.get("MOVIE_DATE");
		String language_Name=(String)map.get("LANGUAGE_NAME");
		String kind_name=(String)map.get("KIND_NAME");
		
		
		StringBuilder json = new StringBuilder();
		json.append("{\"play_Id\":\"").append(play_Id).append("\",");
		json.append("\"play_Time\":\"").append(play_Time).append("\",");
		json.append("\"movie_Long\":\"").append(movie_Long).append("\",");
		json.append("\"movie_Name\":\"").append(movie_Name).append("\",");
		json.append("\"language_Name\":\"").append(language_Name).append("\",");
		json.append("\"kind_name\":\"").append(kind_name).append("\",");
		json.append("\"movie_Date\":\"").append(movie_Date).append("\"}");
		
		return json.toString();
	}

	public static final String listToJson(List<Map<String,Object>> list) {
		
		StringBuilder json = new StringBuilder();
		
		for(Map<String,Object> play : list) {
			if(json.length() != 0) {
				json.append(",");
			}
			
			String str = pojoToJson(play);
			json.append(str);
		}
		
		return "[" + json + "]";
	}
}
