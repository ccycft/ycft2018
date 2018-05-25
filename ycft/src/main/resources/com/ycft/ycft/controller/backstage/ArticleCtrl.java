package com.ycft.ycft.controller.backstage;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.alibaba.fastjson.JSONObject;
import com.ycft.ycft.po.Content;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.po.TitleContent;
import com.ycft.ycft.services.backstage.ArticleSrv;
import com.ycft.ycft.tools.UploadUtil;

@Controller
public class ArticleCtrl {

	@Autowired
	private ArticleSrv articleSrv;
	
	/**
	 * 
	 * @return
	 */
	@RequestMapping("/selArticle.do")
	public ModelAndView selArticle() {
		ModelAndView modelAndView = new ModelAndView();
		
		List<TitleContent> tcList = articleSrv.selAllArticle();
		System.out.println(tcList.get(0).getPraise()+"+++++++++");
		modelAndView.addObject("tcList", tcList);
		modelAndView.setViewName("backstage/article/articleMaintenance/maintenance");
		
		return modelAndView;
		
	}
	/**
	 * 查询热门文章
	 * @author 马荣福
	 * @return
	 */
	@RequestMapping("selHotArticle.do")
	public ModelAndView selHotArticle(){
		ModelAndView modelAndView = new ModelAndView();
		List<TitleContent> tcList = articleSrv.selAllArticle();
		modelAndView.addObject("tcList", tcList);
		modelAndView.setViewName("backstage/article/hotArticleSel/maintenance");
		return modelAndView;
	}
	/**
	 * 
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/addArticle.do")
	public String addArticle(HttpServletResponse response,HttpServletRequest request, Content content,Title title,MultipartFile titleFile) throws IOException { 
		boolean flag = articleSrv.addArticleAffairs(request,content,title,titleFile);
		if(flag) {
			return "selArticle.do";
		}else {
			return "selArticle.do";
		}
		
	}
	@RequestMapping("/articleDel.do")
	public void del(HttpServletResponse response,HttpServletRequest request) {
		
		PrintWriter writer = null;
		int id = Integer.parseInt(request.getParameter("id"));
		try {
			writer = response.getWriter();
			boolean flag = articleSrv.del(id);
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
	
	@ResponseBody
	@RequestMapping("articleUpload.do")
	public void summernoteImage(HttpServletRequest request, HttpServletResponse response,MultipartFile file) throws Exception{
     try {
    	 System.out.println("----------");
    	//图片上传之后返回图片的路径
    	 String path = UploadUtil.commonUpload(request, file);
    	 //返回json类型的数据
    	 JSONObject jObject=new JSONObject();
    	 jObject.put("path", path);
    	 PrintWriter out=response.getWriter();   
    	 out.print(jObject);
    	 out.close();
     }catch(Exception e) {
    	 e.printStackTrace();
     }
	 
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
		modelAndView.setViewName("backstage/article/articleMaintenance/articleUpdate");
		
		return modelAndView;
	}
	
	@RequestMapping("/updArticle.do")
	public void updArticle(HttpServletResponse response,HttpServletRequest request,Title title,Content content,MultipartFile updFile) throws IOException {
		boolean flag = articleSrv.updArticle(request,title,content,updFile);
		if(flag) {
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
}
