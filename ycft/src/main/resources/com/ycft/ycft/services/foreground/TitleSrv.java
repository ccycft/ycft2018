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
	 * 查询热门文章（就是点赞数量排序）
	 * 
	 * @author 邵帅
	 * @param count 一页显示的个数
	 * @return
	 * 2018年5月18日上午11:16:22
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
	 * 根据时间查询和类型查询
	 * @param type 查询类型 1.文章   2.通知
	 * @return
	 */
	public List<Title> selectTime(int type ,Integer nowPage, Integer pageSize ){
		/*if(count == null || count == 0) {
			count = 2;
		}*/
		if(nowPage == null ||nowPage <=0 ) {
			//页数须要置回0
			nowPage = 0;
		}
		//2:查询通知  0：起始坐标  2终止坐标 [查询两条]
		int start = (nowPage - 1) * pageSize;
		List<Title> list =  tm.selectByTime(2 , start, pageSize);
		for(Title title : list) {
			title.setImgName( title.getImgName());
		}
		return list;
	}
	
	//活动报名
	public  boolean  joinActivity(Integer tid , Integer uid) {
		return tm.insertActivity(tid , uid) > 0 ? true : false;
	}
	
	/**
	 * 查询是否报过名
	 * @param tid
	 * @param uid
	 * @return Boolean true是已经报过名了
	 */
	public boolean selectIsJoin(Integer tid , Integer uid) {
		return tm.selectActivityByTidUid(tid , uid) > 0 ? true : false;
	}
	
	//查询论坛
	public List<Forum> selectForum(Integer nowPage , Integer pageSize){
		 
		return tm.selectForum(nowPage , pageSize);
	}
	
	public List<Forum> selDetail(Integer id){
		return tm.selDetail(id);
	}
}
