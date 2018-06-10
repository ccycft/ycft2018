package com.ycft.ycft.po;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.List;

import com.ycft.ycft.system.Core;

//��̳model  ��title��̳�
public class Forum { 
		//����id
	    private Integer id;
	    //������
	    private String name;
	    //�������û��û���
	    private String user;
	    public Integer getUid() {
			return uid;
		}
		public void setUid(Integer uid) {
			this.uid = uid;
		}
		private Integer uid;
	    
	    public String getUser() {
			return user;
		}
		public void setUser(String user) {
			this.user = user;
		}
		//���·���ʱ��
	    private String time; 
	    //�������ͣ� 
	    private Integer type;
	    //zan 
	    private Integer praise;
	    //��ҳͼƬ����
	    private String imgName;
	    //����������
	    private String text;
	      
	    
	    private String img1Name;
	    private String img2Name;
	    private String img3Name;

	    public String getImg1Name() {
			return img1Name;
		}

		public void setImg1Name(String img1Name) {
			this.img1Name = img1Name;
		}

		public String getImg2Name() {
			return img2Name;
		}

		public void setImg2Name(String img2Name) {
			this.img2Name = img2Name;
		}

		public String getImg3Name() {
			return img3Name;
		}

		public void setImg3Name(String img3Name) {
			this.img3Name = img3Name;
		}
	    //��Ӧ������һ�Զ�
	    List<Comment> commentList;
	    public List<Comment> getCommentList() {
			return commentList;
		}
		public void setCommentList(List<Comment> commentList) {
			this.commentList = commentList;
		}
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
			//��ȡ�û�ͷ����
			//����û�ͷ��û�л��浽�������� ��ô����һ��
			//��ѯ����Ŀ¼�Ƿ����
			File file = new File(Core.ICONPATH);
			
			if(file.exists()) {
				
			}else {
				//�������Ŀ¼
				file.mkdirs();
			}
			//��ѯ����Ŀ¼���û���ͼƬ�Ƿ����
			file = new File(Core.ICONPATH + userImgName);
			
			//����ļ��Ѿ�����
			if(file.exists()) {
				
			}else {
				if( getUserImg() != null) {
					//û�л�����Ҫ���»���
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
		//������ -->
	    private Integer comment ;
	    //�û�ID -->
	    private Integer userid ;
	    // �û��� -->
	    private String  userName ;
	    // �û�ͷ�� -->
	    private byte[] userImg; 
	    // �û�ͷ���� -->
	    private String userImgName ;
	    
}
