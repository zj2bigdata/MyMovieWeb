package com.ssma.movie.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssma.movie.dao.MovieMapper;
import com.ssma.movie.pojo.Member;
import com.ssma.movie.pojo.Movie;
import com.ssma.movie.pojo.Ticket;

@Service
@Transactional
public class MovieDaoService {
	@Resource
	private MovieMapper movieMapper;

	public void setMoviemapper(MovieMapper movieMapper) {
		this.movieMapper = movieMapper;
	}
	//查询总电影数据
	@Transactional(readOnly=true)
	public List<Movie> queryAllMovies(){
		return movieMapper.queryAllMovies();	
	}
	//查询五条电影数据
	@Transactional(readOnly=true)
	public List<Movie> queryFiveMovies(Integer s,Integer e){
		return movieMapper.queryFiveMovies(s,e);
	}
	//查询电影详情根据电影ID
	@Transactional(readOnly=true)
	public List<Movie> queryMoviesById(Integer movie_Id){
		return movieMapper.queryMoviesById(movie_Id);
	}
	//查询场次信息根据电影ID
	@Transactional(readOnly=true)
	public List<Map<String,String>> querySinglePlay(Integer Movie_Id){
		return movieMapper.querySinglePlay(Movie_Id);
	}
	//查询座位信息根据场次ID
	@Transactional(readOnly=true)
	public List<String> querySeatsByPlayId(Integer play_Id){
		return movieMapper.querySeatsByPlayId(play_Id);
	}
	//查询所有邮箱
	@Transactional(readOnly=true)
	public List<String> queryEmails(){
		return movieMapper.queryEmails();
	}
	//新增用户
	public boolean insertSingleMember(Member member){
		return movieMapper.insertSingleMember(member);
	}
	//根据邮箱查找到用户
	@Transactional(readOnly=true)
	public Member querySingleMemberByEmail(String member_Email){
		return movieMapper.querySingleMemberByEmail(member_Email);
	}
	//新增电影票信息
	public boolean insertSingleTicket(Ticket ticket){
		return movieMapper.insertSingleTicket(ticket);
	}
	//动态跟新用户
	public boolean updateSingleMember(Member member){
		return movieMapper.updateSingleMember(member);
	}
	
	public void saveMemberPhoto(Member member){
		movieMapper.saveMemberPhoto(member);
	}
	//根据用户查找票务信息
	public List<Map<String,String>> queryAllTicketsForMember(String email){
		return movieMapper.queryAllTicketsForMember(email);
	}
	public String queryTicketById(String ticket_Id){
		return movieMapper.queryTicketById(ticket_Id);
	}
	//更新用户余额
	public boolean updateMemberMoney(Member member){
		return movieMapper.updateMemberMoney(member);
	}
	//根据票ID删除
	public boolean deleteTicketById(String id){
		return movieMapper.deleteTicketById(id);
	}
}
