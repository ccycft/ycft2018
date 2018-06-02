package com.ycft.ycft.services.backstage;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ycft.ycft.mapper.SignEventMapper;
import com.ycft.ycft.po.SignEvent;

@Service
public class SignSrv {
	
	@Autowired
	private SignEventMapper signEventMapper;
	
	/**
	 * 查询签到事件对应的人
	 * @param se
	 * @return
	 */
	public List<SignEvent> SigneventUser(SignEvent se){
		return signEventMapper.selSignUser(se);
	}
	
	/**
	 * 查询签到事件的名称
	 * @return
	 */
	public List<SignEvent> selEvent(SignEvent se){
		List<SignEvent> seList = signEventMapper.selEvent(se);
		for(int i = 0;i<seList.size();i++) {
			//如果seList 里面的id和前台的数据传过来的id对比，如果相同和第一个数据交换
			if(seList.get(i).getId() == se.getId()) {
				Collections.swap(seList, 0, i);
			}
		}
		return seList;
	}
}
