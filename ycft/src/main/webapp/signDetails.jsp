<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.ycft.ycft.po.SignEvent"%>
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
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
 	<script src="http://webapi.amap.com/maps?v=1.4.6&key=1662e84b6b9339c8e60267a9d9afb106"></script>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=basePath%>css/navs.css">
<title></title>
<script>
		var map, geolocation;
		
		$(function(){
		    //加载地图，调用浏览器定位服务
		    map = new AMap.Map('container', {
		    	/*  resizeEnable: true,
			     zoom:15,
			     //可变坐标
			     center: [125.277062,43.823759] */
		    });
		});	
		
		
		
		function getGeolocation(){
			
			map.plugin('AMap.Geolocation', function() {
			   	geolocation = new AMap.Geolocation({
					enableHighAccuracy: true,//是否使用高精度定位，默认:true
		            timeout: 10000,          //超过10秒后停止定位，默认：无穷大
				    buttonOffset: new AMap.Pixel(10, 20),//定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
				});
			   	map.addControl(geolocation);
		        geolocation.getCurrentPosition();
		        AMap.event.addListener(geolocation, 'complete', onComplete);//返回定位信息
		        AMap.event.addListener(geolocation, 'error', onError);      //返回定位出错信息 
		   });
		
		
		
		//解析定位结果
		function onComplete(data) {
		    alert("定位成功！");
		    /* 
		    console.log(str.push('经度：' + data.position.getLng()));
		    console.log(str.push('纬度：' + data.position.getLat()));  */
		    var cId = $('#cid').val();
			var p1 = cId.split(",");
			/* alert("p1 is"+p1); */
			var p2 = [];
		    p2.push(data.position.getLng());
		    p2.push(data.position.getLat());
		    /* alert("p2 is"+p2); */
		    // 返回 p1 到 p2 间的地面距离，单位：米
		    var dis = AMap.GeometryUtil.distance(p1, p2);
		    if( dis <= 500){
		    	//ajax后台    sign	event  code
		    	
		    	var sid = $("#sid").val();
				var uid = $("#uid").val();
				if(uid != ''){
					htmlobj=$.ajax({url: "<%=basePath%>fore/signEvent/sign.do?sid="+sid+"&uid="+uid,async:false});
		  			var rtn = (htmlobj.responseText);
		  			if(rtn == 1){
		  				alert("签到成功！！");
		  				//签到变样式
				    	$('#sign_btn').text("已签到").addClass('btn-danger').attr("disabled", true);
		  			}else{
		  				alert("签到失败...");
		  			}
					
				}else{
					alert("用户信息未找到，请重新登录后尝试...");
				}
		    	
		    }else{
		    	alert("太远啦~");
		    }
		 }
		}
		//解析定位错误信息
		function onError(data) {
		    alert("定位失败！");
		} 
		
		function toLocation(){
			
			window.open('<%=basePath%>/location.jsp?coordinate=123','_self');
			
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
<style>
		.img-rounded{
		
			width:100%;
		}
		.row{
			line-height:4rem;
			margin-top:1rem;
		}
		.icon_area{
		
    		border-top:1px solid #ccc;
    		border-bottom:1px solid #ccc;
    	}
    	.icon{
    		display:inline;
    		width:2.5rem;
    		height:100%;
    	}
    	.a_item{
    	
    		margin-left:2rem;
    	}
		
	</style>
	<script type="text/javascript">
		
		
	</script> 
</head>
<body>
	<div class="container-fluid">
			
		<%
			SignEvent sign = (SignEvent)request.getAttribute("signEvent");
			//是否能签到
			boolean canSign = (Boolean)request.getAttribute("canSign");
			String uid = "";
			//获取cookie找到用户信息
			Cookie[] cookies = request.getCookies();
			if(cookies != null){ 
				for(Cookie cookie : cookies){ 
					 //用户id
					 if(cookie.getName().equals("uid")){
						 uid = cookie.getValue();
					 }
				 }
			}
		%>
		<!-- uid和sid -->
		<input type="hidden" value="<%=uid%>" id="uid" />
		<input type="hidden" value="<%=sign.getId()%>" id="sid"  />
		<input type="hidden" value="<%=sign.getCoordinate()%>" id="cid"/>
		
		<!-- 页面顶端导航栏 -->
		<div class="nav-area">
			<img class="left-icon"  src="<%=basePath%>images/back.png" onClick="back()">	
			<span class="nav-title">签到 | 考勤</span>	
			<img class="right-icon" src="<%=basePath%>images/location.png"onClick="toLocation()">
		</div>
		
		<div id="sign_div" class="row">
			<div class="col-xs-12">
				<img class="img-rounded" src="<%=basePath%>images/t1.jpg" alt="...">	
			</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12">
				<h4>签到标题:<%=sign.getName() %></h4>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<h4>主办单位:<%=sign.getSname() %></h4>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<span>签到时间:<%=sign.getTime() %></span>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
			<%-- 	<span>截止时间:<%=sign.getDeadLine()%></span> --%>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<span>签到地点:<%=sign.getCoordinateName() %></span>
			</div>
		</div>
		 
				<%-- <span>签到坐标:<%=sign.getCoordinate() %></span> --%>
		 
		
		<div class="row icon_area" >
			<div class="col-xs-12">
				<img class="img-responsive icon" src="<%=basePath%>images/tongzhi.png">
			 
			    		<span class="a_item" style="font-size:1.5rem;font-weight:bold;"><%=sign.getState() %></span>
			     
				
			</div>
		</div>
		<div class="row">
		   <div class="col-xs-12 text-center" disabled="disabled" style="margin-top:3rem;">
			<%
				//用户没签到 过  并且  签到时间未过   
				if(canSign && sign.getState().equals("正在签到") ){
			%>	
					 
							<a class="btn btn-info" onclick="getGeolocation()"> 点击签到 </a> 
			<%
				}else{
					if(!sign.getState().equals("正在签到") ){
			%>
			<%
					}else{ 
			%> 
							<a disabled="disabled" class="btn btn-info btn-danger" onclick="return false;"> 您已经签到过了 </a>
			<%		
					}
				}
			%>
			</div>
		</div> 
	</div>
</body>
</html>