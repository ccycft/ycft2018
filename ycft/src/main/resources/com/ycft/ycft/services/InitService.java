package com.ycft.ycft.services;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServlet;

import org.springframework.beans.factory.annotation.Autowired;

import com.ycft.ycft.mapper.DictionaryMapper;
import com.ycft.ycft.mapper.SlideMapper;
import com.ycft.ycft.po.Dictionary;
import com.ycft.ycft.po.Privilege;
import com.ycft.ycft.po.Slide;
import com.ycft.ycft.system.Core;
import com.ycft.ycft.system.Dict;

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
	@Autowired
	private SlideMapper sm;
	
	public void cacheSlide() {
		List<Slide> list = sm.selectAll();
		File file1 = new File(Core.PhotoPath);
		if(!file1.exists()) {
			file1.mkdirs();
		}
		if(list != null && list.size() > 0) {
			//开始缓存图片至目录  [如果目录已经存在该图片直接使用，否则加载图片到目录]
			for(Slide sli : list) {
				String path = Core.PhotoPath + sli.getName();
				System.out.println("Path=========:"+path);
				File file = new File(path);
				if(file.exists()) {
					//如果图片存在
				}else {
					//不存在须要重新加载图片至目录
					OutputStream os = null;
					try {
						os = new FileOutputStream(file);
						os.write(sli.getImg()); 
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} finally {
						try {
							os.close();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					
					
				}
			}
			/*if() {
				
			}*/
		}else {
			return ;
		}
	}
	
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
	public List<Privilege> cacheMenu(){
		privilegeList = ps.testQueryMenuList();
		return privilegeList;
	}
}
