package com.ycft.ycft.controller.backstage;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ycft.ycft.po.Role;
import com.ycft.ycft.po.User;
import com.ycft.ycft.services.backstage.RoleSrv;
import com.ycft.ycft.services.backstage.UserSrv;

@Controller(value="BSUserCon")
public class UserCtrl {
	
	@Autowired
	private UserSrv us;
	@Autowired
	private RoleSrv rs;
	
	/**
	 * ��¼��ajax
	 * @author ZHENGBIN
	 * @param response
	 * @param request
	 */
	@RequestMapping("/userAjax.do")
	public void UserAjax(HttpServletResponse response,HttpServletRequest request) {
		//�û���
		String sno = request.getParameter("sno");
		//����
		String psd = request.getParameter("psd");
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			boolean flag = us.userAjax(sno, psd,request);
			//��¼�ɹ��򷵻�1����ǰ̨��ת��ҳ��
			if (flag) {
				writer.println("1");
			} else {
				writer.print("0");
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			writer.flush();
			writer.close();
		}
		
	}
	/**
	 * ����excel
	 * 
	 * @param student
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/exportExcel.do")
	public ModelAndView exportExcel(HttpServletResponse response){
		ModelAndView mav = new ModelAndView();
		boolean b = us.exportExcel(response);
		System.out.println(b+"-------");
		if(b){
			mav.setViewName("backstage/success");
		}else{
			mav.setViewName("backstage/fail");
		}
		return mav;
	}
	
	/**
	 * ���ص���excelģ��demo�ļ�
	 * @param response
	 * @param request
	 */
	@RequestMapping("/downloadDemo.do")
	public void downloadDemo(HttpServletResponse response,HttpServletRequest request){
		response.reset();
        us.downloadDemo(response, request);
	}
	/**
	 * ����excel
	 * @return
	 */
	@RequestMapping("/importExcel.do")
	public ModelAndView importExcel(MultipartFile file){
		ModelAndView mav = new ModelAndView();
		boolean b = false;
		try {
			b =  us.importExcelAffairs(file);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(b){
			mav.setViewName("backstage/success");
			
		}else{
			mav.setViewName("backstage/fail");
		}
		return mav;
	}
	
	/**
	 * ��ѯȫ��ѧ��
	 * @return backstage/userMgmt/userMaintenance/maintenance
	 */
	@RequestMapping("/selAll.do")
	public ModelAndView selAll() {
		ModelAndView modelAndView = new ModelAndView();
		
		List<User> uList = us.selAll();
		//��ȡ����Ȩ�����ƣ��޸ĸ��û�Ȩ�޵�ʱ���������ֵ
		List<Role> rList = rs.selAll();
		modelAndView.setViewName("backstage/userMgmt/userMaintenance/maintenance");
		modelAndView.addObject("uList" , uList);
		modelAndView.addObject("rList" , rList);
		
		return modelAndView;
	}
	@RequestMapping("/addOneUser.do")
	public ModelAndView addOneUser(User user) {
		ModelAndView modelAndView = new ModelAndView();
		boolean flag = us.addOneUser(user);
		if (flag) {
			modelAndView.setViewName("jump.do");
		} else {
			modelAndView.setViewName("backstage/fail");
		}
		return modelAndView;
	}
	/**
	 * ajaxɾ��
	 * @author ZHENGBIN
	 * @param response
	 * @param request
	 */
	@RequestMapping("/userDel.do")
	public void del(HttpServletResponse response,HttpServletRequest request) {
		
		PrintWriter writer = null;
		//��ȡɾ����id
		int id = Integer.parseInt(request.getParameter("id"));
		try {
			writer = response.getWriter();
			boolean flag = us.del(id);
			//ɾ���ɹ��󷵻�1
			if (flag) {
				writer.println("1");
			} else {
				writer.print("0");
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			writer.flush();
			writer.close();
		}
	}
	/**
	 * @author ZHENGBIN
	 * @param user ������
	 * @param role ������
	 * @return selAll.do
	 */
	@RequestMapping("/update.do")
	public ModelAndView update(User user,Role role) {
		ModelAndView modelAndView = new ModelAndView();
		boolean flag = us.updateAffairs(user,role);
		//ɾ���ɹ��󷵻�ԭҳ��
		if (flag) {
			modelAndView.setViewName("selAll.do");
		} else {
			//modelAndView.setViewName("backstage/fail");
		}
		return modelAndView;
	}
}
