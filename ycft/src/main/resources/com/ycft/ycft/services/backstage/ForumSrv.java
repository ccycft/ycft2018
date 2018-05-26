package com.ycft.ycft.services.backstage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ycft.ycft.mapper.ContentMapper;
import com.ycft.ycft.mapper.TitleMapper;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.po.TitleContent;

@Service
public class ForumSrv {
	
	@Autowired
	private TitleMapper tm;
	@Autowired
	private ContentMapper contentMapper;
	
	/**
	 * �����ѯȫ��֪ͨ
	 * @return
	 */
	public List<TitleContent> selAllForum(){
		return tm.selAllByType(4);
	}
	
	/**����id��ѯ��Ӧ������
	 * @param id
	 * @return
	 */
	public List<Title> selTitleCommentById(int id){
		return tm.selTitleCommentById(id);
	}
}
