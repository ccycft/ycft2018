package com.ycft.ycft.mapper;

import java.util.List;

import com.ycft.ycft.po.Title;

public interface TitleMapper {
	
	/*
	 * �ͻ��˷�����ʼ
	 * 
	 * */
	//���ݵ���������ѯ��������
	public List<Title> selectByPraiseCount(int count);
	//���ݷ���ʱ���ѯ����   ���ڼ��ظ���limit start:��ʼ���� end��������
	public List<Title> selectByTime(int start , int end);
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
	/**
	 * ����˷�������
	 * */
}