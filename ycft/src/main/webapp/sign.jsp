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
<title>签到</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/sign.css">
    <link rel="stylesheet" href="<%=basePath%>css/navs.css">
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
	
	
	
	function details(div){
		$(div).find("form").submit();
	
	}
	 
	function back(){ 
		
		if(typeof(window.ceshi) != 'undefined'){
			//说明 可以调用安卓的返回功能
			window.ceshi.back(); 
		}else{
			window.history.back();
		}
		
	}
	</script>
	
</head>

<body >
	<div class="container-fluid">
			<!-- 页面顶端导航栏 -->
		<div class="nav-area">
			<img class="left-icon"  src="<%=basePath%>images/back.png" onclick="back()">	
			<span class="nav-title">签到 | 考勤</span>	
			<img class="right-icon" src="<%=basePath%>images/backhome.png">
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
						<input type="hidden" value="<%=sign.getDeadLine() %>" name="deadLine" />
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
											<li class="">截止时间： <%=sign.getDeadLine() %> </li>
											<li class=""> 主 办 方： <%=sign.getSname() %></li>
											<li class="">签到地点：<%=sign.getCoordinateName()%> </li>
										</ul>
									</div>
									
									<%
									  SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
									  Date now = new Date();
									  String dete = sdf.format(now);
									  now = sdf.parse(dete);
									  long time = now.getTime();
									  Date et=sdf.parse(sign.getDeadLine()); 
									  long hh =  et.getTime();
									  Date startDate =sdf.parse(sign.getTime()); 
									  long start = startDate.getTime();
									  //现在的时间必须要比 截止时间小 并且大等于开始时间
									  boolean b = time - hh <= 0 && time - start >= 0;
									  if(b){
								    	  //则现在的时间还早于截止时间   即为正在签到
								    %>
								    	<div id="" class="col-xs-4 sign_btn">
											<a  class="btn btn-info btn-lg"
											data-complete-text="签到中"
											>签到中</a> 
										</div>
								    <%
								      }else{
								    	  if(time - start < 0){
								    %>
								    		<div id="" class="col-xs-4 sign_btn">
												<a  class="btn btn-info btn-lg btn-danger" 
												data-complete-text="未开始"
												>未开始</a> 
											</div>	
								    <% 
								    	  }else{
								    %>
								    	<div id="" class="col-xs-4 sign_btn">
											<a  class="btn btn-info btn-lg btn-danger" 
											data-complete-text="已结束"
											>已结束</a> 
										</div>	  
								    <%
								    	  }
								      }
									%>
									 
								</div>
							</div>
					</div>
				</div>
				
				<hr>	<!--    华丽丽的分割线———————————————————————————————————— -->
		<%
		
				}
			}else{
		%>
			未发现任何信息
		<%
			}
			
		%>
		 
	</div>		 
</body>
</html>