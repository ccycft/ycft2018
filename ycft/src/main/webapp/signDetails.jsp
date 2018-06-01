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
<title>签到详情</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <script type="text/javascript" src="./assets/js/jquery.min.js"></script>
    <link rel="stylesheet" href="./assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="./assets/bootstrap/css/fileinput.min.css">
    <script type="text/javascript" src="./assets/bootstrap/js/fileinput.min.js"></script>
    <script type="text/javascript" src="./assets/bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="./css/navs.css">
    <link rel="stylesheet" href="./assets/date-plugin/bootstrap-datetimepicker.min.css">
    <script type="text/javascript" src="./assets/date-plugin/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="./assets/date-plugin/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
	<script type="text/javascript" src="./assets/date-plugin/moment-with-locales.min.js"></script>
	<style type="text/css">
    	.icon{
    		display:inline;
    		width:2.5rem;
    		height:100%;
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
    	.add_sign{
    		margin-top:1.5rem;
    		
    	}
    	.img{
    	
    		height:
    	}
    	.list-group{
    	
    		 margin-top:5rem; 
    	}
    	
    </style>

	<script>
	
		$(function () {  
		    $('#datetimepicker').datetimepicker({  
		    	language:  'zh-CN',  //日期
		    	format: 'yyyy-mm-dd hh:ii',  
		        autoclose:true//自动关闭
		    });  
		}); 
	
	</script>
</head>
<body>
	<!-- 页面顶端导航栏 -->
	<div class="nav-area">
		<img class="left-icon"  src="./images/back.png" onClick="javascript:window.history.back();return false;">	
		<span class="nav-title">校园导航</span>	
		<img class="right-icon" src="./images/add.png">
	</div>

	<div class="list-group" >
		  <div class="list-group-item ">
		   	<img class="img-responsive logo_icon" src="./images/wode.png">
		    <span class="name_item">我的签到</span>
		  	<img data-toggle="modal" data-target="#myModal"
		  		 class="img-responsive icon pull-right add_sign" src="./images/add.png">	
		  </div>
		  <a  href="#" class="list-group-item ">
		   	<img class="img-responsive icon" src="./images/huodong.png">
		    <span class="a_item">活动 | 互联网+ 网页设计大赛 </span>
		   	<img class="img-responsive icon pull-right " src="./images/success.png">
		  </a>
		  <a  href="#" class="list-group-item ">
		   	<img class="img-responsive icon" src="./images/tongzhi.png">
		    <span class="a_item">课程 | 网络工程-13-李老师 </span>
		   	<img class="img-responsive icon pull-right " src="./images/error.png">
		  </a>
		   <a  href="#" class="list-group-item ">
		   	<img class="img-responsive icon" src="./images/huodong.png">
		    <span class="a_item">活动 | 互联网+ 网页设计大赛 </span>
		   	<img class="img-responsive icon pull-right " src="./images/success.png">
		  </a>
		  <a  href="#" class="list-group-item ">
		   	<img class="img-responsive icon" src="./images/tongzhi.png">
		    <span class="a_item">课程 | 网络工程-13-李老师 </span>
		   	<img class="img-responsive icon pull-right " src="./images/error.png">
		  </a>
	</div>

	
	
	<form class="form-inline">
		<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title text-center" id="myModalLabel">
						发布签到
					</h4>
				</div>
				<div class="modal-body">
					<div class="container-fluid">
					  <div class="row form-group">
					  	<div class="col-xs-4"><label >签到名称:</label></div>
						<div class="col-xs-8"><input type="text" class="form-control" placeholder="请输入签到名称"></div>
					  </div>
					  <div class="row form-group">
					  	<div class="col-xs-4"><label >签到发起人:</label></div>
						<div class="col-xs-8"><input type="text" class="form-control" placeholder="请输入签到发起人"></div>
					  </div>
					   <div class="row form-group">
					  	<div class="col-xs-4"><label >签到地点:</label></div>
						<div class="col-xs-8 form-inline">
						    <div class="input-group">
						      <input type="text" class="form-control"  placeholder="请输入签到位置">
						      <div class="input-group-addon">∨</div>
						    </div>
						</div>
						
						
					  </div>
					  <div class="row form-group">
					  	<div class="col-xs-4"><label >签到时间:</label></div>
						<div class="col-xs-8">
							 <div class='input-group date' id='datetimepicker'>  
				                <input type='text' class="form-control" disabled="disabled"/>  
				                <span class="input-group-addon">  
				                    <span class="glyphicon glyphicon-calendar"></span>  
				                </span>  
				            </div> 
						</div>
					  </div>
					  <div class="row form-group">
					  	<div class="col-xs-4"><label >签到类别:</label></div>
						<div class="col-xs-8">
							<select class="form-control">
							  <option>课程考勤</option>
							  <option>活动考勤</option>
							  <option>…</option>
							  <option>…</option>
							</select>
						</div>
					  </div>
					</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button type="submit" class="btn btn-info">
						确认发布
					</button>
				</div>
			</div>
		</div>
		</div>
	</div>
	</form> 
	
	<%--  			  <div class="form-group">
					    <label >签到发起人:</label>
					    <input type="text" class="form-control" placeholder="请输入签到发起人">
					  </div>
					   <div class="form-group">
					    <label >签到地点:</label>
					    <input type="text" class="form-control" placeholder="请输入签到地点">
					  </div>
					   <div class="form-group">
					    <label >签到日期:</label>
					    <input type="text" class="form-control" placeholder="请输入签到日期">
					  </div>
					   <div class="form-group">
					    <label >签到时间:</label>
					    <input type="text" class="form-control" placeholder="请输入签到时间">
					  </div>
					 <div class="form-group">
				        <div class=" tl th">
				            <input type="file" name="image" class="projectfile btn btn-info" value="${deal.image}" />
				            <p class="help-block">支持jpg、jpeg、png、gif格式，大小不超过2.0M</p>
				        </div>
				    </div>  --%>
</body>
</html>