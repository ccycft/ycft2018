package com.ycft.ycft.controller.backstage;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.ycft.ycft.po.TitleContent;
import com.ycft.ycft.services.backstage.ForumSrv;

@Controller
public class CommentCtrl {
	
	@Autowired
	private ForumSrv forumSrv;
	
	/**
	 * 查询论坛信息
	 * @return
	 */
	@RequestMapping("selForum.do")
	public ModelAndView selComment(HttpServletRequest request){
		ModelAndView modelAndView = new ModelAndView();
		//查询论坛的信息
		List<TitleContent> tcList = forumSrv.selAllForum();
		modelAndView.addObject("tcList", tcList);
		//返回结果界面
		modelAndView.setViewName("backstage/forum/forumMaintenance/maintenance");
		return modelAndView;
	}
}
