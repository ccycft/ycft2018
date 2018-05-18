package com.ycft.ycft.po;
import java.util.ArrayList;
import java.util.List;

public class Dictionary {
	
    private Integer id;

    private String dictType;

    private String dictCode;

    private String dictName;

    //字典名称 例如性别
    private String typeName;
    //备注
    private String remark;
    private String sort;
    private String enabled;
    public String getRemark(){
    	return remark;
    }
    public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getEnabled() {
		return enabled;
	}
	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public void detRemark(String remark){
    	this.remark = remark;
    }
    public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	private List<Dictionary> dList ;
    
    
    
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


	public String getDictCode() {
        return dictCode;
    }

    public void setDictCode(String dictCode) {
        this.dictCode = dictCode == null ? null : dictCode.trim();
    }

    public String getDictName() {
        return dictName;
    }

    public void setDictName(String dictName) {
        this.dictName = dictName == null ? null : dictName.trim();
    }

    @Override
	public String toString() {
		return "Dictionary [id=" + id + ", dictType=" + dictType
				+ ", dictCode=" + dictCode + ", dictName=" + dictName
				+ ", dList=" + dList + "]";
	}
	

	public static void main(String[] args) {
		//List list = new ArrayList();
		
	}
    
}