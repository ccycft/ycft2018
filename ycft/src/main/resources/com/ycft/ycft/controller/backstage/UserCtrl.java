package com.ycft.ycft.controller.backstage;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
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
	
	@RequestMapping("/userAjax.do")
	public void UserAjax(HttpServletResponse response,HttpServletRequest request) {
		String sno = request.getParameter("sno");
		String psd = request.getParameter("psd");
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			boolean flag = us.userAjax(sno, psd,request);
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
	 * 导出excel
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
		if(b){
			mav.setViewName("success");
			
		}else{
			mav.setViewName("fail");
		}
		return mav;
	}
	
	/**
	 * 下载导入excel模版demo文件
	 * @param response
	 * @param request
	 */
	@RequestMapping("/downloadDemo.do")
	public void downloadDemo(HttpServletResponse response,HttpServletRequest request){
		response.reset();
        us.downloadDemo(response, request);
	}
	/**
	 * 导入excel
	 * @return
	 */
	@RequestMapping("/importExcel.do")
	public ModelAndView importExcel(MultipartFile file){
		ModelAndView mav = new ModelAndView();
		boolean b = false;
		try {
			b =  us.importExcel(file);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(b){
			mav.setViewName("success");
			
		}else{
			mav.setViewName("fail");
		}
		return mav;
	}
	
	/**
	 * 查询全部学生
	 * @return modelAndView
	 */
	@RequestMapping("/selAll.do")
	public ModelAndView selAll() {
		ModelAndView modelAndView = new ModelAndView();
		
		List<User> uList = us.selAll();
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
			modelAndView.setViewName("fail");
		}
		return modelAndView;
	}
	@RequestMapping("/userDel.do")
	public void del(HttpServletResponse response,HttpServletRequest request) {
		
		PrintWriter writer = null;
		int id = Integer.parseInt(request.getParameter("id"));
		try {
			writer = response.getWriter();
			boolean flag = us.del(id);
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
	 * 
	 * @return modelAndView
	 */
	@RequestMapping("/update.do")
	public ModelAndView update(User user,Role role) {
		ModelAndView modelAndView = new ModelAndView();
		boolean flag = us.update(user,role);
		if (flag) {
			modelAndView.setViewName("selAll.do");
		} else {
			modelAndView.setViewName("fail");
		}
		return modelAndView;
	}
}
