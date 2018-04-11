package com.movie.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.movie.dao.MovieMapper;
import com.movie.pojo.Member;
import com.movie.pojo.Movie;
import com.movie.pojo.Play;
import com.movie.pojo.Ticket;
import com.movie.utils.MemberDataUtils;
import com.movie.utils.MovieDataUtils;

@Service
@Transactional
public class MovieDaoService {
	@Resource
	private MovieMapper mm;
	@Transactional(readOnly=true)
	public String findAll(){
		List<Movie> list=mm.findAll();
		return  MovieDataUtils.listToJson(list);
	}
	@Transactional(readOnly=true)
	public String selectMovies(Integer s,Integer e){
		List<Movie> list=mm.selectMovies(s,e);
		return  MovieDataUtils.listToJson(list);
	}
	@Transactional(readOnly=true)
	public String findById(String id){
		return MovieDataUtils.movieToJson(mm.findById(id));
	}
	@Transactional(readOnly=true)
	public String finSingleMember(String email){
		return MemberDataUtils.movieToJson(mm.finSingleMember(email));
	}
	@Transactional(readOnly=true)
	public String findMember(String email){
		return mm.finSingleMember(email).getMember_money();
	}
	public void updateSingleMember(Member m){
		mm.updateSingleMember(m);
	}
	@Transactional(readOnly=true)
	public List<Play> findTime(String name){
		return mm.findTime(name);
	}
	
	public void addTicket(Ticket t){
		mm.addTicket(t);
	}
	@Transactional(readOnly=true)
	public String findTickets(String email){
		return MemberDataUtils.ticketsToJson(mm.findTickets(email));
	}
	
	public 	void updateMoney(Member m){
		mm.updateMoney(m);
	}
	public 	void updateMoney2(Member m){
		mm.updateMoney2(m);
	}
	@Transactional(readOnly=true)
	public List<String> findSeats(String id){
		return mm.findSeats(id);
	}
	public void addMember(Member m){
		mm.addMember(m);
	}
	public void deleteTicket(String id){
		mm.deleteTicket(id);
	}
	@Transactional(readOnly=true)
	public String findTicket(String id){
		return mm.findTicket(id);
	}
	public void savePhoto(Member m){
		mm.savePhoto(m);
	}
	@Transactional(readOnly=true)
	public String loadPhoto(String email){
		return mm.loadPhoto(email);
	}
}
