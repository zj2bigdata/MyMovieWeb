package sun.moviemgr.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import sun.moviemgr.pojo.Movie;
@Repository
public interface MovieMapper {
	List<Movie> showMovies();
	void addYu(String language);
	void addKind(String kind);
	void addEd(String ed);
	void addMovie(Movie m);
	Movie findMovieById(String id);
	void updateMovie(Movie m);
	List<Movie> selectMovies3(Integer i1,Integer i2);
	void deleteMovie(String id);
}
