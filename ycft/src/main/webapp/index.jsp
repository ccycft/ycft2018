<html lang="en" dir="ltr">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Index</title>
    <link rel="stylesheet" href="./assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/index.css">
    <script type="text/javascript" src="./assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="./assets/bootstrap/js/bootstrap.min.js"></script>
	<style>
	@media (max-width: 767px) {
	   //CSS代码 
	}	
	@media (min-width: 768px) and (max-width: 991px) {
	   //CSS代码 
	}
	.left{
		text-shadow:none;
	}		
	.carousel-control.right, .carousel-control.left{
		background-image: none;
	}	
	.row{  
  		margin-top:14px;  
  		margin-bottom:14px;  
	} 
	.thumbnail{
		margin-bottom: 5px;
	} 
	#jiaowu{
		width:100%;
		height:7rem;
	}
	.container-fluid{
	
		/* margin-top:10rem; */
		height:100%;
	}	
	
	</style>  
</head>
<body class="text-center">
	<div class="container-fluid">
	
		<div class="row">
				<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
				  <!-- Indicators -->
				  <ol class="carousel-indicators">
				    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
				    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
				    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
				  </ol>
				
				  <!-- Wrapper for slides -->
				  <div class="carousel-inner" role="listbox">
				    <div class="item active">
				      <img src="./images/time.jpg" alt="...">
				    </div>
				    <div class="item">
				      <img src="./images/time.jpg" alt="...">
				    </div>
				    <div class="item">
				      <img src="./images/time.jpg" alt="...">
				    </div>
				  </div>
				  <!-- Controls -->
				  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
				    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				    <span class="sr-only">Previous</span>
				  </a>
				  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
				    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				    <span class="sr-only">Next</span>
				  </a>
				</div>
		</div>
		<div class="row">
			<div class="col-xs-2 col-xs-offset-1">
				    <img class="img-responsive btn-block" src="./images/daohang.png" alt="...">
				    <span>导航</span>
			</div>
			<div class="col-xs-2 ">
					<img class="img-responsive btn-block" src="./images/tongzhi.png" alt="...">
				  	<span>通知</span>	  
			</div>
			<div class="col-xs-2 ">
				    <img class="img-responsive btn-block" src="./images/wenzhang.png" alt="...">
				  	<span>文章</span>	  
			</div>
			<div class="col-xs-2 ">
				    <img class="img-responsive btn-block" src="./images/qiandao.png" alt="...">
				  	<span>签到</span>	  
			</div>
			<div class="col-xs-2 ">
				   <img class="img-responsive btn-block" src="./images/huodong.png" alt="...">
				  	<span>活动</span>	  
			</div>
		</div>
		<!--    华丽丽的分割线———————————————————————————————————— -->
		
		<div class="row">
			<div id="jiaowu" class="col-xs-10">
     				 <img id="jiaowu" class=" img-rounded " src="./images/jiaowu.jpg" alt="...">
  			</div>
		</div>
		<!--    华丽丽的分割线———————————————————————————————————— -->
		
		<div class="row">
			<h4>- 热门文章 -</h4><hr>
			 <div class="col-xs-12">
			      <div class="row">
				      <div class="col-xs-7 col-">
					      <div class="thumbnail">
					      	<img src="./images/t1.jpg" alt="...">
					  	  </div>
				      </div>
				      <div class="col-xs-5 ">
					       	<p class="tab-p">史蒂夫·乔布斯 [1]（Steve Jobs，1955年2月24日—2011年10月5日 [2]），
					       		出生于……  
							</p>
				      </div>
			      </div>
			      <div class="row">
			      		<div class="col-xs-6">
			      			<span style="float:left">沉睡的毛利小五郎</span>
			      		</div>
			      		<div class="col-xs-6">
			      			<span style="float:right">2018-5-16</span>
			      		</div>
			      </div>
			      
			      <hr><!--    华丽丽的分割线———————————————————————————————————— -->
			      
			      <div class="row">
				      <div class="col-xs-7 col-">
					      <div class="thumbnail">
					      	<img src="./images/t2.jpg" alt="...">
					  	  </div>
				      </div>
				      <div class="col-xs-5 ">
					       	<p class="tab-p">马克·艾略特·扎克伯格
					       	，1984年05月14日生于美国纽约州白原市。
					       	社交网站Facebook（脸书）的创始人兼首席执行官，被人们冠……</p>
				      </div>
			      </div>
			      <div class="row">
			      		<div class="col-xs-6">
			      			<span style="float:left">沉睡的毛利小五郎</span>
			      		</div>
			      		<div class="col-xs-6">
			      			<span style="float:right">2018-5-16</span>
			      		</div>
			      </div>
			      <hr>
			 </div>
		</div>
		<hr>
		
		
		<!--    华丽丽的分割线———————————————————————————————————— -->
	 	
		<div class="row">
			<h4>- 最新通知 -</h4><hr>
			 <div class="col-xs-12">
			      <div class="row">
				      <div class="col-xs-7 col-">
					      <div class="thumbnail">
					      	<img src="./images/tongzhi.png" alt="...">
					  	  </div>
				      </div>
				      <div class="col-xs-5 ">
					       	<p class="tab-p">This is a simple hero unit,
					       	 a simple jumbotron-style component for 
					       	 calling extra attention to featured 
					       	 content or information.</p>
				      </div>
			      </div>
			      <div class="row">
			      		<div class="col-xs-6">
			      			<span style="float:left">沉睡的毛利小五郎</span>
			      		</div>
			      		<div class="col-xs-6">
			      			<span style="float:right">2018-5-16</span>
			      		</div>
			      </div>
			      
			      <hr>   干他娘的分割线————————————————————————————————————
			      
			      <div class="row">
				      <div class="col-xs-7 col-">
					      <div class="thumbnail">
					      	<img src="./images/tongzhi.png" alt="...">
					  	  </div>
				      </div>
				      <div class="col-xs-5 ">
					       	<p class="tab-p">This is a simple hero unit,
					       	 a simple jumbotron-style component for 
					       	 calling extra attention to featured 
					       	 content or information.</p>
				      </div>
			      </div>
			      <div class="row">
			      		<div class="col-xs-6">
			      			<span style="float:left">沉睡的毛利小五郎</span>
			      		</div>
			      		<div class="col-xs-6">
			      			<span style="float:right">2018-5-16</span>
			      		</div>
			      </div>
			      <hr>
			 </div>
		</div> 
		
		<!--    华丽丽的分割线———————————————————————————————————— -->
	</div>
</body>

</html>
