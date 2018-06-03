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
    <link rel="stylesheet" href="<%=basePath%>css/navs.css">
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/activity.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
    <style type="text/css">
    	.icon{
    		display:inline;
    		width:2.5rem;
    		height:100%;
    	}
    	#nav{
    		marign-left:
    	}
    	.a_item{
    	
    		margin-left:1rem;
    	}
    	.logo_icon{
    		display:inline;
    		margin-left:1rem;
    		width:4.5rem;
    	}
    	.name_item{
    		line-height:6rem;
    		font-size:1.8rem;
    		margin-left:3rem;
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
	<div class="list-group" >
		  <a  href="#" class="list-group-item ">
		   	<img class="img-responsive logo_icon" src="./images/wode.png">
		    <span class="name_item">Jerry</span></a>
		  <a  href="#" class="list-group-item ">
		   	<img class="img-responsive icon" src="./images/huodong.png">
		    <span class="a_item">我的活动 </span></a>
		  <a href="<%=basePath%>signDetails.jsp" class="list-group-item ">
		  	<img class="img-responsive icon" src="./images/qiandao.png">	
		  	<span class="a_item">我的签到</span></a>
		  <a href="#" class="list-group-item ">
		  	<img class="img-responsive icon" src="./images/fabu.png">
		  	<span class="a_item">我的发布</span></a>
		  <a href="#" class="list-group-item ">
		  	<img class="img-responsive icon" src="./images/jiaowurukou.png">
		  	<span class="a_item">教务信息</span></a>
		  <a href="#" class="list-group-item ">
		  	<img class="img-responsive icon" src="./images/jianyi.png">
		  	<span class="a_item">我的建议</span></a>
		  <a href="#" class="list-group-item ">
		  	<img class="img-responsive icon" src="./images/guanyu.png">
		  	<span class="a_item">关于我们</span></a>
		  <a href="#" class="list-group-item ">
		  	<img class="img-responsive icon" src="./images/banben.png">
		  	<span class="a_item">当前版本</span></a>
	</div>
</body>
</html>