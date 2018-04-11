package sun.moviemgr.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import sun.moviemgr.pojo.Admin;
import sun.moviemgr.service.AdminDaoImpl;

public class AdminServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static AdminDaoImpl adi;
	@Override
	public void init() throws ServletException {
		String springPath=this.getServletContext().getInitParameter("springPath");
		ApplicationContext context=new ClassPathXmlApplicationContext(springPath);
		adi=context.getBean("adminDaoImpl",AdminDaoImpl.class);
	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String path=req.getServletPath();
		String json="";
		if("/test.admin".equals(path)){
			String captcha = (String)req.getSession().getAttribute("captcha");
			json="{\"captcha\":\""+captcha+"\"}";
		}else if("/filter.admin".equals(path)){
			String flag=req.getParameter("flag");
			String qx=req.getParameter("qx");
			HttpSession hs=req.getSession();
			if(hs.isNew()|| hs.getAttribute("flag") == null||hs.getAttribute("qx")==null){
				hs.setAttribute("flag",flag);
				hs.setAttribute("qx",qx);
			}
			json="{\"setHs\":"+true+"}";
		}else if("/find.admin".equals(path)){
			json=adi.findAll();
		}else if("/add.admin".equals(path)){
			String admin_Name=req.getParameter("admin_Name");
			String admin_Pwd=req.getParameter("admin_Pwd");
			String admin_Privilege=req.getParameter("admin_Privilege");
			Admin a=new Admin();
			a.setAdmin_Name(admin_Name);
			a.setAdmin_Pwd(admin_Pwd);
			a.setAdmin_Privilege(admin_Privilege);
			json=adi.addAdmin(a);
		}else if("/toUpdate.admin".equals(path)){
			String admin_Id=req.getParameter("admin_Id");
			json=adi.findById(admin_Id);	
		}else if("/update.admin".equals(path)){
			Admin a=new Admin();
			a.setAdmin_Id(req.getParameter("admin_Id"));
			a.setAdmin_Name(req.getParameter("admin_Name"));
			a.setAdmin_Pwd(req.getParameter("admin_Pwd"));
			a.setAdmin_Privilege(req.getParameter("admin_Privilege"));
			json=adi.updateAdmin(a);
		}else if("/delete.admin".equals(path)){
			String admin_Id=req.getParameter("admin_Id");
			json=adi.deleteAdmin(admin_Id);
		}else if("/layout.admin".equals(path)){
			HttpSession hs=req.getSession();
			if(!hs.isNew()){
				hs.removeAttribute("flag");
				hs.removeAttribute("qx");
			}
		}
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.println(json);
		out.flush();
		out.close();
	}
	
	
}
