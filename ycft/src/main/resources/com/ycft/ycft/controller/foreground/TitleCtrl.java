package com.ycft.ycft.controller.foreground;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ycft.ycft.mapper.TitleMapper;
import com.ycft.ycft.po.Content;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.po.TitleContent;

@Controller(value="foreTitleCtrl")
@RequestMapping("fore/title/")
public class TitleCtrl {
	
	@Autowired
	TitleMapper tm;

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
}
