package com.ycft.ycft.controller.backstage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ycft.ycft.po.Navigation;
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
