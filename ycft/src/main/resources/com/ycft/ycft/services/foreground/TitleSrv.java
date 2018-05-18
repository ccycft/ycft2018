package com.ycft.ycft.services.foreground;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ycft.ycft.mapper.TitleMapper;
import com.ycft.ycft.po.Title;

@Service(value="titleSrv")
public class TitleSrv {

	@Autowired
	private TitleMapper tm;
	
	/**
	 * ��ѯ����
	 * 
	 * @author ��˧
	 * @param count һҳ��ʾ�ĸ���
	 * @return
	 * 2018��5��18������11:16:22
	 */
	public List<Title> select(int count){
		/*if(count == null || count == 0) {
			count = 2;
		}*/
		return tm.select(count);
	}
}
