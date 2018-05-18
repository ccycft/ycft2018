package com.ycft.ycft.services.foreground;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ycft.ycft.mapper.UserMapper;
import com.ycft.ycft.po.User;
import com.ycft.ycft.tools.MD5;

@Service(value="feUserSer")
public class UserSrv {
	
	@Autowired
	private UserMapper um;
	
	 
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
