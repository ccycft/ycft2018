package com.ycft.ycft.controller.backstage;

import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.alibaba.fastjson.JSONObject;
import com.ycft.ycft.tools.UploadUtil;

@Controller
public class ToolCtrl {
	
	/**
	 * 使用summernote插件上传图片 ajax
	 * @author 马荣福
	 * @param request
	 * @param response
	 * @param file 文件名
	 * @throws Exception
	 * 
	 */
	@ResponseBody
	@RequestMapping("upload.do")
	public void summernoteImage(HttpServletRequest request, HttpServletResponse response,MultipartFile file) throws Exception{
     try {
    	//图片上传之后返回图片的路径
    	 String path = UploadUtil.commonUpload(request, file);
    	 //返回json类型的数据
    	 JSONObject jObject=new JSONObject();
    	 //把路径传给前台
    	 jObject.put("path", path);
    	 PrintWriter out=response.getWriter();
    	 out.print(jObject);
    	 out.close();
     }catch(Exception e) {
    	 e.printStackTrace();
     }
	 
    }
	
}
