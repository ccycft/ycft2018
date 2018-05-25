package com.ycft.ycft.mapper;

import com.ycft.ycft.po.Activity;

public interface ActivityMapper {
    int insert(Activity record);

    int insertSelective(Activity record);
}