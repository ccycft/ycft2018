package com.ycft.ycft.po;

//��̳model  ��title��̳�
public class Forum { 
		//����id
	    private Integer id;
	    //������
	    private String name;
	    //���·���ʱ��
	    private String time; 
	    //�������ͣ� 
	    private Integer type;
	    //zan 
	    private Integer praise;
	    //��ҳͼƬ����
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
		//������ -->
	    private Integer cmtcnts ;
	    //�û�ID -->
	    private Integer userid ;
	    // �û��� -->
	    private String  userName ;
	    // �û�ͷ�� -->
	    private byte[] userImg; 
	    // �û�ͷ���� -->
	    private String userImgName ;
	    
}
