package poly.filter;

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

import poly.dto.UserMemberDTO;

public class CrossScriptingFilter implements Filter {
	 
	private FilterConfig filterConfig;

	public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }
 
    public void destroy() {
        this.filterConfig = null;
    }
 
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {
    	
    	HttpServletRequest httpReq = (HttpServletRequest) request;
    	HttpSession session = httpReq.getSession(false);
/*
    	
    	if(session.getAttribute("uDTO") == null) {
    		System.out.println("세션 만료됨");
    		
    	} else {
    	}
    	*/
    	chain.doFilter(new UrlFilter((HttpServletRequest) request), response);
    	
    	
 
    }

 
}