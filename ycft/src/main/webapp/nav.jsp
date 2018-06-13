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
<title>Insert title here</title>
<style>
	div.col-xs-3{
		text-align:center!important;
	}
</style>
  <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$(".col-xs-3").click(function(){
			
			var index = $(this).index();
			var url = "";
			switch(index){
			case 0:
				url = "<%=basePath%>fore/index/index.do";
				break;
			case 1:
				url = "<%=basePath%>fore/title/selectForum.do";
				break;
			case 2:
				url = "<%=basePath%>fore/title/selectForum.do";
				break;
			case 3:
				url = "<%=basePath%>fore/user/select.do";
				break;
			}
			window.location.href = url;
			window.localStorage.setItem("selectNav" , index);
		});
		
		
		var id = window.localStorage.getItem("selectNav");
		$(".col-xs-3:eq("+id+")").css({"color":"#000" , "backgroundColor" : "#00f"});
	});
</script>
</head>
<body style="margin:0;padding:0">
	<div class="row" style="line-height:5rem;color:#fff;font-size:17px;border:0;margin:0;padding:0;position:fixed;left:0;bottom:0;width:100%;height:5rem;background-color: #f00;">
		<div class="col-xs-3"    >首页</div>
		<div class="col-xs-3"   >论坛</div>
		<div class="col-xs-3"   >教务</div>
		<div class="col-xs-3"   >我的</div>
	</div>
	<script>
		
	</script>
</body>
</html>