package com.ycft.ycft.controller.foreground;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import com.ycft.ycft.po.SignEvent;
import com.ycft.ycft.services.foreground.SignEventSrv;
import com.ycft.ycft.system.Core;

@Controller(value="foreSignEventCtrl")
@RequestMapping("fore/signEvent/")
public class SignEventCtrl {

	@Autowired
	SignEventSrv ss; 
	
	//查询签到事件
	@RequestMapping("selSignEvent.do")
	public ModelAndView index(Integer nowPage , Integer pageSize)  {
		if(pageSize == null || pageSize == 0) {
			//如果前端未指定查询几条数据  那后台指定为4条
			pageSize = 4;
		}
		if(nowPage == null || nowPage <= 0) {
			nowPage = 1;
		}
		List<SignEvent> slist = ss.selSignEvent(nowPage, pageSize);
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		 
		try {
			for(SignEvent sign : slist) {
				//如果isdead==1说明已经结束
				if(sign.getIsdead() == 1) {
					sign.setState("已结束");
				}else {
					Long nowTime = date.getTime();
					Long qiandaoTime = sdf.parse(sign.getTime()).getTime();
					if(nowTime >= qiandaoTime) {
						sign.setState("正在签到");
					}else {
						sign.setState("未开始");
					}
					
				}
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("sList", slist ); 
		mav.setViewName("sign.jsp");
		return mav;
	}
	
	//查询签到事件
		@RequestMapping("selSignEventByPage.do")
		public void selSignEventByPage(Integer nowPage , Integer pageSize , HttpServletResponse response)  {
			if(pageSize == null || pageSize == 0) {
				//如果前端未指定查询几条数据  那后台指定为4条
				pageSize = 4;
			}
			if(nowPage == null || nowPage <= 0) {
				nowPage = 1;
			}
			List<SignEvent> slist = ss.selSignEvent(nowPage, pageSize);
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			 
			try {
				for(SignEvent sign : slist) {
					//如果isdead==1说明已经结束
					if(sign.getIsdead() == 1) {
						sign.setState("已结束");
					}else {
						Long nowTime = date.getTime();
						Long qiandaoTime = sdf.parse(sign.getTime()).getTime();
						if(nowTime >= qiandaoTime) {
							sign.setState("正在签到");
						}else {
							sign.setState("未开始");
						}
						
					}
				}
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			 PrintWriter out;
			try {
				out = response.getWriter();
				out.print(new Gson().toJson(slist));
				 out.flush();
				 out.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			 
		}
	
	//点击签到
	@RequestMapping("sign.do")
	public void sign(Integer sid , Integer uid , HttpServletResponse rspn) {
		boolean b = ss.foreSign(sid , uid);
		int flag = b ? 1 : 0;
		PrintWriter out = null;
		try {
			out = rspn.getWriter();
			out.print(flag);
			out.flush();
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			out.close();
		}
	}
	
	//查询签到详情
	@RequestMapping("selDetail.do")
	public ModelAndView selDetail(Integer userid , SignEvent se , HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		 
		boolean b = ss.selSignByUidAndSid(userid , se.getId());
		//能不能签到
		mav.addObject("canSign" , !b);
		System.out.println(!b);
		mav.addObject("signEvent" , se);
		//查询详情
		mav.setViewName("signDetails.jsp");
		return mav;
	}
	
	//查询我的签到信息
	@RequestMapping("myReleaseSign.do")
	public ModelAndView myReleaseSign(HttpServletRequest req , Integer nowPage , Integer pageSize) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("signList.jsp");
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
		List<SignEvent> list = ss.selectSignById(uid , start , pageSize);
		mav.addObject("sList" , list);
		return mav;
	}
	
	@RequestMapping("selDetailById.do")
	public ModelAndView selDetailById(Integer id) {
		SignEvent sign = ss.selDetailById(id);
		Calendar c = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		try {
			String beforeTime = sign.getTime();
			Date date = sdf.parse(beforeTime);
			//设置日历时间
			/*c.setTime(date);
			c.add(Calendar.MINUTE, Core.SIGNDEADTIME);
			date = c.getTime();
			String deadTime = sdf.format(date);
			//设置终止时间
			sign.setDeadLine(deadTime);*/
		}catch (Exception e) {
			e.printStackTrace();
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("signEvent" , sign);
		mav.setViewName("myReleaseSignDetails.jsp" );;
		return mav;
	}
	
}
