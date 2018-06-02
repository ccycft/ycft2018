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
}
