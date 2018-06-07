package com.ycft.ycft.controller.foreground;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ycft.ycft.po.User;
import com.ycft.ycft.services.foreground.UserSrv;

/**
 * �û����Ʋ�
 * @author ��˧
 *
 */
@Controller(value="foreUserCtrl")
@RequestMapping("fore/user/")
public class UserCtrl {
	
	@Autowired
	private UserSrv us;
	
	/**
	 * �ͻ��˵�¼
	 * 
	 * @author ��˧
	 * @param User u ������User����
	 * @param res HttpServletResponse����
	 * 2018��5��16������3:53:13
	 */ 
	@RequestMapping("login.do")
	public void login(User u , HttpServletResponse rspn) {
		//�Ƿ��¼�ɹ�
		User user = us.login(u.getSno(), u.getPsd());
		boolean isLogin = false;
		if (user != null) {
			//��ʼ�洢session,cookieɶ��
			//ʵ����һ��Cookie  
	        Cookie cookie1 = new Cookie("uid", String.valueOf(user.getId()));  
	        Cookie cookie2 = new Cookie("sno", user.getSno());  
	        //����
	        Cookie cookie3 = null;
			try {
				cookie3 = new Cookie("sname",  URLEncoder.encode(user.getSname(), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}  
	        //�绰
	        Cookie cookie4 = new Cookie("tel", user.getTel());  
	        //����Cookie��������������  
	        cookie1.setMaxAge(5*365*24*60*60);  
	        cookie2.setMaxAge(5*365*24*60*60);  
	        cookie3.setMaxAge(5*365*24*60*60);  
	        cookie4.setMaxAge(5*365*24*60*60); 
	        cookie1.setPath("/");
	        cookie2.setPath("/");
	        cookie3.setPath("/");
	        cookie4.setPath("/");
	        //���Cookie���ͻ���  
	        rspn.addCookie(cookie1);  
	        rspn.addCookie(cookie2); 
	        rspn.addCookie(cookie3); 
	        rspn.addCookie(cookie4); 
			//........../
	        isLogin = true;
		}
	/*	ModelAndView mav = new ModelAndView();
		if(isLogin) {
			mav.setViewName("fore/index/index.do");
		}else {
			mav.setViewName("preLogin.jsp");
		}*/
		PrintWriter out = null;
		try {
			out = rspn.getWriter();
			out.print(isLogin);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
	}
	
	@RequestMapping("select.do")
	public ModelAndView login(HttpServletRequest rq) {
		//�Ƿ��¼�ɹ�
		Cookie[] cookies = rq.getCookies();
		int uid = 1;
		try {
			if(cookies != null && cookies.length > 0) {
				for(Cookie cookie : cookies) {
					if(cookie.getName().equals("uid")) {
						uid = Integer.parseInt(cookie.getValue());
					}
				}
			}
			//��ѯ�û���Ϣ
		 	User u = us.selectById(uid);
		 	ModelAndView mav = new ModelAndView();
		 	mav.setViewName("personal.jsp");
		 	mav.addObject("user" , u);
		 	return mav;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace( );
			return null;
		}
		 
	}	
	
	
	
	public static void main(String[] args) throws UnsupportedEncodingException {
		 String a = URLEncoder.encode("��˧", "UTF-8");
		 System.out.println(a);
	}

}
