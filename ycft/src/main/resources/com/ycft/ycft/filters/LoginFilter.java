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
	
	//����������
	private static final String LOGINJSP = "backstagelogin.html";
	private static final String LOGINACTION = "userAjax.do";
	//��Ŀ��
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
		
		//��ȡsession
		HttpSession session = req.getSession();
		//�û�
		User user = (User)session.getAttribute("user");
		//����·��
		String path = req.getContextPath();
		String basePath = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+path+"/";
		PrintWriter out = res.getWriter();
		String requestURI = req.getRequestURI();
		int index = requestURI.indexOf(PROJECTNAME) + PROJECTNAME.length() + 1;
		String resource = requestURI.substring(index);
		System.out.println(resource+"+0++++");
		if(user != null) {
			//�ѵ�ַ�������ݺ��û�Ӧ�е����ݽ��бȽϣ������true����Ź�
			SysPrivilege s = new SysPrivilege();
			//�����true˵�����ݿ�����������˵�
			boolean flag = s.compareMenuIsTrue(resource, req);
			if(flag) {
				//�ж��û�ʱ��������˵�
				boolean state = s.compareMenu(resource, req);
				if(state) {
					chain.doFilter(request, response);
				}else {
					out.print("<script>window.top.location.href='" + basePath + LOGINJSP +"';</script>");
				}
			}else {
				//û�в˵�ֱ�ӷŹ�
				chain.doFilter(request, response);
			}
		}else {
			if(LOGINACTION.equals(resource) || LOGINJSP.equals(resource)){
				chain.doFilter(request, response);
			}else {
				//���ص�¼
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
