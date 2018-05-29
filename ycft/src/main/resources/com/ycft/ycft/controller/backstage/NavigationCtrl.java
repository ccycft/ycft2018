package com.ycft.ycft.controller.backstage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ycft.ycft.po.Navigation;

@Controller
public class NavigationCtrl {
	
	public ModelAndView navigationSel() {
		ModelAndView modelAndView = new ModelAndView();
		
		
		return modelAndView;
	}
	
	/**
	 * @author ZHENGBIN
	 * @param navigation
	 * @return
	 */
	@RequestMapping("navigationUpdate.do")
	public ModelAndView navigationUpdate(Navigation navigation) {
		ModelAndView modelAndView = new ModelAndView();
		
		
		
		
		return modelAndView;
	}

}
