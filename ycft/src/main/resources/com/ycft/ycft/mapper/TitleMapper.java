package com.ycft.ycft.mapper;

import java.util.List;

import com.ycft.ycft.po.Comment;
import com.ycft.ycft.po.Forum;
import com.ycft.ycft.po.SignEvent;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.po.TitleContent;

public interface TitleMapper {
	
	/*
	 * 客户端方法开始
	 * 
	 * */
	//根据点赞数量查询热门文章
	public List<Title> selectByPraiseCount(int type , int count  );
	//根据发布时间查询文章   用于加载更多limit start:开始坐标 end结束坐标
	public List<Title> selectByTime( int type , int start , int end );
	public List<Title> selectByTimeAndCount(  int start , int end );
	public int insertActivity(Integer tid , Integer uid);
	//根据uid和tid查询
	public int selectActivityByTidUid(Integer tid , Integer uid);
	//论坛查询
	public List<Forum> selectForum(Integer nowPage , Integer pageSize);
	public List<Forum> selDetail(Integer id);
	//论坛title插入
	public int insertForum(Title t);
	//插入用户评论
	public int insertComment(Comment comment);
	//查询我的活动
	List<Title> selectActivityById(Integer uid,Integer nowPage , Integer pageSize);
	/**
	 * 客户端方法结束
	 * */
    int deleteByPrimaryKey(Integer id);

    int insert(Title record);

    int insertSelective(Title record);

    Title selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Title record);

    int updateByPrimaryKey(Title record);
    
    /*
	 * 服务端方法开始
	 * 
	 * */
	public List<Title> selByCount(int type);
	public int insertTitle(Title title);
	//连表查询所有的通知属性
	public List<TitleContent> selAllByType(int type);
	
	public TitleContent selAllByTypeAndId(int type,int id);
	public TitleContent selByTypeAndIdNot(int type,int id);
	public List<Title> selTitleCommentById(int id);
	public int updateReport(int id);
	/*
	 * 服务端方法结束
	 * */
}