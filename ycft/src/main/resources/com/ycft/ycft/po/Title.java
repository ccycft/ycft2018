package com.ycft.ycft.po;

import java.util.List;

public class Title {
	//����id
    private Integer id;
    //������
    private String name;
    //���·���ʱ��
    private String time;
    //���·����û�
    private String user;
    //�������ͣ� 
    private Integer type;
    //�ݲ�ʹ��
    private Integer praise;
    //��ҳͼƬ����
    private String imgName;

    //�����۱����һ��һ����
    private List<Comment> commentList;
    
	public List<Comment> getComment() {
		return commentList;
	}

	public void setComment(List<Comment> commentList) {
		this.commentList = commentList;
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
        this.name = name == null ? null : name.trim();
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time == null ? null : time.trim();
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user == null ? null : user.trim();
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
        this.imgName = imgName == null ? null : imgName.trim();
    }
}