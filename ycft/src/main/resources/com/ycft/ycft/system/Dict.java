package com.ycft.ycft.system;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

import com.ycft.ycft.po.Dictionary;


public class Dict {
	
	/**
	 *  不允许其他类实例化该类
	 */
	private Dict(){
		
	}

	//装载数据字典结构
	private static LinkedHashMap<String,HashMap<String,String>> totalMap = new LinkedHashMap<String,HashMap<String,String>>();
	

	//装载反向数据字典
	private static HashMap<String,HashMap<String,String>>  reverseMap = new  HashMap<String,HashMap<String,String>>();
	
	
	//装载字典类别和描述
	private static  HashMap<String,String>   dictDesMap = new  HashMap<String,String> ();
	
	public static  HashMap<String, String>  getDictDesMap() {
		return  dictDesMap;
	}
	public static void setDictDesMap( HashMap<String, String> setDictDesMap) {
		Dict.dictDesMap = setDictDesMap;
	}
	public static LinkedHashMap<String, HashMap<String, String>> getTotalMap() {
		return totalMap;
	}
	public static void setTotalMap(
			LinkedHashMap<String, HashMap<String, String>> totalMap) {
		Dict.totalMap = totalMap;
	}
	public static HashMap<String, HashMap<String, String>> getReverseMap() {
		return reverseMap;
	}
	public static void setReverseMap(
			HashMap<String, HashMap<String, String>> reverseMap) {
		Dict.reverseMap = reverseMap;
	}
	
	/**
	 * 根据type 列出所有字典项  
	 * 		例：param:sex  
	 * 		return :男 , 女
	 * 
	 * @author  
	 * @param type 字典类别
	 * @return Dictionary[] 所有字典选项
	 * @throws NullPointerException 集合结构为空抛出
	 */
	public static Dictionary[] getDictByType(String type) throws NullPointerException{
		HashMap<String,String> getMap =  totalMap.get(type);
		if(getMap != null && getMap.size() > 0 ){
			Dictionary[] dictArray = new Dictionary[getMap.size()];
			int i = 0;
			for(Map.Entry<String, String> map : getMap.entrySet() ){
				Dictionary dict = new Dictionary();
				//设置字典属性
				dict.setDictCode(map.getKey());
				dict.setDictName(map.getValue());
				dictArray[i] = dict;
				i++;
			}
			/*//
			for(Dictionary d: dictArray){
				System.out.println(d);
			}*/
			return dictArray;
		}else{
			return null;
		}
		
	}
	
	/**
	 * 根据 字典类别 字典代码 查找出唯一字典项
	 * 		例：param1:sex param2:1 
	 * 		return: 男
	 * 
	 * @author  
	 * @param type 字典类别
	 * @param code 字典详细代码（唯一）
	 * @return String 字典名称
	 */
	public static String getDictName(String type,String code){
		//获取value
		HashMap<String,String> getMap =  totalMap.get(type);
		String getValue = getMap.get(code);
		return getValue;
	}
	

	/**
	 * 直接根据   字典代码 查找出唯一字典项
	 * 		例：param1: 1 
	 * 		return: 男
	 * 
	 * @author  
	 * @param code 字典详细代码（唯一）
	 * @return String 字典名称
	 */
	public static String getDictNameByCode( String code){
		String value = "";
		for(Map.Entry<String, HashMap<String,String>> entry : totalMap.entrySet()){
			HashMap<String,String> map  = entry.getValue();
			for(Map.Entry<String, String> entry2 : map.entrySet()){
				String key  = entry2.getKey();
				if(key.equals(code)){
					value = entry2.getValue();
				}
			}
		}
		return value.equals("") ? "暂无" : value;
	}
	
	/**
	 * 根据字典项目获取编码(反向获取)
	 * 		例： param1:sex param2:男  
	 * 			returnCode: 1
	 * 
	 * @author  
	 * @param type 字典类别
	 * @param code 字典名称
	 * @return
	 */
	public static String getReverseCode(String type,String name){
		//获取value
		HashMap<String,String> getMap =  reverseMap.get(type);
		String getValue = getMap.get(name);
		return getValue;
	}
	
	
	/**
	 * 获取所有字典类别  sex  university等
	 * 
	 * @return
	 */
	public static Dictionary[] getAllType(){
		Dictionary[] array =  new Dictionary[dictDesMap.size()];
		int i = 0;
		for(Map.Entry<String, String> entry :dictDesMap.entrySet() ){
			Dictionary dict = new Dictionary();
			dict.setDictType(entry.getKey());
			System.out.println(entry.getValue());
			dict.setTypeName(entry.getValue());
			array[i] = dict;
			i++;
		}
		return array;
	}
}
