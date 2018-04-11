package com.movie.utils;

import java.util.List;

import com.movie.pojo.Movie;
import com.movie.pojo.Play;

public final class MovieDataUtils {

	private MovieDataUtils() {}
	
	public static final String pojoToJson(Movie movie) {
		
		String movie_id = movie.getMovie_id();
		String movie_name = movie.getMovie_name();
		String movie_photo = movie.getMovie_photo();
		String movie_date = movie.getMovie_date();

		StringBuilder json = new StringBuilder();
		json.append("{\"movie_id\":\"").append(movie_id).append("\",");
		json.append("\"movie_name\":\"").append(movie_name).append("\",");
		json.append("\"movie_photo\":\"").append(movie_photo).append("\",");
		json.append("\"movie_date\":\"").append(movie_date).append("\",");
		for(Play p:movie.getPlays()){
			json.append("\"movie_price\":\"").append(p.getPlay_price()).append("\"}");
			break;
		}
		
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
	
public static final String movieToJson(Movie movie) {
		
		String movie_id = movie.getMovie_id();
		String movie_name = movie.getMovie_name();
		String movie_director = movie.getMovie_director();
		String movie_actor = movie.getMovie_actor();
		String movie_info = movie.getMovie_info();
		String movie_language = movie.getMovie_language();
		String movie_kind = movie.getMovie_kind();
		String movie_photo = movie.getMovie_photo();
		String movie_long = movie.getMovie_long();
		String movie_date = movie.getMovie_date();
		String movie_edition = movie.getMovie_edition();
		
		StringBuilder json = new StringBuilder();
		json.append("{\"movie_id\":\"").append(movie_id).append("\",");
		json.append("\"movie_name\":\"").append(movie_name).append("\",");
		json.append("\"movie_director\":\"").append(movie_director).append("\",");
		json.append("\"movie_actor\":\"").append(movie_actor).append("\",");
		json.append("\"movie_info\":\"").append(movie_info).append("\",");
		json.append("\"movie_language\":\"").append(movie_language).append("\",");
		json.append("\"movie_kind\":\"").append(movie_kind).append("\",");
		json.append("\"movie_photo\":\"").append(movie_photo).append("\",");
		json.append("\"movie_long\":\"").append(movie_long).append("\",");
		json.append("\"movie_date\":\"").append(movie_date).append("\",");
		json.append("\"movie_edition\":\"").append(movie_edition).append("\"}");
		
		return json.toString();
	}
}