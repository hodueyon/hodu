package egovframework.fusion.common.filter;


import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.util.ContentCachingRequestWrapper;

import java.io.IOException;


public class SnsFilter implements Filter {
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {
		System.out.println("filter pass");

		RereadableRequestWrapper requestWrapper = new RereadableRequestWrapper((HttpServletRequest) servletRequest);

		filterChain.doFilter(requestWrapper, servletResponse);
	}

	@Override
	public void destroy() {

	}
}