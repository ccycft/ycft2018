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
	 * һ�Զ��ѯ�������ֵ���Ϣ
	 * @author ZHENGBIN
	 * @return backstage/systemSetting/dictMaintenance/maintenance.jsp
	 */
	@RequestMapping("/selDictDictionary.do")
	public ModelAndView selDictDictionary(){
		ModelAndView modelAndView = new ModelAndView();
		//һ�Զ��ȡ���е��ֵ�����
		List<DictDepict> ddList = ds.selDictDictionary();
		
		modelAndView.addObject("ddList",ddList);
		modelAndView.setViewName("backstage/systemSetting/dictMaintenance/maintenance.jsp");
		
		return modelAndView;
	}
	
	/**
	 * ����ajax
	 * @author ZHENGBIN
	 * @param request
	 * @param response
	 */
	@RequestMapping("enabledDict.do")
	public void enabledDict(HttpServletRequest request,HttpServletResponse response) {
		//��ȡѡ�����õ�id
		int id = Integer.parseInt(request.getParameter("id"));
		PrintWriter writer = null;
		boolean flag = ds.enabledDict(id);
		try {
			writer = response.getWriter();
			if (flag) {
				//���óɹ��󷵻�1
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
	 * ���õ�ajax
	 * @author ZHENGBIN
	 * @param request
	 * @param response
	 */
	@RequestMapping("disabledDict.do")
	public void disabliedDict(HttpServletRequest request,HttpServletResponse response) {
		//��ȡѡ����õ�id
		int id = Integer.parseInt(request.getParameter("id"));
		PrintWriter writer = null;
		boolean flag = ds.disabledDict(id);
		try {
			writer = response.getWriter();
			if (flag) {
				//���óɹ��󷵻�1
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
