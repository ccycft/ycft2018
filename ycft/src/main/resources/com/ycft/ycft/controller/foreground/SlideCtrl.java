package com.ycft.ycft.controller.foreground;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ycft.ycft.services.foreground.SlideSrv;

@Controller(value="foreSlideCtrl")
@RequestMapping("fore/slide/")
public class SlideCtrl {

	@Autowired
	private SlideSrv ss;
	
	/*@RequestMapping("select.do")
	public void select(HttpServletRequest rqus) {
		 ss.selectAll();
		//System.out.println(path);
	}*/
	
}
