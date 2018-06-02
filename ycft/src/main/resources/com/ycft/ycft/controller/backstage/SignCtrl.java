package com.ycft.ycft.controller.backstage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ycft.ycft.po.SignEvent;
import com.ycft.ycft.po.User;
import com.ycft.ycft.services.backstage.SignSrv;

@Controller
public class SignCtrl {
	
	@Autowired
	SignSrv signSrv;
	
	@RequestMapping("selSignEvent.do")
	public ModelAndView SigneventUser(HttpServletRequest request){
		ModelAndView modelAndView = new ModelAndView();
		//对象
		SignEvent se = new SignEvent();
		//接收值
		String id = request.getParameter("uid");
		if(id != null && !id.equals("")) {
			se.setId(Integer.parseInt(id));
		}
		User u = (User)request.getSession().getAttribute("user");
		//设置只能查现在登录的人发布的签到事件
		se.setUid(u.getId());
		//查询签到人的数据
		List<SignEvent> sList = signSrv.SigneventUser(se);
		//查询下拉框里面的事件
		List<SignEvent> eventList = signSrv.selEvent(se);
		//向页面返回第一个值
		modelAndView.addObject("sList", sList.get(0));
		modelAndView.addObject("eventList", eventList);
		modelAndView.setViewName("backstage/sign/signMaintenance/maintenance.jsp");
		return modelAndView;
	}
}
