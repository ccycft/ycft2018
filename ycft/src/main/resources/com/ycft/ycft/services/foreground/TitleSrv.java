package com.ycft.ycft.services.foreground;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ycft.ycft.mapper.TitleMapper;
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
	public List<Title> selectHot(int count){
		/*if(count == null || count == 0) {
			count = 2;
		}*/
		List<Title> list =  tm.selectByPraiseCount(count);
		for(Title title : list) {
			title.setImgName( "title/" +  title.getImgName());
		}
		return list;
	}
	
	/**
	 * ��ѯ���£�����ʱ�併��
	 * 
	 * @param nowPage ��ǰҳ
	 * @param pageSize ÿҳ��ʾ������
	 * @return
	 */
	public List<Title> selectTitle(Integer nowPage, Integer pageSize){
		//�����0ҳ
		if(nowPage == null ||nowPage <=0 ) {
			//ҳ����Ҫ�û�0
			nowPage = 0;
		}
		int start = (nowPage - 1) * pageSize;
		List<Title> list =  tm.selectByTime(start, pageSize);
		return list;
	}
}
