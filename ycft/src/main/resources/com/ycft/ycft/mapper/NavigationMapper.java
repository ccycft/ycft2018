package com.ycft.ycft.mapper;

import java.util.List;

import com.ycft.ycft.po.Navigation;

public interface NavigationMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Navigation record);

    int insertSelective(Navigation record);

    Navigation selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Navigation record);

    int updateByPrimaryKey(Navigation record);
    
    List<Navigation> selectAll();
}