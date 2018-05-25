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
		
		List<TitleContent> tcList = as.selAllActivity();
		
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
	
	/**
	 * 点修改带id进来查询出数据到修改界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/activityUpdate.do")
	public ModelAndView activityUpdate(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		
		int id = Integer.parseInt(request.getParameter("id"));
		
		TitleContent tc = as.selAllActivityById(id);
		
		modelAndView.addObject("tc",tc);
		modelAndView.setViewName("backstage/activity/activityMaintenance/activityUpdate");
		
		return modelAndView;
	}
	
	@RequestMapping("/updActivity.do")
	public void updActivity(HttpServletResponse response,HttpServletRequest request,Title title,Content content,MultipartFile updFile) throws IOException {
		boolean flag = as.updActivity(request,title,content,updFile);
		if(flag) {
			response.setContentType("text/html");
        	response.setCharacterEncoding("UTF-8");
        	PrintWriter out = response.getWriter();
        	out.println("<script>"); 
        	out.println("alert('修改成功');"); 
        	out.println("window.opener=null;window.close();");
        	out.println("</script>");
		}else {
			response.setContentType("text/html");
        	response.setCharacterEncoding("UTF-8");
        	PrintWriter out = response.getWriter();
        	out.println("<script>"); 
        	out.println("alert('修改失败');"); 
        	out.println("window.opener=null;window.close();");
        	out.println("</script>");
		}
	}
}
