package com.ycft.ycft.controller.backstage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ycft.ycft.system.Menu;

@Controller
public class LoginCtrl {

	
	@RequestMapping("/jump.do")
	public ModelAndView jump() {
		
		ModelAndView modelAndView = new ModelAndView();
		System.out.println("---------");
		if (Menu.pList.size() > 0) {
			String url = Menu.pList.get(0).getChildMenus().get(0).getmUrl();
			modelAndView.setViewName(url);
		} else {
			modelAndView.setViewName("fail.jsp");
		}
		
		
		return modelAndView;
		
	}
}
