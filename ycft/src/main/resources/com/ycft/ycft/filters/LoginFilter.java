package com.ycft.ycft.filters;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ycft.ycft.po.User;
import com.ycft.ycft.system.SysPrivilege;

/**
 * Servlet Filter implementation class LoginFilter
 */
public class LoginFilter implements Filter {
	
	//不过滤请求
	private static final String LOGINJSP = "backstagelogin.html";
	private static final String LOGINACTION = "backstage/userAjax.do";
	//项目名
	private static final String PROJECTNAME = "ycft";
	private static final String BACK_STAGE = "backstage";
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
		request.setCharacterEncoding("utf-8");  
		response.setCharacterEncoding("utf-8"); 
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		//设置编码格式
		req.setCharacterEncoding("utf-8");  
		res.setCharacterEncoding("utf-8");  
       // res.setContentType("text/html;charset=utf-8");  
		//获取session
		HttpSession session = req.getSession();
		//用户
		User user = (User)session.getAttribute("user");
		//工程路径
		String path = req.getContextPath();
		String basePath = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+path+"/";
		PrintWriter out = res.getWriter();
		String requestURI = req.getRequestURI();
		int index = 0;
		//地址栏上的地址如果包含ycft，则从ycft向后截取
		if(requestURI.contains(PROJECTNAME)) {
			index = requestURI.indexOf(PROJECTNAME) + PROJECTNAME.length() + 1;
		}else {
			index = requestURI.indexOf("/") + 1;
		}
		String resource = requestURI.substring(index);
		//后台
		if(resource.startsWith(BACK_STAGE)) {
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
					chain.doFilter(req, res);
					//res.sendRedirect( basePath + LOGINJSP );
				}else {
					//返回登录
					out.print("<script>window.top.location.href='" + basePath + LOGINJSP +"';</script>");
				}
			}
		}else {
			if(resource.contains("login.do") || resource.contains("preLogin.jsp") || resource.contains("redirct_preLogin.jsp")) {
				chain.doFilter(req,res);
				return ;
			}
			//
			Cookie[] cs = req.getCookies();
			Integer uid = null;
			try {
				if(cs != null && cs.length > 0) {
					for(Cookie c : cs) {
						if(c.getName().equals("uid")) {
							uid = Integer.parseInt(c.getValue());
						}
					}
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				uid = 0;
			}
			//如果uid为0  说明无uid信息  则转向登录
			if(uid == null || uid == 0) {
				res.sendRedirect(basePath + "redirct_preLogin.jsp");
				return ;
			}else {
				chain.doFilter(req,res);
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
