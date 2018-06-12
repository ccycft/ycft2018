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
	
	//��ѯ��̳����
	public List<Forum> selDetail(Integer id){
		List<Forum> list = tm.selDetail(id);
		//�鿴����Ŀ¼�ǲ��Ǵ���
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
	
	//¼����̳����  ʹ������
	public int insertTitleAffairs( MultipartFile[] files , Title t  , Content con ) {
		int type = 4;
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String nowDate = sdf.format(date);
		
		//ʱ��
		t.setTime(nowDate);
		//����
		t.setType(type);
		
		//��ʼ����title
		tm.insertForum(t);
		//�²��������
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
					//��ȡͼƬ�ĺ�׺
					String suffix = oldName.substring(oldName.lastIndexOf("."));
					//�Զ����ͼƬ����   ʱ���-�û�id
					String newName = String.valueOf(System.currentTimeMillis()) + "-" + t.getUid() + suffix ;
					//��������  
					File photo = new File(Core.FORUMPATH + newName);
					//ת�浽��·��
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
		
		//����content
		cm.insertSelective(con);
		return 1;
	}
}
