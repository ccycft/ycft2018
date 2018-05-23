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
public class InformSrv {

	@Autowired
	private TitleMapper tm;
	@Autowired
	private ContentMapper contentMapper;
	/**
	 * 查询通知的信息
	 * @return
	 */
	public List<Title> sel(){
		List<Title> tList = selByCount(2);
		return tList;
	}
	
	/**
	 * 通过type查询 1文章2通知3活动
	 * @param count
	 * @return
	 */
	public List<Title> selByCount(int count){
		
		List<Title> tList = tm.selByCount(count);
		
		return tList;
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
	
	/**
	 * 添加通知信息
	 * @author 马荣福
	 * @param content 内容表
	 * @param title	标题表
	 * @param titleFile 标题的图片
	 * @return
	 * @throws IOException 
	 */
	public boolean addInformAffairs(HttpServletRequest request,Content content,Title title,MultipartFile titleFile){
		boolean flag = false;
		String imgNamePath  = "";
		//上传图片
		try {
			imgNamePath = UploadUtil.commonUpload(request, titleFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
		title.setTime(DateUtil.getNowDate());
		User user = (User)request.getSession().getAttribute("user");
		title.setUser(user.getSname());
		title.setType(2);
		String imgName = imgNamePath.substring(imgNamePath.lastIndexOf("/")+1);
		title.setImgName(imgName);
		//插入标题
		tm.insertTitle(title);
		content.setTid(title.getId());
		int success = contentMapper.insertSelective(content);
		System.out.println(success);
		return flag;
	}
	/**
	 * 连表查询全部通知
	 * @return
	 */
	public List<TitleContent> selAllInform(){
		return tm.selAllTwo();
	}
	
	/**
	 * 通过id连表查询
	 * @param id
	 * @return
	 */
	public TitleContent selAllTwoById(int id) {
				
		return tm.selAllTwoById(id);
	}
	/**
	 * 修改通知的标题和内容信息
	 * @author 马荣福
	 * @param request
	 * @param title 标题
	 * @param content 内容
	 * @return
	 */
	public boolean updInform(HttpServletRequest request,Title title,Content content,MultipartFile updFile) {
		boolean flag = false;
		System.out.println(updFile.getOriginalFilename()+"++++++++++");
		String imgNamePath  = "";
		//上传图片
		try {
			//得到的是图片的路径
			imgNamePath = UploadUtil.commonUpload(request, updFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
		//设置修改时间
		title.setTime(DateUtil.getNowDate());
		//获取用户信息
		User user = (User)request.getSession().getAttribute("user");
		title.setUser(user.getSname());
		String imgName = imgNamePath.substring(imgNamePath.lastIndexOf("/")+1);
		title.setImgName(imgName);
		
		tm.updateByPrimaryKeySelective(title);
		contentMapper.updateByTid(content);
		return flag;
	}
}
