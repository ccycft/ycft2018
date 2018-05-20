package com.ycft.ycft.system;

import java.io.IOException;

import javax.servlet.jsp.JspContext;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.JspFragment;
import javax.servlet.jsp.tagext.JspTag;
import javax.servlet.jsp.tagext.SimpleTagSupport;


/**
 * ×Öµä´úÂë ------>  ÎÄ×Ö
 * 
 * @author SHAOSHUAI
 *
 */
public class CodeSwitchTag extends SimpleTagSupport{
	
	//×Öµä´úÂë
	private String code;
	private String classname;
	private String style;
	private String name;
	//inputµÄÖµ
	private String value;
	
	public void setValue(String value){
		this.value = value;
	}
	
	public void setStyle(String style) {
		this.style = style;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCode(){
		return code;
	}
	public void setCode(String code){
		this.code = code;
		
	}
	public void setClassname(String classname){
		this.classname = classname;
	}
	

	@Override
	public void doTag() throws JspException, IOException {
		// TODO Auto-generated method stub
		JspWriter out = getJspContext().getOut();
		//ºº×Ö
		String value  = Dict.getDictNameByCode(code);
		StringBuilder str = null;
		if( style == null || style.equals("label") ){
			str =  new StringBuilder("<span class='"+classname+"' >" + value +"</span>");
		}else if(style.equals("input")){
			str =  new StringBuilder("<input name='"+name+"' class='"+classname+"' ");
			str.append(" value='"+value+"'");
		    str.append(" />");
		}
	    out.print(str);
	    out.flush();
	}

	@Override
	protected JspFragment getJspBody() {
		// TODO Auto-generated method stub
		return super.getJspBody();
	}

	@Override
	protected JspContext getJspContext() {
		// TODO Auto-generated method stub
		return super.getJspContext();
	}

	@Override
	public JspTag getParent() {
		// TODO Auto-generated method stub
		return super.getParent();
	}

	@Override
	public void setJspBody(JspFragment jspBody) {
		// TODO Auto-generated method stub
		super.setJspBody(jspBody);
	}

	@Override
	public void setJspContext(JspContext pc) {
		// TODO Auto-generated method stub
		super.setJspContext(pc);
	}

	@Override
	public void setParent(JspTag parent) {
		// TODO Auto-generated method stub
		super.setParent(parent);
	}

}
