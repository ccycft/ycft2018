package com.ycft.ycft.mapper;

import java.util.List;

import com.ycft.ycft.po.SignEvent;
import com.ycft.ycft.po.User;

public interface SignEventMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SignEvent record);

    int insertSelective(SignEvent record);

    SignEvent selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SignEvent record);

    int updateByPrimaryKey(SignEvent record);
    
   List<SignEvent> selSignUser(SignEvent record);
   
   List<SignEvent> selEvent(SignEvent record);
   
   //查出该签到课程的人数
   int conditionSel(User user);
   //根据条件查询分母
   int conditionSelUser(User user);
}