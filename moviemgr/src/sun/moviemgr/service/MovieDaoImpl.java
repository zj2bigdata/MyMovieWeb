package sun.moviemgr.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import sun.moviemgr.dao.MovieMapper;
import sun.moviemgr.pojo.Movie;
import sun.moviemgr.utils.MovieDataUtils;

@Service
@Transactional
public class MovieDaoImpl {
	@Resource
	private MovieMapper movieMapper;

	public void setMovieMapper(MovieMapper movieMapper) {
		this.movieMapper = movieMapper;
	}
	
	public String showMovies(){
		List<Movie> list=movieMapper.showMovies();
		return MovieDataUtils.listToJson(list);
	}
	
	public void addYu(String language){
		movieMapper.addYu(language);
	}
	public void addKind(String kind){
		movieMapper.addKind(kind);
	}
	public void addEd(String ed){
		movieMapper.addEd(ed);
	}
	public 	void addMovie(Movie m){
		movieMapper.addMovie(m);
	}
	
	public String findMovieById(String id){
		return MovieDataUtils.pojoToJson(movieMapper.findMovieById(id));
	}
	public void updateMovie(Movie m){
		movieMapper.updateMovie(m);
	}
	//·ÖÒ³
	public String selectMovies3(Integer i1,Integer i2){
		return MovieDataUtils.listToJson(movieMapper.selectMovies3(i1,i2));
	}
	//
	public void deleteMovie(String id){
		movieMapper.deleteMovie(id);
	}
	
	
}
