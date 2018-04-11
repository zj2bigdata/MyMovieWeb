package sun.moviemgr.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import sun.moviemgr.pojo.Movie;
import sun.moviemgr.service.MovieDaoImpl;

public class MovieServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private static MovieDaoImpl modi;
	//初始化spring容器并获得MemberDaoImpl的实例化对象
	@Override
	public void init() throws ServletException {
		String springPath=this.getServletContext().getInitParameter("springPath");
		ApplicationContext context=new ClassPathXmlApplicationContext(springPath);
		modi=context.getBean("movieDaoImpl",MovieDaoImpl.class);
	}
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path=req.getServletPath();
		String json="";
		if("/find.movie".equals(path)){
			json=modi.showMovies();
		}else if("/addYu.movie".equals(path)){
			modi.addYu(req.getParameter("yu"));
			json="1";
		}else if("/addKind.movie".equals(path)){
			modi.addKind(req.getParameter("kind"));
			json="1";
		}else if("/addEd.movie".equals(path)){
			modi.addEd(req.getParameter("ed"));
			json="1";
		}else if("/addMovie.movie".equals(path)){
				Movie m=new Movie();
				m.setMovie_Name(req.getParameter("movie_name"));
				m.setMovie_Director(req.getParameter("movie_Director"));
				m.setMovie_Actor(req.getParameter("movie_Actor"));
				m.setMovie_Language(req.getParameter("movie_Language"));
				m.setMovie_Kind(req.getParameter("movie_Kind"));
				m.setMovie_Long(req.getParameter("movie_Long"));
				m.setMovie_Edition(req.getParameter("movie_Edition"));
				m.setMovie_Info(req.getParameter("movie_Info"));
				m.setMovie_Photo(req.getParameter("movie_photo"));;
				m.setMovie_Date(req.getParameter("movie_Date"));
				modi.addMovie(m);
				json="1";
		}else if("/saveImg.movie".equals(path)){
			saveImg(req, resp);
		}else if("/findById.movie".equals(path)){
			json=modi.findMovieById(req.getParameter("movie_Id"));	
		}else if("/updateMovie.movie".equals(path)){
			Movie m=new Movie();
			m.setMovie_Id(req.getParameter("movie_Id"));
			m.setMovie_Name(req.getParameter("movie_name"));
			m.setMovie_Director(req.getParameter("movie_Director"));
			m.setMovie_Actor(req.getParameter("movie_Actor"));
			m.setMovie_Language(req.getParameter("movie_Language"));
			m.setMovie_Kind(req.getParameter("movie_Kind"));
			m.setMovie_Long(req.getParameter("movie_Long"));
			m.setMovie_Edition(req.getParameter("movie_Edition"));
			m.setMovie_Info(req.getParameter("movie_Info"));
			m.setMovie_Photo(req.getParameter("movie_photo"));;
			modi.updateMovie(m);
			json="1";
		}else if("/selectMovies3.movie".equals(path)){
			Integer start=Integer.parseInt(req.getParameter("start"));
			Integer end=Integer.parseInt(req.getParameter("end"));
			//分页方法需要参数
			json=modi.selectMovies3(start,end);
		}else if("/deleteMovie.movie".equals(path)){
			String id=req.getParameter("id");
			modi.deleteMovie(id);
		}
		//向传来的url写入json
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.println(json);
		out.flush();
		out.close();
	}
	
	private void saveImg(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

		req.setCharacterEncoding("utf-8");
		
	
//		ServletContext context = this.getServletContext();
//		String path = context.getRealPath("images");
		String path="D:\\Program Files\\apache-tomcat-8.5.24\\webapps\\movie\\images";
		System.out.println(path);
		
		//D:\Program Files\apache-tomcat-8.5.24\webapps\moviemgr\images
		
		// 创建文件处理工厂,用于生成FileItem对象,使用默认的缓冲区大小和临时存储目录
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		// 创建文件上传处理�?
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
					System.out.println(filePath);
					// 获取上传的文件名
					String fileName = FilenameUtils.getName(filePath);
					System.out.println(fileName);
					if(!fileName.isEmpty()) {
						// 创建文件对象
						File file = new File(path, fileName);
						
						// 将文件保存到服务器指定目录
						fileItem.write(file);
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			resp.sendRedirect("movieJsp/movieShow.jsp");
		}
	}
	
}
