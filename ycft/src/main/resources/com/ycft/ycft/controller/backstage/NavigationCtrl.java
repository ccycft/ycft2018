package com.ycft.ycft.controller.backstage;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.ycft.ycft.po.Content;
import com.ycft.ycft.po.Navigation;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.services.backstage.NavigationSrv;

@Controller
public class NavigationCtrl {
	
	@Autowired
	private NavigationSrv ns;
	
	/**
	 * ��ѯ��ȫ���ĵ�������
	 * @author ZHENGBIN
	 * @return backstage/navigation/navigationMaintenance/maintenance.jsp
	 */
	@RequestMapping("navigationSel.do")
	public ModelAndView navigationSel() {
		ModelAndView modelAndView = new ModelAndView();
		List<Navigation> nList = ns.navigationSel();
		if (nList != null) {
			modelAndView.addObject("nList",nList);
			modelAndView.setViewName("backstage/navigation/navigationMaintenance/maintenance.jsp");
		} else {
			modelAndView.setViewName("fail.jsp");
		}
		return modelAndView;
	}
	
	/**
	 * ͨ��id�����ѯ�ص�ajax
	 * @param response
	 * @param request
	 * @param id
	 */
	@RequestMapping("selNavigationById.do")
	public void selNavigationById(HttpServletResponse response,HttpServletRequest request,int id) {
		Navigation n = ns.selById(id);
		Gson g = new Gson();
		//��̨��ʾһ�£����رյ�ǰҳ��
		response.setContentType("text/html");
    	response.setCharacterEncoding("UTF-8");
    	PrintWriter out;
		try {
			out = response.getWriter();
			out.print(g.toJson(n));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * ������Ϣ��¼��==�޸�
	 * @author ZHENGBIN
	 * @param navigation ������
	 * @return navigationSel.do
	 */
	@RequestMapping("navigationUpdate.do")
	public ModelAndView navigationUpdate(Navigation navigation) {
		ModelAndView modelAndView = new ModelAndView();
		
		boolean flag = ns.navigationUpDate(navigation);
		//�޸ĳɹ��󷵻���ʾҳ��
		if (flag) {
			modelAndView.setViewName("navigationSel.do");
		} else {
			modelAndView.setViewName("fail.jsp");
		}
		return modelAndView;
	}

	/**
	 * ͨ��idɾ����ͨ�������󶨹���id
	 * @author ZHENGBIN
	 * @param navigation ������
	 * @return navigationSel.do
	 */
	@RequestMapping("navigationDel.do")
	public ModelAndView navigationDel(Navigation navigation) {
		ModelAndView modelAndView = new ModelAndView();
		boolean flag = ns.navigationDel(navigation);
		//ɾ���ɹ��󷵻���ʾҳ��
		if (flag) {
			modelAndView.setViewName("navigationSel.do");
		} else {
			modelAndView.setViewName("fail.jsp");
		}
		return modelAndView;
	}
}
