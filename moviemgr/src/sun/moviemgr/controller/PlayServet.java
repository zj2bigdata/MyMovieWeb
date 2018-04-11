package sun.moviemgr.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import sun.moviemgr.pojo.Play;
import sun.moviemgr.service.PlayDaoImpl;

public class PlayServet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static PlayDaoImpl pdi;
	
	@Override
	public void init() throws ServletException {
		String springPath=this.getServletContext().getInitParameter("springPath");
		ApplicationContext context=new ClassPathXmlApplicationContext(springPath);
		pdi=context.getBean("playDaoImpl",PlayDaoImpl.class);
	}
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String path=req.getServletPath();
		String json="";
		if("/find.play".equals(path)){
			json=pdi.findAll();
		
		}else if("/selectPlays.play".equals(path)){
			Integer s=Integer.parseInt(req.getParameter("start"));
			Integer e=Integer.parseInt(req.getParameter("end"));
			json=pdi.selectPlays(s, e);
		}else if("/addPlay.play".equals(path)){
			String play_Movie=req.getParameter("play_Movie");
			String play_Time=req.getParameter("play_Time");
			String play_Price=req.getParameter("play_Price");
			Play p=new Play();
			p.setPlay_Movie(play_Movie);
			p.setPlay_Time(play_Time);
			p.setPlay_Price(play_Price);
			pdi.addPlay(p);
			resp.sendRedirect("/moviemgr/playJsp/playShow.jsp");
		}else if("/updatePlay.play".equals(path)){
			String play_Id=req.getParameter("play_Id");
			String play_Time=req.getParameter("play_Time");
			String play_Price=req.getParameter("play_Price");
			Play p=new Play();
			p.setPlay_Id(play_Id);
			p.setPlay_Time(play_Time);
			p.setPlay_Price(play_Price);
			System.out.println(play_Id);
			pdi.updatePlay(p);
			resp.sendRedirect("/moviemgr/playJsp/playShow.jsp");
		}else if("/deletePlay.play".equals(path)){
			String play_Id=req.getParameter("id");
			pdi.deletePlay(play_Id);
			json="1";
		}
		
		
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.println(json);
		out.flush();
		out.close();
	}
	
}
