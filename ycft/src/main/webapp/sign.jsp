<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>签到</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="./assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/sign.css">
    <script type="text/javascript" src="./assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="./assets/bootstrap/js/bootstrap.min.js"></script>
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
			//AJAX 签到
			$(this).button('complete').addClass('btn-danger');
			$(this).attr("disabled", true); 
		});
	}); 
	</script>
	
	
</head>

<body>
	<div class="container-fluid">
		<ul class="pager ">
			<li class="previous"><a href="#"><span aria-hidden="true">&larr;</span> </a></li>
			<h5>签到</h5>
		</ul>
		
		<hr><!--    华丽丽的分割线———————————————————————————————————— -->
		
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