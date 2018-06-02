package com.ycft.ycft.controller.backstage;

import java.text.DecimalFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ycft.ycft.po.SignEvent;
import com.ycft.ycft.po.User;
import com.ycft.ycft.services.backstage.SignSrv;
import com.ycft.ycft.services.backstage.UserSrv;

@Controller
public class SignCtrl {
	
	@Autowired
	SignSrv signSrv;
	@Autowired
	private UserSrv us;
	
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
		//查询出所有班级
		List<User> uList = us.selCls();
		//向页面返回第一个值
		modelAndView.addObject("sList", sList.get(0));
		modelAndView.addObject("eventList", eventList);
		modelAndView.addObject("uList", uList);
		modelAndView.setViewName("backstage/sign/signMaintenance/maintenance.jsp");
		return modelAndView;
	}
	
	/**
	 * 统计
	 * @author ZHENGBIN
	 * @param user 参数绑定 id为sign_event 的id R3为该id的名
	 * @param request
	 * @return
	 */
	@RequestMapping("/signSel.do")
	public ModelAndView signSel(User user,HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		//分子：签到个数
		int numerator = signSrv.signSel(user);
		//分母
		int denominator  = signSrv.signSelUser(user);
		//默认为0.00若能分母不为0则修改
		String result = "0.00";
		if (denominator != 0) {
			double number = Double.parseDouble(numerator+"")/denominator * 100;
			//如果算完等于0了就不修改了
			if (number != 0) {
				//使double保留双精度
				DecimalFormat df = new DecimalFormat("#.00");
				result = df.format(number);
			}
		}
		modelAndView.setViewName("backstage/sign/signMaintenance/sign.jsp");
		modelAndView.addObject("numerator",numerator);
		modelAndView.addObject("result",result);
		//活动名绑定到R3上了
		modelAndView.addObject("name",user.getR3());
		return modelAndView;
	}
}
