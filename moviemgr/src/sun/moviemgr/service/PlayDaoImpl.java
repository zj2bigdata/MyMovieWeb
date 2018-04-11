package sun.moviemgr.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import sun.moviemgr.dao.PlayMapper;
import sun.moviemgr.pojo.Play;
import sun.moviemgr.utils.PlayDataUtils;

@Service
@Transactional
public class PlayDaoImpl {
	@Resource
	private PlayMapper playMapper;
	
	public String findAll(){
		List<Map<String,Object>> list=playMapper.findAll();
		return PlayDataUtils.listToJson(list);
	}
	
	public String selectPlays(Integer s,Integer e){
		return PlayDataUtils.listToJson(playMapper.selectPlays(s, e));
	}
	public void addPlay(Play p){
		playMapper.addPlay(p);
	}
	
	public void updatePlay(Play p){
		playMapper.updatePlay(p);
	}
	public void deletePlay(String id){
		playMapper.deletePlay(id);
	}
}
