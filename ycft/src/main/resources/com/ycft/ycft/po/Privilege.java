package com.ycft.ycft.po;

import java.util.List;

public class Privilege {
    private Integer id;

    private String mName;

    private String mUrl;

    private Integer level;

    private Integer pId;
    private String icon;
    private List<Privilege> childMenus;
    
    public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public List<Privilege> getChildMenus() {
		return childMenus;
	}

	public void setChildMenus(List<Privilege> childMenus) {
		this.childMenus = childMenus;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getmName() {
        return mName;
    }

    public void setmName(String mName) {
        this.mName = mName == null ? null : mName.trim();
    }

    public String getmUrl() {
        return mUrl;
    }

    public void setmUrl(String mUrl) {
        this.mUrl = mUrl == null ? null : mUrl.trim();
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public Integer getpId() {
        return pId;
    }

    public void setpId(Integer pId) {
        this.pId = pId;
    }
}