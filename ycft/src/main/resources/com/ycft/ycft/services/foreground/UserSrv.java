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
	
	//�����û�����ֱ�Ӳ�ѯ
	public User selectById(Integer uid) {
		User u = um.selectByPrimaryKey(uid);
		//��ѯ����Ŀ¼�Ƿ����
		File file = new File(Core.ICONPATH);
		
		if(file.exists()) {
			
		}else {
			//�������Ŀ¼
			file.mkdirs();
		}
		//��ѯ����Ŀ¼���û���ͼƬ�Ƿ����
		file = new File(Core.ICONPATH + u.getImgName());
		
		//����ļ��Ѿ�����
		if(file.exists()) {
			
		}else {
			if(u.getImg() != null) {
				//û�л�����Ҫ���»���
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
	 * �û���¼
	 * 
	 * @author ��˧
	 * @param stuCode ѧ��
	 * @param pwd ����
	 * @param res HttpServletResponse����
	 * @return Boolean ��¼�Ƿ�ɹ�
	 * 2018��5��16������3:53:13
	 */
	public User login(String stuCode, String pwd) {
		//��¼
		List<User> list =  um.feLogin(stuCode,pwd);
		if (list != null && list.size() > 0) {
			User u = list.get(0);
			//ȥ���ո�
			pwd = pwd.trim();
			//�ȶ�Md5����
			if(u.getPsd().equals( MD5.md5Password(pwd) ) ) {
		        return u;
			} 
		} 
		return null;
	}
}
