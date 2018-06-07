package com.ycft.ycft.controller.foreground;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ycft.ycft.mapper.TitleMapper;
import com.ycft.ycft.po.Forum;
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
	
	/**
	 * 根据时间降序 查询文章
	 * @param nowPage 当前页
	 * @return
	 */
	@RequestMapping("loadArticle.do")
	public ModelAndView loadArticle(Integer nowPage ) {
		ModelAndView mav = new ModelAndView();
		if(nowPage == null || nowPage <= 0) {
			nowPage = 1;
		}
		//默认查询四条数据
		int pageSize = 4;
		int start = ( nowPage - 1 ) * pageSize;
		List<Title> tList = tm.selectByTime(1, start , pageSize);
		mav.addObject("tList" , tList);
		mav.setViewName("article.jsp");
		return mav;
	}
	
	/**
	 * 根据时间降序 查询通知
	 * @param nowPage 当前页
	 * @return
	 */
	@RequestMapping("loadInform.do")
	public ModelAndView loadInform(Integer nowPage ) {
		ModelAndView mav = new ModelAndView();
		if(nowPage == null || nowPage <= 0) {
			nowPage = 1;
		}
		//默认查询四条数据
		int pageSize = 4;
		int start = ( nowPage - 1 ) * pageSize;
		List<Title> tList = tm.selectByTime(2, start , pageSize);
		mav.addObject("tList" , tList);
		mav.setViewName("inform.jsp");
		return mav;
	}
	//查询文章详情
	@RequestMapping("articleDetail.do")
	public ModelAndView articleDetail(Integer id) {
		TitleContent con = tm.selAllByTypeAndId(1, id);
		ModelAndView mav = new ModelAndView();
		mav.addObject("titleContent" , con);
		mav.setViewName("articleDetails.jsp");
		return mav;
	}
	//查询通知详情
	@RequestMapping("informDetail.do")
	public ModelAndView informDetail(Integer id) {
		TitleContent con = tm.selAllByTypeAndId(2, id);
		ModelAndView mav = new ModelAndView();
		mav.addObject("titleContent" , con);
		mav.setViewName("informDetails.jsp");
		return mav;
	}
	/**
	 * 查询活动详情
	 * @param id 活动id
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
	 * 查询活动 根据时间降序
	 * @param nowPage 当前页
	 * @return
	 */
	@RequestMapping("loadActivity.do")
	public ModelAndView loadActivity(Integer nowPage) {
		ModelAndView mav = new ModelAndView();
		//默认查询四条数据
		int pageSize = 4;
		if(nowPage == null || nowPage == 0) {
			nowPage = 1;
		}
		int start = ( nowPage - 1 ) * pageSize;
		if(start < 0 ) {
			start = 0;
		}
		//根据时间查询最新活动 和报名人数 3：代表查询活动
		List<Title> tList = tm.selectByTimeAndCount(start , pageSize);
		mav.addObject("tList" , tList);
		mav.setViewName("activity.jsp");
		return mav;
	}
	
	/**
	 * 活动报名
	 * @param tid 活动id
	 * @param uid 用户id
	 * @param rspn response
	 */
	@RequestMapping("joinActivity.do")
	public void joinActivity(Integer tid , Integer uid , HttpServletResponse rspn) {
		//查询该用户是否已经报过名？
		boolean b = ts.selectIsJoin(tid , uid);
		PrintWriter out = null;
		try {
			out =  rspn.getWriter();
			///如果没报过名
			if(!b) {
				boolean isSuccess = ts.joinActivity(tid , uid);
					if(isSuccess) {
						out.print(1);
					}else {
						out.print(0);
					}
					
			}else {
				//2代表已经报过名了...
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
	
	//查询论坛
	@RequestMapping("selectForum.do")
	public ModelAndView selectForum(Integer nowPage , Integer pageSize) {
		if(pageSize == null || pageSize == 0) {
			//如果前端未指定查询几条数据  那后台指定为4条
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
}
