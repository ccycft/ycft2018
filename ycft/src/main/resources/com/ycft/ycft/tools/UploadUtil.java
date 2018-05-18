package com.ycft.ycft.tools;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

public class UploadUtil {
    
    
    /**
     * 上传图片到服务器
     * @param request
     * @param filedata
     * @return
     * @throws IOException
     */
    public static String commonUpload(HttpServletRequest request, MultipartFile filedata) throws IOException {
    	// 获取时间戳 我是以获取时间戳来命名上传的文件的
        String fileName = TimeTool.getRandomOrderNoOrFileName();
        String path = request.getSession().getServletContext().getRealPath("/");
    	
    	byte[] by =  filedata.getBytes();
    	//原图片名称
    	String filename = filedata.getOriginalFilename();
    	//文件后缀 .jpg
    	String suffix = filename.substring(filename.lastIndexOf("."));
    	//新文件名
    	String newFileName = System.currentTimeMillis() + suffix;
    	System.out.println(newFileName+"--------");
    	System.out.println(path);
    	//上传图片到服务器
    	FileOutputStream fos;
    	String finalPathAndName1 = path +"images/"+newFileName;
    	fos = new FileOutputStream(finalPathAndName1);
    	fos.write(by);
    	fos.close();
        return "http://localhost:8080/ycft/images/"+newFileName;
    }
    
}

