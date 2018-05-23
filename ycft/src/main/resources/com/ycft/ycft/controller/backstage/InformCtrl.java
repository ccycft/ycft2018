package com.ycft.ycft.controller.backstage;

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
import com.ycft.ycft.services.backstage.InformSrv;
import com.ycft.ycft.tools.UploadUtil;

@Controller
public class InformCtrl {
	
	@Autowired
	private InformSrv is;
	
	/**
	 * 
	 * @return
	 */
	@RequestMapping("/selInform.do")
	public ModelAndView selInform() { 
		ModelAndView modelAndView = new ModelAndView();
		
		List<TitleContent> tcList = is.selAllInform();
		
		modelAndView.addObject("tcList", tcList);
		modelAndView.setViewName("backstage/inform/informMaintenance/maintenance");
		
		return modelAndView;
		
	}
	/**
	 * 
	 * @return
	 */
	@RequestMapping("/addInform.do")
	public ModelAndView addInform(HttpServletRequest request, Content content,Title title,MultipartFile titleFile) { 
		ModelAndView modelAndView = new ModelAndView();
		System.out.println("---");
		System.out.println(content.getText()+"---");
		System.out.println(title.getName()+"---");
		System.out.println(titleFile.getName());
		is.addInformAffairs(request,content,title,titleFile);
		return modelAndView;
		
	}
	@RequestMapping("/informDel.do")
	public void del(HttpServletResponse response,HttpServletRequest request) {
		
		PrintWriter writer = null;
		int id = Integer.parseInt(request.getParameter("id"));
		try {
			writer = response.getWriter();
			boolean flag = is.del(id);
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
	@RequestMapping("informUpload.do")
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
	@RequestMapping("/informUpdate.do")
	public ModelAndView informUpdate(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		
		int id = Integer.parseInt(request.getParameter("id"));
		
		TitleContent tc = is.selAllTwoById(id);
		
		modelAndView.addObject("tc",tc);
		modelAndView.setViewName("backstage/inform/informMaintenance/informUpdate");
		
		return modelAndView;
	}
	
	@RequestMapping("/updInform.do")
	public ModelAndView updInform(HttpServletRequest request,Title title,Content content,MultipartFile updFile) {
		ModelAndView modelAndView = new ModelAndView();
		is.updInform(request,title,content,updFile);
		return modelAndView;
	}
}
