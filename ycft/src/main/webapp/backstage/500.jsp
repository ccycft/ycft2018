<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
    		+ request.getServerName() + ":" + request.getServerPort()
    		+ path + "/" + "backstage/";
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<!-- Bootstrap Styles-->
    <link href="<%=basePath%>assets/css/bootstrap.css" rel="stylesheet" />
     <!-- FontAwesome Styles-->
    <link href="<%=basePath%>assets/css/font-awesome.css" rel="stylesheet" />
     <!-- Morris Chart Styles-->
   
        <!-- Custom Styles-->
    <link href="<%=basePath%>assets/css/custom-styles.css" rel="stylesheet" />
     <!-- Google Fonts-->
   <link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
     <!-- TABLE STYLES-->
    <link href="<%=basePath%>assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />

	<!-- jQuery Js -->
    <script src="<%=basePath%>assets/js/jquery-1.10.2.js"></script>
      <!-- Bootstrap Js -->
    <script src="<%=basePath%>assets/js/bootstrap.min.js"></script>
    <!-- Metis Menu Js -->
    <script src="<%=basePath%>assets/js/jquery.metisMenu.js"></script>
     <!-- DATA TABLE SCRIPTS -->
    <script src="<%=basePath%>assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="<%=basePath%>assets/js/dataTables/dataTables.bootstrap.js"></script>
        <!-- Custom Js -->
    <script src="<%=basePath%>assets/js/custom-scripts.js"></script>
<title>Insert title here</title>
<style type="text/css">    
body,code,dd,div,dl,dt,fieldset,form,h1,h2,h3,h4,h5,h6,input,legend,li,ol,p,pre,td,textarea,th,ul{margin:0;padding:0}    
h1,h2,h3,h4,h5,h6,strong{font-weight:700}    
a{color:#428bca;text-decoration:none}    
a:hover{text-decoration:underline}    
.error-page{background:#f0f1f3;padding:80px 0 180px}    
.error-page-container{position:relative;z-index:1}    
.error-page-main{position:relative;background:#f9f9f9;margin:0 auto;width:350px;-ms-box-sizing:border-box;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box;padding:50px 50px 70px}    
.error-page-main:before{content:'';display:block;background:url(img/errorPageBorder.png?1427783409637);height:7px;position:absolute;top:-7px;width:100%;left:0}    
.error-page-main h3{font-size:24px;font-weight:400;border-bottom:1px solid #d0d0d0}    
.error-page-main h3 strong{font-size:54px;font-weight:400;margin-right:20px}    
.error-page-main h4{font-size:20px;font-weight:400;color:#333}    
.error-page-actions{font-size:0;z-index:100}    
.error-page-actions div{font-size:14px;display:inline-block;padding:30px 0 0 10px;width:60%;-ms-box-sizing:border-box;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box;color:#838383}    
.error-page-actions ol{list-style:decimal;padding-left:20px}    
.error-page-actions li{line-height:2.5em}    
.error-page-actions:before{content:'';display:block;position:absolute;z-index:-1;bottom:17px;left:50px;width:200px;height:10px;-moz-box-shadow:4px 5px 31px 11px #999;-webkit-box-shadow:4px 5px 31px 11px #999;box-shadow:4px 5px 31px 11px #999;-moz-transform:rotate(-4deg);-webkit-transform:rotate(-4deg);-ms-transform:rotate(-4deg);-o-transform:rotate(-4deg);transform:rotate(-4deg)}    
.error-page-actions:after{content:'';display:block;position:absolute;z-index:-1;bottom:17px;right:50px;width:200px;height:10px;-moz-box-shadow:4px 5px 31px 11px #999;-webkit-box-shadow:4px 5px 31px 11px #999;box-shadow:4px 5px 31px 11px #999;-moz-transform:rotate(4deg);-webkit-transform:rotate(4deg);-ms-transform:rotate(4deg);-o-transform:rotate(4deg);transform:rotate(4deg)}    
</style>
<script type="text/javascript">
     function jump(count) { 
         window.setTimeout(function(){                 
             count++; 
             if(count <= 500) { 
                 $("#num").html(count);                         
                 jump(count); 
             } else { 
             } 
         },5); 
     } 
</script> 
</head>
<body onload="jump(0)">
	<div id="wrapper">
		<div class="error-page">    
<div class="error-page-container">    
<div class="error-page-main">    
<h3>    
出现点瑕疵<strong id="num">0</strong>
</h3>    
<div class="error-page-actions">    
<div>    
<h4>可能原因：</h4>    
<ol>
<li>网络信号差</li>    
<li>操作失误啦</li>    
<li>程序员累倒了</li>    
</ol>    
</div>    
<div>    
</div>    
</div>    
</div>    
</div>    
</div>       
	</div>    
</body> 
</html>