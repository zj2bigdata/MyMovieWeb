package sun.moviemgr.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import sun.moviemgr.pojo.Member;

@Repository
public interface MemberMapper {
	List<Member> findAll();
	void addMember(Member m);
	void updateMember(Member m);
	Member findById(String id);
	void deleteMember(String id);
}
