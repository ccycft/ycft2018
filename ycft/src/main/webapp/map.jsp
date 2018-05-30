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
<!--     <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
 -->    
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
	    		 console.log(mark);

					$.ajax({
	    			  type: 'POST',
	    			  url: '<%=basePath%>selNavigationById.do',
	    			  async:false,
	    			  data: mark,
	    			  success: function(eve,xhr){
	    				  
	    				  var value = xhr.responseText;
	    				  setPoint(value);
	    			  },
	    			  dataType: 'text'
	    			});
	   		 });
	   });
	   
	   function setPoint(){
		   
		   map.clearMap(value);  // 清除地图覆盖物
		   
		    var markers = [{
		        icon: 'http://webapi.amap.com/theme/v1.3/markers/n/mark_b1.png',
		        position: [116.205467, 39.907761]
		    }, {
		        icon: 'http://webapi.amap.com/theme/v1.3/markers/n/mark_b2.png',
		        position: [116.368904, 39.913423]
		    }, {
		        icon: 'http://webapi.amap.com/theme/v1.3/markers/n/mark_b3.png',
		        position: [116.305467, 39.807761]
		    }];
		    // 添加一些分布不均的点到地图上,地图上添加三个点标记，作为参照
		    markers.forEach(function(marker) {
		        new AMap.Marker({
		            map: map,
		            icon: marker.icon,
		            position: [marker.position[0], marker.position[1]],
		            offset: new AMap.Pixel(-12, -36)
		        });
		    });
		    var center = map.getCenter();
	   }
	   
	  
	   /*  var centerText = '当前中心点坐标：' + center.getLng() + ',' + center.getLat();
	    document.getElementById('centerCoord').innerHTML = centerText;
	    document.getElementById('tips').innerHTML = '成功添加三个点标记，其中有两个在当前地图视野外！';

	    // 添加事件监听, 使地图自适应显示到合适的范围
	    AMap.event.addDomListener(document.getElementById('setFitView'), 'click', function() {
	        var newCenter = map.setFitView();
	        document.getElementById('centerCoord').innerHTML = '当前中心点坐标：' + newCenter.getCenter();
	        document.getElementById('tips').innerHTML = '通过setFitView，地图自适应显示到合适的范围内,点标记已全部显示在视野中！';
	    }); */
	   
	</script>
    <!--  $(function(){
			
			window.open("http://uri.amap.com/marker?position=125.277062,43.823759&name=吉林大学前卫校区南区&key=1662e84b6b9339c8e60267a9d9afb106",'_self');
		}); 
		
		// h5获取当前坐标信息，需要https支持
		
		var x=document.getElementById("demo");
		function getLocation()
		{
		    if (navigator.geolocation)
		    {
		    	alert(1111);
		        navigator.geolocation.getCurrentPosition(showPosition,locationError,{
		        	// 指示浏览器获取高精度的位置，默认为false  
		            enableHighAcuracy: true,  
		            // 指定获取地理位置的超时时间，默认不限时，单位为毫秒  
		            timeout: 5000,  
		            // 最长有效期，在重复获取地理位置时，此参数指定多久再次获取位置。  
		            maximumAge: 3000  
		        });
		    }
		    else
		    {
		        x.innerHTML="该浏览器不支持获取地理位置。";
		    }
		}
		 
		function showPosition(position)
		{
			alert(2222);
		    x.innerHTML="纬度: " + position.coords.latitude + 
		    "<br>经度: " + position.coords.longitude;    
		    alert(333);
		}
		
			function locationError(error){  
			    switch(error.code) {  
			        case error.TIMEOUT:  
			            alert("A timeout occured! Please try again!");  
			            break;  
			        case error.POSITION_UNAVAILABLE:  
			        	alert('We can\'t detect your location. Sorry!');  
			            break;  
			        case error.PERMISSION_DENIED:  
			        	alert('Please allow geolocation access for this to work.');  
			            break;  
			        case error.UNKNOWN_ERROR:  
			        	alert('An unknown error occured!');  
			            break;  
			    }  
			}  
		
		function locationSuccess(position){  
		    var coords = position.coords;       
		        // 维度  
		        alert(coords.latitude);  
		        // 精度  
		        alert(coords.longitude);  
		}	 
		var map = new AMap.Map('container', {
		    resizeEnable: true,
		    zoom:11,
		    center: [116.397428, 39.90923]        
		});
	</script> -->
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