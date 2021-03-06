package com.ycft.ycft.controller.foreground;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.ycft.ycft.mapper.CommentMapper;
import com.ycft.ycft.mapper.PraiseMapper;
import com.ycft.ycft.mapper.TitleMapper;
import com.ycft.ycft.po.Comment;
import com.ycft.ycft.po.Content;
import com.ycft.ycft.po.Forum;
import com.ycft.ycft.po.Praise;
import com.ycft.ycft.po.SignEvent;
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
	
	//查询文章分页
	@RequestMapping("loadArticleByPage.do")
	public void loadArticleByPage(Integer nowPage , Integer pageSize ,HttpServletResponse rspn) {
		if(nowPage == null || nowPage <= 0) {
			nowPage = 1;
		}
		//默认查询四条数据
		if(pageSize == null || pageSize == 0) {
			pageSize = 4;
		}
		
		int start = ( nowPage - 1 ) * pageSize;
		List<Title> tList = tm.selectByTime(1, start , pageSize);
		Gson g = new Gson();
		String rtn = g.toJson(tList);
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
	
	//分页查询 通知(由于首页通知两条一分页，所以首页请指定pageSize为2)
	@RequestMapping("loadInformByPage")
	public void loadInformByPage(Integer nowPage , Integer pageSize , HttpServletResponse rspn) {
		if(nowPage == null || nowPage <= 0) {
			nowPage = 1;
		}
		if(pageSize == null || pageSize == 0) {
			//默认查询四条数据
			pageSize = 4;
		}
		int start = ( nowPage - 1 ) * pageSize;
		List<Title> tList = tm.selectByTime(2, start , pageSize);
		Gson g = new Gson();
		String rtn = g.toJson(tList);
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
	public ModelAndView loadActivity(Integer nowPage , Integer pageSize) {
		ModelAndView mav = new ModelAndView();
		//默认查询四条数据
		if(pageSize == null || pageSize == 0) {
			pageSize = 4;
		}
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
	//加载活动分页
	@RequestMapping("loadActivityByPage.do")
	public void loadActivityByPage(Integer nowPage , Integer pageSize , HttpServletResponse rspn) {
		ModelAndView mav = new ModelAndView();
		//默认查询四条数据
		if(pageSize == null || pageSize == 0) {
			pageSize = 4;
		}
		if(nowPage == null || nowPage == 0) {
			nowPage = 1;
		}
		int start = ( nowPage - 1 ) * pageSize;
		if(start < 0 ) {
			start = 0;
		}
		//根据时间查询最新活动 和报名人数 3：代表查询活动
		List<Title> tList = tm.selectByTimeAndCount(start , pageSize);
		String rtn = new Gson().toJson(tList);
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
	
	//查询我报名的活动
	@RequestMapping("myActivity.do")
	public ModelAndView myReleaseSign(HttpServletRequest req , Integer nowPage , Integer pageSize) throws ParseException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("activityList.jsp");
		Cookie[] cs = req.getCookies();
		int uid = 0;
		try {
			for(Cookie c : cs) {
				if(c.getName().equals("uid")) {
					uid = (Integer.valueOf(c.getValue()));
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			mav.setViewName("exception.jsp");
		}
		if(uid == 0) {
			//未取到用户信息 可能用户未登录或者cookie丢失
			mav.setViewName("no_userinfo.jsp");
		}
		if(nowPage == null || nowPage == 0) {
			nowPage = 1;
		}
		//开始计算开始索引
		
		if(pageSize == null || pageSize == 0) {
			pageSize = 4;
		}
		int start = (nowPage - 1) * pageSize ; 
		List<Title> list = ts.selectActivityById(uid , start , pageSize);
		
		mav.addObject("tList" , list);
		return mav;
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
	 //查询论坛分页
	@RequestMapping("selectForumByPage.do")
	public void selectForumByPage(Integer nowPage , Integer pageSize , HttpServletResponse rspn) {
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
		String rtn = new Gson().toJson(fList);
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
	//查询评论
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
	
	//ajax 用户评论
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
		//缺少用户信息直接结束
		if(uid == 0) {
			return ; 
		}
		
		//设置用户信息
		comment.setUid(uid);
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		//设置当前时间
		comment.setTime(sdf.format(date));
		//开始插入用户评论
		System.out.println(comment.getContent()+"==========");
		int i = tm.insertComment(comment);
		
		PrintWriter out = null;
		try {
			out =  rspn.getWriter();
			
			//1代表成功  0代表失败...
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
		//缺少用户信息直接结束
		if(uid == 0) {
			return ; 
		}
		
		//设置用户信息
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		//设置当前时间
		//开始插入用户点赞
		System.out.println("点赞==========");
		Praise p = new Praise();
		p.setStatus("点赞");
		p.setTime(sdf.format(date) );
		p.setUid(uid);
		p.setTid(tid);
		//插入点赞
		int i = pm.dianzan(p );
		
		PrintWriter out = null;
		try {
			out =  rspn.getWriter();
			
			//1代表成功  0代表失败...
			out.print(i > 0 ? 1 : 0);
			out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			out.close();
		}
	}
	
	@RequestMapping("addForum.do")
	public ModelAndView addForum(@RequestParam("files")MultipartFile[] files ,HttpServletRequest req, Title t , Content c ) {
		ModelAndView mav = new ModelAndView();
		
		Cookie[] cookies = req.getCookies();
		int uid = 0;
		if(cookies != null && cookies.length > 0) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("uid")) {
					uid = Integer.parseInt(cookie.getValue());
				}
			}
		}
		//设置uid
		t.setUid(uid);
		System.out.println(files.length);
		for(int i = 0 ; i < files.length ; i++) {
			System.out.println(files[i].getOriginalFilename());
		}
		int i = ts.insertTitleAffairs( files , t, c);
		if(i > 0) {
			mav.setViewName("fore/title/selectForum.do");
		}
		return mav;
	}
}
