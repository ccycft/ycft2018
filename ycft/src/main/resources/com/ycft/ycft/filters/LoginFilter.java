package com.ycft.ycft.filters;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ycft.ycft.po.User;
import com.ycft.ycft.services.PrivilegeService;
import com.ycft.ycft.system.SysPrivilege;
import com.ycft.ycft.tools.BeanUtil;

/**
 * Servlet Filter implementation class LoginFilter
 */
public class LoginFilter implements Filter {
	
	//不过滤请求
	private static final String LOGINJSP = "backstagelogin.html";
	private static final String LOGINACTION = "userAjax.do";
	//项目名
	private static final String PROJECTNAME = "ycft";
    /**
     * Default constructor. 
     */
    public LoginFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		
		//获取session
		HttpSession session = req.getSession();
		//用户
		User user = (User)session.getAttribute("user");
		//工程路径
		String path = req.getContextPath();
		String basePath = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+path+"/";
		PrintWriter out = res.getWriter();
		String requestURI = req.getRequestURI();
		int index = requestURI.indexOf(PROJECTNAME) + PROJECTNAME.length() + 1;
		String resource = requestURI.substring(index);
		System.out.println(resource+"+0++++");
		if(user != null) {
			//把地址栏的数据和用户应有的数据进行比较，如果是true，则放过
			SysPrivilege s = new SysPrivilege();
			//如果是true说明数据库里面有这个菜单
			boolean flag = s.compareMenuIsTrue(resource, req);
			if(flag) {
				//判断用户时候有这个菜单
				boolean state = s.compareMenu(resource, req);
				if(state) {
					chain.doFilter(request, response);
				}else {
					out.print("<script>window.top.location.href='" + basePath + LOGINJSP +"';</script>");
				}
			}else {
				//没有菜单直接放过
				chain.doFilter(request, response);
			}
		}else {
			if(LOGINACTION.equals(resource) || LOGINJSP.equals(resource)){
				chain.doFilter(request, response);
			}else {
				//返回登录
				out.print("<script>window.top.location.href='" + basePath + LOGINJSP +"';</script>");
			}
		}
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
