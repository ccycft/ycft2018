package com.ycft.ycft.mapper;

import java.util.List;

import com.ycft.ycft.po.Slide;

public interface SlideMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Slide record);

    int insertSelective(Slide record);

    Slide selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Slide record);

    int updateByPrimaryKeyWithBLOBs(Slide record);

    int updateByPrimaryKey(Slide record);
	
	public List<Slide> selectAll();
	//²éÑ¯»ù´¡×Ö¶Î
}