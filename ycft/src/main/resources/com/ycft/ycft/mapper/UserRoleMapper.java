package com.ycft.ycft.mapper;

import com.ycft.ycft.po.UserRole;

public interface UserRoleMapper {
    int insert(UserRole record);

    int insertSelective(UserRole record);
}