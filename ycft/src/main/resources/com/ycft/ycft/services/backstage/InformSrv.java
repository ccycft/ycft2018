package com.ycft.ycft.services.backstage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sun.tools.doclint.Checker.Flag;
import com.ycft.ycft.mapper.TitleMapper;
import com.ycft.ycft.po.Title;

@Service
public class InformSrv {

	@Autowired
	private TitleMapper tm;
	
	/**
	 * ��ѯ֪ͨ����Ϣ
	 * @return
	 */
	public List<Title> sel(){
		List<Title> tList = selByCount(2);
		return tList;
	}
	
	/**
	 * ͨ��type��ѯ 1����2֪ͨ3�
	 * @param count
	 * @return
	 */
	public List<Title> selByCount(int count){
		
		List<Title> tList = tm.selByCount(count);
		
		return tList;
	}
	
	
	/**
	 * ɾ��
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
