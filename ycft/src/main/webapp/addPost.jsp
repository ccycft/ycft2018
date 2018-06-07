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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="./css/navs.css">
	<style>
		#forum-title{
			font-size:2rem;
			height:4rem;
		}	
		#forum-content{
			font-size:1.5rem;
		}
		.form-control{
			
			border:none;
		}
		
		.add-icon{
			
			height:100%;
			width:10rem;
			border:1px solid #ccc;
			
		}
		.forum-img{
		
			padding-left: 8px;
		}
	
	
	</style>
	
	<script type="text/javascript">
	
		$(function(){
			
			$('.forum-img').click(function(){
				
				alert('上传一张图片');
				
			});
			
		});
		
		
		function doCommit(){
			
			
			
			
			
		}
		
	
	</script>
	
</head>
<body class="container-fluid">
	
	<!-- 页面顶端导航栏 -->
	<div class="nav-area">
		<img class="left-icon"  src="./images/back.png" onClick="back()">	
		<span class="nav-title">我要发布</span>	
		<img class="right-icon" src="./images/right.png" onClick="doCommit()">
	</div>
	
	
	<form class="form-horizontal">
	  <div class="form-group">
    	<div class="col-xs-12">
      		<input type="text" class="form-control" id="forum-title" placeholder="请输入标题">
    	</div>
  	  </div>
  	  	<hr>
	  <div class="form-group">
	    <div class="col-xs-12">
	    	<textarea class="form-control" id="forum-content" rows="10" placeholder="快来说点啥~"></textarea>
	    </div>
	  </div>
	  	<hr>
	  <div class="form-group">
	    <div class="col-xs-4 forum-img" >
	    	<img src="./images/add.png" class="add-icon"/>
	    </div>
	    <div class="col-xs-4 forum-img" >
	    	<img src="./images/add.png" class="add-icon"/>
	    </div>
	    <div class="col-xs-4 forum-img" >
	    	<img src="./images/add.png" class="add-icon"/>
	    </div>
	  </div>
	  
	</form>
	
</body>
</html>