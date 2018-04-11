package com.movie.dao;

import java.util.List;
import com.movie.pojo.Member;
import com.movie.pojo.Movie;
import com.movie.pojo.Play;
import com.movie.pojo.Ticket;

public interface MovieMapper {
	List<Movie> findAll();
	List<Movie> selectMovies(Integer s,Integer e);
	Movie findById(String id);
	Member finSingleMember(String email);
	void updateSingleMember(Member m);
	List<Play> findTime(String name);
	void addTicket(Ticket t);
	List<Ticket> findTickets(String email);
	void updateMoney(Member m);
	void updateMoney2(Member m);
	List<String> findSeats(String id);
	void addMember(Member m);
	void deleteTicket(String id);
	String findTicket(String id);
	void savePhoto(Member m);
	String loadPhoto(String email);
}
