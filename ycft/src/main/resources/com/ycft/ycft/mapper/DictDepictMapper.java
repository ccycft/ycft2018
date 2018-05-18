package com.ycft.ycft.mapper;

import com.ycft.ycft.po.DictDepict;

public interface DictDepictMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(DictDepict record);

    int insertSelective(DictDepict record);

    DictDepict selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(DictDepict record);

    int updateByPrimaryKey(DictDepict record);
}