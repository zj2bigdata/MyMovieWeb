package com.movie.controller;

import java.io.File;
import java.io.IOException;
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

import com.movie.pojo.Member;
import com.movie.service.MovieDaoService;

public class UploadServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private static MovieDaoService mds;
	@Override
	public void init() throws ServletException {
		String springPath=this.getServletContext().getInitParameter("springPath");
		ApplicationContext context=new ClassPathXmlApplicationContext(springPath);
		mds=context.getBean("movieDaoService",MovieDaoService.class);
	}

	public void service(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		// 设置接收的编码格式
		req.setCharacterEncoding("utf-8");
		String email=req.getParameter("email");
		
		// 获取上传文件的保存路径
		ServletContext context = this.getServletContext();
		String path = context.getRealPath("images");
		
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
					m.setMember_email(email);
					m.setMember_photo("/movie/images/"+fileName);
					mds.savePhoto(m);
				}
			}
			
			res.sendRedirect("/movie/main/index.jsp?email="+email);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}