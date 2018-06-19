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
	 * 连表查询全部通知
	 * @return
	 */
	public List<TitleContent> selAllForum(){
		return tm.selAllByType(4);
	}
	
	/**根据id查询对应的评论
	 * @param id
	 * @return
	 */
	public List<Title> selTitleCommentById(int id){
		return tm.selTitleCommentById(id);
	}
	
	/**
	 * 根据id删除对应的论坛信息
	 * @param id
	 * @return
	 */
	public int forumDel(int id) {
		return tm.deleteByPrimaryKey(id);
	}
	
	/**
	 * 根据id删除对应的评论信息
	 * @param id
	 * @return
	 */
	public int commentDel(int id) {
		return commentMapper.deleteByPrimaryKey(id);
	}
	
	
	/**
	 * 恢复某条举报内容
	 * @author ZHENGBIN
	 * @param id 参数绑定
	 * @return boolean
	 */
	public boolean forumRestore(int id) {
		//恢复成功后返回true
		boolean flag = tm.updateReport(id) > 0 ? true : false ;
		
		return flag;
	}
	
	
	/**
	 * @author ZHENGBIN
	 * @param id 参数绑定
	 * @return boolean
	 */
	public boolean commentRestore(int id) {
		
		boolean flag = commentMapper.updateCommentRestore(id) > 0 ? true : false;
		
		return flag;
	}
}
