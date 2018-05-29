<%@page import="com.ycft.ycft.system.Core"%>
<%@page import="com.ycft.ycft.po.Title"%>
<%@page import="java.util.List"%>
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
<title>文章</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/article.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
	<style>
		.tab-p{
		
			display: -webkit-box;
			-webkit-box-orient: vertical;
			-webkit-line-clamp: 7;
			overflow: hidden;
			text-align:left;
		}
	
	</style>
	<script>
		//获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
	    var curWwwPath = window.document.location.href;
	    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
	    var pathName = window.document.location.pathname;
	    var pos = curWwwPath.indexOf(pathName);
	    //获取主机地址，如： http://localhost:8083
	    var localhostPath = curWwwPath.substring(0, pos);
	    //获取带"/"的项目名，如：/uimcardprj
	    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
	    var basePath = localhostPath + projectName + "/";	
		function openDetail(id){
			window.open(basePath + 'fore/title/articleDetail.do?id='+id,'_self');	
			
		}
	</script>
</head>
<body class="text-center">
	<div class="container-fluid">
			<div class="row">
			<nav aria-label="...">
			  <ul class="pager">
			    <li class="previous"><a href="#"><span aria-hidden="true">&larr;</span> </a></li>
			 	<h4>文章</h4>
			  </ul>
			</nav>
			 <div class="col-xs-12">
			 
			 	  <%
			 		List<Title> tList = (List<Title>)request.getAttribute("tList");
			 	  	
			 		if(tList != null && tList.size() > 0){
			 			for(Title t : tList){
			 			%>
		 				<div class="row" onclick="openDetail('<%=t.getId()%>')">
					      <div class="col-xs-7 ">
						      <div class="thumbnail">
						      	<img  src="<%=photoPath%><%=t.getImgName() %>" alt="...">
						  	  </div>
					      </div>
					     <div class="col-xs-5 ">
						       	<p class="tab-p">
						       		<%=t.getName() %>
								</p>
					      </div>
				      </div>
				      <div class="row">
				      		<div class="col-xs-6">
				      			<span style="float:left"><%=t.getUser() %></span>
				      		</div>
				      		<div class="col-xs-6">
				      			<span style="float:right"><%=t.getTime() %></span>
				      		</div>
				      </div>
				      
				      <hr><!--    华丽丽的分割线———————————————————————————————————— -->
			 			<%
			 			}
			 		}
			 			
			 	   %> 
			 </div>
		</div>
	</div>
</body>
</html>