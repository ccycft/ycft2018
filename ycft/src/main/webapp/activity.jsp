<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>活动</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="./assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/activity.css">
    <script type="text/javascript" src="./assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="./assets/bootstrap/js/bootstrap.min.js"></script>
    <style>
	    .activity_img{
			width:100%;
		}
		.icon{
			width:1.8rem;
		}
		.row{
			padding-bottom:1rem;
			padding-top:1rem;
			
		}
	</style>
	<script>
	
		function openDetails(){
			
		
			window.open('activityDetails.jsp','_self');
			
			
		}
		
		
	
	</script>
</head>
<body>

	<div class="container-fluid">
		<ul class="pager ">
			<li class="previous"><a href="#"><span aria-hidden="true">&larr;</span> </a></li>
			<h5>活动</h5>
		</ul>
		
		<hr><!--    华丽丽的分割线———————————————————————————————————— -->
		
		 <div class="row" onclick="openDetails()">
			<div  class="col-xs-10 activity_img">
     				 <img class=" img-rounded  activity_img" src="./images/jiaowu.jpg" alt="...">
  			</div>
		</div>
		<div class="row" onclick="openDetails()">
			<div id="info" class="col-xs-7">
     			<span>比赛| 互联网+大赛</span>
  			</div>
  			<div id="renshu" class="col-xs-5">
     			<img class="icon" src="./images/renshu.png" >
     			已有 xx 人参加
  			</div>
		</div>
		
		<hr> <!--    华丽丽的分割线———————————————————————————————————— -->
		
		 <div class="row" onclick="openDetails()">
			<div  class="col-xs-10 activity_img">
     				 <img class=" img-rounded  activity_img" src="./images/jiaowu.jpg" alt="...">
  			</div>
		</div>
		<div class="row" onclick="openDetails()">
			<div id="info" class="col-xs-7">
     			<span>比赛| 互联网+大赛</span>
  			</div>
  			<div id="renshu" class="col-xs-5">
     			<img class="icon" src="./images/renshu.png" >
     			已有 xx 人参加
  			</div>
		</div>
		
		<hr> <!--    华丽丽的分割线———————————————————————————————————— -->
		
		 <div class="row" onclick="openDetails()">
			<div  class="col-xs-10 activity_img">
     				 <img class=" img-rounded  activity_img" src="./images/jiaowu.jpg" alt="...">
  			</div>
		</div>
		<div class="row" onclick="openDetails()">
			<div id="info" class="col-xs-7">
     			<span>比赛| 互联网+大赛</span>
  			</div>
  			<div id="renshu" class="col-xs-5">
     			<img class="icon" src="./images/renshu.png" >
     			已有 xx 人参加
  			</div>
		</div>
		
		<hr> <!--    华丽丽的分割线———————————————————————————————————— -->
		
		 <div class="row" onclick="openDetails()">
			<div  class="col-xs-10 activity_img">
     				 <img class=" img-rounded  activity_img" src="./images/jiaowu.jpg" alt="...">
  			</div>
		</div>
		<div class="row" onclick="openDetails()">
			<div id="info" class="col-xs-7">
     			<span>比赛| 互联网+大赛</span>
  			</div>
  			<div id="renshu" class="col-xs-5">
     			<img class="icon" src="./images/renshu.png" >
     			已有 xx 人参加
  			</div>
		</div>
		
		<hr> <!--    华丽丽的分割线———————————————————————————————————— -->
	
</body>
</html>