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
		//加载文章2个
		List<Title> tlist =  ts.selectHot(2);
		//加载通知两个
		ModelAndView mav = new ModelAndView();
		mav.addObject("sList", slist);
		mav.addObject("tList", tlist);
		mav.setViewName("index");
		return mav;
	}
	
}
