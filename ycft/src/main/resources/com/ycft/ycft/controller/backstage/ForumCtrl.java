package com.ycft.ycft.controller.backstage;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.po.TitleContent;
import com.ycft.ycft.services.backstage.ForumSrv;

@Controller
@RequestMapping("backstage/")
public class ForumCtrl {
	
	@Autowired
	private ForumSrv forumSrv;
	
	/**
	 * 查询论坛信息
	 * @author 马荣福
	 * @return
	 */
	@RequestMapping("selForum.do")
	public ModelAndView selForum(HttpServletRequest request){
		ModelAndView modelAndView = new ModelAndView();
		//查询论坛的信息
		List<TitleContent> tcList = forumSrv.selAllForum();
		modelAndView.addObject("tcList", tcList);
		//返回结果界面
		modelAndView.setViewName("backstage/forum/forumMaintenance/maintenance.jsp");
		return modelAndView;
	}
	/**
	 * 查询评论信息,使用gson传到前台
	 * @author 马荣福
	 * @return
	 */
	@RequestMapping("selComment.do")
	public void selComment(HttpServletRequest request,HttpServletResponse response,int id){
		
		PrintWriter writer = null;
		try {
			//设置编码格式
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			writer = response.getWriter();
			//查询带评论的标题
			List<Title> titleWithCommentList = forumSrv.selTitleCommentById(id);
			Gson g = new Gson();
			//转化成json
			String commentGson = g.toJson(titleWithCommentList);
			writer.print(commentGson);
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			writer.flush();
			writer.close();
		}
	}
	/**
	 * 删除论坛信息
	 * @param response
	 * @param request
	 * @param id
	 */
	@RequestMapping("forumDel.do")
	public void forumDel(HttpServletResponse response,HttpServletRequest request,int id) {
		PrintWriter writer = null;
		try {
			//编码格式
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			writer = response.getWriter();
			//删除通过id
			int temp = forumSrv.forumDel(id);
			
			if(temp > 0) {
				writer.print("1");
			}else {
				writer.print("0");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			writer.flush();
			writer.close();
		}
	}
	/**
	 * 删除评论信息
	 * @author 马荣福
	 * @param request
	 * @param response
	 * @param id
	 */
	@RequestMapping("commentDel.do")
	public void commentDel(HttpServletRequest request,HttpServletResponse response,int id) {
		PrintWriter writer = null;
		try {
			//编码格式
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			
			writer = response.getWriter();
			int temp = forumSrv.commentDel(id);
			if(temp > 0) {
				writer.print("1");
			}else {
				writer.print("0");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			writer.flush();
			writer.close();
		}
	}
	
	/**
	 * 恢复某条举报内容
	 * @author ZHENGBIN
	 * @param id 参数绑定
	 * @return backstage/selForum.do
	 */
	@RequestMapping("/forumRestore.do")
	public ModelAndView forumRestore(int id) {
		ModelAndView modelAndView = new ModelAndView();
		//恢复成功返回显示页面
		String url = forumSrv.forumRestore(id) ? "redirect:/backstage/selForum.do" : "redirect:/backstage/fail.jsp";
		
		modelAndView.setViewName(url);
		
		return modelAndView;
	}
	
	/**
	 * 恢复某条举报评论
	 * @author ZHENGBIN
	 * @param id 参数绑定
	 * @return backstage/selForum.do
	 */
	@RequestMapping("/commentRestore.do")
	public ModelAndView commentRestore(int id) {
		ModelAndView modelAndView = new ModelAndView();
		//恢复成功返回显示页面
		String url = forumSrv.commentRestore(id) ? "redirect:/backstage/selForum.do" : "redirect:/backstage/fail.jsp";
		
		modelAndView.setViewName(url);
		
		return modelAndView;
	}
}
