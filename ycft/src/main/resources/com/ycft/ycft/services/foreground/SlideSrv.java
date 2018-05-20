package com.ycft.ycft.services.foreground;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ycft.ycft.mapper.SlideMapper;
import com.ycft.ycft.po.Slide;
import com.ycft.ycft.system.Core;

@Service
public class SlideSrv {

	@Autowired
	SlideMapper sm;
	
	//查询幻灯片 ，使用了缓存策略，所以直接查效率也会很好
	public List<Slide> selectAll() {
		List<Slide> list =  sm.selectAll();
		if(list != null && list.size() > 0) {
			for(Slide sli : list) {
				sli.setName( sli.getName());
			}
		}
		return list;
		
	}
	 
}
