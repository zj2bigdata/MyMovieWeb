package sun.moviemgr.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import sun.moviemgr.pojo.Admin;

@Repository
public interface AdminMapper {
	List<Admin> findAll();
	void addAdmin(Admin a);
	void updateAdmin(Admin a);
	Admin findById(String id);
	void deleteAdmin(String id);
}
