package com.ycft.ycft.po;

import java.util.List;

public class Title {
	//文章id
    private Integer id;
    //文章名
    private String name;
    //文章发布时间
    private String time;
    //文章发布用户
    private String user;
    //文章类型： 
    private Integer type;
    //暂不使用
    private Integer praise;
    //首页图片名称
    private String imgName;

    //和评论表进行一对一配置
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