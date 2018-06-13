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
	 * ���»����ֵ�
	 * @author ZHENGBIN
	 */
	private void reCache() {
		InitService init =  (InitService)BeanUtil.getBean("InitService");
		try {
			System.out.println("=====================���»����ֵ���=====================");
			//���»����ֵ�
			if (init.cacheDict()) {
				System.out.println("=====================�����ֵ�ɹ�=====================");
			} else {
				System.out.println("=====================�����ֵ�ʧ��=====================");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
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
	 * ����
	 * @author ZHENGBIN
	 * @param request
	 * @param response
	 */
	@RequestMapping("enabledDict.do")
	public ModelAndView enabledDict(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		//��ȡѡ�����õ�id
		int id = Integer.parseInt(request.getParameter("id"));
		boolean flag = ds.enabledDict(id);
		if (flag) {
			//���»����ֵ�
			reCache();
			modelAndView.setViewName("redirect:/backstage/selDictDictionary.do");
		} else {
			modelAndView.setViewName("redirect:/backstage/fail.jsp");
		}
		return modelAndView;
	}

	/**
	 * ���õ�
	 * @author ZHENGBIN
	 * @param request
	 */
	@RequestMapping("disabledDict.do")
	public ModelAndView disabliedDict(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		//��ȡѡ����õ�id
		int id = Integer.parseInt(request.getParameter("id"));
		boolean flag = ds.disabledDict(id);
		if (flag) {
			//���»����ֵ�
			reCache();
			modelAndView.setViewName("redirect:/backstage/selDictDictionary.do");
		} else {
			modelAndView.setViewName("redirect:/backstage/fail.jsp");
		}
		return modelAndView;
	}
	/**
	 * �޸�
	 * @author ZHENGBIN
	 * @param dictionary ������
	 * @return selDictDictionary.do
	 */
	@RequestMapping("/updateDict.do")
	public ModelAndView updateDict(Dictionary dictionary) {
		ModelAndView modelAndView = new ModelAndView();
		boolean flag = ds.updateDict(dictionary);
		//�޸ĳɹ��󷵻�ԭҳ��
		if (flag) {
			//���»����ֵ�
			reCache();
			modelAndView.setViewName("redirect:/backstage/selDictDictionary.do");
		} else {
			modelAndView.setViewName("redirect:/backstage/fail.jsp");
		}
		return modelAndView;
	}
	
	/**
	 * ������ֵ���
	 * @author ZHENGBIN
	 * @param dictionary ������
	 * @return selDictDIctionary.do
	 */
	@RequestMapping("/addDictItem.do")
	public ModelAndView addDictItem(Dictionary dictionary) {
		ModelAndView modelAndView = new ModelAndView();
		boolean flag = ds.addDictItem(dictionary);
		//��ӳɹ��󷵻�ԭҳ��
		if (flag) {
			//���»����ֵ�
			reCache();
			modelAndView.setViewName("redirect:/backstage/selDictDictionary.do");
		} else {
			modelAndView.setViewName("redirect:/backstage/fail.jsp");
		}
		
		return modelAndView;
	}
	/**
	 * У���ֵ�����Ƿ��ظ���ajax
	 * @author ZHENGBIN
	 * @param request
	 * @param response
	 */
	@RequestMapping("/dictTypeAjax.do")
	public void dictTypeAjax(HttpServletRequest request,HttpServletResponse response) {
		//��ȡ�����ֵ����
		String dictType = request.getParameter("dictType");
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			boolean flag = ds.dictTypeAjax(dictType);
			//��������򷵻�true
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
	 * ���������
	 * @author ZHENGBIN
	 * @param dictDepict ������
	 * @param dictionary ������ dictCodeƴ��������id
	 * @return selDictDictionary.do
	 */
	@RequestMapping("addDictType.do")
	public ModelAndView addDictType(DictDepict dictDepict,Dictionary dictionary) {
		ModelAndView modelAndView = new ModelAndView();
		System.out.println("!!!!!!!!!!!!!!!!");
		boolean flag = ds.addDictTypeAffairs(dictDepict, dictionary);
		//�����ӳɹ��򷵻�true
		if (flag) {
			//�ɹ������»��������ֵ�
			reCache();
			modelAndView.setViewName("redirect:/backstage/selDictDictionary.do");
		} else {
			modelAndView.setViewName("redirect:/backstage/fail.jsp");
		}
		return modelAndView;
	}
}
