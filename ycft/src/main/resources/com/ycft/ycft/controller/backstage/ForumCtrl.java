package com.ycft.ycft.controller.backstage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ycft.ycft.po.Title;
import com.ycft.ycft.po.TitleContent;
import com.ycft.ycft.services.backstage.ForumSrv;

@Controller
public class ForumCtrl {
	
	@Autowired
	private ForumSrv forumSrv;
	
	/**
	 * 查询论坛信息
	 * @return
	 */
	@RequestMapping("selForum.do")
	public ModelAndView selForum(HttpServletRequest request){
		ModelAndView modelAndView = new ModelAndView();
		//查询论坛的信息
		List<TitleContent> tcList = forumSrv.selAllForum();
		modelAndView.addObject("tcList", tcList);
		//返回结果界面
		modelAndView.setViewName("backstage/forum/forumMaintenance/maintenance");
		return modelAndView;
	}
	/**
	 * 查询评论信息
	 * @return
	 */
	@RequestMapping("selComment.do")
	public ModelAndView selComment(HttpServletRequest request,int id){
		ModelAndView modelAndView = new ModelAndView();
		//查询论坛的信息
		List<Title> titleList = forumSrv.selTitleCommentById(id);
		modelAndView.addObject("titleList", titleList); 
		System.out.println(titleList.get(0).getComment().get(0).getContent()+"------");
		System.out.println(titleList.get(1).getComment().get(0).getContent()+"------");
		//返回结果界面
		modelAndView.setViewName("backstage/forum/forumMaintenance/maintenance");
		return modelAndView;
	}
	
}
