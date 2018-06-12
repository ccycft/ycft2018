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
public class ArticleSrv {
	@Autowired
	private TitleMapper tm;
	@Autowired
	private ContentMapper contentMapper;
	/**
	 * 查询文章的信息
	 * @author 马荣福
	 * @return
	 */
	public List<Title> sel(){
		//1代表文章
		List<Title> tList = selByCount(1);
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
	public boolean addArticleAffairs(HttpServletRequest request,Content content,Title title,MultipartFile titleFile){
		boolean flag = false;
		String imgNamePath  = "";
		//判断文件不空
		if(!titleFile.isEmpty()) {
			//上传图片
			try {
				imgNamePath = UploadUtil.commonUpload(request, titleFile);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			//把默认的图片存进数据库里
			imgNamePath = "/logo.png";
		}
		//存储日期
		title.setTime(DateUtil.getNowDate());
		//通过session获取用户信息
		User user = (User)request.getSession().getAttribute("user");
		//设置用户名
		title.setUser(user.getSname());
		//设置类型 1代表文章
		title.setType(1);
		//文件名截取
		String imgName = imgNamePath.substring(imgNamePath.lastIndexOf("/")+1);
		title.setImgName(imgName);
		title.setUid(user.getId() );
		System.out.println(title.getUid()+"-------------------===============");
		//插入标题
		tm.insertTitle(title);
		//插入标题的id
		content.setTid(title.getId());
		//判断是否成功
		int success = contentMapper.insertSelective(content);
		if(success > 0) {
			flag = true;
		}
		return flag;
	}
	/**
	 * 连表查询全部文章
	 * @return
	 */
	public List<TitleContent> selAllArticle(){
		return tm.selAllByType(1);
	}
	
	/**
	 * 通过id连表查询
	 * @param id
	 * @return
	 */
	public TitleContent selAllTwoById(int id) {
				
		return tm.selAllByTypeAndId(1, id);
	}
	/**
	 * 修改通知的标题和内容信息
	 * @author 马荣福
	 * @param request
	 * @param title 标题
	 * @param content 内容
	 * @return
	 */
	public boolean updArticle(HttpServletRequest request,Title title,Content content,MultipartFile updFile) {
		boolean flag = false;
		String imgNamePath  = "";
		//文件不空
		if(!updFile.isEmpty()) {
			//上传图片
			try {
				//得到的是图片的路径
				imgNamePath = UploadUtil.commonUpload(request, updFile);
				String imgName = imgNamePath.substring(imgNamePath.lastIndexOf("/")+1);
				title.setImgName(imgName);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		//设置修改时间
		title.setTime(DateUtil.getNowDate());
		//获取用户信息
		User user = (User)request.getSession().getAttribute("user");
		title.setUser(user.getSname());
		title.setUid(user.getId() );
		//选择性修改
		int returnValue1 = tm.updateByPrimaryKeySelective(title);
		//通过id修改
		int returnValue2 = contentMapper.updateByTid(content);
		if(returnValue1 > 0 && returnValue2 > 0) {
			flag = true;
		}
		return flag;
	}
}
