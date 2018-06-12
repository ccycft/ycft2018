package com.ycft.ycft.mapper;

import com.ycft.ycft.po.Content;

public interface ContentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Content record);
    //插入文章内容
    int insertSelective(Content record);

    Content selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Content record);

    int updateByPrimaryKeyWithBLOBs(Content record);

    int updateByPrimaryKey(Content record);
    
   
    
    /*===============服务端方法================*/
    
    Content selectByTid(Integer tid);
    
    int updateByTid(Content content);
    /*===============服务端方法================*/
}