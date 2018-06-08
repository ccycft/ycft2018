package com.ycft.ycft.services.foreground;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ycft.ycft.mapper.TitleMapper;
import com.ycft.ycft.po.Forum;
import com.ycft.ycft.po.Title;

@Service(value="titleSrv")
public class TitleSrv {

	@Autowired
	private TitleMapper tm;
	
	/**
	 * ��ѯ�������£����ǵ�����������
	 * 
	 * @author ��˧
	 * @param count һҳ��ʾ�ĸ���
	 * @return
	 * 2018��5��18������11:16:22
	 */
	public List<Title> selectHot(int type, int count){
		/*if(count == null || count == 0) {
			count = 2;
		}*/
		List<Title> list =  tm.selectByPraiseCount(type , count);
		for(Title title : list) {
			title.setImgName( title.getImgName());
		}
		return list;
	}
	
	/**
	 * ����ʱ���ѯ�����Ͳ�ѯ
	 * @param type ��ѯ���� 1.����   2.֪ͨ
	 * @return
	 */
	public List<Title> selectTime(int type ,Integer nowPage, Integer pageSize ){
		/*if(count == null || count == 0) {
			count = 2;
		}*/
		if(nowPage == null ||nowPage <=0 ) {
			//ҳ����Ҫ�û�0
			nowPage = 0;
		}
		//2:��ѯ֪ͨ  0����ʼ����  2��ֹ���� [��ѯ����]
		int start = (nowPage - 1) * pageSize;
		List<Title> list =  tm.selectByTime(2 , start, pageSize);
		for(Title title : list) {
			title.setImgName( title.getImgName());
		}
		return list;
	}
	
	//�����
	public  boolean  joinActivity(Integer tid , Integer uid) {
		return tm.insertActivity(tid , uid) > 0 ? true : false;
	}
	
	/**
	 * ��ѯ�Ƿ񱨹���
	 * @param tid
	 * @param uid
	 * @return Boolean true���Ѿ���������
	 */
	public boolean selectIsJoin(Integer tid , Integer uid) {
		return tm.selectActivityByTidUid(tid , uid) > 0 ? true : false;
	}
	
	//��ѯ��̳
	public List<Forum> selectForum(Integer nowPage , Integer pageSize){
		 
		return tm.selectForum(nowPage , pageSize);
	}
	
	public List<Forum> selDetail(Integer id){
		return tm.selDetail(id);
	}
}
