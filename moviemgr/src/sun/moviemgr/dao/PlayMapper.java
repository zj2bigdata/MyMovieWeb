package sun.moviemgr.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import sun.moviemgr.pojo.Play;
@Repository
public interface PlayMapper {
	List<Map<String,Object>> findAll();
	List<Map<String,Object>> selectPlays(Integer s,Integer e);
	void addPlay(Play p);
	void updatePlay(Play p);
	void deletePlay(String id);
}
