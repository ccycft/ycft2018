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
<!-- <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests"> -->
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<title>基本地图展示</title>
	<link rel="stylesheet" href="<%=basePath%>css/toast.css">
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/navs.css">
    <script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="http://cache.amap.com/lbs/static/es5.min.js"></script>
    <script src="http://webapi.amap.com/maps?v=1.4.6&key=1662e84b6b9339c8e60267a9d9afb106"></script>
    <script type="text/javascript" src="<%=basePath%>js/toast.js"></script>
    <script>
       var map, geolocation;
       /*
		高德地图js api
	   */
	   $(function(){
		   // 地图初始化…
		   map = new AMap.Map('container', {
		        resizeEnable: true,
		        zoom:15,
		        center: [125.277062,43.823759]
		    });
		   // 设置中心标记
		   marker = new AMap.Marker({
	            icon: "./images/mark_b.png",
	            position: [125.277062,43.823759]
	        });
	        marker.setMap(map);
	        
	      //ajax获取坐标
	        $(".btn-box").click(function(event){
	        	 var mark = $(event.target).attr("id")||$(event.target).parent().attr('id');
	        		$.ajax({
	    			  type: 'GET',
	    			  dataType: 'json',
	    			  url: '<%=basePath%>fore/selNavigationById.do?id='+mark,
	    			  async:true,
	    			  success:function(eve){
	    				 console.log(eve);
	    				 setPoint(eve.coordinate);
	    			  }
	    		});
	   		});
	   });
	   
	   //地图点标记
	   function setPoint(value){
		  
		   map.clearMap();  // 清除地图覆盖物
		   var coordinate = value.split("|");
		    var markers = [{
		        icon: './images/mark_b.png',
		        position: [125.277062,43.823759]
		    }];
		  
		    var len = coordinate.length;
		    for(var i = 0 ; i < len ; i++){
		    	markers[i+1]={};
		    	markers[i+1].icon="./images/mark_b"+(i+1)+".png";
		    	temp = coordinate[i].substring(0,coordinate[i].lastIndexOf(","));
		    	var p = temp.split(",");
		    	markers[i+1].position=[];
		    	markers[i+1].position.push(p[0],p[1]);
		    } 
		   // console.log(markers);
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
	   
	   /***************************************
	   由于Chrome、IOS10等已不再支持非安全域的浏览器定位请求，为保证定位成功率和精度，请尽快升级您的站点到HTTPS。
	   ***************************************/
	   
	   function getGeolocation(){
		   
		   map.plugin('AMap.Geolocation', function() {
			   showMessage('正 在 获 取 定 位  ··· ');
	           geolocation = new AMap.Geolocation({
	               enableHighAccuracy: true,//是否使用高精度定位，默认:true
	               timeout: 10000,          //超过10秒后停止定位，默认：无穷大
	               buttonOffset: new AMap.Pixel(10, 20),//定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
	               zoomToAccuracy: true,      //定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
	           });
	           map.addControl(geolocation);
	           geolocation.getCurrentPosition();
	           AMap.event.addListener(geolocation, 'complete', onComplete);//返回定位信息
	           AMap.event.addListener(geolocation, 'error', onError);      //返回定位出错信息 */
	       });
	   }
	 	//解析定位结果
	    function onComplete(data) {
	    	showMessage('定位成功！');
			/* console.log(str.push('经度：' + data.position.getLng()));
	        	console.log(str.push('纬度：' + data.position.getLat()));  */
	    }
	    //解析定位错误信息
	    function onError(data) {
	    	showMessage('定位失败~');
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
	
	.container-fluid{
		position:absolute;
		background:#fff;
		bottom:0px;
		left:0px;
	}
	#container{
		height:76%;
	}
	.col-xs-3{
	
		/*//margin-top:1.0rem;
		 //margin-left:2.5rem;	 */
	}
	.btn-value{
		
		line-height:2rem;
		font-size:1rem;
	}
	.btn-box{
	
		padding:0.5rem 1rem;
		
	}

</style>
</head>
	<body class="text-center">
	
	<div id="container">
	
	</div>
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-3" >
				<div class="btn-box" id="1">
					<img class="img-responsive " src="./images/bdd.png" alt="...">
					<span class="btn-value">报道点</span>
				</div>
			</div>
			<div class="col-xs-3" >
				<div class="btn-box" id="2">
					<img class="img-responsive " src="./images/bgt.png" alt="...">
					<span class="btn-value">报告厅</span>
				</div>
			</div>
			<div class="col-xs-3" >
				<div class="btn-box" id="3">
					<img class="img-responsive " src="./images/jxl.png" alt="...">
					<span class="btn-value">教学楼</span>
				</div>
			</div>
			<div class="col-xs-3" >
				<div class="btn-box" id="4">
					<img class="img-responsive " src="./images/ct.png" alt="...">
					<span class="btn-value">餐厅</span>
				</div>
			</div>
		</div>
		<!--	第二排btn 23333 	-->
		<div class="row">
			<div class="col-xs-3" >
				<div class="btn-box" id="5">
					<img class="img-responsive btn-block" src="./images/cs.png" alt="...">
					<span class="btn-value">超市</span>
				</div>
			</div>
			<div class="col-xs-3" >
				<div class="btn-box" id="6">
					<img class="img-responsive btn-block" src="./images/ydc.png" alt="...">
					<span class="btn-value">运动场</span>
				</div>
			</div>
			<div class="col-xs-3" >
				<div class="btn-box" id="7">
					<img class="img-responsive btn-block" src="./images/tsg.png" alt="...">
					<span class="btn-value">图书馆</span>
				</div>
			</div>
			<div class="col-xs-3" >
				<div class="btn-box" id="8">
					<img class="img-responsive " src="./images/atm.png" alt="...">
					<span class="btn-value">ATM</span>
				</div>
			</div>
		</div>
	</div>
	
		<!-- 页面顶端导航栏 -->
	<div class="nav-area">
		<img class="left-icon"  src="./images/back.png" onClick="back()">	
		<span class="nav-title">校园导航</span>	
		<img class="right-icon" src="./images/location.png" onClick="getGeolocation()">
	</div>
	</body>

</html>