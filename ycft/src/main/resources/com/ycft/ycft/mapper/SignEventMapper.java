package com.ycft.ycft.mapper;

import java.util.List;

import com.ycft.ycft.po.Sign;
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
   
   //前台查询签到事件
   List<SignEvent> foreSelSignevent(int start , int size);
   int insertSign(Integer sid , Integer uid);
   int selSignByUidAndSid(Integer uid , Integer sid);
   //查询我的签到
   List<SignEvent> selSignByUid(Integer uid , Integer nowPage , Integer pageSize);
   //查询签到详情
   SignEvent selDetailById(Integer id);
   //查出该签到课程的人数
   int conditionSel(User user);
   //根据条件查询分母
   int conditionSelUser(User user);
}