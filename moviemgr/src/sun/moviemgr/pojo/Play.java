package sun.moviemgr.pojo;

import java.util.List;

public class Play {
	private String play_Id;
	private String play_Movie;
	private String play_Time;
	private String play_Price;
	private Movie movie;
	private List<Ticket> tickets;
	public String getPlay_Id() {
		return play_Id;
	}
	public void setPlay_Id(String play_Id) {
		this.play_Id = play_Id;
	}
	public String getPlay_Movie() {
		return play_Movie;
	}
	public void setPlay_Movie(String play_Movie) {
		this.play_Movie = play_Movie;
	}
	public String getPlay_Time() {
		return play_Time;
	}
	public void setPlay_Time(String play_Time) {
		this.play_Time = play_Time;
	}
	public String getPlay_Price() {
		return play_Price;
	}
	public void setPlay_Price(String play_Price) {
		this.play_Price = play_Price;
	}
	public Movie getMovie() {
		return movie;
	}
	public void setMovie(Movie movie) {
		this.movie = movie;
	}
	public List<Ticket> getTickets() {
		return tickets;
	}
	public void setTickets(List<Ticket> tickets) {
		this.tickets = tickets;
	}
	
}
