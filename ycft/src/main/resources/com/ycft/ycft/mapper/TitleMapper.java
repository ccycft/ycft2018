package com.ycft.ycft.mapper;

import java.util.List;

import com.ycft.ycft.po.Title;

public interface TitleMapper {
	
	/*
	 * �ͻ��˷�����ʼ
	 * 
	 * */
	public List<Title> select(int count);
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
	/**
	 * ����˷�������
	 * */
}