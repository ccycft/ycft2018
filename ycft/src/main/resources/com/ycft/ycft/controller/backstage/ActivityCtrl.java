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

import com.ycft.ycft.po.Activity;
import com.ycft.ycft.po.Content;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.po.TitleContent;
import com.ycft.ycft.services.backstage.ActivitySrv;

@Controller
public class ActivityCtrl {
	
	@Autowired
	private ActivitySrv as;

	/**
	 * 查询出所以活动信息
	 * @author ZHENGBIN
	 * @return backstage/activity/activityMaintenance/maintenance
	 */
	@RequestMapping("/selActivity.do")
	public ModelAndView selActivity() {
		ModelAndView modelAndView = new ModelAndView();
		//所有活动信息
		List<TitleContent> tcList = as.selAllActivity();
		
		modelAndView.addObject("tcList", tcList);
		modelAndView.setViewName("backstage/activity/activityMaintenance/maintenance");
		
		return modelAndView;
	}
	
	/**
	 * 活动的发布处理
	 * 发布后跳转回原界面
	 * @author ZHENGBIN
	 * @param response
	 * @param request
	 * @param content 参数绑定
	 * @param title 参数绑定
	 * @param titleFile 活动的图片
	 * @return selActivity.do
	 * @throws IOException 
	 */
	@RequestMapping("/addActivity.do")
	public String addInform(HttpServletResponse response,HttpServletRequest request, Content content,Title title,MultipartFile titleFile) throws IOException { 
		boolean flag = as.addActivityAffairs(request,content,title,titleFile);
		//true为发布成功
		if(flag) {
			return "selActivity.do";
		}else {
			return "selActivity.do";
		}
		
	}
	
	/**
	 * ajax删除
	 * 删除成功后返回1
	 * 因为创建了触发器所以删除某条活动，该活动的报名信息也删除
	 * @author ZHENGBIN
	 * @param response
	 * @param request
	 */
	@RequestMapping("/activityDel.do")
	public void del(HttpServletResponse response,HttpServletRequest request) {
		
		PrintWriter writer = null;
		//获取删除哪条活动信息的id
		int id = Integer.parseInt(request.getParameter("id"));
		try {
			writer = response.getWriter();
			boolean flag = as.del(id);
			//true为删除成功
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
	 * 点修改带id进来查询出数据跳转到新的修改界面
	 * @author ZHENGBIN
	 * @param request
	 * @return backstage/activity/activityMaintenance/activityUpdate
	 */
	@RequestMapping("/activityUpdate.do")
	public ModelAndView activityUpdate(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		//获取想要修改某条活动信息的id
		int id = Integer.parseInt(request.getParameter("id"));
		//查询出该id的活动信息
		TitleContent tc = as.selAllActivityById(id);
		
		modelAndView.addObject("tc",tc);
		modelAndView.setViewName("backstage/activity/activityMaintenance/activityUpdate");
		
		return modelAndView;
	}
	
	/**
	 * 修改成功后提示修改成功，并关闭修改页面
	 * @author ZHENGBIN
	 * @param response
	 * @param request
	 * @param title 参数绑定
	 * @param content 参数绑定
	 * @param updFile 修改的图片
	 * @throws IOException
	 */
	@RequestMapping("/updActivity.do")
	public void updActivity(HttpServletResponse response,HttpServletRequest request,Title title,Content content,MultipartFile updFile) throws IOException {
		boolean flag = as.updActivity(request,title,content,updFile);
		//true为修改成功
		if(flag) {
			//后台提示一下，并关闭当前页面
			response.setContentType("text/html");
        	response.setCharacterEncoding("UTF-8");
        	PrintWriter out = response.getWriter();
        	out.println("<script>"); 
        	out.println("alert('修改成功');"); 
        	out.println("window.opener=null;window.close();");
        	out.println("</script>");
		}else {
			response.setContentType("text/html");
        	response.setCharacterEncoding("UTF-8");
        	PrintWriter out = response.getWriter();
        	out.println("<script>"); 
        	out.println("alert('修改失败');"); 
        	out.println("window.opener=null;window.close();");
        	out.println("</script>");
		}
	}
	
	/**
	 * 下载导入活动的excel模版demo文件
	 * @author ZHENGBIN
	 * @param response
	 * @param request
	 */
	@RequestMapping("/downloadActivityDemo.do")
	public void downloadActivityDemo(HttpServletResponse response,HttpServletRequest request){
        //下载模板
		as.downloadActivityDemo(response, request);
	}
	
	/**
	 * 导入成功后跳转回原界面
	 * @author ZHENGBIN
	 * @param file
	 * @param activity 参数绑定，导入哪个活动，绑定过来id
	 * @return selActivity.do
	 */
	@RequestMapping("/importActivityExcel.do")
	public ModelAndView importActivityExcel(MultipartFile file,Activity activity){
		ModelAndView modelAndView = new ModelAndView();
		boolean flag = false;
		try {
			flag =  as.importActivityExcelAffairs(file,activity);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//true 导入成功
		if(flag){
			modelAndView.setViewName("selActivity.do");
		}else{
			modelAndView.setViewName("backstage/fail");
		}
		return modelAndView;
	}
	
	/**
	 * 导出excel
	 * 导出成功后跳转到success，否则后台会因为getWriter和getOutputStream冲突而报错
	 * @author ZHENGBIN
	 * @param response
	 * @param activity 参数绑定，导出哪个活动，绑定过来id
	 * @return backstage/success
	 */
	@RequestMapping("/exportActivityExcel.do")
	public ModelAndView exportActivityExcel(HttpServletResponse response,Activity activity){
		ModelAndView modelAndView = new ModelAndView();
		boolean flag = as.exportActivityExcel(response,activity.getId());
		//true 为导出成功
		if(flag){
			modelAndView.setViewName("backstage/success");
		}else{
			modelAndView.setViewName("backstage/fail");
		}
		return modelAndView;
	}
}
