package sun.moviemgr.controller;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.patchca.utils.encoder.EncoderHelper;
import sun.moviemgr.service.CaptchaService;

public class CaptchaServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void service(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		// 设置两个响应�?
		res.setContentType("image/png");
		res.setHeader("cache", "no-cache");
		
		OutputStream os = res.getOutputStream();
		
		// 值随�?,宽度110px,高度40px
		CaptchaService captchaService = new CaptchaService(110, 40);
		String captcha = EncoderHelper.getChallangeAndWriteImage(captchaService, "png", os);
		os.flush();
		
		if(os != null) {
			os.close();
			os = null;
		}
		
		req.getSession().setAttribute("captcha", captcha);
	}
}