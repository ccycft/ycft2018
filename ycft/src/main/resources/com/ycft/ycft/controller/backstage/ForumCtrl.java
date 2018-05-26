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
	 * ��ѯ��̳��Ϣ
	 * @return
	 */
	@RequestMapping("selForum.do")
	public ModelAndView selForum(HttpServletRequest request){
		ModelAndView modelAndView = new ModelAndView();
		//��ѯ��̳����Ϣ
		List<TitleContent> tcList = forumSrv.selAllForum();
		modelAndView.addObject("tcList", tcList);
		//���ؽ������
		modelAndView.setViewName("backstage/forum/forumMaintenance/maintenance");
		return modelAndView;
	}
	/**
	 * ��ѯ������Ϣ
	 * @return
	 */
	@RequestMapping("selComment.do")
	public ModelAndView selComment(HttpServletRequest request,int id){
		ModelAndView modelAndView = new ModelAndView();
		//��ѯ��̳����Ϣ
		List<Title> titleList = forumSrv.selTitleCommentById(id);
		modelAndView.addObject("titleList", titleList); 
		System.out.println(titleList.get(0).getComment().get(0).getContent()+"------");
		System.out.println(titleList.get(1).getComment().get(0).getContent()+"------");
		//���ؽ������
		modelAndView.setViewName("backstage/forum/forumMaintenance/maintenance");
		return modelAndView;
	}
	
}
