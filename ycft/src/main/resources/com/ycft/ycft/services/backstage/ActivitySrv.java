package com.ycft.ycft.services.backstage;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ycft.ycft.mapper.ContentMapper;
import com.ycft.ycft.mapper.TitleMapper;
import com.ycft.ycft.po.Content;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.po.TitleContent;
import com.ycft.ycft.po.User;
import com.ycft.ycft.tools.DateUtil;
import com.ycft.ycft.tools.UploadUtil;

@Service
public class ActivitySrv {

	@Autowired
	private TitleMapper tm;
	@Autowired
	private ContentMapper contentMapper;
	
	/**
	 * 连表查询全部通知
	 * @return
	 */
	public List<TitleContent> selAllInform(){
		return tm.selAllByType(3);
	}
	/**
	 * 添加通知信息
	 * @author 郑斌
	 * @param content 内容表
	 * @param title	标题表
	 * @param titleFile 标题的图片
	 * @return
	 * @throws IOException 
	 */
	public boolean addActivityAffairs(HttpServletRequest request,Content content,Title title,MultipartFile titleFile){
		boolean flag = false;
		String imgNamePath  = "";
		if(!titleFile.isEmpty()) {
			//上传图片
			try {
				imgNamePath = UploadUtil.commonUpload(request, titleFile);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {//把默认的图片存进数据库里
			imgNamePath = "/baidu.png";
		}
		title.setTime(DateUtil.getNowDate());
		User user = (User)request.getSession().getAttribute("user");
		title.setUser(user.getSname());
		title.setType(3);
		String imgName = imgNamePath.substring(imgNamePath.lastIndexOf("/")+1);
		title.setImgName(imgName);
		//插入标题
		tm.insertTitle(title);
		content.setTid(title.getId());
		int result = contentMapper.insertSelective(content);
		if (result > 0) {
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	public boolean del(int id) {
		boolean flag = false;
		
		int result = tm.deleteByPrimaryKey(id);
		if (result > 0) {
			flag = true;
		}
		
		return flag;
	}
}
