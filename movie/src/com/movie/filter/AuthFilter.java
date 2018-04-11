package com.movie.filter;

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

	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;  
        HttpServletResponse response = (HttpServletResponse) servletResponse;  
        String currentURL = request.getRequestURI();  
        String targetURL = currentURL.substring(currentURL.indexOf("/", 1),  
                currentURL.length());  
        HttpSession session = request.getSession(false);
        if (!"/main/login.jsp".equals(targetURL)) {
        	if (session == null || session.getAttribute("email") == null) {
                response.sendRedirect(request.getContextPath() + "/main/login.jsp");   
            }  
        }  
        filterChain.doFilter(request, response);  
	}

	@Override
	public void destroy() {

	}

}
