package com.ycft.ycft.controller.backstage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ycft.ycft.po.Privilege;
import com.ycft.ycft.po.User;
import com.ycft.ycft.services.PrivilegeService;


@Controller
public class LoginCtrl {
	
	@Autowired
	PrivilegeService ps;
	
	@RequestMapping("/jump.do")
	public ModelAndView jump(HttpServletRequest request) {
		
		ModelAndView modelAndView = new ModelAndView();
		User user = (User)request.getSession().getAttribute("user");
		List<Privilege> privilegeList = null;
		if(user != null) {
			privilegeList = ps.testQueryMenuList(user);
		}
		if (privilegeList!= null && privilegeList.size() > 0) {
			String url = privilegeList.get(0).getChildMenus().get(0).getmUrl();
			modelAndView.setViewName(url);
		} else {
			modelAndView.setViewName("fail.jsp");
		}
		
		
		return modelAndView;
		
	}
}
