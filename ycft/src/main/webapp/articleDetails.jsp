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
<title>活动详情</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
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
	<%
	 	TitleContent con = (TitleContent)request.getAttribute("titleContent");
	  	if(con != null){
	%>
	
	
		<div class="container-fluid">
			<ul class="pager">
				<li class="previous"><a href="#"><span aria-hidden="true">&larr;</span> </a></li>
				<h5>活动详情</h5>
			</ul>
			<hr>
			<div class="row">
				<div  class="col-xs-12 activity_img">
	     				 <img class=" img-rounded  activity_img" src="<%=photoPath %><%=con.getImgName() %>" alt="...">
	  			</div>
	  			<div class="col-xs-12">
					<ul class="none_style">
						<li class="">活动名称：比赛 | 互联网+大赛</li>
						<li class="">活动地点： 经信九阶</li>
						<li class="">活动时间：2018.5.18</li>	
						<li class="">活动主办方：吉林大学经管学院</li>	
						<li class="">联系方式：到场报名即可</li>	
						<li class="">活动内容描述：</li>	
					</ul>								
				</div>
			</div>
			<dir class="row">
				<div class="col-xs-11">
					
					 <%=con.getText() %>
				</div>
			</dir>
			
			<hr>
			
			<dir class="row">
				<div id="activity_btn" class="col-xs-9">
				
					<a class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">点击报名</a>
				
				</div>
			</dir>		
		</div>
		
			<!-- 模态框（Modal） -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">
							互联网+网页设计大赛
						</h4>
					</div>
					<div class="modal-body">
						<div class="list-group">
							<div class="list-group-item">
								 姓名
							</div>
							<div class="list-group-item">
								 学号
							</div>
							<div class="list-group-item">
								 电话
							</div>
							<div class="list-group-item">
								 …
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-info">
							确认报名
						</button>
					</div>
				</div>
			</div>
		</div>
	<%  		
	  	}else{
	  		out.print("未查询到内容...");
	  	}
	 %>
	
	
	
</body>
</html>