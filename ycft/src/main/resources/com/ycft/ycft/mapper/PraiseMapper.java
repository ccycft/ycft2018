package com.ycft.ycft.mapper;

import com.ycft.ycft.po.Praise;

public interface PraiseMapper {
	
	/**
	 * �ͻ��˷�����ʼ
	 * */
	//����
	public int insertUid(Praise p);
	/**
	 * �ͻ��˷�������
	 * */
    int deleteByPrimaryKey(Integer id);

    int insert(Praise record);

    int insertSelective(Praise record);

    Praise selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Praise record);

    int updateByPrimaryKey(Praise record);
}