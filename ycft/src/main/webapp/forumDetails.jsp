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
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="./css/navs.css">
<title>论坛详情</title>
<style type="text/css">
	.icon{
			height:3.5rem;
			width:3.5rem;
		}
	.add-icon{
			
			height:100%;
			width:10rem;
			border:1px solid #ccc;
	}
	.forum-img{
		
			padding-left: 8px;
	}
	.forum-title{
			font-size:1.5rem;
			font-weight:bold;
	}	
	.forum-content{
	
		
	}
	.row{
		
		line-height:2rem;
		margin-top:1.5rem;
	}
	
</style>
</head>
<body class="container-fluid">

	<!-- 页面顶端导航栏 -->
	<div class="nav-area">
		<img class="left-icon"  src="./images/back.png" onClick="back()">	
		<span class="nav-title">论坛详情</span>	
	</div>
		
		
	<div class="row">
			
		<div class="col-xs-2 text-center">
			<img class="img-circle icon" src="./images/users.png">
		</div>
			
		<div class="col-xs-8" style="line-height:4rem;padding-left:0px;">
			<span>郑斌斌</span>
		</div>
		
	</div>
	
	<div class="row">
			<div class="col-xs-12 text-center">
				<span class="forum-title ">文章标题</span>
			</div>
	</div>
		
		<div class="row context ">
			<div class="col-xs-12">
				<p >吉林省慕蝶商贸有限公司
					长春市铖金科技有限公司
					长春派瑞特网络科技有限公司吉林省慕蝶商贸有限公司
					长春市铖金科技有限公司
					长春派瑞特网络科技有限公司吉林省慕蝶商贸有限公司
					长春市铖金科技有限公司
					长春派瑞特网络科技有限公司吉林省慕蝶商贸有限公司
					长春市铖金科技有限公司
					长春派瑞特网络科技有限公司吉林省慕蝶商贸有限公司
					长春市铖金科技有限公司长春派瑞特网络科技有限公司
				</p>
			</div>
		</div>
		
		<div class="row">
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
		
		<div class="row">
			<div class="col-xs-12 text-center" style="margin-top:1rem;">
				<span class="forum-title">评论区:</span>
			</div>
		</div>
		
		<div class="row">
		
			<div class="col-xs-3 text-center">
				<span class="a_item">xxx 说: </span>
			</div>
			<div class="col-xs-9 ">
				<span>说的内容123182376128361878328说的内容123182376128361878328说的内容123182376128361878328说的内容123182376128361878328说的内容123182376128361878328</span>
			</div>
		</div>
		
		<div class="row">
		
			<div class="col-xs-3 text-center">
				<span class="a_item">xxx 说: </span>
			</div>
			<div class="col-xs-9 ">
				<span>说的内容123182376128361内容1361878328说的内容123182376128361878328</span>
			</div>
		</div>
		
		<div class="row">
		
			<div class="col-xs-3 text-center">
				<span class="a_item">xxx 说: </span>
			</div>
			<div class="col-xs-9 ">
				<span>说的内容123182376128361内容1361878328说的内容123182376128361878328</span>
			</div>
			
		</div>
		<hr>
		<div class="row text-center">
			<a class="btn btn-info">点击展开更多评论</a>
		</div>
		<hr>
</body>
</html>