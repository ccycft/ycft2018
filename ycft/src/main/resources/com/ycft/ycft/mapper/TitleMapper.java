package com.ycft.ycft.mapper;

import java.util.List;

import com.ycft.ycft.po.Title;

public interface TitleMapper {
	
	/*
	 * 客户端方法开始
	 * 
	 * */
	public List<Title> select(int count);
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
	/**
	 * 服务端方法结束
	 * */
}