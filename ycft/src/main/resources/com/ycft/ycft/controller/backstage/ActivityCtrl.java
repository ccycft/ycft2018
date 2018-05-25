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

import com.ycft.ycft.po.Content;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.po.TitleContent;
import com.ycft.ycft.services.backstage.ActivitySrv;

@Controller
public class ActivityCtrl {
	
	@Autowired
	private ActivitySrv as;

	@RequestMapping("/selActivity.do")
	public ModelAndView selActivity() {
		ModelAndView modelAndView = new ModelAndView();
		
		List<TitleContent> tcList = as.selAllInform();
		
		modelAndView.addObject("tcList", tcList);
		modelAndView.setViewName("backstage/activity/activityMaintenance/maintenance");
		
		return modelAndView;
	}
	
	/**
	 * 
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/addActivity.do")
	public String addInform(HttpServletResponse response,HttpServletRequest request, Content content,Title title,MultipartFile titleFile) throws IOException { 
		boolean flag = as.addActivityAffairs(request,content,title,titleFile);
		if(flag) {
			return "selActivity.do";
		}else {
			return "selActivity.do";
		}
		
	}
	
	@RequestMapping("/activityDel.do")
	public void del(HttpServletResponse response,HttpServletRequest request) {
		
		PrintWriter writer = null;
		int id = Integer.parseInt(request.getParameter("id"));
		try {
			writer = response.getWriter();
			boolean flag = as.del(id);
			if (flag) {
				writer.println("1");
			} else {
				writer.print("0");
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			writer.flush();
			writer.close();
		}
	}
}
