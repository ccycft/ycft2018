package com.ycft.ycft.po;

public class Comment {
    private Integer id;

    private Integer uid;

    private Integer tid;

    private String content;
    //�Ƿ񱻾ٱ� 1�����ٱ�
    private Integer report;
    
    //ʱ��
    private String time;
    //�����û���
    private String sname;
    
    public Integer getReport() {
		return report;
	}

	public void setReport(Integer report) {
		this.report = report;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getSname() {
		return sname;
	}

	public void setSname(String sname) {
		this.sname = sname;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getTid() {
        return tid;
    }

    public void setTid(Integer tid) {
        this.tid = tid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }
}