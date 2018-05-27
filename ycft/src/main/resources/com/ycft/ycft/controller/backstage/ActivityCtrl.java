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
	 * ��ѯ�����Ի��Ϣ
	 * @author ZHENGBIN
	 * @return backstage/activity/activityMaintenance/maintenance
	 */
	@RequestMapping("/selActivity.do")
	public ModelAndView selActivity() {
		ModelAndView modelAndView = new ModelAndView();
		//���л��Ϣ
		List<TitleContent> tcList = as.selAllActivity();
		
		modelAndView.addObject("tcList", tcList);
		modelAndView.setViewName("backstage/activity/activityMaintenance/maintenance");
		
		return modelAndView;
	}
	
	/**
	 * ��ķ�������
	 * ��������ת��ԭ����
	 * @author ZHENGBIN
	 * @param response
	 * @param request
	 * @param content ������
	 * @param title ������
	 * @param titleFile ���ͼƬ
	 * @return selActivity.do
	 * @throws IOException 
	 */
	@RequestMapping("/addActivity.do")
	public String addInform(HttpServletResponse response,HttpServletRequest request, Content content,Title title,MultipartFile titleFile) throws IOException { 
		boolean flag = as.addActivityAffairs(request,content,title,titleFile);
		//trueΪ�����ɹ�
		if(flag) {
			return "selActivity.do";
		}else {
			return "selActivity.do";
		}
		
	}
	
	/**
	 * ajaxɾ��
	 * ɾ���ɹ��󷵻�1
	 * ��Ϊ�����˴���������ɾ��ĳ������û�ı�����ϢҲɾ��
	 * @author ZHENGBIN
	 * @param response
	 * @param request
	 */
	@RequestMapping("/activityDel.do")
	public void del(HttpServletResponse response,HttpServletRequest request) {
		
		PrintWriter writer = null;
		//��ȡɾ���������Ϣ��id
		int id = Integer.parseInt(request.getParameter("id"));
		try {
			writer = response.getWriter();
			boolean flag = as.del(id);
			//trueΪɾ���ɹ�
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
	 * ���޸Ĵ�id������ѯ��������ת���µ��޸Ľ���
	 * @author ZHENGBIN
	 * @param request
	 * @return backstage/activity/activityMaintenance/activityUpdate
	 */
	@RequestMapping("/activityUpdate.do")
	public ModelAndView activityUpdate(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		//��ȡ��Ҫ�޸�ĳ�����Ϣ��id
		int id = Integer.parseInt(request.getParameter("id"));
		//��ѯ����id�Ļ��Ϣ
		TitleContent tc = as.selAllActivityById(id);
		
		modelAndView.addObject("tc",tc);
		modelAndView.setViewName("backstage/activity/activityMaintenance/activityUpdate");
		
		return modelAndView;
	}
	
	/**
	 * �޸ĳɹ�����ʾ�޸ĳɹ������ر��޸�ҳ��
	 * @author ZHENGBIN
	 * @param response
	 * @param request
	 * @param title ������
	 * @param content ������
	 * @param updFile �޸ĵ�ͼƬ
	 * @throws IOException
	 */
	@RequestMapping("/updActivity.do")
	public void updActivity(HttpServletResponse response,HttpServletRequest request,Title title,Content content,MultipartFile updFile) throws IOException {
		boolean flag = as.updActivity(request,title,content,updFile);
		//trueΪ�޸ĳɹ�
		if(flag) {
			//��̨��ʾһ�£����رյ�ǰҳ��
			response.setContentType("text/html");
        	response.setCharacterEncoding("UTF-8");
        	PrintWriter out = response.getWriter();
        	out.println("<script>"); 
        	out.println("alert('�޸ĳɹ�');"); 
        	out.println("window.opener=null;window.close();");
        	out.println("</script>");
		}else {
			response.setContentType("text/html");
        	response.setCharacterEncoding("UTF-8");
        	PrintWriter out = response.getWriter();
        	out.println("<script>"); 
        	out.println("alert('�޸�ʧ��');"); 
        	out.println("window.opener=null;window.close();");
        	out.println("</script>");
		}
	}
	
	/**
	 * ���ص�����excelģ��demo�ļ�
	 * @author ZHENGBIN
	 * @param response
	 * @param request
	 */
	@RequestMapping("/downloadActivityDemo.do")
	public void downloadActivityDemo(HttpServletResponse response,HttpServletRequest request){
        //����ģ��
		as.downloadActivityDemo(response, request);
	}
	
	/**
	 * ����ɹ�����ת��ԭ����
	 * @author ZHENGBIN
	 * @param file
	 * @param activity �����󶨣������ĸ�����󶨹���id
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
		//true ����ɹ�
		if(flag){
			modelAndView.setViewName("selActivity.do");
		}else{
			modelAndView.setViewName("backstage/fail");
		}
		return modelAndView;
	}
	
	/**
	 * ����excel
	 * �����ɹ�����ת��success�������̨����ΪgetWriter��getOutputStream��ͻ������
	 * @author ZHENGBIN
	 * @param response
	 * @param activity �����󶨣������ĸ�����󶨹���id
	 * @return backstage/success
	 */
	@RequestMapping("/exportActivityExcel.do")
	public ModelAndView exportActivityExcel(HttpServletResponse response,Activity activity){
		ModelAndView modelAndView = new ModelAndView();
		boolean flag = as.exportActivityExcel(response,activity.getId());
		//true Ϊ�����ɹ�
		if(flag){
			modelAndView.setViewName("backstage/success");
		}else{
			modelAndView.setViewName("backstage/fail");
		}
		return modelAndView;
	}
}
