<%@page import="com.ycft.ycft.system.Core"%>
<%@page import="com.ycft.ycft.po.Title"%>
<%@page import="java.util.List"%>
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
<title>文章</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="<%=basePath%>css/navs.css">
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/article.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
	<style>
		.tab-p{
		
			display: -webkit-box;
			-webkit-box-orient: vertical;
			-webkit-line-clamp: 7;
			overflow: hidden;
			text-align:left;
		}
	
	</style>
</head>
<body class="text-center">
	<!-- 页面顶端导航栏 -->
	<div class="nav-area">
		<img class="left-icon"  src="./images/back.png" onClick="javascript:window.history.back();return false;">	
		<span class="nav-title">校园导航</span>	
		<img class="right-icon" src="./images/add.png">
	</div>
	
	<div class="container-fluid">
			<div class="row">
			 <div class="col-xs-12">
			 
			 	  <%
			 		List<Title> tList = (List<Title>)request.getAttribute("tList");
			 	  	
			 		if(tList != null && tList.size() > 0){
			 			for(Title t : tList){
			 			%>
		 				<div class="row">
					      <div class="col-xs-7 ">
						      <div class="thumbnail">
						      	<img  src="<%=photoPath%><%=t.getImgName() %>" alt="...">
						  	  </div>
					      </div>
					     <div class="col-xs-5 ">
						       	<p class="tab-p">
						       		<%=t.getName() %>
								</p>
					      </div>
				      </div>
				      <div class="row">
				      		<div class="col-xs-6">
				      			<span style="float:left"><%=t.getUser() %></span>
				      		</div>
				      		<div class="col-xs-6">
				      			<span style="float:right"><%=t.getTime() %></span>
				      		</div>
				      </div>
				      
				      <hr><!--    华丽丽的分割线———————————————————————————————————— -->
			 			<%
			 			}
			 		}
			 			
			 	   %> 
			 </div>
		</div>
	</div>
</body>
</html>