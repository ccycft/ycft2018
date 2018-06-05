package com.ycft.ycft.services.backstage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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
	 * ���õ�
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
	 * ���õ�
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

	/**
	 * �޸�
	 * @author ZHENGBIN
	 * @param dictionary ������
	 * @return boolean
	 */
	public boolean updateDict(Dictionary dictionary) {
		boolean flag = false;
		int result = dm.updateByPrimaryKeySelective(dictionary);
		//����޸ĳɹ�����true
		if (result > 0) {
			flag = true;
		}
		
		return flag;
	}
	
	/**
	 * ������ֵ���
	 * @author ZHENGBIN
	 * @param dictionary ������
	 * @return boolean
	 */
	public boolean addDictItem(Dictionary dictionary) {
		boolean flag = false;
		//��ȡ�������id�Ǹ��������һ����id,����Ҫ��Ӿ���Ҫ+1
		int id = dictionary.getId();
		id += 1;
		//��id��code��ӽ�ȥ
		dictionary.setId(id);
		dictionary.setDictCode(id+"");
		dictionary.setEnabled("1");
		
		int result = dm.insertSelective(dictionary);
		//��ӳɹ��󷵻�true
		if (result > 0) {
			flag = true;
		}
		return flag;
	}
	
	/**
	 * У���ֵ�����Ƿ��ظ���ajax
	 * @author ZHENGBIN
	 * @param dictType
	 * @return boolean
	 */
	public boolean dictTypeAjax(String dictType) {
		boolean flag = false;
		if (ddm.selectByDictType(dictType) == null) {
			flag = true;
		}
		return flag;
	}
	
	/**
	 * ����µ���������
	 * @author ZHENGBIN
	 * @param dictDepict ������
	 * @param dictionary ������ dictCodeƴ��������id
	 * @return boolean
	 */
	public boolean addDictTypeAffairs(DictDepict dictDepict,Dictionary dictionary) {
		boolean flag = false;
		//id[0]���ֵ�����������һ��id id[1]���ֵ������һ��id
		String[] id = dictionary.getDictCode().split("-");
		
		dictDepict.setId(Integer.parseInt(id[0])+1);
		int resultOne = ddm.insertSelective(dictDepict);
		
		dictionary.setId(Integer.parseInt(id[1])+20);
		dictionary.setDictCode(Integer.parseInt(id[1]) + 20 + "");
		//Ĭ��״̬�ǿ�����
		dictionary.setEnabled("1");
		int resultTwo = dm.insertSelective(dictionary);
		//�����������ӳɹ��򷵻�true
		if (resultOne > 0 && resultTwo > 0) {
			flag = true;
		}
		
		return flag;
	}
}
