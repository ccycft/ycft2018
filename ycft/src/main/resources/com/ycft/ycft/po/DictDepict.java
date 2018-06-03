package com.ycft.ycft.po;

import java.util.List;

public class DictDepict {
    private Integer id;

    private String dictType;

    private String dictTypeName;

    private String remark;
    
    private List<Dictionary> dList;

    public List<Dictionary> getdList() {
		return dList;
	}

	public void setdList(List<Dictionary> dList) {
		this.dList = dList;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDictType() {
        return dictType;
    }

    public void setDictType(String dictType) {
        this.dictType = dictType == null ? null : dictType.trim();
    }

    public String getDictTypeName() {
        return dictTypeName;
    }

    public void setDictTypeName(String dictTypeName) {
        this.dictTypeName = dictTypeName == null ? null : dictTypeName.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }
}