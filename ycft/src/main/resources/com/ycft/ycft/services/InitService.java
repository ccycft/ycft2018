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
 * ����������ʼ�������ֵ�Ȳ���
 * 	
 * �쳣ͳһ��Controller����try catch ,�˴�ֻ�׳�������
 * @author  
 */

public class InitService extends HttpServlet{
	@Autowired
	DictionaryMapper dm;
	@Autowired
	PrivilegeService ps;
	//�����ֵ�
	private LinkedHashMap<String,HashMap<String,String>> totalMap = new LinkedHashMap<String,HashMap<String,String>>();
	//װ�ط��������ֵ�
	private  HashMap<String,HashMap<String,String>>  reverseMap = new  HashMap<String,HashMap<String,String>>();
	//�Ѳ˵���������
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
			//��ʼ����ͼƬ��Ŀ¼  [���Ŀ¼�Ѿ����ڸ�ͼƬֱ��ʹ�ã��������ͼƬ��Ŀ¼]
			for(Slide sli : list) {
				String path = Core.PhotoPath + sli.getName();
				System.out.println("Path=========:"+path);
				File file = new File(path);
				if(file.exists()) {
					//���ͼƬ����
				}else {
					//��������Ҫ���¼���ͼƬ��Ŀ¼
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
	 * �����ֵ��ʼ�� ����
	 * 		��ʽ ��  String(sex)��Map<String,String>(key:1,value:Ů)
	 * 			
	 * @author  
	 * @return boolean �����Ƿ�ɹ�
	 * @throws Exception ͳһ��controller�����쳣
	 */
	public boolean cacheDict() throws Exception{
    	//�ֵ��Ƿ���سɹ�
		boolean isSuccess = false;
		//dao����������ֵ�
		List<Dictionary> typeList =  dm.selAllDicType();
		LinkedHashMap<String,String> keyValue  =  new LinkedHashMap<String,String>();;
		if(typeList != null && typeList.size() > 0){
			for(Dictionary dict : typeList){
				LinkedHashMap<String,String> map = new LinkedHashMap<String,String>();
				LinkedHashMap<String,String> reMap = new LinkedHashMap<String,String>();
				for(Dictionary dict2 : dict.getdList() ){
					//�����ֵ�
					map.put(dict2.getDictCode(), dict2.getDictName());
					//�����ֵ�
					reMap.put( dict2.getDictName(),dict2.getDictCode());
				}
				totalMap.put(dict.getDictType(),map);
				//�����ֵ�װ��
				reverseMap.put(dict.getDictType(),reMap);
				//�ֵ��������map  sex --- �� 
				keyValue.put(dict.getDictType(), dict.getTypeName());
			}
			//��ֵ��dict�ֵ������
			Dict.setTotalMap(totalMap);
			Dict.setReverseMap(reverseMap);
			Dict.setDictDesMap(keyValue);
		}
		isSuccess = true;
		return isSuccess;
	}
	/**
	 * �Ѳ˵���������
	 * @param response
	 * @throws UnsupportedEncodingException
	 */
	public List<Privilege> cacheMenu(){
		privilegeList = ps.testQueryMenuList();
		return privilegeList;
	}
}
