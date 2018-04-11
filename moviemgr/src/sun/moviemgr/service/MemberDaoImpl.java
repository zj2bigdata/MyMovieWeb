package sun.moviemgr.service;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sun.moviemgr.dao.MemberMapper;
import sun.moviemgr.pojo.Member;
import sun.moviemgr.utils.MemberDataUtils;


@Service
@Transactional
public class MemberDaoImpl {
	@Resource
	private MemberMapper memberMapper;
	
	public void setMemberMapper(MemberMapper memberMapper) {
		this.memberMapper = memberMapper;
	}

	@Transactional(readOnly=true)
	public String findAll() {
		List<Member> list=memberMapper.findAll();
		return MemberDataUtils.listToJson(list);
	}

	public String addMember(Member m) {
		memberMapper.addMember(m);
		return "{\"result\":"+true+"}";
	}
	

	public String updateMember(Member m) {
		memberMapper.updateMember(m);
		return "{\"result\":"+true+"}";
	}
	@Transactional(readOnly=true)
	public String findById(String id) {
		Member member=memberMapper.findById(id);
		return MemberDataUtils.pojoToJson(member);
	}
	

	public String deleteMember(String id) {
		memberMapper.deleteMember(id);
		return "{\"result\":"+true+"}";
	}
	
}
