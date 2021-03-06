package com.ycft.ycft.controller.foreground;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ycft.ycft.po.Slide;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.services.foreground.SlideSrv;
import com.ycft.ycft.services.foreground.TitleSrv;

@Controller(value="foreIndexCtrl")
@RequestMapping("fore/index/")
public class IndexCtrl {

	@Autowired
	TitleSrv ts;
	@Autowired
	SlideSrv ss;
	
	@RequestMapping("index.do")
	public ModelAndView index() {
		//加载幻灯片
		List<Slide> slist = ss.selectAll();
		//加载热门文章2个
		List<Title> tlist =  ts.selectHot(1 , 2);
		//加载最新通知两个
		List<Title> informList =  ts.selectTime( 2 , 1 , 2);
		ModelAndView mav = new ModelAndView();
		mav.addObject("sList", slist);
		mav.addObject("tList", tlist);
		mav.addObject("informList", informList);
		mav.setViewName("index.jsp");
		return mav;
	}
	
	
	
	
}
