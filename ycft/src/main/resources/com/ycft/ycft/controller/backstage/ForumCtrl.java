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
import com.sun.tools.hat.internal.server.FinalizerObjectsQuery;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.po.TitleContent;
import com.ycft.ycft.services.backstage.ForumSrv;

@Controller
public class ForumCtrl {
	
	@Autowired
	private ForumSrv forumSrv;
	
	/**
	 * ��ѯ��̳��Ϣ
	 * @author ���ٸ�
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
	 * ��ѯ������Ϣ,ʹ��gson����ǰ̨
	 * @author ���ٸ�
	 * @return
	 */
	@RequestMapping("selComment.do")
	public void selComment(HttpServletRequest request,HttpServletResponse response,int id){
		
		PrintWriter writer = null;
		try {
			//���ñ����ʽ
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			writer = response.getWriter();
			//��ѯ�����۵ı���
			List<Title> titleWithCommentList = forumSrv.selTitleCommentById(id);
			Gson g = new Gson();
			//ת����json
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
	 * ɾ����̳��Ϣ
	 * @param response
	 * @param request
	 * @param id
	 */
	@RequestMapping("forumDel.do")
	public void forumDel(HttpServletResponse response,HttpServletRequest request,int id) {
		PrintWriter writer = null;
		try {
			//�����ʽ
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			writer = response.getWriter();
			//ɾ��ͨ��id
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
	 * ɾ��������Ϣ
	 * @author ���ٸ�
	 * @param request
	 * @param response
	 * @param id
	 */
	@RequestMapping("commentDel.do")
	public void commentDel(HttpServletRequest request,HttpServletResponse response,int id) {
		PrintWriter writer = null;
		try {
			//�����ʽ
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
	
}
