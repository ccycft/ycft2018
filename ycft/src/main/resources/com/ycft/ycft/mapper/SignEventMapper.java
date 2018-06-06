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
   
   //ǰ̨��ѯǩ���¼�
   List<SignEvent> foreSelSignevent(int start , int size);
   int insertSign(Integer sid , Integer uid);
   int selSignByUidAndSid(Integer uid , Integer sid);
   
   //�����ǩ���γ̵�����
   int conditionSel(User user);
   //����������ѯ��ĸ
   int conditionSelUser(User user);
}