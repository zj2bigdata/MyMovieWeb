package com.movie.pojo;
public class Play {
	private String play_id;
	private String play_movie;
	private String play_time;
	private String play_price;
	private Movie movie;
	
	
	public Movie getMovie() {
		return movie;
	}
	public void setMovie(Movie movie) {
		this.movie = movie;
	}
	public String getPlay_id() {
		return play_id;
	}
	public void setPlay_id(String play_id) {
		this.play_id = play_id;
	}
	public String getPlay_movie() {
		return play_movie;
	}
	public void setPlay_movie(String play_movie) {
		this.play_movie = play_movie;
	}
	public String getPlay_time() {
		return play_time;
	}
	public void setPlay_time(String play_time) {
		this.play_time = play_time;
	}
	public String getPlay_price() {
		return play_price;
	}
	public void setPlay_price(String play_price) {
		this.play_price = play_price;
	}
	
}
