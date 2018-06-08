package com.ycft.ycft.mapper;

import java.util.List;

import com.ycft.ycft.po.Forum;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.po.TitleContent;

public interface TitleMapper {
	
	/*
	 * �ͻ��˷�����ʼ
	 * 
	 * */
	//���ݵ���������ѯ��������
	public List<Title> selectByPraiseCount(int type , int count  );
	//���ݷ���ʱ���ѯ����   ���ڼ��ظ���limit start:��ʼ���� end��������
	public List<Title> selectByTime( int type , int start , int end );
	public List<Title> selectByTimeAndCount(  int start , int end );
	public int insertActivity(Integer tid , Integer uid);
	//����uid��tid��ѯ
	public int selectActivityByTidUid(Integer tid , Integer uid);
	//��̳��ѯ
	public List<Forum> selectForum(Integer nowPage , Integer pageSize);
	public List<Forum> selDetailAndComment(Integer id);
	/**
	 * �ͻ��˷�������
	 * */
    int deleteByPrimaryKey(Integer id);

    int insert(Title record);

    int insertSelective(Title record);

    Title selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Title record);

    int updateByPrimaryKey(Title record);
    
    /*
	 * ����˷�����ʼ
	 * 
	 * */
	public List<Title> selByCount(int type);
	public int insertTitle(Title title);
	//�����ѯ���е�֪ͨ����
	public List<TitleContent> selAllByType(int type);
	
	public TitleContent selAllByTypeAndId(int type,int id);
	public List<Title> selTitleCommentById(int id);
	/**
	 * ����˷�������
	 * */
}