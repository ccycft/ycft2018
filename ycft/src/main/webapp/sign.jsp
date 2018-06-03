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
<title>签到</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/sign.css">
    <link rel="stylesheet" href="<%=basePath%>css/navs.css">
    <script src="http://webapi.amap.com/maps?v=1.4.6&key=1662e84b6b9339c8e60267a9d9afb106"></script>
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
	<style>
		#sign_div{
		
			height:1rem;
		}
		.sign_btn{
		
			margin-top:1.5rem;
		}
		#course_title{
			margin-left:1.5rem;
		}
		.none_style{
			list-style-type:none;
			padding-left:2rem;
			line-height:2.5rem;
		}
	</style>
	
	<script>
	
	$(function() { 
		$(".btn").click(function(){
			$.ajax({
  			  type: 'GET',
  			  url: '<%=basePath%>selNavigationById.do?id='+mark,
  			  async:false,
  			  success:function(eve){
  					$(this).button('complete').addClass('btn-danger');
  					$(this).attr("disabled", true); 
  			  },
  			  dataType: 'json'
  			});
			
		});
	}); 
	</script>
	
	
</head>

<body >
	<div class="container-fluid">
			<!-- 页面顶端导航栏 -->
		<div class="nav-area">
			<img class="left-icon"  src="<%=basePath%>images/back.png" onClick="javascript:window.history.back();return false;">	
			<span class="nav-title">签到 | 考勤</span>	
			<img class="right-icon" src="<%=basePath%>images/backhome.png">
		</div>
		
		<!--    华丽丽的分割线———————————————————————————————————— -->
		
		 <div id="sign_div" class="row">
			<div class="col-xs-12">
					<div class="thumbnail">
						<img class="img-rounded" src="<%=basePath%>images/t1.jpg" alt="...">
						<h4 id="course_title" >13级网络工程课</h4>
						<div class="row">
							<div class="col-xs-8">
								<ul class="none_style">
									<li class="">签到时间：2018.5.18 11:30</li>
									<li class="">主办方： 网络工程-李老师</li>
									<li class="">签到地点：北校区-第三教学楼</li>
								</ul>
							</div>
							<div id="" class="col-xs-4 sign_btn">
								<a  class="btn btn-info btn-lg"
								data-complete-text="已签到"
								>签到</a> 
							</div>
						</div>
					</div>
			</div>
		</div>
		
		<hr>	<!--    华丽丽的分割线———————————————————————————————————— -->
		
		<div id="sign_div" class="row">
			<div class="col-xs-12">
					<div class="thumbnail">
						<img class="img-rounded" src="<%=basePath%>images/t1.jpg" alt="...">
						<h4 id="course_title" >13级网络工程课</h4>
						<div class="row">
							<div class="col-xs-8">
								<ul class="none_style">
									<li class="">签到时间：2018.5.18 11:30</li>
									<li class="">主办方： 网络工程-李老师</li>
									<li class="">签到地点：北校区-第三教学楼</li>
								</ul>
							</div>
							<div id="" class="col-xs-4 sign_btn">
								<a  class="btn btn-info btn-lg"
								data-complete-text="已签到"
								>签到</a> 
							</div>
						</div>
					</div>
			</div>
		</div>
		
		<hr>	<!--    华丽丽的分割线———————————————————————————————————— -->
		
		<div id="sign_div" class="row">
			<div class="col-xs-12">
					<div class="thumbnail">
						<img class="img-rounded" src="./images/t1.jpg" alt="...">
						<h4 id="course_title" >13级网络工程课</h4>
						<div class="row">
							<div class="col-xs-8">
								<ul class="none_style">
									<li class="">签到时间：2018.5.18 11:30</li>
									<li class="">主办方： 网络工程-李老师</li>
									<li class="">签到地点：北校区-第三教学楼</li>
								</ul>
							</div>
							<div id="" class="col-xs-4 sign_btn">
								<a  class="btn btn-info btn-lg"
								data-complete-text="已签到"
								>签到</a> 
							</div>
						</div>
					</div>
			</div>
		</div>	
		
		<hr>	<!--    华丽丽的分割线———————————————————————————————————— -->
		
	</div>		 
</body>
</html>