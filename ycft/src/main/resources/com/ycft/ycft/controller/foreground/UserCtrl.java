package com.ycft.ycft.controller.foreground;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ycft.ycft.po.User;
import com.ycft.ycft.services.foreground.UserSrv;

/**
 * 用户控制层
 * @author 邵帅
 *
 */
@Controller(value="foreUserCon")
@RequestMapping("fore/user/")
public class UserCtrl {
	
	@Autowired
	private UserSrv us;
	
	/**
	 * 客户端登录
	 * 
	 * @author 邵帅
	 * @param User u 参数绑定User对象
	 * @param res HttpServletResponse对象
	 * 2018年5月16日下午3:53:13
	 */ 
	@RequestMapping("login.do")
	public void login(User u , HttpServletResponse rspn) {
		//是否登录成功
		User user = us.login(u.getSno(), u.getPsd());
		boolean isLogin = false;
		if (user != null) {
			//开始存储session,cookie啥的
			//实例化一个Cookie  
	        Cookie cookie1 = new Cookie("uid", String.valueOf(u.getId()));  
	        Cookie cookie2 = new Cookie("sno", u.getSno());  
	        //设置Cookie的生命期限五年  
	        cookie1.setMaxAge(5*365*24*60*60);  
	        cookie2.setMaxAge(5*365*24*60*60);  
	        //添加Cookie到客户端  
	        rspn.addCookie(cookie1);  
	        rspn.addCookie(cookie2); 
			//........../
	        isLogin = true;
		}
		PrintWriter out = null;
		try {
			out = rspn.getWriter();
			out.print("isSuccess="+isLogin);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
	}

}
