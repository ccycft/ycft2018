<%@page import="com.ycft.ycft.system.Core"%>
<%@page import="com.ycft.ycft.po.Slide"%>
<%@page import="com.ycft.ycft.po.Title"%>
<%@page import="java.util.List"%>
<html lang="en" dir="ltr">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/" ;
	
	//文件路径 Core.PATH是访问图片的虚拟路径
	String photoPath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort() +  Core.PATH +"/" ;
%>
<head>
	<title>Index</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/index.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
	<style>
	 @media (max-width: 767px) {
	  
	}	
	/* @media (min-width: 768px) and (max-width: 991px) {
	   //CSS代码 
	}  */
	.tab-p{
	
		text-align:left;
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
		height:8rem;
	}
	.container-fluid{
	
		/* margin-top:10rem; */
		height:100%;
	}	
	.col-xs-2{
	 	width:20%; 
	}
	</style>  
	
	<script>
		
		function openDetails(){
			
			window.open('articleDetails.jsp','_self');	
			
		}
	
	</script>
	
	
	
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
				   	<%
				   		List<Slide> sList = (List<Slide>)request.getAttribute("sList");
				   		List<Title> tList = (List<Title>)request.getAttribute("tList");
				   	%>
				   	<%
				   		if(sList != null && sList.size() > 0){
				   			for(int i = 0 ; i< sList.size() ; i++){
				   				Slide slide = sList.get(i);
				   				if(i == 0){
				   	%>
					   				<div class="item active">
								      <img src="<%=( photoPath + slide.getName())%>" alt="...">
								    </div>
				   	<%
				   				}else{
				   					
				   	%>
				   					<div class="item">
								      <img src="<%=(photoPath+ slide.getName())%>" alt="...">
								    </div>
				   	<%
				   				}
				   			}
				   		}
				   	%>
				   	
				    
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
		
		<!--    华丽丽的分割线———————————————————————————————————— -->
		
		
		<div class="row">
			<div class="col-xs-2">
				   <a href="<%=basePath%>index.jsp">
				    <img class="img-responsive btn-block" src="<%=basePath%>images/daohang.png" alt="...">
				    <span>导航</span>
				   </a>
			</div>
			<div class="col-xs-2">
				 <a href="<%=basePath%>article.jsp">
					<img class="img-responsive btn-block" src="<%=basePath%>images/tongzhi.png" alt="...">
				  	<span>通知</span>	
				  </a>  
			</div>
			<div class="col-xs-2">
				    <a href="<%=basePath%>article.jsp">
					    <img class="img-responsive btn-block" src="<%=basePath%>images/wenzhang.png" alt="...">
					  	<span>文章</span>
				  	</a>	  
			</div>
			<div class="col-xs-2">
					<a href="<%=basePath%>sign.jsp">
					    <img class="img-responsive btn-block" src="<%=basePath%>images/qiandao.png" alt="...">
					  	<span>签到</span>	  
				  	</a>
			</div>
			<div class="col-xs-2">
					<a href="<%=basePath%>activity.jsp">
					   <img class="img-responsive btn-block" src="<%=basePath%>images/huodong.png" alt="...">
					  	<span>活动</span>	
					</a>  
			</div>
		</div>
		<!--    华丽丽的分割线———————————————————————————————————— -->
		
		<div class="row">
			<div id="jiaowu" class="col-xs-10">
					<a href="<%=basePath%>preLogin.html">
     				 <img id="jiaowu" class=" img-rounded " src="<%=basePath%>images/jiaowu.jpg" alt="...">
  					</a>
  			</div>
		</div>
		<!--    华丽丽的分割线———————————————————————————————————— -->
		
		<div class="row">
			<h4>- 热门文章 -</h4><hr>
			 <div class="col-xs-12">
			      <%
			      	 if(tList != null && tList.size() > 0){
			      		 for(Title title : tList){
			      %>
			      			 <div onclick="openDetails()" class="row">
							      <div class="col-xs-7 col-">
								      <div class="thumbnail">
								      	<img src="<%= (photoPath + "/" +title.getImgName()) %>" alt="...">
								  	  </div>
							      </div>
							      <div class="col-xs-5 ">
								       	<p class="tab-p">
								       		<%=title.getName() %>
										</p>
							      </div>
						      </div>
						      <div class="row">
						      		<div class="col-xs-6">
						      			<span style="float:left"><%=title.getUser() %></span>
						      		</div>
						      		<div class="col-xs-6">
						      			<span style="float:right"> <%=title.getTime()%></span>
						      		</div>
						      </div>
						      
						      <hr><!--    华丽丽的分割线———————————————————————————————————— -->
			      
			      <%
			      		 }
			      }
			      %>
			     
			      
			     <%--  <div class="row">
				      <div class="col-xs-7 col-">
					      <div class="thumbnail">
					      	<img src="<%=basePath%>images/t2.jpg" alt="...">
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
			      <hr> --%>
			 </div>
		</div>
		
		<!--    华丽丽的分割线———————————————————————————————————— -->
	 	
		<div class="row">
			<h4>- 最新通知 -</h4><hr>
			 <div class="col-xs-12">
			      <div class="row">
				      <div class="col-xs-7 col-">
					      <div class="thumbnail">
					      	<img src="<%=basePath%>images/t1.jpg" alt="...">
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
					      	<img src="<%=basePath%>images/t2.jpg" alt="...">
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
	</div>
</body>

</html>
