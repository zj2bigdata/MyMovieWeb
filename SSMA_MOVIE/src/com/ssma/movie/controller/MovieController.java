package com.ssma.movie.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssma.movie.pojo.Member;
import com.ssma.movie.pojo.Movie;
import com.ssma.movie.pojo.Ticket;
import com.ssma.movie.service.MovieDaoService;

@Controller
public class MovieController {
	
	@Resource
	private MovieDaoService mds;
	//查询总电影数据
	@RequestMapping("/queryAllMovies")
	@ResponseBody
	public List<Movie> queryAllMovies(){
		return mds.queryAllMovies();
	}
	//查询五条电影数据
	@RequestMapping("/queryAllMovies/{start}&{end}")
	@ResponseBody
	public List<Movie> queryFiveMovies(@PathVariable Integer start,@PathVariable Integer end){
		return mds.queryFiveMovies(start, end);
	}
	//查询电影详情根据电影ID
	@RequestMapping("/queryMoviesById/{movie_Id}")
	@ResponseBody
	public  List<Movie> queryMoviesById(@PathVariable Integer movie_Id){
		return mds.queryMoviesById(movie_Id);
	}
	//查询场次信息根据电影ID
	@RequestMapping(value="/querySinglePlay/{movie_Id}",produces = {"application/text;charset=UTF-8"})
	@ResponseBody
		public String querySinglePlay(@PathVariable Integer movie_Id) throws UnsupportedEncodingException{
			List<Map<String,String>> list= mds.querySinglePlay(movie_Id);
			StringBuffer s=new StringBuffer();	
			for(Map<String,String> map:list){
				if(s.length()!=0){
					s.append(",");
				}
				Object c=(Object) map.get("PLAY_ID");
				BigDecimal d=(BigDecimal) c;
				DecimalFormat df = new DecimalFormat("00");
				String play_Id = df.format(d);
				s.append("{\"play_Id\":\""+play_Id+"\",");
				s.append("\"movie_Name\":\""+map.get("MOVIE_NAME")+"\",");
				s.append("\"play_Time\":\""+map.get("PLAY_TIME")+"\",");
				Object c2=(Object) map.get("PLAY_PRICE");
				BigDecimal d2=(BigDecimal) c2;
				DecimalFormat df2 = new DecimalFormat("00.00");
				String play_Price = df2.format(d2);
				s.append("\"play_Price\":\""+play_Price+"\"}");
			}
			String newS="["+s+"]";
			return newS;
		}
		//查询座位信息根据场次ID
		@RequestMapping("/querySeatsByPlayId/{play_Id}")
		@ResponseBody
		public List<String> querySeatsByPlayId(@PathVariable Integer play_Id){
			return mds.querySeatsByPlayId(play_Id);
		}
		//查询所有邮箱
		@RequestMapping("/queryEmails")
		@ResponseBody
		public List<String> queryEmails(){
			return mds.queryEmails();
		}
		//新增用户
		@RequestMapping("/insertSingleMember")
		@ResponseBody
		public String insertSingleMember(Member member){
			return "{\"result\":"+mds.insertSingleMember(member)+"}";
		}
		//根据邮箱查找用户
		@RequestMapping("/querySingleMemberByEmail")
		@ResponseBody
		public Member querySingleMemberByEmail(HttpServletRequest req){
			String member_Email=req.getParameter("member_Email");
			return mds.querySingleMemberByEmail(member_Email);
		}
		//由cookie保存账号
		@RequestMapping("/saveMember")
		public void saveMember(HttpServletRequest req,HttpServletResponse res){
			String member_Email=req.getParameter("member_Email");
			String flag=req.getParameter("flag");
			Cookie c=new Cookie("email",member_Email);
			if(flag.equals("true")){
				c.setMaxAge(600);
			}
			res.addCookie(c);
		}
		//清除cookie里的账号
		@RequestMapping("/clearMember")
		public void clearMember(HttpServletRequest req,HttpServletResponse res) throws IOException{
			 //从客户端得到所有cookie信息  
            Cookie [] allCookies=req.getCookies();  
            int i=0;  
            //如果allCookies不为空...  
            if(allCookies!=null){  
                //从中取出cookie  
                for(i=0;i<allCookies.length;i++){  
                    //依次取出  
                    Cookie temp=allCookies[i];  
                    if(temp.getName().equals("email")){  
                        //将该cookie删除  
                        temp.setMaxAge(0);
                        res.addCookie(temp);
                        break;  
                    }
                }          
            }
            res.sendRedirect("main/index.jsp");
		}
		//新增电影票信息
		@RequestMapping("/insertSingleTicket")
		@ResponseBody
		public String insertSingleTicket(Ticket ticket){
			Date day=new Date();
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss"); 
			ticket.setTicket_Code(df.format(day)+"P"+ticket.getTicket_Play()+"M"+ticket.getTicket_Member());
			return "{\"result\":"+mds.insertSingleTicket(ticket)+"}";
		}
		
		//动态跟新用户
		@RequestMapping("/updateSingleMember")
		@ResponseBody
		public String updateSingleMember(Member member){
			return "{\"result\":"+mds.updateSingleMember(member)+"}";
		}
		
		//保存用户头像
		@RequestMapping("/saveMemberPhoto")
		public void saveMemberPhoto(HttpServletRequest req, HttpServletResponse res) throws UnsupportedEncodingException{
			// 设置接收的编码格式
			req.setCharacterEncoding("utf-8");
			String email=req.getParameter("email");
			
			// 获取上传文件的保存路径
			//ServletContext context = this.getServletContext();
			//String path = context.getRealPath("images");
			String path="D:\\Program Files\\apache-tomcat-8.5.24\\webapps\\SSMA_MOVIE\\images";
			
			// 创建文件处理工厂,用于生成FileItem对象,使用默认的缓冲区大小和临时存储目录
			DiskFileItemFactory factory = new DiskFileItemFactory();
			
			// 创建文件上传处理
			ServletFileUpload upload = new ServletFileUpload(factory);
			
			try {
				// 解析保存在request中的数据并返回list集合
				List<FileItem> fileItemList = upload.parseRequest(req);
				
				for(FileItem fileItem : fileItemList) {
					// 获取表单中的元素是否为文件类型,若是(即type=file)则返回false,否则返回true
					boolean flag = fileItem.isFormField();
					
					if(!flag) {
						// 获取上传文件在客户端的绝对路径
						String filePath = fileItem.getName();
						//System.out.println(filePath);
						// 获取上传的文件名
						String fileName = FilenameUtils.getName(filePath);
						//System.out.println(fileName);
						if(!fileName.isEmpty()) {
							// 创建文件对象
							File file = new File(path, fileName);
							
							// 将文件保存到服务器指定目录
							fileItem.write(file);
						}
						Member m=new Member();
						m.setMember_Email(email);
						m.setMember_Photo(fileName);
						mds.saveMemberPhoto(m);
					}
				}
				
				res.sendRedirect("/SSMA_MOVIE/main/index.jsp");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//根据用户查找票务信息
		@RequestMapping(value="/queryAllTicketsForMember",produces = {"application/text;charset=UTF-8"})
		@ResponseBody
		public String queryAllTicketsForMember(HttpServletRequest req){
			List<Map<String,String>> list=mds.queryAllTicketsForMember(req.getParameter("email"));
			StringBuffer s=new StringBuffer();	
			for(Map<String,String> map:list){
				if(s.length()!=0){
					s.append(",");
				}
				Object c=(Object) map.get("TICKET_ID");
				BigDecimal d=(BigDecimal) c;
				DecimalFormat df = new DecimalFormat("00");
				String TICKET_ID = df.format(d);
				s.append("{\"ticket_Id\":\""+TICKET_ID+"\",");
				s.append("\"movie_Name\":\""+map.get("MOVIE_NAME")+"\",");
				s.append("\"play_Time\":\""+map.get("PLAY_TIME")+"\",");
				s.append("\"movie_Photo\":\""+map.get("MOVIE_PHOTO")+"\",");
				Object c2=(Object) map.get("TICKET_PRICE");
				BigDecimal d2=(BigDecimal) c2;
				DecimalFormat df2 = new DecimalFormat("00.00");
				String TICKET_PRICE = df2.format(d2);
				s.append("\"ticket_Price\":\""+TICKET_PRICE+"\",");
				s.append("\"ticket_Seat\":\""+map.get("TICKET_SEAT")+"\"}");
			}
			String newS="["+s+"]";
			return newS;
		}
		//退票业务
		@RequestMapping("deleteTicketById")
		@ResponseBody
		public String deleteTicketById(HttpServletRequest req){
			String ticket_Id=req.getParameter("ticket_Id");
			String email=req.getParameter("email");
			double money=Double.parseDouble(mds.querySingleMemberByEmail(email).getMember_Money());
			double price=Double.parseDouble(mds.queryTicketById(ticket_Id));
			double sum=money+price;
			String s=String.valueOf(sum);
			Member m=new Member();
			m.setMember_Money(s);
			m.setMember_Email(email);
			boolean uf=mds.updateMemberMoney(m);
			boolean dt=mds.deleteTicketById(ticket_Id);
			if(uf&&dt){
				return "{\"result\":true}";
			}else{
				return "{\"result\":false}";
			}
		}
	
}
