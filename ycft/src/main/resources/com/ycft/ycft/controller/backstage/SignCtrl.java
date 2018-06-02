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
		//����
		SignEvent se = new SignEvent();
		//����ֵ
		String id = request.getParameter("uid");
		if(id != null && !id.equals("")) {
			se.setId(Integer.parseInt(id));
		}
		User u = (User)request.getSession().getAttribute("user");
		//����ֻ�ܲ����ڵ�¼���˷�����ǩ���¼�
		se.setUid(u.getId());
		//��ѯǩ���˵�����
		List<SignEvent> sList = signSrv.SigneventUser(se);
		//��ѯ������������¼�
		List<SignEvent> eventList = signSrv.selEvent(se);
		//��ҳ�淵�ص�һ��ֵ
		modelAndView.addObject("sList", sList.get(0));
		modelAndView.addObject("eventList", eventList);
		modelAndView.setViewName("backstage/sign/signMaintenance/maintenance.jsp");
		return modelAndView;
	}
}
