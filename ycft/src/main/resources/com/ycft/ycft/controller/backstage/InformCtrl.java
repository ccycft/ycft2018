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

import com.ycft.ycft.po.Content;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.po.TitleContent;
import com.ycft.ycft.services.backstage.InformSrv;

@Controller
public class InformCtrl {
	
	@Autowired
	private InformSrv is;
	
	/**
	 * ��ѯ���е�֪ͨ
	 * @author ���ٸ�
	 * @return
	 */
	@RequestMapping("/selInform.do")
	public ModelAndView selInform() { 
		ModelAndView modelAndView = new ModelAndView();
		
		List<TitleContent> tcList = is.selAllInform();
		
		modelAndView.addObject("tcList", tcList);
		//���ؽ���
		modelAndView.setViewName("backstage/inform/informMaintenance/maintenance.jsp");
		
		return modelAndView;
		
	}
	/**
	* @param response
	 * @param request
	 * @param content ����
	 * @param title ����
	 * @param titleFile �����ļ�
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/addInform.do")
	public String addInform(HttpServletResponse response,HttpServletRequest request, Content content,Title title,MultipartFile titleFile) throws IOException { 
		boolean flag = is.addInformAffairs(request,content,title,titleFile);
		if(flag) {
			return "selInform.do";
		}else {
			return "selInform.do";
		}
		
	}
	/**
	 * ɾ��֪ͨ�ɹ��󷵻�ԭҳ��
	 * @author ZHENGBIN
	 * @param request
	 * @return selInform.do
	 */
	@RequestMapping("/informDel.do")
	public ModelAndView del(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		//��ȡɾ����id
		int id = Integer.parseInt(request.getParameter("id"));
		boolean flag = is.del(id);
		//ɾ���ɹ�����true
		if (flag) {
			modelAndView.setViewName("selInform.do");
		} else {
			modelAndView.setViewName("fail.jsp");
		}
		return modelAndView;
	}
	
	/**
	 * ���޸Ĵ�id������ѯ�����ݵ��޸Ľ���
	 * @author ZHENGBIN
	 * @param request
	 * @return backstage/inform/informMaintenance/informUpdate.jsp
	 */
	@RequestMapping("/informUpdate.do")
	public ModelAndView informUpdate(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		
		int id = Integer.parseInt(request.getParameter("id"));
		//��ȡ����id����Ϣ
		TitleContent tc = is.selAllInformById(id);
		
		modelAndView.addObject("tc",tc);
		modelAndView.setViewName("backstage/inform/informMaintenance/informUpdate.jsp");
		
		return modelAndView;
	}
	
	/**
	 * �޸�֪ͨ��Ϣ
	 * @param response
	 * @param request
	 * @param title
	 * @param content
	 * @param updFile
	 * @throws IOException
	 */
	@RequestMapping("/updInform.do")
	public void updInform(HttpServletResponse response,HttpServletRequest request,Title title,Content content,MultipartFile updFile) throws IOException {
		boolean flag = is.updInform(request,title,content,updFile);
		//ʹ��js�ر�ҳ��
		if(flag) {
			response.setContentType("text/html");
        	response.setCharacterEncoding("UTF-8");
        	PrintWriter out = response.getWriter();
        	out.println("<script>"); 
        	out.println("alert('�޸ĳɹ�');"); 
        	out.println("window.open('selInform.do','_top');");
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
}
