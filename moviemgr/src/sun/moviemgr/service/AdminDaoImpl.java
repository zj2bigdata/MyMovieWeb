package sun.moviemgr.service;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import sun.moviemgr.dao.AdminMapper;
import sun.moviemgr.pojo.Admin;
import sun.moviemgr.utils.AdminDataUtils;


@Service
@Transactional
public class AdminDaoImpl {
	@Resource
	private AdminMapper adminMapper;
	public void setShopMapper(AdminMapper adminMapper) {
		this.adminMapper = adminMapper;
	}
	@Transactional(readOnly=true)
	public String findAll() {
		List<Admin> list=adminMapper.findAll();
		return AdminDataUtils.listToJson(list);
	}

	public String addAdmin(Admin s) {
		adminMapper.addAdmin(s);
		return "{\"result\":"+true+"}";
	}
	

	public String updateAdmin(Admin s) {
		adminMapper.updateAdmin(s);
		return "{\"result\":"+true+"}";
	}
	@Transactional(readOnly=true)
	public String findById(String id) {
		Admin admin=adminMapper.findById(id);
		return AdminDataUtils.pojoToJson(admin);
	}
	

	public String deleteAdmin(String id) {
		adminMapper.deleteAdmin(id);
		return "{\"result\":"+true+"}";
	}
	
}
