package com.ycft.ycft.controller.foreground;

import java.io.PrintWriter;
import java.util.List;

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
	
	@RequestMapping("selSignEvent.do")
	public ModelAndView index(Integer nowPage , Integer pageSize) {
		if(pageSize == null || pageSize == 0) {
			//如果前端未指定查询几条数据  那后台指定为4条
			pageSize = 4;
		}
		if(nowPage == null || nowPage <= 0) {
			nowPage = 1;
		}
		List<SignEvent> slist = ss.selSignEvent(nowPage, pageSize);
		ModelAndView mav = new ModelAndView();
		mav.addObject("sList", slist ); 
		mav.setViewName("sign.jsp");
		return mav;
	}
	
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
	
}
