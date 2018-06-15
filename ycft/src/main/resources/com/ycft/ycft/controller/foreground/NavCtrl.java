package com.ycft.ycft.controller.foreground;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.ycft.ycft.po.Navigation;
import com.ycft.ycft.services.backstage.NavigationSrv;

@Controller
@RequestMapping("fore/")
public class NavCtrl {
	
	@Autowired
	private NavigationSrv ns;
	
	
	/**
	 * 通过id逐个查询地点ajax
	 * @param response
	 * @param request
	 * @param id
	 */
	@RequestMapping("selNavigationById.do")
	public void selNavigationById(HttpServletResponse response,HttpServletRequest request) {
		int id = Integer.parseInt(request.getParameter("id"));
		Navigation n = ns.selById(id);
		Gson g = new Gson();
		//后台提示一下，并关闭当前页面
		response.setContentType("text/html");
    	response.setCharacterEncoding("UTF-8");
    	PrintWriter out;
		try {
			out = response.getWriter();
			out.print(g.toJson(n));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
