package com.ycft.ycft.mapper;

import java.util.List;

import com.ycft.ycft.po.User;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    /*===============客户端方法================*/
    public List<User> feLogin(String stuCode , String pwd);
    
    /*===============客户端方法================*/
    
    /*===============服务端方法================*/
    //通过账号查
    public User bsLogin(String sno);
    List<User> selective(User us);
    public int batchInsert(List<User> uList);
    //查询所有学生的信息，不包括超级管理员
    public List<User> selAll();
    //删除重复的数据
    public int delRepeat();
    //查询导出某活动的学生信息
    List<User> selExport(int tid);
    //查询出都有什么班级
    List<User> selCls();
    /*===============服务端方法================*/
}