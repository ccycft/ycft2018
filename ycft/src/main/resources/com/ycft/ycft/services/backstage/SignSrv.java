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
	 * ��ѯǩ���¼���Ӧ����
	 * @param se
	 * @return
	 */
	public List<SignEvent> SigneventUser(SignEvent se){
		return signEventMapper.selSignUser(se);
	}
	
	/**
	 * ��ѯǩ���¼�������
	 * @return
	 */
	public List<SignEvent> selEvent(SignEvent se){
		List<SignEvent> seList = signEventMapper.selEvent(se);
		for(int i = 0;i<seList.size();i++) {
			//���seList �����id��ǰ̨�����ݴ�������id�Աȣ������ͬ�͵�һ�����ݽ���
			if(seList.get(i).getId() == se.getId()) {
				Collections.swap(seList, 0, i);
			}
		}
		return seList;
	}
	/**
	 * ��ѯ���������ĸ��� �� ����
	 * @author ZHENGBIN
	 * @param user ������ id�󶨵���sign_event��id
	 * @return int
	 */
	public int signSel(User user) {
		//�����""���ʾΪûѡ���������ѯ
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
	 * ����������ѯ�û��� �� ��ĸ
	 * @author ZHENGBIN
	 * @param user ������id�󶨵���sign_event��id
	 * @return int
	 */
	public int signSelUser(User user) {
		//�����""���ʾΪûѡ���������ѯ
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
