package com.ycft.ycft.services.backstage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ycft.ycft.mapper.ContentMapper;
import com.ycft.ycft.po.Content;


@Service
public class ContentSrv {
	
	@Autowired
	private ContentMapper cm;
	
	
	
	/**
	 * 通过tid查询发布的内容
	 * @param tid
	 * @return
	 */
	public Content selById(int tid) {
		
		return cm.selectByTid(tid);
	}

}
