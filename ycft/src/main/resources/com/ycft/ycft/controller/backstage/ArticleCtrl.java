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
import com.ycft.ycft.services.backstage.ArticleSrv;

@Controller
@RequestMapping("backstage/")
public class ArticleCtrl {

	@Autowired
	private ArticleSrv articleSrv;
	
	/**
	 * ��ѯ���е�����
	 * @author ���ٸ�
	 * @return
	 */
	@RequestMapping("/selArticle.do")
	public ModelAndView selArticle() {
		ModelAndView modelAndView = new ModelAndView();
		//��ѯ���µı�������ݵ�����
		List<TitleContent> tcList = articleSrv.selAllArticle();
		//����ҳ�������
		modelAndView.addObject("tcList", tcList);
		//��ת��ҳ��
		modelAndView.setViewName("backstage/article/articleMaintenance/maintenance.jsp");
		return modelAndView;
		
	}
	/**
	 *  ���µ�¼��
	 * @param response
	 * @param request
	 * @param content ����
	 * @param title ����
	 * @param titleFile �����ļ�
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/addArticle.do")
	public String addArticle(HttpServletResponse response,HttpServletRequest request, Content content,Title title,MultipartFile titleFile) throws IOException { 
		//¼������
		boolean flag = articleSrv.addArticleAffairs(request,content,title,titleFile);
		if(flag) {
			return "redirect:/backstage/selArticle.do";
		}else {
			return "redirect:/backstage/fail.jsp";
		}
		
	}
	/**
	 * ���µ�ɾ��ͨ��idɾ�����������£�ʹ���˴�����ɾ����Ӧ������
	 * @author ���ٸ�
	 * @param request
	 * @param id �����id
	 */
	@RequestMapping("/articleDel.do")
	public ModelAndView del(HttpServletRequest request,int id) {
		ModelAndView modelAndView = new ModelAndView();
		boolean flag = articleSrv.del(id);
		if (flag) {
			modelAndView.setViewName("redirect:/backstage/selArticle.do");
		} else {
			modelAndView.setViewName("redirect:/backstage/fail.jsp");
		}
			//��ǰ̨������Ϣ
		return modelAndView;
	}
	/**
	 * ���޸Ĵ�id������ѯ�����ݵ��޸Ľ���
	 * @param request
	 * @return
	 */
	@RequestMapping("/articleUpdate.do")
	public ModelAndView articleUpdate(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		
		int id = Integer.parseInt(request.getParameter("id"));
		
		TitleContent tc = articleSrv.selAllTwoById(id);
		
		modelAndView.addObject("tc",tc);
		//���صĽ���
		modelAndView.setViewName("backstage/article/articleMaintenance/articleUpdate.jsp");
		
		return modelAndView;
	}
	
	/**
	 * �޸�������Ϣ
	 * @author ���ٸ�
	 * @param response
	 * @param request
	 * @param title
	 * @param content
	 * @param updFile
	 * @throws IOException
	 */
	@RequestMapping("/updArticle.do")
	public void updArticle(HttpServletResponse response,HttpServletRequest request,Title title,Content content,MultipartFile updFile) throws IOException {
		//�޸�����
		boolean flag = articleSrv.updArticle(request,title,content,updFile);
		//ʹ��js����ر�ǰ̨����
		if(flag) {
			response.setContentType("text/html");
        	response.setCharacterEncoding("UTF-8");
        	PrintWriter out = response.getWriter();
        	out.println("<script>"); 
        	out.println("alert('�޸ĳɹ�');"); 
        	out.println("window.open('selArticle.do','_top');");
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
