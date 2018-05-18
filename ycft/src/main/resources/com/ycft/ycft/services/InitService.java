package com.ycft.ycft.services;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import javax.servlet.ServletContextEvent;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.ycft.ycft.mapper.DictionaryMapper;
import com.ycft.ycft.po.Dictionary;
import com.ycft.ycft.po.Privilege;
import com.ycft.ycft.system.Dict;
import com.ycft.ycft.system.Menu;

/**
 * 容器启动初始化数据字典等操作
 * 	
 * 异常统一由Controller进行try catch ,此处只抛出不处理
 * @author  
 */
public class InitService extends HttpServlet{
	@Autowired
	DictionaryMapper dm;
	@Autowired
	PrivilegeService ps;
	//正向字典
	private LinkedHashMap<String,HashMap<String,String>> totalMap = new LinkedHashMap<String,HashMap<String,String>>();
	//装载反向数据字典
	private  HashMap<String,HashMap<String,String>>  reverseMap = new  HashMap<String,HashMap<String,String>>();
	//把菜单缓存起来
	public List<Privilege> privilegeList = new ArrayList<Privilege>();
	/**
	 * 数据字典初始化 缓存
	 * 		格式 ：  String(sex)，Map<String,String>(key:1,value:女)
	 * 			
	 * @author  
	 * @return boolean 缓存是否成功
	 * @throws Exception 统一由controller处理异常
	 */
	public boolean cacheDict() throws Exception{
    	//字典是否加载成功
		boolean isSuccess = false;
		//dao层加载数据字典
		List<Dictionary> typeList =  dm.selAllDicType();
		LinkedHashMap<String,String> keyValue  =  new LinkedHashMap<String,String>();;
		if(typeList != null && typeList.size() > 0){
			for(Dictionary dict : typeList){
				LinkedHashMap<String,String> map = new LinkedHashMap<String,String>();
				LinkedHashMap<String,String> reMap = new LinkedHashMap<String,String>();
				for(Dictionary dict2 : dict.getdList() ){
					//正向字典
					map.put(dict2.getDictCode(), dict2.getDictName());
					//反向字典
					reMap.put( dict2.getDictName(),dict2.getDictCode());
				}
				totalMap.put(dict.getDictType(),map);
				//反向字典装载
				reverseMap.put(dict.getDictType(),reMap);
				//字典类别描述map  sex --- 男 
				keyValue.put(dict.getDictType(), dict.getTypeName());
			}
			//赋值给dict字典操作类
			Dict.setTotalMap(totalMap);
			Dict.setReverseMap(reverseMap);
			Dict.setDictDesMap(keyValue);
		}
		isSuccess = true;
		return isSuccess;
	}
	
	/**
	 * 把菜单缓存起来
	 * @param response
	 * @throws UnsupportedEncodingException
	 */
	public List<Privilege> cacheMenu() throws UnsupportedEncodingException {
		privilegeList = ps.testQueryMenuList();
		return privilegeList;
	}
}
