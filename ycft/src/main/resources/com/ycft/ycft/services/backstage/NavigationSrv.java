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
	 * 查询全部导航
	 * @author ZHENGBIN
	 * @return List<Navigation>
	 */
	public List<Navigation> navigationSel() { 
		List<Navigation> nList = null;
		nList = nm.seclecAll();
		return nList;
	}
	
	
	/**
	 * 导航修改
	 * @author ZHENGBIN
	 * @param navigation 参数绑定
	 * @return boolean
	 */
	public boolean navigationUpDate(Navigation navigation) {
		boolean flag = false;
		int result = nm.updateByPrimaryKeySelective(navigation);
		//修改成功后flag为true
		if (result > 0) {
			flag = true;
		}
		return flag;
	}
	
	
	/**
	 * 根据id删除
	 * @author ZHENGBIN
	 * @param navigation 参数绑定
	 * @return boolean
	 */
	public boolean navigationDel(Navigation navigation) {
		boolean flag = false;
		int result = nm.deleteByPrimaryKey(navigation.getId());
		//删除成功后flag为true
		if (result > 0) {
			flag = true;
		}
		return flag;
	}
}
