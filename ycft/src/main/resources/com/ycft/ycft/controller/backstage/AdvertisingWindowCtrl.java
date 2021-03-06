package com.ycft.ycft.controller.backstage;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ycft.ycft.po.Slide;
import com.ycft.ycft.po.SlideContent;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.services.backstage.AdvertisingWindowSrv;
import com.ycft.ycft.services.backstage.ArticleSrv;

@Controller
@RequestMapping("backstage/")
public class AdvertisingWindowCtrl {
	
	@Autowired
	private AdvertisingWindowSrv aws;
	@Autowired
	private ArticleSrv as;

	/**
	 * 查寻出全部广告窗内容和发布的文章的内容
	 * @author ZHENGBIN
	 * @return backstage/advertisingWindow/advertisingWindowMaintenance/maintenance.jsp
	 */
	@RequestMapping("advertisingWindowSel.do")
	public ModelAndView advertisingWindowSel() {
		ModelAndView modelAndView = new ModelAndView();
		List<SlideContent> scList = aws.advertisingWindowSel();
		//查询全部文章--修改用
		List<Title> tList = as.selByCount(1);
		if (scList != null && tList != null) {
			modelAndView.addObject("scList",scList);
			modelAndView.addObject("tList",tList);
			modelAndView.setViewName("backstage/advertisingWindow/advertisingWindowMaintenance/maintenance.jsp");
		} else {
			modelAndView.setViewName("backstage/fail.jsp");
		}
		
		return modelAndView;
	}
	
	/**
	 * 广告窗修改
	 * @author ZHENGBIN
	 * @param request
	 * @param titleFile 参数绑定
	 * @param slide 参数绑定
	 * @return advertisingWindowSel.do
	 */
	@RequestMapping("uploadAdvertisingWindow.do")
	public ModelAndView upload(HttpServletRequest request,MultipartFile titleFile,Slide slide) {
		ModelAndView modelAndView = new ModelAndView();
		boolean flag = aws.uploadAdvertisingWindow(request,titleFile,slide);
		//修改成功后返回原页面
		if (flag) {
			modelAndView.setViewName("redirect:/backstage/advertisingWindowSel.do");
		} else {
			modelAndView.setViewName("redirect:/backstage/fail.jsp");
		}
		return modelAndView;
	}
	
}
