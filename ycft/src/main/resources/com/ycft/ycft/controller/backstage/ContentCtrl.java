package com.ycft.ycft.controller.backstage;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ycft.ycft.po.Content;
import com.ycft.ycft.services.backstage.ContentSrv;

@Controller
public class ContentCtrl {

	@Autowired
	private ContentSrv cs;
	
	@RequestMapping("/selBYTid.do")
	public void selByTid(HttpServletResponse response,HttpServletRequest request) {
		
		int tid = Integer.parseInt(request.getParameter("tid"));
		boolean flag = false;
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			Content content = cs.selById(tid);
			
			//如果查到了则为true
			if (content != null && !content.equals("")) {
				flag = true;
			}
			//查到以后把内容返回过去
			if (flag) {
				writer.println(content.getText());
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
	
}
