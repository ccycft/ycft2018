package com.ycft.ycft.services.foreground;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ycft.ycft.mapper.UserMapper;
import com.ycft.ycft.po.User;
import com.ycft.ycft.system.Core;
import com.ycft.ycft.tools.MD5;

@Service(value="feUserSer")
public class UserSrv {
	
	@Autowired
	private UserMapper um;
	
	//根据用户主键直接查询
	public User selectById(Integer uid) {
		User u = um.selectByPrimaryKey(uid);
		//查询缓存目录是否存在
		File file = new File(Core.ICONPATH);
		
		if(file.exists()) {
			
		}else {
			//创建这个目录
			file.mkdirs();
		}
		//查询缓存目录中用户的图片是否存在
		file = new File(Core.ICONPATH + u.getImgName());
		
		//如果文件已经缓存
		if(file.exists()) {
			
		}else {
			if(u.getImg() != null) {
				//没有缓存须要重新缓存
				OutputStream out;
				try {
					out = new FileOutputStream(file);
					out.write(u.getImg());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			
		}
		return u;
	}
	 
	/**
	 * 用户登录
	 * 
	 * @author 邵帅
	 * @param stuCode 学号
	 * @param pwd 密码
	 * @param res HttpServletResponse对象
	 * @return Boolean 登录是否成功
	 * 2018年5月16日下午3:53:13
	 */
	public User login(String stuCode, String pwd) {
		//登录
		List<User> list =  um.feLogin(stuCode,pwd);
		if (list != null && list.size() > 0) {
			User u = list.get(0);
			//去个空格
			pwd = pwd.trim();
			//比对Md5加密
			if(u.getPsd().equals( MD5.md5Password(pwd) ) ) {
		        return u;
			} 
		} 
		return null;
	}
}
