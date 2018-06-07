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
	
	<style>
		.icon{
			
			height:3.5rem;
			width:3.5rem;
		}
		
		.context img{
			
			padding-top:0.5rem;
			padding-bottom:1.5rem;
		}
		.context p{
			
			text-indent:2em;
			display: -webkit-box;
			-webkit-box-orient: vertical;
			overflow: hidden;
			text-align:left;
		
		}
		.min_icon{
			
			height:2rem;
			width:2rem;
		}
		
		.context p{
		
			display: -webkit-box;
			-webkit-box-orient: vertical;
			-webkit-line-clamp: 2;
			overflow: hidden;
			text-align:left;
			line-height:2rem;
		}
		.row{
			margin-top:1rem;
			line-height:1rem;
		}
		.forum-title{
		
			font-size:1.5rem;
			font-weight:bold;
		}
	</style>
	
<title>论坛</title>
<script type="text/javascript">

	function back(){ 
		
		if(typeof(window.ceshi) != 'undefined'){
			//说明 可以调用安卓的返回功能
			window.ceshi.back(); 
		}else{
			window.history.back();
		}
	}
	
	function addPost(){
		
		window.open('<%=basePath%>addPost.jsp','_self');
		
	}

</script>
</head>
<body class="container-fluid ">
	
	<!-- 页面顶端导航栏 -->
	<div class="nav-area">
		<img class="left-icon"  src="./images/back.png" onClick="back()">	
		<span class="nav-title">校园论坛</span>	
		<img class="right-icon" src="./images/add.png" onClick="addPost()">
	</div>
	
	<div class="row ">
	
		<div class="row">
			
			<div class="col-xs-4 text-center">
				<img class="img-circle icon" src="./images/users.png">
			</div>
			
			<div class="col-xs-6">
				<div class="row">
					<span>郑斌斌</span>
				</div>
				<div class="row">
					<span>2018.6.6 18:13</span>
				</div>
			</div>
		
		</div>
	
		<div class="row">
			<div class="col-xs-5 col-xs-offset-1" style="margin-top:1rem;">
				<span class="forum-title">文章标题</span>
			</div>
		</div>
		
		<div class="row context ">
			<div class="col-xs-10 col-xs-offset-1">
				<p>吉林省慕蝶商贸有限公司
长春市铖金科技有限公司
长春派瑞特网络科技有限公司吉林省慕蝶商贸有限公司
长春市铖金科技有限公司
长春派瑞特网络科技有限公司吉林省慕蝶商贸有限公司
长春市铖金科技有限公司
长春派瑞特网络科技有限公司吉林省慕蝶商贸有限公司
长春市铖金科技有限公司
长春派瑞特网络科技有限公司吉林省慕蝶商贸有限公司
长春市铖金科技有限公司
长春派瑞特网络科技有限公司</p>
			</div>
		</div>
		
		<div class="row">
		
			<div class="col-xs-1 col-xs-offset-7" >
				<img src="./images/tongzhi.png"  class="min_icon">
			</div>
			
			<div class="col-xs-1">
				<span>10</span>
			</div>
			
			<div class="col-xs-1 " >
				<img src="./images/tongzhi.png"  class="min_icon">
			</div>
			
			<div class="col-xs-1">
				<span>5</span>
			</div>
			
		</div>
		
    </div>
    
    <hr>
    
    <div class="row ">
	
		<div class="row">
			
			<div class="col-xs-4 text-center">
				<img class="img-circle icon" src="./images/users.png">
			</div>
			
			<div class="col-xs-6">
				<div class="row">
					<span>郑斌斌</span>
				</div>
				<div class="row">
					<span>2018.6.6 18:13</span>
				</div>
			</div>
		
		</div>
	
		<div class="row">
			<div class="col-xs-5 col-xs-offset-1">
				<span class="forum-title">文章标题</span>
			</div>
		</div>
		
		<div class="row context ">
			<div class="col-xs-10 col-xs-offset-1">
				<p>吉林省慕蝶商贸有限公司
长春市铖金科技有限公司
长春派瑞特网络科技有限公司吉林省慕蝶商贸有限公司
长春市铖金科技有限公司
长春派瑞特网络科技有限公司吉林省慕蝶商贸有限公司
长春市铖金科技有限公司
长春派瑞特网络科技有限公司吉林省慕蝶商贸有限公司
长春市铖金科技有限公司
长春派瑞特网络科技有限公司吉林省慕蝶商贸有限公司
长春市铖金科技有限公司
长春派瑞特网络科技有限公司</p>
			</div>
		</div>
		
		<div class="row">
		
			<div class="col-xs-1 col-xs-offset-7" >
				<img src="./images/tongzhi.png"  class="min_icon">
			</div>
			
			<div class="col-xs-1">
				<span>10</span>
			</div>
			
			<div class="col-xs-1 " >
				<img src="./images/tongzhi.png"  class="min_icon">
			</div>
			
			<div class="col-xs-1">
				<span>5</span>
			</div>
			
		</div>
		
    </div>
    
    <hr>
    
    <div class="row ">
	
		<div class="row">
			
			<div class="col-xs-4 text-center">
				<img class="img-circle icon" src="./images/users.png">
			</div>
			
			<div class="col-xs-6">
				<div class="row">
					<span>郑斌斌</span>
				</div>
				<div class="row">
					<span>2018.6.6 18:13</span>
				</div>
			</div>
		
		</div>
	
		<div class="row">
			<div class="col-xs-5 col-xs-offset-1">
				<span class="forum-title">文章标题</span>
			</div>
		</div>
		
		<div class="row context ">
			<div class="col-xs-10 col-xs-offset-1">
				<p>吉林省慕蝶商贸有限公司
长春市铖金科技有限公司
长春派瑞特网络科技有限公司吉林省慕蝶商贸有限公司
长春市铖金科技有限公司
长春派瑞特网络科技有限公司吉林省慕蝶商贸有限公司
长春市铖金科技有限公司
长春派瑞特网络科技有限公司吉林省慕蝶商贸有限公司
长春市铖金科技有限公司
长春派瑞特网络科技有限公司吉林省慕蝶商贸有限公司
长春市铖金科技有限公司
长春派瑞特网络科技有限公司</p>
			</div>
		</div>
		
		<div class="row">
		
			<div class="col-xs-1 col-xs-offset-7" >
				<img src="./images/tongzhi.png"  class="min_icon">
			</div>
			
			<div class="col-xs-1">
				<span>10</span>
			</div>
			
			<div class="col-xs-1 " >
				<img src="./images/tongzhi.png"  class="min_icon">
			</div>
			
			<div class="col-xs-1">
				<span>5</span>
			</div>
			
		</div>
		
    </div>
    
    <hr>
</body>
</html>