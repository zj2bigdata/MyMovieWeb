package sun.moviemgr.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import sun.moviemgr.pojo.Member;
import sun.moviemgr.service.MemberDaoImpl;

public class MemberServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static MemberDaoImpl mdi;
	@Override
	public void init() throws ServletException {
		String springPath=this.getServletContext().getInitParameter("springPath");
		ApplicationContext context=new ClassPathXmlApplicationContext(springPath);
		mdi=context.getBean("memberDaoImpl",MemberDaoImpl.class);
	}
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String path=req.getServletPath();
		String json="";
		if("/find.member".equals(path)){
			json=mdi.findAll();
		}else if("/add.member".equals(path)){
			Member m=new Member("",req.getParameter("member_Email"),req.getParameter("member_Pwd"),req.getParameter("member_Name"),
					req.getParameter("member_Phone"),req.getParameter("member_Money"),req.getParameter("member_Gender"),req.getParameter("member_Photo"));
			json=mdi.addMember(m);
		}else if("/toUpdate.member".equals(path)){
			String member_Id=req.getParameter("member_Id");
			json=mdi.findById(member_Id);	
		}else if("/update.member".equals(path)){
			Member m=new Member(req.getParameter("member_Id"),req.getParameter("member_Email"),req.getParameter("member_Pwd"),req.getParameter("member_Name"),
					req.getParameter("member_Phone"),req.getParameter("member_Money"),req.getParameter("member_Gender"),req.getParameter("member_Photo"));
			json=mdi.updateMember(m);
		}else if("/delete.member".equals(path)){
			String member_Id=req.getParameter("member_Id");
			json=mdi.deleteMember(member_Id);
		}

		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.println(json);
		out.flush();
		out.close();
	}
	
	
	
}
