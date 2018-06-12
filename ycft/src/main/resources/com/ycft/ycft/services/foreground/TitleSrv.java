package com.ycft.ycft.services.foreground;

import java.io.File;
import java.io.IOException;
import java.nio.file.spi.FileSystemProvider;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ycft.ycft.mapper.ContentMapper;
import com.ycft.ycft.mapper.TitleMapper;
import com.ycft.ycft.po.Content;
import com.ycft.ycft.po.Forum;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.system.Core;

@Service(value="titleSrv")
public class TitleSrv {

	@Autowired
	private TitleMapper tm;
	@Autowired
	private ContentMapper cm;
	
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
	
	//查询论坛详情
	public List<Forum> selDetail(Integer id){
		List<Forum> list = tm.selDetail(id);
		//查看缓存目录是不是存在
		File file = new File(Core.FORUMPATH);
		if(file.exists()) {
			 
		}else {
			boolean b = file.mkdirs();
			 
		}
		for(Forum f : list) {
			String img1 = f.getImg1Name();
			String img2 = f.getImg2Name();
			String img3 = f.getImg3Name();
			
		}
		
		return list;
	}
	
	//录入论坛帖子  使用事务
	public int insertTitleAffairs( MultipartFile[] files , Title t  , Content con ) {
		int type = 4;
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String nowDate = sdf.format(date);
		
		//时间
		t.setTime(nowDate);
		//类型
		t.setType(type);
		
		//开始插入title
		tm.insertForum(t);
		//新插入的主键
		int newId = t.getId();
		con.setTid(newId);
		if(files != null ) {
			File file = new File(Core.FORUMPATH);
			if(file.exists()) {
				
			}else {
				file.mkdirs();
			}
			for(int i = 0 ; i < files.length ; i++) {
				if(files[i] != null) {
					String oldName = files[i].getOriginalFilename();
					//获取图片的后缀
					String suffix = oldName.substring(oldName.lastIndexOf("."));
					//自定义的图片名称   时间戳-用户id
					String newName = String.valueOf(System.currentTimeMillis()) + "-" + t.getUid() + suffix ;
					//存入哪里  
					File photo = new File(Core.FORUMPATH + newName);
					//转存到该路径
					try {
						files[i].transferTo(photo);
						if(i == 0) {
							con.setImg1Name(newName);
						}if(i == 1) {
							con.setImg2Name(newName);
						}if(i == 2) {
							con.setImg3Name(newName);
						}
						
						
						
					} catch (IllegalStateException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				
			}
		}
		
		//插入content
		cm.insertSelective(con);
		return 1;
	}
}
