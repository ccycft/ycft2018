package com.ycft.ycft.mapper;

import java.util.List;

import com.ycft.ycft.po.Role;

public interface RoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);
    /*===============服务端方法================*/
    List<Role> selAllRole();
    
    Role selByRname(String rname);
    /*===============服务端方法================*/
}