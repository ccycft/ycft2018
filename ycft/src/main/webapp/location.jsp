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
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<title>Map</title>
	<script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
	<script src="http://webapi.amap.com/maps?v=1.4.6&key=1662e84b6b9339c8e60267a9d9afb106"></script>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=basePath%>css/navs.css">

	<script type="text/javascript">
	var map, geolocation;
	
	$(function(){
	    //加载地图，调用浏览器定位服务
	    map = new AMap.Map('container', {
	    	 resizeEnable: true,
		     zoom:15,
		     //可变坐标
		     center: [125.277062,43.823759]
	    });
		 // 设置中心标记
		   marker = new AMap.Marker({
	            icon: "./images/mark_b.png",
	            //可变坐标
	            position: [125.277062,43.823759]
	        });
	        marker.setMap(map);
	});
	
	function getGeolocation(){
		alert("开始定位，请稍等…");
		  map.plugin('AMap.Geolocation', function() {
		        geolocation = new AMap.Geolocation({
			        enableHighAccuracy: true,//是否使用高精度定位，默认:true
			        timeout: 10000,          //超过10秒后停止定位，默认：无穷大
			        buttonOffset: new AMap.Pixel(10, 20),//定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
			        zoomToAccuracy: true,      //定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
		        });
		        map.addControl(geolocation);
		        geolocation.getCurrentPosition();
		        AMap.event.addListener(geolocation, 'complete', onComplete);//返回定位信息
		        AMap.event.addListener(geolocation, 'error', onError);      //返回定位出错信息
		   });	  
	}
	//解析定位结果
    function onComplete(data) {
        alert("定位成功！");
    }
    //解析定位错误信息
    function onError(data) {
        alert("定位失败！");
    } 
	</script>
</head>
<body>
	<div id="container">
	
	</div>
	<!-- 页面顶端导航栏 -->
	<div class="nav-area">
		<img class="left-icon"  src="<%=basePath%>images/back.png" onClick="javascript:window.history.back();return false;">	
		<span class="nav-title">地图 | 定位</span>	
		<img class="right-icon" src="<%=basePath%>images/location.png" onClick="getGeolocation();"/>
	</div>
	
</body>
</html>