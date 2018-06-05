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
	 * 一对多查询出所有字典信息
	 * @author ZHENGBIN
	 * @return List<DictDepict>
	 */
	public List<DictDepict> selDictDictionary(){
		
		return ddm.selDictDictionary();
	}
	/**
	 * 启用的
	 * @author ZHENGBIN
	 * @param id
	 * @return boolean
	 */
	public boolean enabledDict(int id) {
		boolean flag = false;
		Dictionary dictionary = new Dictionary();
		dictionary.setId(id);
		//启用为1
		dictionary.setEnabled("1");
		int result = dm.updateByPrimaryKeySelective(dictionary);
		//修改成功 >0
		if (result > 0) {
			flag = true;
		}
		return flag;
	}
	/**
	 * 禁用的
	 * @author ZHENGBIN
	 * @param id
	 * @return boolean
	 */
	public boolean disabledDict(int id) {
		boolean flag = false;
		Dictionary dictionary = new Dictionary();
		dictionary.setId(id);
		//禁用为0
		dictionary.setEnabled("0");
		int result = dm.updateByPrimaryKeySelective(dictionary);
		//修改成功 >0
		if (result > 0) {
			flag = true;
		}
		return flag;
	}

	/**
	 * 修改
	 * @author ZHENGBIN
	 * @param dictionary 参数绑定
	 * @return boolean
	 */
	public boolean updateDict(Dictionary dictionary) {
		boolean flag = false;
		int result = dm.updateByPrimaryKeySelective(dictionary);
		//如果修改成功返回true
		if (result > 0) {
			flag = true;
		}
		
		return flag;
	}
	
	/**
	 * 添加新字典项
	 * @author ZHENGBIN
	 * @param dictionary 参数绑定
	 * @return boolean
	 */
	public boolean addDictItem(Dictionary dictionary) {
		boolean flag = false;
		//获取到的这个id是该类型最后一个的id,所有要添加就需要+1
		int id = dictionary.getId();
		id += 1;
		//将id和code添加进去
		dictionary.setId(id);
		dictionary.setDictCode(id+"");
		dictionary.setEnabled("1");
		
		int result = dm.insertSelective(dictionary);
		//添加成功后返回true
		if (result > 0) {
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 校验字典代码是否重复的ajax
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
	 * 添加新的数据类型
	 * @author ZHENGBIN
	 * @param dictDepict 参数绑定
	 * @param dictionary 参数绑定 dictCode拼接了两个id
	 * @return boolean
	 */
	public boolean addDictTypeAffairs(DictDepict dictDepict,Dictionary dictionary) {
		boolean flag = false;
		//id[0]是字典描述表的最后一个id id[1]是字典表的最后一个id
		String[] id = dictionary.getDictCode().split("-");
		
		dictDepict.setId(Integer.parseInt(id[0])+1);
		int resultOne = ddm.insertSelective(dictDepict);
		
		dictionary.setId(Integer.parseInt(id[1])+20);
		dictionary.setDictCode(Integer.parseInt(id[1]) + 20 + "");
		//默认状态是开启的
		dictionary.setEnabled("1");
		int resultTwo = dm.insertSelective(dictionary);
		//如果两个都添加成功则返回true
		if (resultOne > 0 && resultTwo > 0) {
			flag = true;
		}
		
		return flag;
	}
}
