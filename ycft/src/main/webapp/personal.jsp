<%@page import="com.ycft.ycft.po.User"%>
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
<title>Personal</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="<%=basePath%>css/navs.css">
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/activity.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
    <style type="text/css">
    	.icon{
    		display:inline;
    		width:2.5rem;
    		height:100%;
    	}
    	#nav{
    		marign-left:
    	}
    	.a_item{
    	
    		margin-left:1rem;
    	}
    	.logo_icon{
    		display:inline;
    		margin-left:1rem;
    		width:4.5rem;
		    height: 4.5rem;
		    border-radius: 50%;
    	}
    	.name_item{
    		line-height:6rem;
    		font-size:1.8rem;
    		margin-left:3rem;
    	}
    	.nav-area{
    		position:relative;
    		border:0;
    	}
    </style>
    <script>
    	function logout(){
    		if(confirm("确认退出当前登录吗?")){
    			window.location.href = "<%=basePath%>fore/user/logout.do";
    		}
    	}
    
    </script>
    
    
</head>
<body>
	<!-- 页面顶端导航栏 -->
	<div class="nav-area" style="position:relative;top:0">
		<span class="nav-title">个人中心</span>	
		<img class="right-icon" src="<%=basePath%>images/注销.png" onClick="logout()" style="position:absolute;right:0.6rem;">
	</div>
	<div class="list-group" >
		  <a  href="#" class="list-group-item ">
		  <%
		  	User u = (User)request.getAttribute("user");
			if(u != null){
		  %>
		  		
		  		<img class="img-responsive logo_icon" src="<%=photoPath+"icon/" + u.getImgName()%>">
				    <span class="name_item"><%=u.getSname()%></span></a>
				  <a  href="#" class="list-group-item ">
				   	<img class="img-responsive icon" src="<%=basePath%>images/huodong.png">
				    <span class="a_item">我的活动 </span></a>
				  <a href="<%=basePath%>fore/signEvent/myReleaseSign.do" class="list-group-item ">
				  	<img class="img-responsive icon" src="<%=basePath%>images/qiandao.png">	
				  	<span class="a_item">我的签到</span></a>
				  <a href="#" class="list-group-item ">
				  	<img class="img-responsive icon" src="<%=basePath%>images/fabu.png">
				  	<span class="a_item">我的发布</span></a>
				  <a href="http://www.cchzyc.com" class="list-group-item ">
				  	<img class="img-responsive icon" src="<%=basePath%>images/jiaowurukou.png">
				  	<span class="a_item">教务信息</span></a>
				  <a href="#" class="list-group-item ">
				  	<img class="img-responsive icon" src="<%=basePath%>images/jianyi.png">
				  	<span class="a_item">我的建议</span></a>
				  <a href="#" class="list-group-item ">
				  	<img class="img-responsive icon" src="<%=basePath%>images/guanyu.png">
				  	<span class="a_item">关于我们</span></a>
				  <a href="#" class="list-group-item ">
				  	<img class="img-responsive icon" src="<%=basePath%>images/banben.png">
				  	<span class="a_item">当前版本</span></a>
				  	<a href="<%=basePath %>preLogin.jsp" class="list-group-item ">
				  	<img class="img-responsive icon" src="<%=basePath%>images/banben.png">
				  	<span class="a_item">我重新登录</span></a>
		  <%	  
			}
		  %>
	</div>
</body>
</html>