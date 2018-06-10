package com.ycft.ycft.system;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ycft.ycft.po.User;

@Controller
public class LogOut {
	
	/**
	 * 注销session
	 * @author ZHENGBIN
	 * @param session
	 * @return backstagelogin.html
	 */
	@RequestMapping("logOut.do")
	public ModelAndView logOut(HttpSession session) {
		ModelAndView modelAndView = new ModelAndView();
		User user = (User)session.getAttribute("user");
		System.out.println(user.getSname() + "注销了！");
		//注销session
		session.invalidate();
		
		modelAndView.setViewName("backstagelogin.html");
		return modelAndView;
	}
}
