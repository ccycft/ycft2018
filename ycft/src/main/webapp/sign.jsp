<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.ycft.ycft.po.SignEvent"%>
<%@page import="java.util.List"%>
<%@page import="com.ycft.ycft.system.Core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>校园通</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="<%=basePath%>css/toast.css">
	<link rel="stylesheet" href="<%=basePath%>css/animate.css">
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/navs.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/toast.js"></script>
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
		.getMore{
			font-size:1.5rem;
			color:#ccc;
			border:0px;
		}
		.bottomDiv{
			margin-top:1rem;
			margin-bottom:1.5rem;
		}
		
	</style>
	
	<script>
	

	function details(div){
		$(div).find("form").submit();
	}
	
	function showtoastFromDocument(){
		showMessage('咩有更多喽~');
	}
	
	function showtoastFromDocumentCenter(){
		showMessage('慢些刷,少年~');
	}
	
	
	
	$(function(){
		
		var b = true ;
		var nowPage = 1;
		//滚动条到页面底部加载更多案例   
		$(window).scroll(function(){  
		      
		 var scrollTop = $(this).scrollTop();    //滚动条距离顶部的高度  
		 var scrollHeight = $(document).height();   //当前页面的总高度  
		 var clientHeight = $(this).height();    //当前可视的页面高度  
		 // console.log("top:"+scrollTop+",doc:"+scrollHeight+",client:"+clientHeight);  
		 if(scrollTop + clientHeight >= scrollHeight){   //距离顶部+当前高度 >=文档总高度 即代表滑动到底部   
		     //滚动条到达底部  
		     //alert('开始加载....')  ;
		 	//开始ajax请求下一页
		 	 ++nowPage;
			 htmlobj=$.ajax({url:"<%=basePath%>fore/signEvent/selSignEventByPage.do?nowPage="+nowPage,async:false});
			 var json = (htmlobj.responseText);
			 //alert(json);
			 var obj = JSON.parse(json);
			 var container = $('.container-fluid');
			 for(var i = 0 ; i < obj.length ;i++){
				container.append("<div id='sign_div' class='row' onclick='details(this)'><form action='<%=basePath%>fore/signEvent/selDetail.do' method='post' ><input type='hidden' value='"+obj[i].id+"' name='id' /><input type='hidden' value='"+obj[i].name+"' name='name' /><input type='hidden' value='"+obj[i].time+"' name='time' /><input type='hidden' value='"+obj[i].state +"' name='state' /><input type='hidden' value='"+obj[i].sname+"' name='sname' /><input type='hidden' value='"+obj[i].coordinate+"' name='coordinate' /><input type='hidden' value='"+obj[i].coordinateName+"'  name='coordinateName' /><input type='hidden' value='"+obj[i].uid+"'  name='userid' /></form><div class='col-xs-12'><div class='thumbnail'><img class='img-rounded' src='<%=basePath%>images/t1.jpg' alt='...'><h4 id='course_title' >"+obj[i].name+"</h4><div class='row'><div class='col-xs-8'><ul class='none_style'><li class=''>签到时间："+obj[i].time+"</li><li class=''> 主 办 方："+obj[i].sname+"</li><li class=''>签到地点："+obj[i].coordinateName+"</li></ul></div><div id='' class='col-xs-4 sign_btn'><a  class='btn btn-info btn-lg signBtn' data-complete-text='"+obj[i].state+"'>"+obj[i].state+"</a> </div></div></div></div></div><hr>");
			 } 
			 if(obj.length == 0 &&  b){
				 b = false;
				 showtoastFromDocument();
			 }
		 }else if(scrollTop<=0){  
		    //滚动条到达顶部  
		 //滚动条距离顶部的高度小于等于0 TODO  
		     if(!b){
		    	 b = true;
		    	 showtoastFromDocumentCenter();
		     }
		 }  
		 
		}); 
		
		//修改图标样式
		changeStyle();
	});
	function back(){ 
		
		if(typeof(window.ceshi) != 'undefined'){
			//说明 可以调用安卓的返回功能
			window.ceshi.back(); 
		}else{
			window.history.back();
		}
	}
	
	function changeStyle(){
		
		//修改btn样式信息
		var btnArray = document.getElementsByClassName('signBtn');
		
		for(var i = 0 ; i < btnArray.length ; i++){
			
			if(btnArray[i].innerText =='已结束'){
				
				btnArray[i].className = "btn btn-danger btn-lg";
				
			}else if(btnArray[i].innerText =='未开始'){
				
				btnArray[i].className = "btn btn-warning btn-lg";
			}	
		}
	}
	</script>
	
</head>

<body >
	<div class="container-fluid">
			<!-- 页面顶端导航栏 -->
		
		<div class="toast_div">
		</div>
		<!--    华丽丽的分割线———————————————————————————————————— -->
		<% 
			List<SignEvent> sList = (List<SignEvent>)request.getAttribute("sList");
			if(sList != null && sList.size() > 0){
				
				String uid = "";
				String sno = "";
				//获取cookie找到用户信息
				Cookie[] cookies = request.getCookies();
				if(cookies != null){ 
					for(Cookie cookie : cookies){ 
						 //用户id
						 if(cookie.getName().equals("uid")){
							 uid = cookie.getValue();
						 }if(cookie.getName().equals("sno")){
							 //学号
							sno = cookie.getValue();
						 } 
					 }
				}
				%>
				<!-- 隐藏的签到事件id信息 -->
				<input type="hidden" value="<%=sList.get(0).getId() %>" id="sid"/>
				<!-- 隐藏的用户id -->
				<input type="hidden" value="<%=uid%>" id="uid" />
				<%
				for(SignEvent sign : sList){
				%>
				
				<div id="sign_div" class="row" onclick="details(this)">
					<form action="<%=basePath%>fore/signEvent/selDetail.do" method="post" >
						<input type="hidden" value="<%=sign.getId()%>" name="id" />
						<input type="hidden" value="<%=sign.getName() %>" name="name" />
						<input type="hidden" value="<%=sign.getTime() %>" name="time" />
						 <input type="hidden" value="<%=sign.getState() %>" name="state" /> 
						<input type="hidden" value="<%=sign.getSname() %>" name="sname" />
						<input type="hidden" value="<%=sign.getCoordinate() %>" name="coordinate" />
						<input type="hidden" value="<%=sign.getCoordinateName()%>"  name="coordinateName" />
						<input type="hidden" value="<%=uid%>"  name="userid" />
					</form>
					<div class="col-xs-12">
						<div class="thumbnail">
							<img class="img-rounded" src="<%=basePath%>images/t1.jpg" alt="...">
								<h4 id="course_title" > <%=sign.getName()%>  </h4>
								<div class="row">
									<div class="col-xs-8">
										<ul class="none_style">
											<li class="">签到时间： <%=sign.getTime() %> </li>
											<%-- <li class="">截止时间： <%=sign.getDeadLine() %> </li> --%>
											<li class=""> 主 办 方： <%=sign.getSname() %></li>
											<li class="">签到地点：<%=sign.getCoordinateName()%> </li>
										</ul>
									</div>
								    <div id="" class="col-xs-4 sign_btn">
										<a  class="btn btn-info btn-lg signBtn" data-complete-text="<%=sign.getState() %>"><%=sign.getState() %></a> 
									</div>	
								</div>
						</div>
					</div>
				</div>
				
				<hr>	
				<!--    华丽丽的分割线———————————————————————————————————— -->
		<%
				}
			}else{
		%>
			未发现任何信息
		<%
			}
		%>
		<div class="nav-area">
			<img class="left-icon"  src="<%=basePath%>images/back.png" onclick="back()">	
			<span class="nav-title">签到 | 考勤</span>	
			<img class="right-icon" src="<%=basePath%>images/backhome.png">
		</div>
	</div>	
</body>
</html>