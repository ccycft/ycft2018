package com.ycft.ycft.services.foreground;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ycft.ycft.mapper.PraiseMapper;
import com.ycft.ycft.po.Praise;

@Service
public class PraiseSrv {

	@Autowired
	private PraiseMapper pm;
	
	/*public boolean praise(Praise p) {
		
		int i = pm.insertUid(p);
		return i > 0 ? true : false ;
	}*/
}
