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

<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Login</title>
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/login.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://res.wx.qq.com/open/js/jweixin-1.3.2.js"></script>
    <script type="text/javascript">
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
    	
	    
    	 $(document).ready(function(){
    		 
    		$("#login_btn").click(function(){
    			var sno = $("#inputEmail").val().trim();
    			var psd = $("#inputPassword").val().trim();
    			//post请求数据
    			$.post(basePath + "fore/user/login.do",
					  {
					    sno :sno,
					    psd :psd
					  },
					  function(data,status){
					    //alert("Data: " + data + "\nStatus: " + status);
					    if(data == 'true'){
					    	document.getElementById("showSpan").innerText = "go to login";
					    	//app端跳转
					    	document.getElementById("myForm").submit();
					    }else{
		   			  		alert("用户名或者密码错误!");
		   			  	} 
				  });
    		}); 
    	});  
    	 
    </script>
  </head>
  <body class="text-center">
    <form class="form-signin" action="<%=basePath%>fore/user/login.do" method="post" >
    <div id="logo" class="mb-3">
    	<img id="logo_img" src="<%=basePath%>images/users.png">
    </div>
    <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
    <label for="inputEmail" class="sr-only">学	号</label>
    <input type="text" value="201517030217" id="inputEmail" name="sno" class="form-control" placeholder="Student ID" required autofocus>
    <label for="inputPassword" class="sr-only">密	码</label>
    <input type="password" value="123456" id="inputPassword" name="psd" class="form-control" placeholder="Password" required>
    <div class="checkbox mb-3 line">
      <label>
        <input type="checkbox" value="remember-me"> <span id="showSpan">Remember me</span>
      </label>
    </div>
    <button id="login_btn" class="btn btn-lg btn-info btn-block" type="submit" onclick="return false">Sign in</button>
    <div  class="mb-3 line">
    	<p class="mt-5 mb-3 text-muted">&copy; 2018 - * </p>
    </div>
  </form>
  <form id="myForm" action="<%=basePath %>fore/index/index.do" method="post"> 
  </form>
  </body>
</html>
