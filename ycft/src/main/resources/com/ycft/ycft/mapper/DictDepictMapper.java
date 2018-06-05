package com.ycft.ycft.mapper;

import java.util.List;

import com.ycft.ycft.po.DictDepict;

public interface DictDepictMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(DictDepict record);

    int insertSelective(DictDepict record);

    DictDepict selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(DictDepict record);

    int updateByPrimaryKey(DictDepict record);
    
    List<DictDepict> selDictDictionary();
    //查询是否有重复的字典代码
    DictDepict selectByDictType(String dictType);
}