package com.movie.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.movie.pojo.Member;
import com.movie.pojo.Play;
import com.movie.pojo.Ticket;
import com.movie.service.MovieDaoService;

public class TicketServlet extends HttpServlet {
	
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
		StringBuffer sb1=new StringBuffer();
		String json=new String();
		if("/findTime.ticket".equals(path)){
			String movie_name=req.getParameter("movie_name");
			List<Play> ps=mds.findTime(movie_name);
			
			for(Play p:ps){
				if(sb1.length() != 0) {
					sb1.append(",");
				}
				sb1.append("{\"play_id\":\""+p.getPlay_id()+"\",\"play_time\":\""+p.getPlay_time()+"\"}");
			}
			json="["+sb1+"]";
		}else if("/buyMovie.ticket".equals(path)){
				Ticket t=new Ticket();
				t.setTicket_play(req.getParameter("play_id"));
				t.setTicket_code(req.getParameter("ticket_code")+"号");
				t.setTicket_seat(req.getParameter("seats"));
				t.setTicket_price(req.getParameter("movie_price"));
				t.setTicket_member(req.getParameter("member_id"));
				t.setTicket_flag("12");
				mds.addTicket(t);
		}else if("/findTickets.ticket".equals(path)){
			String email=req.getParameter("email");
			json=mds.findTickets(email);
		}else if("/lessMoney.ticket".equals(path)){
			String member_id=req.getParameter("id");
			String count_price=req.getParameter("count");
			Member m=new Member();
			m.setMember_id(member_id);
			m.setMember_money(count_price);
			mds.updateMoney(m);
			json="{\"result\":\"true\"}";
		}else if("/findSeats.ticket".equals(path)){
			String play_id=req.getParameter("id");
			List<String> seats=mds.findSeats(play_id);
			StringBuffer s1=new StringBuffer();
			for(String s:seats){
				if(s1.length()!=0){
					s1.append(",");
				}
				s1.append("'"+s+"'");
			}
			json="["+s1+"]";
			HttpSession hs=req.getSession();
			hs.setAttribute("seats",json);
			hs.setAttribute("play_id",play_id);
		}else if("/deleteTicket.ticket".equals(path)){
			String ticket_id=req.getParameter("ticket_id");
			String email=req.getParameter("email");
			double money=Double.parseDouble(mds.findMember(email));
			double price=Double.parseDouble(mds.findTicket(ticket_id));
			double sum=money+price;
			String s=String.valueOf(sum);
			Member m=new Member();
			m.setMember_money(s);
			m.setMember_email(email);
			mds.deleteTicket(ticket_id);
			mds.updateMoney2(m);
			HttpSession hs=req.getSession();
			if(!hs.isNew()){
				hs.removeAttribute("play_id");
				hs.removeAttribute("seats");
			}
			resp.sendRedirect("/movie/main/index.jsp?email="+email);
		}
		
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.println(json);
		out.flush();
		out.close();
	}

}
