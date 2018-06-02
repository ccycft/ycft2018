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
		//��ѯ�����а༶
		List<User> uList = us.selCls();
		//��ҳ�淵�ص�һ��ֵ
		modelAndView.addObject("sList", sList.get(0));
		modelAndView.addObject("eventList", eventList);
		modelAndView.addObject("uList", uList);
		modelAndView.setViewName("backstage/sign/signMaintenance/maintenance.jsp");
		return modelAndView;
	}
	
	/**
	 * ͳ��
	 * @author ZHENGBIN
	 * @param user ������ idΪsign_event ��id R3Ϊ��id����
	 * @param request
	 * @return
	 */
	@RequestMapping("/signSel.do")
	public ModelAndView signSel(User user,HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		//���ӣ�ǩ������
		int numerator = signSrv.signSel(user);
		//��ĸ
		int denominator  = signSrv.signSelUser(user);
		//Ĭ��Ϊ0.00���ܷ�ĸ��Ϊ0���޸�
		String result = "0.00";
		if (denominator != 0) {
			double number = Double.parseDouble(numerator+"")/denominator * 100;
			//����������0�˾Ͳ��޸���
			if (number != 0) {
				//ʹdouble����˫����
				DecimalFormat df = new DecimalFormat("#.00");
				result = df.format(number);
			}
		}
		modelAndView.setViewName("backstage/sign/signMaintenance/sign.jsp");
		modelAndView.addObject("numerator",numerator);
		modelAndView.addObject("result",result);
		//����󶨵�R3����
		modelAndView.addObject("name",user.getR3());
		return modelAndView;
	}
}
