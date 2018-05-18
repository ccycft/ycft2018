package com.ycft.ycft.mapper;

import java.util.List;

import com.ycft.ycft.po.Dictionary;

public interface DictionaryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Dictionary record);

    int insertSelective(Dictionary record);

    Dictionary selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Dictionary record);

    int updateByPrimaryKey(Dictionary record);
    
    public List<Dictionary> selAllDicType();
    //½ûÓÃ×ÖµäÏîÄ¿
    public int disableDict(String code,String status);
    public int updDict(Dictionary dict);
    Dictionary selDictByCode(String code);
    public List<Dictionary> selByType(String value);
}