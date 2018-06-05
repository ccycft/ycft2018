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
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
 	<script src="http://webapi.amap.com/maps?v=1.4.6&key=1662e84b6b9339c8e60267a9d9afb106"></script>
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=basePath%>css/navs.css">
<title></title>
<style>
		#sign_div{
		
			height:1rem;
		}
		.a_item{
    	
    		margin-left:1rem;
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
		.icon{
    		display:inline;
    		width:2.5rem;
    		height:100%;
    	}
	</style>
</head>
<body>
	<div class="container-fluid">
			<!-- 页面顶端导航栏 -->
		<div class="nav-area">
			<img class="left-icon"  src="<%=basePath%>images/back.png" onClick="javascript:window.history.back();return false;">	
			<span class="nav-title">签到 | 考勤</span>	
			<img class="right-icon" src="<%=basePath%>images/backhome.png">
		</div>
		
		<div id="sign_div" class="row">
					<div class="col-xs-12">
							<div class="thumbnail">
								<img class="img-rounded" src="<%=basePath%>images/t1.jpg" alt="...">
								<h4 id="course_title" > 1231231 </h4>
								<div class="row">
									<div class="col-xs-8">
										<ul class="none_style">
											<li class="">签到时间： 123123 </li>
											<li class="">签到地点：1231231 </li>
											<li><a  class="btn btn-info btn-lg"
													data-complete-text="已签到"
												>签到</a> 
											</li>
										</ul>
									</div>
									<div class="list-group" >
									  <a  href="#" class="list-group-item pull-left ">
									   	<img class="img-responsive icon" src="./images/tongzhi.png">
									    <span class="a_item">正在签到 </span>
									  </a>
									</div>
									<div id="" class="col-xs-4 sign_btn">
										
									</div>
								</div>
							</div>
					</div>
				</div>
		
	</div>

</body>
</html>