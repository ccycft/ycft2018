package com.ycft.ycft.po;

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
		public Integer getCmtcnts() {
			return cmtcnts;
		}
		public void setCmtcnts(Integer cmtcnts) {
			this.cmtcnts = cmtcnts;
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
			return userImgName;
		}
		public void setUserImgName(String userImgName) {
			this.userImgName = userImgName;
		}
		//评论数 -->
	    private Integer cmtcnts ;
	    //用户ID -->
	    private Integer userid ;
	    // 用户名 -->
	    private String  userName ;
	    // 用户头像 -->
	    private byte[] userImg; 
	    // 用户头像名 -->
	    private String userImgName ;
	    
}
