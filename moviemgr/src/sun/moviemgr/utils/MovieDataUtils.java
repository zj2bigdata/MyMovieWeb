package sun.moviemgr.utils;

import java.util.List;
import sun.moviemgr.pojo.Movie;


public class MovieDataUtils {

	public static final String pojoToJson(Movie movie) {
		
		String movie_Id = movie.getMovie_Id();
		String movie_Name =movie.getMovie_Name();
		String movie_Director = movie.getMovie_Director();
		String movie_Actor = movie.getMovie_Actor();
		String movie_Info =	movie.getMovie_Info();
		String movie_Language = movie.getMovie_Language();
		String movie_Kind = movie.getMovie_Kind();
		String movie_Photo = movie.getMovie_Photo();
		String movie_Long = movie.getMovie_Long();
		String movie_Date = movie.getMovie_Date();
		String movie_Edition = movie.getMovie_Edition();
		
		StringBuilder json = new StringBuilder();
		json.append("{\"movie_Id\":\"").append(movie_Id).append("\",");
		json.append("\"movie_Name\":\"").append(movie_Name).append("\",");
		json.append("\"movie_Director\":\"").append(movie_Director).append("\",");
		json.append("\"movie_Actor\":\"").append(movie_Actor).append("\",");
		json.append("\"movie_Info\":\"").append(movie_Info).append("\",");
		json.append("\"movie_Language\":\"").append(movie_Language).append("\",");
		json.append("\"movie_Kind\":\"").append(movie_Kind).append("\",");
		json.append("\"movie_Photo\":\"").append(movie_Photo).append("\",");
		json.append("\"movie_Long\":\"").append(movie_Long).append("\",");
		json.append("\"movie_Date\":\"").append(movie_Date).append("\",");
		json.append("\"movie_Edition\":\"").append(movie_Edition).append("\"}");
		
		return json.toString();
	}

	public static final String listToJson(List<Movie> list) {
			
			StringBuilder json = new StringBuilder();
			
			for(Movie mo : list) {
				if(json.length() != 0) {
					json.append(",");
				}
				
				String str = pojoToJson(mo);
				json.append(str);
			}
			
			return "[" + json + "]";
		}
}
