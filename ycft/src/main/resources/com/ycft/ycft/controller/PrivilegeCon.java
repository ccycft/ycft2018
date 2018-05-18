package com.ycft.ycft.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ycft.ycft.po.Privilege;
import com.ycft.ycft.po.User;
import com.ycft.ycft.services.PrivilegeService;

@Controller
public class PrivilegeCon {
	
	@Autowired
	PrivilegeService ps;
	
	@RequestMapping("privilege.do")
	public ModelAndView selPrivilege(User user) {
		ModelAndView mav = new ModelAndView();
		List<Privilege> pList = ps.testQueryMenuList();
		mav.addObject("pList",pList);
		mav.setViewName("cpt/index.jsp");
		return mav;
	}
}
