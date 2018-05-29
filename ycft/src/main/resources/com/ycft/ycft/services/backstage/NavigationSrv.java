package com.ycft.ycft.services.backstage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ycft.ycft.mapper.NavigationMapper;
import com.ycft.ycft.po.Navigation;

@Service
public class NavigationSrv {

	@Autowired
	private NavigationMapper nm;
	
	/**
	 * ��ѯȫ������
	 * @author ZHENGBIN
	 * @return List<Navigation>
	 */
	public List<Navigation> navigationSel() { 
		List<Navigation> nList = null;
		nList = nm.seclecAll();
		return nList;
	}
	
	
	/**
	 * �����޸�
	 * @author ZHENGBIN
	 * @param navigation ������
	 * @return boolean
	 */
	public boolean navigationUpDate(Navigation navigation) {
		boolean flag = false;
		int result = nm.updateByPrimaryKeySelective(navigation);
		//�޸ĳɹ���flagΪtrue
		if (result > 0) {
			flag = true;
		}
		return flag;
	}
	
	
	/**
	 * ����idɾ��
	 * @author ZHENGBIN
	 * @param navigation ������
	 * @return boolean
	 */
	public boolean navigationDel(Navigation navigation) {
		boolean flag = false;
		int result = nm.deleteByPrimaryKey(navigation.getId());
		//ɾ���ɹ���flagΪtrue
		if (result > 0) {
			flag = true;
		}
		return flag;
	}
}
