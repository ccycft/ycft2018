package com.ycft.ycft.po;

public class Sign {
    private Integer id;

    private Integer sid;

    private Integer uid;
    
    private User u;
    
	public User getU() {
		return u;
	}

	public void setU(User u) {
		this.u = u;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }
}