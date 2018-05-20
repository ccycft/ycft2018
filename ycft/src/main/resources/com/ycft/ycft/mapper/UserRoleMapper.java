package com.ycft.ycft.mapper;

import com.ycft.ycft.po.UserRole;

public interface UserRoleMapper {
    int insert(UserRole record);

    int insertSelective(UserRole record);
    /*===============服务端方法================*/
    int updateByUid(int rid ,int uId);
    /*===============服务端方法================*/
}