package com.ycft.ycft.mapper;

import java.util.List;

import com.ycft.ycft.po.Activity;

public interface ActivityMapper {
    int insert(Activity record);

    int insertSelective(Activity record);
    /*===============服务端方法================*/
    int batchInsert(List<Activity> aList);
    //删除重复的数据
    public int delRepeat();
    /*===============服务端方法================*/
}