package sun.moviemgr.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {
		 /** 
         * 1,doFilter�����ĵ�һ������ΪServletRequest���󡣴˶�����������ṩ�˶Խ������Ϣ������* 
         * �����ݡ�cookie��HTTP����ͷ������ȫ���ʡ��ڶ�������ΪServletResponse��ͨ���ڼ򵥵Ĺ�* 
         * �����к��Դ˲��������һ������ΪFilterChain���˲�����������servlet��JSPҳ�� 
         */  
        HttpServletRequest request = (HttpServletRequest) servletRequest;  
        /** 
         * �������HTTP���󣬲�����Ҫ��������getHeader��getCookies����ServletRequest��* 
         * �޷��õ��ķ�������Ҫ�Ѵ�request�������HttpServletRequest 
         */  
        HttpServletResponse response = (HttpServletResponse) servletResponse;  
        String currentURL = request.getRequestURI();  
        // ȡ�ø�Ŀ¼����Ӧ�ľ���·��:  
        String targetURL = currentURL.substring(currentURL.indexOf("/", 1),  
                currentURL.length());  
        // ��ȡ����ǰ�ļ������ڱȽ�  
        HttpSession session = request.getSession(false);
        if (!"/adminJsp/adminLogin.jsp".equals(targetURL)) {// �жϵ�ǰҳ�Ƿ����ض����Ժ�ĵ�¼ҳ��ҳ�棬����ǾͲ���session���жϣ���ֹ������ѭ��  
            if (session == null || session.getAttribute("flag") == null) {
                // *�û���¼�Ժ����ֶ����session  
                response.sendRedirect(request.getContextPath() + "/adminJsp/adminLogin.jsp");  
                // ���sessionΪ�ձ�ʾ�û�û�е�¼���ض���login.jspҳ��  
                return;  
            }  
        }  
        // ����filter����������ִ��  
        filterChain.doFilter(request, response);  
        /** 
         * ����FilterChain�����doFilter������Filter�ӿڵ�doFilter����ȡһ��FilterChain������* Ϊ�� 
         * ��һ���������ڵ��ô˶����doFilter����ʱ��������һ����صĹ����������û����* 
         * һ����������servlet��JSPҳ���������servlet��JSPҳ�汻��� 
         */  

	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

}
