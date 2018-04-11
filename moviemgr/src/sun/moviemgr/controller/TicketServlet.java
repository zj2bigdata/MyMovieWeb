package sun.moviemgr.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import sun.moviemgr.pojo.Ticket;
import sun.moviemgr.service.TicketDaoImpl;

public class TicketServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private TicketDaoImpl tdi;
	@Override
	public void init() throws ServletException {
		String springPath=this.getServletContext().getInitParameter("springPath");
		ApplicationContext context=new ClassPathXmlApplicationContext(springPath);
		tdi=context.getBean("ticketDaoImpl",TicketDaoImpl.class);
	}



	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String path=req.getServletPath();
		StringBuilder json = new StringBuilder();
		if("/findBt.ticket".equals(path)){
			String ticket_Id=req.getParameter("ticket_Id");
			Ticket t=tdi.findByTicketId(ticket_Id);
			String ticket_Date = t.getTicket_Date();
			String ticket_Price = t.getTicket_Price();
			String member_Name = t.getMember().getMember_Name();
			String member_Email = t.getMember().getMember_Email();
			String movie_Name = t.getPlay().getMovie().getMovie_Name();
			String play_Time = t.getPlay().getPlay_Time();
			String ticket_Seat = t.getTicket_Seat();
			String ticket_Flag = t.getTicket_Flag();
			json.append("{\"ticket_Date\":\"").append(ticket_Date).append("\",");
			json.append("\"ticket_Price\":\"").append(ticket_Price).append("\",");
			json.append("\"member_Name\":\"").append(member_Name).append("\",");
			json.append("\"member_Email\":\"").append(member_Email).append("\",");
			json.append("\"movie_Name\":\"").append(movie_Name).append("\",");
			json.append("\"play_Time\":\"").append(play_Time).append("\",");
			json.append("\"ticket_Seat\":\"").append(ticket_Seat).append("\",");
			json.append("\"ticket_Flag\":\"").append(ticket_Flag).append("\"}");
		}else{
			json.append("{\"result\":"+false+"}");
		}
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.println(json);
		out.flush();
		out.close();
	}
	
	
	
}
