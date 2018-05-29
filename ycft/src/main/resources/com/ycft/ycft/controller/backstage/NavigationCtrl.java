package com.ycft.ycft.controller.backstage;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.ycft.ycft.po.Content;
import com.ycft.ycft.po.Navigation;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.services.backstage.NavigationSrv;

@Controller
public class NavigationCtrl {
	
	@Autowired
	private NavigationSrv ns;
	
	/**
	 * 查询出全部的导航坐标
	 * @author ZHENGBIN
	 * @return backstage/navigation/navigationMaintenance/maintenance.jsp
	 */
	@RequestMapping("navigationSel.do")
	public ModelAndView navigationSel() {
		ModelAndView modelAndView = new ModelAndView();
		List<Navigation> nList = ns.navigationSel();
		if (nList != null) {
			modelAndView.addObject("nList",nList);
			modelAndView.setViewName("backstage/navigation/navigationMaintenance/maintenance.jsp");
		} else {
			modelAndView.setViewName("fail.jsp");
		}
		return modelAndView;
	}
	
	/**
	 * 通过id逐个查询地点ajax
	 * @param response
	 * @param request
	 * @param id
	 */
	@RequestMapping("selNavigationById.do")
	public void selNavigationById(HttpServletResponse response,HttpServletRequest request,int id) {
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
	/**
	 * 导航信息的录入==修改
	 * @author ZHENGBIN
	 * @param navigation 参数绑定
	 * @return navigationSel.do
	 */
	@RequestMapping("navigationUpdate.do")
	public ModelAndView navigationUpdate(Navigation navigation) {
		ModelAndView modelAndView = new ModelAndView();
		
		boolean flag = ns.navigationUpDate(navigation);
		//修改成功后返回显示页面
		if (flag) {
			modelAndView.setViewName("navigationSel.do");
		} else {
			modelAndView.setViewName("fail.jsp");
		}
		return modelAndView;
	}

	/**
	 * 通过id删除，通过参数绑定过来id
	 * @author ZHENGBIN
	 * @param navigation 参数绑定
	 * @return navigationSel.do
	 */
	@RequestMapping("navigationDel.do")
	public ModelAndView navigationDel(Navigation navigation) {
		ModelAndView modelAndView = new ModelAndView();
		boolean flag = ns.navigationDel(navigation);
		//删除成功后返回显示页面
		if (flag) {
			modelAndView.setViewName("navigationSel.do");
		} else {
			modelAndView.setViewName("fail.jsp");
		}
		return modelAndView;
	}
}
