package com.ycft.ycft.po;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

import com.ycft.ycft.system.Core;

//论坛model  自title表继承
public class Forum { 
		//文章id
	    private Integer id;
	    //文章名
	    private String name;
	    //文章发布时间
	    private String time; 
	    //文章类型： 
	    private Integer type;
	    //zan 
	    private Integer praise;
	    //首页图片名称
	    private String imgName;
	    //发布的文章
	    private String text;
	      
	    public String getText() {
			return text;
		}
		public void setText(String text) {
			this.text = text;
		}
		public Integer getId() {
			return id;
		}
		public void setId(Integer id) {
			this.id = id;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getTime() {
			return time;
		}
		public void setTime(String time) {
			this.time = time;
		}
		public Integer getType() {
			return type;
		}
		public void setType(Integer type) {
			this.type = type;
		}
		public Integer getPraise() {
			return praise;
		}
		public void setPraise(Integer praise) {
			this.praise = praise;
		}
		public String getImgName() {
			return imgName;
		}
		public void setImgName(String imgName) {
			this.imgName = imgName;
		}
		public Integer getComment() {
			return comment;
		}
		public void setComment(Integer cmtcnts) {
			this.comment = cmtcnts;
		}
		public Integer getUserid() {
			return userid;
		}
		public void setUserid(Integer userid) {
			this.userid = userid;
		}
		public String getUserName() {
			return userName;
		}
		public void setUserName(String userName) {
			this.userName = userName;
		}
		public byte[] getUserImg() {
			return userImg;
		}
		public void setUserImg(byte[] userImg) {
			this.userImg = userImg;
		}
		public String getUserImgName() {
			//获取用户头像名
			//如果用户头像没有缓存到服务器中 那么缓存一个
			//查询缓存目录是否存在
			File file = new File(Core.ICONPATH);
			
			if(file.exists()) {
				
			}else {
				//创建这个目录
				file.mkdirs();
			}
			//查询缓存目录中用户的图片是否存在
			file = new File(Core.ICONPATH + userImgName);
			
			//如果文件已经缓存
			if(file.exists()) {
				
			}else {
				if( getUserImg() != null) {
					//没有缓存须要重新缓存
					OutputStream out;
					try {
						out = new FileOutputStream(file);
						out.write(getUserImg());
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
				}
				
			}
			return userImgName;
		}
		public void setUserImgName(String userImgName) {
			this.userImgName = userImgName;
		}
		//评论数 -->
	    private Integer comment ;
	    //用户ID -->
	    private Integer userid ;
	    // 用户名 -->
	    private String  userName ;
	    // 用户头像 -->
	    private byte[] userImg; 
	    // 用户头像名 -->
	    private String userImgName ;
	    
}
