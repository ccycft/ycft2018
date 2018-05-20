package com.ycft.ycft.services.backstage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ycft.ycft.mapper.RoleMapper;
import com.ycft.ycft.po.Role;

@Service
public class RoleSrv {

	@Autowired
	private RoleMapper rm;
	
	
	/**
	 * È«²é
	 * @return
	 */
	public List<Role> selAll(){
		List<Role> rList = rm.selAllRole();
		
		return rList;
	}
	
}
