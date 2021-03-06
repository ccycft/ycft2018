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
import com.ycft.ycft.services.backstage.InformSrv;

@Controller
@RequestMapping("backstage/")
public class InformCtrl {
	
	@Autowired
	private InformSrv is;
	
	/**
	 * 查询所有的通知
	 * @author 马荣福
	 * @return
	 */
	@RequestMapping("/selInform.do")
	public ModelAndView selInform() { 
		ModelAndView modelAndView = new ModelAndView();
		
		List<TitleContent> tcList = is.selAllInform();
		
		modelAndView.addObject("tcList", tcList);
		//返回界面
		modelAndView.setViewName("backstage/inform/informMaintenance/maintenance.jsp");
		
		return modelAndView;
		
	}
	/**
	* @param response
	 * @param request
	 * @param content 内容
	 * @param title 标题
	 * @param titleFile 标题文件
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/addInform.do")
	public String addInform(HttpServletResponse response,HttpServletRequest request, Content content,Title title,MultipartFile titleFile) throws IOException { 
		boolean flag = is.addInformAffairs(request,content,title,titleFile);
		if(flag) {
			return "redirect:/backstage/selInform.do";
		}else {
			return "redirect:/backstage/selInform.do";
		}
		
	}
	/**
	 * 删除通知成功后返回原页面
	 * @author ZHENGBIN
	 * @param request
	 * @return selInform.do
	 */
	@RequestMapping("/informDel.do")
	public ModelAndView del(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		//获取删除的id
		int id = Integer.parseInt(request.getParameter("id"));
		boolean flag = is.del(id);
		//删除成功返回true
		if (flag) {
			modelAndView.setViewName("redirect:/backstage/selInform.do");
		} else {
			modelAndView.setViewName("redirect:/backstage/fail.jsp");
		}
		return modelAndView;
	}
	
	/**
	 * 点修改带id进来查询出数据到修改界面
	 * @author ZHENGBIN
	 * @param request
	 * @return backstage/inform/informMaintenance/informUpdate.jsp
	 */
	@RequestMapping("/informUpdate.do")
	public ModelAndView informUpdate(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		
		int id = Integer.parseInt(request.getParameter("id"));
		//获取到该id的信息
		TitleContent tc = is.selAllInformById(id);
		
		modelAndView.addObject("tc",tc);
		modelAndView.setViewName("backstage/inform/informMaintenance/informUpdate.jsp");
		
		return modelAndView;
	}
	
	/**
	 * 修改通知信息
	 * @param response
	 * @param request
	 * @param title
	 * @param content
	 * @param updFile
	 * @throws IOException
	 */
	@RequestMapping("/updInform.do")
	public void updInform(HttpServletResponse response,HttpServletRequest request,Title title,Content content,MultipartFile updFile) throws IOException {
		boolean flag = is.updInform(request,title,content,updFile);
		//使用js关闭页面
		if(flag) {
			response.setContentType("text/html");
        	response.setCharacterEncoding("UTF-8");
        	PrintWriter out = response.getWriter();
        	out.println("<script>"); 
        	out.println("alert('修改成功');"); 
        	out.println("window.open('selInform.do','_top');");
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
