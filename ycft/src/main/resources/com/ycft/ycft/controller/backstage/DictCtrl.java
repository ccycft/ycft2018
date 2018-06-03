package com.ycft.ycft.controller.backstage;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspectj.apache.bcel.Repository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sun.tools.internal.ws.processor.model.Response;
import com.ycft.ycft.po.DictDepict;
import com.ycft.ycft.services.backstage.DictSrv;

@Controller
public class DictCtrl {
	
	@Autowired
	private DictSrv ds;
	
	
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
	 * 启用ajax
	 * @author ZHENGBIN
	 * @param request
	 * @param response
	 */
	@RequestMapping("enabledDict.do")
	public void enabledDict(HttpServletRequest request,HttpServletResponse response) {
		//获取选择启用的id
		int id = Integer.parseInt(request.getParameter("id"));
		PrintWriter writer = null;
		boolean flag = ds.enabledDict(id);
		try {
			writer = response.getWriter();
			if (flag) {
				//启用成功后返回1
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
	 * 禁用的ajax
	 * @author ZHENGBIN
	 * @param request
	 * @param response
	 */
	@RequestMapping("disabledDict.do")
	public void disabliedDict(HttpServletRequest request,HttpServletResponse response) {
		//获取选择禁用的id
		int id = Integer.parseInt(request.getParameter("id"));
		PrintWriter writer = null;
		boolean flag = ds.disabledDict(id);
		try {
			writer = response.getWriter();
			if (flag) {
				//禁用成功后返回1
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
}
