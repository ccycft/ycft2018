package com.ycft.ycft.controller.foreground;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.ycft.ycft.mapper.CommentMapper;
import com.ycft.ycft.mapper.PraiseMapper;
import com.ycft.ycft.mapper.TitleMapper;
import com.ycft.ycft.po.Comment;
import com.ycft.ycft.po.Forum;
import com.ycft.ycft.po.Praise;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.po.TitleContent;
import com.ycft.ycft.services.foreground.TitleSrv;

@Controller(value="foreTitleCtrl")
@RequestMapping("fore/title/")
public class TitleCtrl {
	
	@Autowired
	TitleMapper tm;
	@Autowired
	TitleSrv ts;
	@Autowired
	PraiseMapper pm;
	
	/**
	 * ����ʱ�併�� ��ѯ����
	 * @param nowPage ��ǰҳ
	 * @return
	 */
	@RequestMapping("loadArticle.do")
	public ModelAndView loadArticle(Integer nowPage ) {
		ModelAndView mav = new ModelAndView();
		if(nowPage == null || nowPage <= 0) {
			nowPage = 1;
		}
		//Ĭ�ϲ�ѯ��������
		int pageSize = 4;
		int start = ( nowPage - 1 ) * pageSize;
		List<Title> tList = tm.selectByTime(1, start , pageSize);
		mav.addObject("tList" , tList);
		mav.setViewName("article.jsp");
		return mav;
	}
	
	/**
	 * ����ʱ�併�� ��ѯ֪ͨ
	 * @param nowPage ��ǰҳ
	 * @return
	 */
	@RequestMapping("loadInform.do")
	public ModelAndView loadInform(Integer nowPage ) {
		ModelAndView mav = new ModelAndView();
		if(nowPage == null || nowPage <= 0) {
			nowPage = 1;
		}
		//Ĭ�ϲ�ѯ��������
		int pageSize = 4;
		int start = ( nowPage - 1 ) * pageSize;
		List<Title> tList = tm.selectByTime(2, start , pageSize);
		mav.addObject("tList" , tList);
		mav.setViewName("inform.jsp");
		return mav;
	}
	//��ѯ��������
	@RequestMapping("articleDetail.do")
	public ModelAndView articleDetail(Integer id) {
		TitleContent con = tm.selAllByTypeAndId(1, id);
		ModelAndView mav = new ModelAndView();
		mav.addObject("titleContent" , con);
		mav.setViewName("articleDetails.jsp");
		return mav;
	}
	//��ѯ֪ͨ����
	@RequestMapping("informDetail.do")
	public ModelAndView informDetail(Integer id) {
		TitleContent con = tm.selAllByTypeAndId(2, id);
		ModelAndView mav = new ModelAndView();
		mav.addObject("titleContent" , con);
		mav.setViewName("informDetails.jsp");
		return mav;
	}
	/**
	 * ��ѯ�����
	 * @param id �id
	 * @return
	 */
	@RequestMapping("activityDetail.do")
	public ModelAndView activityDetail(Integer id) {
		TitleContent con = tm.selAllByTypeAndId(3, id);
		ModelAndView mav = new ModelAndView();
		mav.addObject("titleContent" , con);
		mav.setViewName("activityDetails.jsp");
		return mav;
	}
	/**
	 * ��ѯ� ����ʱ�併��
	 * @param nowPage ��ǰҳ
	 * @return
	 */
	@RequestMapping("loadActivity.do")
	public ModelAndView loadActivity(Integer nowPage) {
		ModelAndView mav = new ModelAndView();
		//Ĭ�ϲ�ѯ��������
		int pageSize = 4;
		if(nowPage == null || nowPage == 0) {
			nowPage = 1;
		}
		int start = ( nowPage - 1 ) * pageSize;
		if(start < 0 ) {
			start = 0;
		}
		//����ʱ���ѯ���» �ͱ������� 3�������ѯ�
		List<Title> tList = tm.selectByTimeAndCount(start , pageSize);
		mav.addObject("tList" , tList);
		mav.setViewName("activity.jsp");
		return mav;
	}
	
	/**
	 * �����
	 * @param tid �id
	 * @param uid �û�id
	 * @param rspn response
	 */
	@RequestMapping("joinActivity.do")
	public void joinActivity(Integer tid , Integer uid , HttpServletResponse rspn) {
		//��ѯ���û��Ƿ��Ѿ���������
		boolean b = ts.selectIsJoin(tid , uid);
		PrintWriter out = null;
		try {
			out =  rspn.getWriter();
			///���û������
			if(!b) {
				boolean isSuccess = ts.joinActivity(tid , uid);
					if(isSuccess) {
						out.print(1);
					}else {
						out.print(0);
					}
					
			}else {
				//2�����Ѿ���������...
				out.print(2);
			}
			out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			out.close();
		}
		
	}
	
	//��ѯ��̳
	@RequestMapping("selectForum.do")
	public ModelAndView selectForum(Integer nowPage , Integer pageSize) {
		if(pageSize == null || pageSize == 0) {
			//���ǰ��δָ����ѯ��������  �Ǻ�ָ̨��Ϊ4��
			pageSize = 4;
		}
		if(nowPage == null || nowPage <= 0) {
			nowPage = 1;
		}
		int start = (nowPage - 1 ) * pageSize;
		ModelAndView mav = new ModelAndView();
		mav.setViewName("forum.jsp");
		List<Forum> fList = ts.selectForum(start , pageSize);
		mav.addObject("sList",fList);
		return mav;
	}
	
	@RequestMapping("selDetail.do")
	public ModelAndView selDetailAndComment(Integer id) {
		List<Forum> fList = ts.selDetail(id);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("forumDetails.jsp");
		mav.addObject("fList",fList);
		return mav;
	}
	
	@Autowired
	CommentMapper cm;
	//��ѯ����
	@RequestMapping("selComment.do")
	public void selDetail(Integer id , HttpServletResponse rspn) {
		List<Comment> fList = cm.selComment(id);
		Gson g = new Gson();
		String rtn = g.toJson(fList);
		PrintWriter out = null;
		try {
			out =  rspn.getWriter();
			out.print(rtn);
			out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			out.close();
		}
	}
	
	//ajax �û�����
	@RequestMapping("comment.do")
	public void comment(Comment comment , HttpServletRequest req , HttpServletResponse rspn) {
		Cookie[] cookies = req.getCookies();
		int uid = 0;
		if(cookies != null && cookies.length > 0) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("uid")) {
					uid = Integer.parseInt(cookie.getValue());
				}
			}
		}
		//ȱ���û���Ϣֱ�ӽ���
		if(uid == 0) {
			return ; 
		}
		
		//�����û���Ϣ
		comment.setUid(uid);
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		//���õ�ǰʱ��
		comment.setTime(sdf.format(date));
		//��ʼ�����û�����
		System.out.println(comment.getContent()+"==========");
		int i = tm.insertComment(comment);
		
		PrintWriter out = null;
		try {
			out =  rspn.getWriter();
			
			//1����ɹ�  0����ʧ��...
			out.print(i > 0 ? 1 : 0);
			out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			out.close();
		}
		
	}
	
	@RequestMapping("dianzan.do")
	public void dianzan(Integer tid , HttpServletRequest req , HttpServletResponse rspn) {
		Cookie[] cookies = req.getCookies();
		int uid = 0;
		if(cookies != null && cookies.length > 0) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("uid")) {
					uid = Integer.parseInt(cookie.getValue());
				}
			}
		}
		//ȱ���û���Ϣֱ�ӽ���
		if(uid == 0) {
			return ; 
		}
		
		//�����û���Ϣ
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		//���õ�ǰʱ��
		//��ʼ�����û�����
		System.out.println("����==========");
		Praise p = new Praise();
		p.setStatus("����");
		p.setTime(sdf.format(date) );
		p.setUid(uid);
		p.setTid(tid);
		//�������
		int i = pm.dianzan(p );
		
		PrintWriter out = null;
		try {
			out =  rspn.getWriter();
			
			//1����ɹ�  0����ʧ��...
			out.print(i > 0 ? 1 : 0);
			out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			out.close();
		}
	}
}
