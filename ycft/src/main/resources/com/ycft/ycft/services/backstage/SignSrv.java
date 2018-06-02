package com.ycft.ycft.services.backstage;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ycft.ycft.mapper.SignEventMapper;
import com.ycft.ycft.po.SignEvent;
import com.ycft.ycft.po.User;

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
	/**
	 * 查询满足条件的个数 ： 分子
	 * @author ZHENGBIN
	 * @param user 参数绑定 id绑定的是sign_event的id
	 * @return int
	 */
	public int signSel(User user) {
		//如果是""则表示为没选择该条件查询
		if (user.getProfession() == "") {
			user.setProfession(null);
		} 
		if (user.getCollege() == "") {
			user.setCollege(null);
		}
		if (user.getCls() == "") {
			user.setCls(null);
		}
		if (user.getDepartment() == "") {
			user.setDepartment(null);
		}
		return signEventMapper.conditionSel(user);
	}
	
	/**
	 * 根据条件查询用户表 ： 分母
	 * @author ZHENGBIN
	 * @param user 参数绑定id绑定的是sign_event的id
	 * @return int
	 */
	public int signSelUser(User user) {
		//如果是""则表示为没选择该条件查询
		if (user.getProfession() == "") {
			user.setProfession(null);
		} 
		if (user.getCollege() == "") {
			user.setCollege(null);
		}
		if (user.getCls() == "") {
			user.setCls(null);
		}
		if (user.getDepartment() == "") {
			user.setDepartment(null);
		}
		return signEventMapper.conditionSelUser(user);
	}
}
