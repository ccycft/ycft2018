package com.ycft.ycft.mapper;

import com.ycft.ycft.po.Praise;

public interface PraiseMapper {
	
	/**
	 * 客户端方法开始
	 * */
	//点赞
	public int insertUid(Praise p);
	/**
	 * 客户端方法结束
	 * */
    int deleteByPrimaryKey(Integer id);

    int insert(Praise record);

    int insertSelective(Praise record);

    Praise selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Praise record);

    int updateByPrimaryKey(Praise record);
}