package com.ycft.ycft.mapper;

import java.util.List;

import com.ycft.ycft.po.Activity;

public interface ActivityMapper {
    int insert(Activity record);

    int insertSelective(Activity record);
    /*===============����˷���================*/
    int batchInsert(List<Activity> aList);
    //ɾ���ظ�������
    public int delRepeat();
    /*===============����˷���================*/
}