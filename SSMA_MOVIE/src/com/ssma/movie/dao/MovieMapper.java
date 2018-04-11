package com.ssma.movie.dao;

import java.util.List;
import java.util.Map;

import com.ssma.movie.pojo.Member;
import com.ssma.movie.pojo.Movie;
import com.ssma.movie.pojo.Ticket;

public interface MovieMapper {
	List<Movie> queryAllMovies();
	List<Movie> queryFiveMovies(Integer s,Integer e);
	List<Movie> queryMoviesById(Integer movie_Id);
	List<Map<String,String>> querySinglePlay(Integer Movie_Id);
	List<String> querySeatsByPlayId(Integer play_Id);
	List<String> queryEmails();
	boolean insertSingleMember(Member member);
	Member querySingleMemberByEmail(String member_Email);
	boolean insertSingleTicket(Ticket ticket);
	boolean updateSingleMember(Member member);
	void saveMemberPhoto(Member member);
	List<Map<String,String>> queryAllTicketsForMember(String email);
	String queryTicketById(String ticket_Id);
	boolean updateMemberMoney(Member member);
	boolean deleteTicketById(String id);
}
