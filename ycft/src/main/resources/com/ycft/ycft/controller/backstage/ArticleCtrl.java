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
	 * 查询所有的文章
	 * @author 马荣福
	 * @return
	 */
	@RequestMapping("/selArticle.do")
	public ModelAndView selArticle() {
		ModelAndView modelAndView = new ModelAndView();
		//查询文章的标题和内容的连表
		List<TitleContent> tcList = articleSrv.selAllArticle();
		//返回页面的数据
		modelAndView.addObject("tcList", tcList);
		//跳转的页面
		modelAndView.setViewName("backstage/article/articleMaintenance/maintenance.jsp");
		return modelAndView;
		
	}
	/**
	 *  文章的录入
	 * @param response
	 * @param request
	 * @param content 内容
	 * @param title 标题
	 * @param titleFile 标题文件
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/addArticle.do")
	public String addArticle(HttpServletResponse response,HttpServletRequest request, Content content,Title title,MultipartFile titleFile) throws IOException { 
		//录入文章
		boolean flag = articleSrv.addArticleAffairs(request,content,title,titleFile);
		if(flag) {
			return "redirect:/backstage/selArticle.do";
		}else {
			return "redirect:/backstage/fail.jsp";
		}
		
	}
	/**
	 * 文章的删除通过id删除标题表的文章，使用了触发器删除对应的内容
	 * @author 马荣福
	 * @param request
	 * @param id 标题的id
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
			//向前台返回信息
		return modelAndView;
	}
	/**
	 * 点修改带id进来查询出数据到修改界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/articleUpdate.do")
	public ModelAndView articleUpdate(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		
		int id = Integer.parseInt(request.getParameter("id"));
		
		TitleContent tc = articleSrv.selAllTwoById(id);
		
		modelAndView.addObject("tc",tc);
		//返回的界面
		modelAndView.setViewName("backstage/article/articleMaintenance/articleUpdate.jsp");
		
		return modelAndView;
	}
	
	/**
	 * 修改文章信息
	 * @author 马荣福
	 * @param response
	 * @param request
	 * @param title
	 * @param content
	 * @param updFile
	 * @throws IOException
	 */
	@RequestMapping("/updArticle.do")
	public void updArticle(HttpServletResponse response,HttpServletRequest request,Title title,Content content,MultipartFile updFile) throws IOException {
		//修改文章
		boolean flag = articleSrv.updArticle(request,title,content,updFile);
		//使用js代码关闭前台界面
		if(flag) {
			response.setContentType("text/html");
        	response.setCharacterEncoding("UTF-8");
        	PrintWriter out = response.getWriter();
        	out.println("<script>"); 
        	out.println("alert('修改成功');"); 
        	out.println("window.open('selArticle.do','_top');");
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
}
