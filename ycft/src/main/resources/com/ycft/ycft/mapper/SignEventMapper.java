package com.ycft.ycft.mapper;

import com.ycft.ycft.po.SignEvent;

public interface SignEventMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SignEvent record);

    int insertSelective(SignEvent record);

    SignEvent selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SignEvent record);

    int updateByPrimaryKey(SignEvent record);
}