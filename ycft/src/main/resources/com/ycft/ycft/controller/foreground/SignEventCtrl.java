package com.ycft.ycft.controller.foreground;

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

import com.ycft.ycft.po.SignEvent;
import com.ycft.ycft.services.foreground.SignEventSrv;

@Controller(value="foreSignEventCtrl")
@RequestMapping("fore/signEvent/")
public class SignEventCtrl {

	@Autowired
	SignEventSrv ss; 
	
	//��ѯǩ���¼�
	@RequestMapping("selSignEvent.do")
	public ModelAndView index(Integer nowPage , Integer pageSize)  {
		if(pageSize == null || pageSize == 0) {
			//���ǰ��δָ����ѯ��������  �Ǻ�ָ̨��Ϊ4��
			pageSize = 4;
		}
		if(nowPage == null || nowPage <= 0) {
			nowPage = 1;
		}
		List<SignEvent> slist = ss.selSignEvent(nowPage, pageSize);
		//��ǩ����ֹʱ��  ����Ϊ20����֮��
		Calendar c = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		try {
			for(SignEvent sign : slist) {
				String beforeTime = sign.getTime();
				Date date = sdf.parse(beforeTime);
				//��������ʱ��
				c.setTime(date);
				c.add(Calendar.MINUTE, 20);
				date = c.getTime();
				String deadTime = sdf.format(date);
				//������ֹʱ��
				sign.setDeadLine(deadTime);
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
	
	//���ǩ��
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
	
	//��ѯǩ������
	@RequestMapping("selDetail.do")
	public ModelAndView selDetail(Integer userid , SignEvent se , HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		 
		boolean b = ss.selSignByUidAndSid(userid , se.getId());
		//�ܲ���ǩ��
		mav.addObject("canSign" , !b);
		mav.addObject("signEvent" , se);
		//��ѯ����
		mav.setViewName("signDetails.jsp");
		return mav;
	}
	
}
