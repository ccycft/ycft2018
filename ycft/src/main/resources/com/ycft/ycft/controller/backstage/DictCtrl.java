package com.ycft.ycft.controller.backstage;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ycft.ycft.po.DictDepict;
import com.ycft.ycft.po.Dictionary;
import com.ycft.ycft.services.InitService;
import com.ycft.ycft.services.backstage.DictSrv;
import com.ycft.ycft.tools.BeanUtil;

@Controller
@RequestMapping("backstage/")
public class DictCtrl {
	
	@Autowired
	private DictSrv ds;
	
	/**
	 * 重新缓存字典
	 * @author ZHENGBIN
	 */
	private void reCache() {
		InitService init =  (InitService)BeanUtil.getBean("InitService");
		try {
			System.out.println("=====================重新缓存字典中=====================");
			//重新缓存字典
			if (init.cacheDict()) {
				System.out.println("=====================缓存字典成功=====================");
			} else {
				System.out.println("=====================缓存字典失败=====================");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 一对多查询出所有字典信息
	 * @author ZHENGBIN
	 * @return backstage/systemSetting/dictMaintenance/maintenance.jsp
	 */
	@RequestMapping("/selDictDictionary.do")
	public ModelAndView selDictDictionary(){
		ModelAndView modelAndView = new ModelAndView();
		//一对多获取所有的字典数据
		List<DictDepict> ddList = ds.selDictDictionary();
		
		modelAndView.addObject("ddList",ddList);
		modelAndView.setViewName("backstage/systemSetting/dictMaintenance/maintenance.jsp");
		
		return modelAndView;
	}
	
	/**
	 * 启用
	 * @author ZHENGBIN
	 * @param request
	 * @param response
	 */
	@RequestMapping("enabledDict.do")
	public ModelAndView enabledDict(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		//获取选择启用的id
		int id = Integer.parseInt(request.getParameter("id"));
		boolean flag = ds.enabledDict(id);
		if (flag) {
			//重新缓存字典
			reCache();
			modelAndView.setViewName("redirect:/backstage/selDictDictionary.do");
		} else {
			modelAndView.setViewName("redirect:/backstage/fail.jsp");
		}
		return modelAndView;
	}

	/**
	 * 禁用的
	 * @author ZHENGBIN
	 * @param request
	 */
	@RequestMapping("disabledDict.do")
	public ModelAndView disabliedDict(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		//获取选择禁用的id
		int id = Integer.parseInt(request.getParameter("id"));
		boolean flag = ds.disabledDict(id);
		if (flag) {
			//重新缓存字典
			reCache();
			modelAndView.setViewName("redirect:/backstage/selDictDictionary.do");
		} else {
			modelAndView.setViewName("redirect:/backstage/fail.jsp");
		}
		return modelAndView;
	}
	/**
	 * 修改
	 * @author ZHENGBIN
	 * @param dictionary 参数绑定
	 * @return selDictDictionary.do
	 */
	@RequestMapping("/updateDict.do")
	public ModelAndView updateDict(Dictionary dictionary) {
		ModelAndView modelAndView = new ModelAndView();
		boolean flag = ds.updateDict(dictionary);
		//修改成功后返回原页面
		if (flag) {
			//重新缓存字典
			reCache();
			modelAndView.setViewName("redirect:/backstage/selDictDictionary.do");
		} else {
			modelAndView.setViewName("redirect:/backstage/fail.jsp");
		}
		return modelAndView;
	}
	
	/**
	 * 添加新字典项
	 * @author ZHENGBIN
	 * @param dictionary 参数绑定
	 * @return selDictDIctionary.do
	 */
	@RequestMapping("/addDictItem.do")
	public ModelAndView addDictItem(Dictionary dictionary) {
		ModelAndView modelAndView = new ModelAndView();
		boolean flag = ds.addDictItem(dictionary);
		//添加成功后返回原页面
		if (flag) {
			//重新缓存字典
			reCache();
			modelAndView.setViewName("redirect:/backstage/selDictDictionary.do");
		} else {
			modelAndView.setViewName("redirect:/backstage/fail.jsp");
		}
		
		return modelAndView;
	}
	/**
	 * 校验字典代码是否重复的ajax
	 * @author ZHENGBIN
	 * @param request
	 * @param response
	 */
	@RequestMapping("/dictTypeAjax.do")
	public void dictTypeAjax(HttpServletRequest request,HttpServletResponse response) {
		//获取盗的字典代码
		String dictType = request.getParameter("dictType");
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			boolean flag = ds.dictTypeAjax(dictType);
			//如果不重则返回true
			if (flag) {
				writer.println("1");
			} else {
				writer.println("0");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			writer.flush();
			writer.close();
		}
	}
	/**
	 * 添加新类型
	 * @author ZHENGBIN
	 * @param dictDepict 参数绑定
	 * @param dictionary 参数绑定 dictCode拼接了两个id
	 * @return selDictDictionary.do
	 */
	@RequestMapping("addDictType.do")
	public ModelAndView addDictType(DictDepict dictDepict,Dictionary dictionary) {
		ModelAndView modelAndView = new ModelAndView();
		System.out.println("!!!!!!!!!!!!!!!!");
		boolean flag = ds.addDictTypeAffairs(dictDepict, dictionary);
		//如果添加成功则返回true
		if (flag) {
			//成功后重新缓存数据字典
			reCache();
			modelAndView.setViewName("redirect:/backstage/selDictDictionary.do");
		} else {
			modelAndView.setViewName("redirect:/backstage/fail.jsp");
		}
		return modelAndView;
	}
}
