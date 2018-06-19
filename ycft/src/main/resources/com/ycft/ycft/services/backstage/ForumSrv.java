package com.ycft.ycft.services.backstage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ycft.ycft.mapper.CommentMapper;
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
	@Autowired
	private CommentMapper commentMapper;
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
	
	/**
	 * ����idɾ����Ӧ����̳��Ϣ
	 * @param id
	 * @return
	 */
	public int forumDel(int id) {
		return tm.deleteByPrimaryKey(id);
	}
	
	/**
	 * ����idɾ����Ӧ��������Ϣ
	 * @param id
	 * @return
	 */
	public int commentDel(int id) {
		return commentMapper.deleteByPrimaryKey(id);
	}
	
	
	/**
	 * �ָ�ĳ���ٱ�����
	 * @author ZHENGBIN
	 * @param id ������
	 * @return boolean
	 */
	public boolean forumRestore(int id) {
		//�ָ��ɹ��󷵻�true
		boolean flag = tm.updateReport(id) > 0 ? true : false ;
		
		return flag;
	}
	
	
	/**
	 * @author ZHENGBIN
	 * @param id ������
	 * @return boolean
	 */
	public boolean commentRestore(int id) {
		
		boolean flag = commentMapper.updateCommentRestore(id) > 0 ? true : false;
		
		return flag;
	}
}
