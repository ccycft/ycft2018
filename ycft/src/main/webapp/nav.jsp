<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="com.ycft.ycft.system.Core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/" ;
	
	//文件路径 Core.PATH是访问图片的虚拟路径
	String photoPath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort() +  Core.PATH +"/" ;
	Integer nav = 0;
	try{
		String nav1 = request.getParameter("nav");
		nav = Integer.parseInt(nav1);
		if(nav == null || nav < 0 ){
			nav = 0;
		}
	}catch(Exception e){
		
		nav = 0;
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style>

	.bottom-btn-box{
		text-align:center!important;
	}
	.bottom-btn-value{
		line-height:2;
	}
	.inner-wrapper{
	  width:50%;
	  margin:0 auto;
	  padding-top:0.4rem;
	  padding-bottom:0.4rem;
	}
	.inner-wrapper img{
		width:3.3rem;
		height:2.9rem;
	}
	
</style>
  <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		
		$(".col-xs-3").click(function(){
			
			
			var index = $(this).index();
			var url = "";
			switch(index){
			case 0:
				url = "<%=basePath%>fore/index/index.do";
				break;
			case 1:
				url = "<%=basePath%>fore/title/selectForum.do";
				break;
			case 2:
				url = "http://www.tsinghua.edu.cn/publish/thu2018/index.html";
				break;
			case 3:
				url = "<%=basePath%>fore/user/select.do";
				break;
			}
			window.location.href = url;
			//window.localStorage.setItem("selectNav" , index);
		});
		
		
		var id = <%=nav%>;
		var onImg = "<%=basePath%>images/tab01_sel.png";
		switch(parseInt(id)){
		case 0:
			onImg = "<%=basePath%>images/tab01_sel.png";
			break;
		case 1:
			onImg = "<%=basePath%>images/tab02_sel.png";
			break;
		case 2:
			onImg = "<%=basePath%>images/tab03_sel.png";
			break;
		case 3:
			onImg = "<%=basePath%>images/tab04_sel.png";
			break;
		}
		$(".col-xs-3:eq("+id+")").css({"color":"#1e9bdd" });
		$("#img"+id).attr("src", onImg);
	});
</script>
</head>
<body style="margin:0;padding:0">

	<div style="height:5.8rem;color:#707070;font-size:17px;border:0;border-top:1px solid #e3e3e3;margin:0;padding:0;position:fixed;left:0;bottom:0;width:100%;background-color: #fff;">
	
		<div class="row" style="margin-left:0px;margin-right:0px;margin-top:0px;padding-left:0px;" >
			<div class="col-xs-3 bottom-btn-box"   style="text-align:center;">
				<div class="inner-wrapper">
					<img alt="暂无图片" id="img0" src="<%=basePath%>images/tab01_unsel.png" class="img-responsive" />
				    <span class="bottom-btn-value" style="font-size:14px;">首页</span>
				</div>
			</div>
			<div class="col-xs-3 bottom-btn-box"   style="text-align:center;" >
				<div class="inner-wrapper">
					<img alt="暂无图片" id="img1" src="<%=basePath%>images/tab02_unsel.png" class="img-responsive" />
				    <span class="bottom-btn-value" style="font-size:14px;">论坛</span>
				</div>
			</div>
			<div class="col-xs-3 bottom-btn-box"   style="text-align:center;" >
				<div class="inner-wrapper">
					<img alt="暂无图片" id="img2" src="<%=basePath%>images/tab03_unsel.png" class="img-responsive" />
				    <span class="bottom-btn-value" style="font-size:14px;">教务</span>
				</div>
			</div>
			<div class="col-xs-3 bottom-btn-box"  style="text-align:center;"  >
				<div class="inner-wrapper">
					<img alt="暂无图片" id="img3" src="<%=basePath%>images/tab04_unsel.png" class="img-responsive" />
				    <span class="bottom-btn-value" style="font-size:14px;">我的</span>
				</div>
			</div>
		</div>
	</div>
	
	
</body>
</html>