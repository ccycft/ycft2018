package com.ycft.ycft.po;

public class Content {
    private Integer id;

    private Integer tid;

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

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getTid() {
        return tid;
    }

    public void setTid(Integer tid) {
        this.tid = tid;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text == null ? null : text.trim();
    }
}