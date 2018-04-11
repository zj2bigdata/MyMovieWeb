package com.movie.controller;

import java.io.IOException;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.movie.pojo.Member;
import com.movie.service.MovieDaoService;

public class MovieServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static MovieDaoService mds;
	@Override
	public void init() throws ServletException {
		String springPath=this.getServletContext().getInitParameter("springPath");
		ApplicationContext context=new ClassPathXmlApplicationContext(springPath);
		mds=context.getBean("movieDaoService",MovieDaoService.class);
	}
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String path=req.getServletPath();
		String json="";
		if("/find.movie".equals(path)){
				json=mds.findAll();
		}else if("/findById.movie".equals(path)){
			String id=req.getParameter("movie_id");
			json=mds.findById(id);
		}else if("/login.movie".equals(path)){
			String email=req.getParameter("member_email");
			json=mds.finSingleMember(email);
		}else if("/saveCount.movie".equals(path)){
			String email=req.getParameter("email");
			String pwd=req.getParameter("pwd");
			String id=req.getParameter("id");
			HttpSession hs=req.getSession();
			if(hs.isNew()||hs.getAttribute("email")==null){
				hs.setAttribute("email",email);
				hs.setAttribute("pwd",pwd);
				hs.setAttribute("id",id);
			}
		}else if("/updateMember.movie".equals(path)){
			Member m=new Member();
			m.setMember_id(req.getParameter("member_id"));
			m.setMember_email(req.getParameter("member_email"));
			m.setMember_pwd(req.getParameter("member_pwd"));
			m.setMember_name(req.getParameter("member_name"));
			m.setMember_phone(req.getParameter("member_phone"));
			m.setMember_gender(req.getParameter("member_gender"));
			mds.updateSingleMember(m);
		}else if("/clearCount.movie".equals(path)){
				Cookie[] cookies=req.getCookies();
				for(Cookie cookie:cookies){
					cookie.setMaxAge(0);
					resp.addCookie(cookie);
				}
				HttpSession hs=req.getSession();
				if(!hs.isNew()){
					hs.removeAttribute("email");
					hs.removeAttribute("pwd");
					hs.removeAttribute("id");
					hs.removeAttribute("play_id");
					hs.removeAttribute("seats");
				}
				resp.sendRedirect("/movie/main/index.jsp");
		}else if("/register.movie".equals(path)){
			Member m=new Member();
			m.setMember_email(req.getParameter("member_email"));
			m.setMember_gender(req.getParameter("gender"));
			m.setMember_name(req.getParameter("member_name"));
			m.setMember_phone(req.getParameter("member_phone"));
			m.setMember_pwd(req.getParameter("member_pwd"));
			m.setMember_money("5");
			m.setMember_photo("无");
			mds.addMember(m);
			resp.sendRedirect("/movie/main/login.jsp");
		}else if("/loadPhoto.movie".equals(path)){
			String email=req.getParameter("email");
			json=mds.loadPhoto(email);
		}else if("/selectMovies.movie".equals(path)){
			Integer s=Integer.parseInt(req.getParameter("start"));
			Integer e=Integer.parseInt(req.getParameter("end"));
			json=mds.selectMovies(s, e);
		}else if("/saveCookie.movie".equals(path)){
			String email=req.getParameter("email");
			Cookie cookie1=new Cookie("email",email);
			resp.addCookie(cookie1);
			json="1";
		}
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.println(json);
		out.flush();
		out.close();
	}
	
	
	
	
	
	
	
}
