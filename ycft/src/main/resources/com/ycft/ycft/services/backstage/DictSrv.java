package com.ycft.ycft.services.backstage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sun.tools.internal.xjc.runtime.ZeroOneBooleanAdapter;
import com.ycft.ycft.mapper.DictDepictMapper;
import com.ycft.ycft.mapper.DictionaryMapper;
import com.ycft.ycft.po.DictDepict;
import com.ycft.ycft.po.Dictionary;

@Service
public class DictSrv {
	
	@Autowired
	private DictDepictMapper ddm;
	@Autowired
	private DictionaryMapper dm;
	
	/**
	 * һ�Զ��ѯ�������ֵ���Ϣ
	 * @author ZHENGBIN
	 * @return List<DictDepict>
	 */
	public List<DictDepict> selDictDictionary(){
		
		return ddm.selDictDictionary();
	}
	/**
	 * ���õ�ajax
	 * @author ZHENGBIN
	 * @param id
	 * @return boolean
	 */
	public boolean enabledDict(int id) {
		boolean flag = false;
		Dictionary dictionary = new Dictionary();
		dictionary.setId(id);
		//����Ϊ1
		dictionary.setEnabled("1");
		int result = dm.updateByPrimaryKeySelective(dictionary);
		//�޸ĳɹ� >0
		if (result > 0) {
			flag = true;
		}
		return flag;
	}
	/**
	 * ���õ�ajax
	 * @author ZHENGBIN
	 * @param id
	 * @return boolean
	 */
	public boolean disabledDict(int id) {
		boolean flag = false;
		Dictionary dictionary = new Dictionary();
		dictionary.setId(id);
		//����Ϊ0
		dictionary.setEnabled("0");
		int result = dm.updateByPrimaryKeySelective(dictionary);
		//�޸ĳɹ� >0
		if (result > 0) {
			flag = true;
		}
		return flag;
	}

}
