<%@page import="com.ycft.ycft.system.Core"%>
<%@page import="com.ycft.ycft.po.TitleContent"%>
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>文章详情</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="<%=basePath%>css/navs.css">
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/activity.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
    <style>
		.activity_img{
			width:100%;
		}
		#activity_btn{
			margin-left:23%;
		}
		.text-area{
			
			text-indent:2em;
			display: -webkit-box;
			-webkit-box-orient: vertical;
			/* -webkit-line-clamp: 7; */
			overflow: hidden;
			text-align:left;
		
		}
		.none_style{
			list-style-type:none;
			padding-left:1rem;
			padding-top:1rem;
			line-height:3rem;
			font-weight: bold;
			font-size:1.5rem;
		}
	</style>
</head>
<body>
	<!-- 页面顶端导航栏 -->
	<div class="nav-area">
		<img class="left-icon"  src="./images/back.png" onClick="javascript:window.history.back();return false;">	
		<span class="nav-title">校园导航</span>	
		<img class="right-icon" src="./images/add.png">
	</div>
	<div class="container-fluid">
		<%
		 	TitleContent con = (TitleContent)request.getAttribute("titleContent");
		  	if(con != null){
		%>
			<div class="row">
					<div  class="col-xs-12 activity_img">
		  			</div>
		  			<div class="col-xs-12">
						<ul class="none_style">
							<li class="" style="font-size:18px;"><%=con.getName()%></li>
						    <li class="" ><span style="font-size:13px;color:#444">作者：<%=con.getUser() %></span></li>
							<li class=""  ><span style="font-size:13px;color:#444">发布时间：<%=con.getTime() %></span></li>	
						</ul>								
					</div>
				</div>
				<dir class="row">
					<div class="col-xs-11">
						<%=con.getText() %>
		 			</div>
		 		</dir>
		 </div>
		 
	<%  		
	  	}else{
	  		out.print("未查询到内容...");
	  	}
	 %>
	<script>
		//控制图片宽度
		var width  = $(".col-xs-11").width();
		$(".col-xs-11").find("img").width(width);
	</script>
	
	
	
</body>
</html>