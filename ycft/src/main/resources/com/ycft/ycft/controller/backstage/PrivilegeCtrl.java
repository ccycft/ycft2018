package com.ycft.ycft.controller.backstage;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.ycft.ycft.po.Privilege;
import com.ycft.ycft.po.User;
import com.ycft.ycft.services.PrivilegeService;

@Controller
public class PrivilegeCtrl {
	
	@Autowired
	PrivilegeService ps;
	
	/**
	 * ≤È—Ø≤Àµ•
	 * @param user
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("privilege.do")
	public ModelAndView selMenu(User user,HttpServletResponse response,HttpServletRequest request) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		List<Privilege> privilegeList = ps.testQueryMenuList();
		
		Gson g = new Gson();
		for(Privilege p : privilegeList) {
			p.setmName(URLEncoder.encode(p.getmName(), "UTF-8"));
			for(Privilege p2 : p.getChildMenus()) {
				p2.setmName(URLEncoder.encode(p2.getmName(), "UTF-8"));				
			}
		}
		String menuGson = g.toJson(privilegeList);
		System.out.println(menuGson);
		Cookie cookie = new Cookie("menuGson",menuGson );
		System.out.println(menuGson);
		response.addCookie(cookie);
		return mav;
	}
}
