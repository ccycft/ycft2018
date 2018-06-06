package com.ycft.ycft.services.foreground;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ycft.ycft.mapper.SignEventMapper;
import com.ycft.ycft.po.SignEvent;
import com.ycft.ycft.po.Title;

@Service
public class SignEventSrv {
	
	@Autowired
	SignEventMapper sem;
	
	//��ѯǩ��
	public List<SignEvent> selSignEvent(Integer nowPage , Integer pageSize){
		if(nowPage == null ||nowPage <=0 ) {
			//ҳ����Ҫ�û�0
			nowPage = 0;
		}
		//2  0����ʼ����  2�鼸�� [��ѯ����]
		int start = (nowPage - 1) * pageSize;
		List<SignEvent> list =  sem.foreSelSignevent(  start, pageSize);
		 
		return list;
		
	}
	
	public boolean foreSign(Integer sid , Integer uid) {
		int i = sem.insertSign(sid , uid);
		return i > 0 ? true : false;
	}
	
	
	public boolean selSignByUidAndSid(Integer uid , Integer sid) {
		//����true  �����û��Ѿ�ǩ����  �޷��ٴ�ǩ��
		return sem.selSignByUidAndSid(uid , sid) > 0 ? true : false;
	}
}
