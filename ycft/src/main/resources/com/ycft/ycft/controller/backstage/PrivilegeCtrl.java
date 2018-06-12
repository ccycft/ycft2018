package com.ycft.ycft.controller.backstage;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.ycft.ycft.po.Privilege;
import com.ycft.ycft.po.User;
import com.ycft.ycft.services.PrivilegeService;

@Controller
@RequestMapping("backstage/")
public class PrivilegeCtrl {
	
	@Autowired
	PrivilegeService ps;
	
	/**
	 * 
	 * @param user
	 * @param response
	 * @return
	 */
	@RequestMapping(value="privilege.do")
	public void selMenu(User user,HttpServletResponse response,HttpServletRequest request) {
		response.setCharacterEncoding("utf-8");
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			user = (User)request.getSession().getAttribute("user");
			List<Privilege> privilegeList = null;
			if(user != null) {
				privilegeList = ps.testQueryMenuList(user);
			}else {
				privilegeList = ps.testQueryMenuList(null);
			}
			Gson g = new Gson();
			String menuGson = g.toJson(privilegeList);
			writer.print(menuGson);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			writer.flush();
			writer.close();
		}
	}
}
