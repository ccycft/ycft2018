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
	 * 登录的ajax
	 * @author ZHENGBIN
	 * @param response
	 * @param request
	 */
	@RequestMapping("/userAjax.do")
	public void UserAjax(HttpServletResponse response,HttpServletRequest request) {
		//用户名
		String sno = request.getParameter("sno");
		//密码
		String psd = request.getParameter("psd");
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			boolean flag = us.userAjax(sno, psd,request);
			//登录成功则返回1并由前台跳转主页面
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
	 * 把用户信息导出excel表格
	 * 
	 * @author 马荣福
	 * @param response
	 * @return
	 */
	@RequestMapping("/exportExcel.do")
	public ModelAndView exportExcel(HttpServletResponse response){
		ModelAndView mav = new ModelAndView();
		boolean b = us.exportExcel(response);
		if(b){
			//成功页面
			mav.setViewName("backstage/success.jsp");
		}else{
			//失败页面
			mav.setViewName("backstage/fail.jsp");
		}
		return mav;
	}
	
	/**
	 * 下载导入excel模版demo文件,不用跳转页面
	 * @author 马荣福
	 * @param response
	 * @param request
	 */
	@RequestMapping("/downloadDemo.do")
	public void downloadDemo(HttpServletResponse response,HttpServletRequest request){
		
        us.downloadDemo(response, request);
	}
	/**
	 * 学生信息导入excel
	 * @author 马荣福
	 * @param file xls格式的表格
	 * @return
	 */
	@RequestMapping("/importExcel.do")
	public ModelAndView importExcel(MultipartFile file){
		ModelAndView mav = new ModelAndView();
		boolean b = false;
		try {
			b =  us.importExcelAffairs(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(b){
			//成功页面
			mav.setViewName("selAll.do");
		}else{
			//失败页面
			mav.setViewName("backstage/fail.jsp");
		}
		return mav;
	}
	
	/**
	 * 查询全部学生
	 * @return backstage/userMgmt/userMaintenance/maintenance
	 */
	@RequestMapping("/selAll.do")
	public ModelAndView selAll() {
		ModelAndView modelAndView = new ModelAndView();
		
		List<User> uList = us.selAll();
		//获取所有权限名称，修改该用户权限的时候下拉框的值
		List<Role> rList = rs.selAll();
		modelAndView.setViewName("backstage/userMgmt/userMaintenance/maintenance.jsp");
		modelAndView.addObject("uList" , uList);
		modelAndView.addObject("rList" , rList);
		
		return modelAndView;
	}
	/**
	 * 学生单个录入
	 * @author 马荣福
	 * @param user 参数绑定
	 * @return
	 */
	@RequestMapping("/addOneUser.do")
	public ModelAndView addOneUser(User user) {
		ModelAndView modelAndView = new ModelAndView();
		boolean flag = us.addOneUser(user);
		if (flag) {
			//返回首页
			modelAndView.setViewName("jump.do");
		} else {
			modelAndView.setViewName("backstage/fail.jsp");
		}
		return modelAndView;
	}
	/**
	 * ajax删除
	 * @author ZHENGBIN
	 * @param response
	 * @param request
	 */
	@RequestMapping("/userDel.do")
	public void del(HttpServletResponse response,HttpServletRequest request) {
		
		PrintWriter writer = null;
		//获取删除的id
		int id = Integer.parseInt(request.getParameter("id"));
		try {
			writer = response.getWriter();
			boolean flag = us.del(id);
			//删除成功后返回1
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
	 * @param user 参数绑定
	 * @param role 参数绑定
	 * @return selAll.do
	 */
	@RequestMapping("/update.do")
	public ModelAndView update(User user,Role role) {
		ModelAndView modelAndView = new ModelAndView();
		boolean flag = us.updateAffairs(user,role);
		//删除成功后返回原页面
		if (flag) {
			modelAndView.setViewName("selAll.do");
		} else {
			//modelAndView.setViewName("backstage/fail");
		}
		return modelAndView;
	}
}
