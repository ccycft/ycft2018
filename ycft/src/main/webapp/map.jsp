<%@page import="com.ycft.ycft.system.Core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/" ;
	
	//文件路径 Core.PATH是访问图片的虚拟路径
	String photoPath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort() +  Core.PATH +"/" ;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
<title>基本地图展示</title>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
    <link rel="stylesheet" href="./assets/bootstrap/css/bootstrap.min.css">
    <script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <script type="text/javascript" src="./assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="http://cache.amap.com/lbs/static/es5.min.js"></script>
    <script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="http://webapi.amap.com/maps?v=1.4.6&key=1662e84b6b9339c8e60267a9d9afb106"></script>

    <script>
    var map ;
	   $(function(){
		   
		   // 地图初始化…
		   map = new AMap.Map('container', {
		        resizeEnable: true,
		        zoom:15,
		        center: [125.277062,43.823759]
		    });
		   // 设置化中心标记
		   marker = new AMap.Marker({
	            icon: "http://webapi.amap.com/theme/v1.3/markers/n/mark_b.png",
	            position: [125.277062,43.823759]
	        });
	        marker.setMap(map);
	        
	        $(".col-xs-2").click(function(event){
	    		 var mark = $(event.target).attr("id")||$(event.target).parent().attr('id');
	    		 //console.log(mark);
					$.ajax({
	    			  type: 'GET',
	    			  url: '<%=basePath%>selNavigationById.do?id='+mark,
	    			  async:false,
	    			  success:function(eve){
	    				  //console.log(eve.coordinate);
	    				  setPoint(eve.coordinate);
	    			  },
	    			  dataType: 'json'
	    			});
	   		 });
	   });
	   
	   function setPoint(value){
		   map.clearMap();  // 清除地图覆盖物
		   var coordinate = value.split("|");
		    var markers = [{
		        icon: './images/mark_b.png',
		        position: [125.277062,43.823759]
		    }];
		    console.log(coordinate);
		    var len = coordinate.length;
		    for(var i = 0 ; i < len ; i++){
		    	markers[i+1]={};
		    	markers[i+1].icon="http://webapi.amap.com/theme/v1.3/markers/n/mark_b"+(i+1)+".png";
		    	console.log(markers)
		    	temp = coordinate[i].substring(0,coordinate[i].lastIndexOf(","));
		    	var p = temp.split(",");
		    	markers[i+1].position=[];
		    	markers[i+1].position.push(p[0],p[1]);
		    } 
		    
		    // 添加一些分布不均的点到地图上,地图上添加三个点标记，作为参照
		    markers.forEach(function(marker) {
		        new AMap.Marker({
		            map: map,
		            icon: marker.icon,
		            position: [marker.position[0], marker.position[1]],
		            offset: new AMap.Pixel(-12, -36)
		        });
		    });
		    map.setFitView();
	   }
	   
	</script>
	
	<style>
	.container-fluid{
		position:absolute;
		background:#fff;
		bottom:0px;
		left:0px;
	}
	#container{
		height:73%;
	}
	.col-xs-2{
	
		margin-top:1.0rem;
		margin-left:2.5rem;	
	}
	span{
		line-height:3rem;
		font-size:1rem;
	}
	
</style>
</head>
	<body class="text-center">
	<div id="container">
	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-2" id="1">
				<img class="img-responsive btn-block" src="./images/daohang.png" alt="...">
				<span>报道点</span>
			</div>
			<div class="col-xs-2" id="2">
				<img class="img-responsive btn-block" src="./images/daohang.png" alt="...">
				<span>报告厅</span>
			</div>
			<div class="col-xs-2">
				<img class="img-responsive btn-block" src="./images/daohang.png" alt="...">
				<span>教学楼</span>
			</div>
			<div class="col-xs-2">
				<img class="img-responsive btn-block" src="./images/daohang.png" alt="...">
				<span>餐厅</span>
			</div>
		</div>
		<!--	第二排btn 23333 	-->
		
		<div class="row">
			<div class="col-xs-2">
				<img class="img-responsive btn-block" src="./images/daohang.png" alt="...">
				<span>超市</span>
			</div>
			<div class="col-xs-2">
				<img class="img-responsive btn-block" src="./images/daohang.png" alt="...">
				<span>运动场</span>
			</div>
			<div class="col-xs-2">
				<img class="img-responsive btn-block" src="./images/daohang.png" alt="...">
				<span>图书馆</span>
			</div>
			<div class="col-xs-2">
				<img class="img-responsive btn-block" src="./images/daohang.png" alt="...">
				<span>ATM</span>
			</div>
		</div>
		
	</div>
	
	</body>
</html>