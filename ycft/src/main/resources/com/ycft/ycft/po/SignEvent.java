package com.ycft.ycft.po;

import java.util.List;

public class SignEvent {
    private Integer id;

    private String name;

    private Integer uid;
    
    //用来显示用户姓名
    private String sname;

    public String getSname() {
		return sname;
	}

	public void setSname(String sname) {
		this.sname = sname;
	}

	private String coordinate;
    
    private String coordinateName;

    public String getCoordinateName() {
		return coordinateName;
	}

	public void setCoordinateName(String coordinateName) {
		this.coordinateName = coordinateName;
	}

	private String time;

    private String signType;
    
    private List<Sign> signList;
    
    
    public List<Sign> getSignList() {
		return signList;
	}

	public void setSignList(List<Sign> signList) {
		this.signList = signList;
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

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getCoordinate() {
        return coordinate;
    }

    public void setCoordinate(String coordinate) {
        this.coordinate = coordinate == null ? null : coordinate.trim();
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time == null ? null : time.trim();
    }

    public String getSignType() {
        return signType;
    }

    public void setSignType(String signType) {
        this.signType = signType == null ? null : signType.trim();
    }
}