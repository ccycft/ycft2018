<%@page import="java.util.List"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>校园通</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/navs.css">
    <link rel="stylesheet" href="<%=basePath%>assets/date-plugin/bootstrap-datetimepicker.min.css">
    <script type="text/javascript" src="<%=basePath%>assets/date-plugin/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/date-plugin/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
	<script type="text/javascript" src="<%=basePath%>assets/date-plugin/moment-with-locales.min.js"></script>
	<script src="https://webapi.amap.com/maps?v=1.4.6&key=1662e84b6b9339c8e60267a9d9afb106"></script>
    <link rel="stylesheet" href="https://cache.amap.com/lbs/static/main1119.css"/>
    
	<style type="text/css">
    	.icon{
    		display:inline;
    		width:2.5rem;
    		height:100%;
    	}
    	.a_item{
    	
    		margin-left:1rem;
    	}
    	.logo_icon{
    		display:inline;
    		margin-left:1rem;
    		width:4.5rem;
    	}
    	.name_item{
    		line-height:6rem;
    		font-size:1.8rem;
    		margin-left:3rem;
    	}
    	.add_sign{
    		margin-top:1.5rem;
    	}
    	
    	.list-group{
    	
    		 margin-top:5rem; 
    	}
    	
    </style>

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
	    
	    $('#datetimepicker').datetimepicker({  
	    	language:  'zh-CN',  //日期
	    	format: 'yyyy-mm-dd hh:ii',  
	        autoclose:true//自动关闭
	    }); 
	    getGeolocation();
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
			var info = data.position.getLng()+","+data.position.getLat();
			$('.position').val(info);
		}
		
		function onError(data) {
	        alert("定位失败！");
	    } 
	}
	
	function back(){ 
		
		if(typeof(window.ceshi) != 'undefined'){
			//说明 可以调用安卓的返回功能
			window.ceshi.back(); 
		}else{
			window.history.back();
		}
		
	}
	function tijiao(){
		var name = $("#name").val().trim();
		var coor = $("#coordinate").val().trim();
		var coorName = $("#coordinateName").val().trim();
		
		var time = $("#time").val().trim();
		var type = $("#signType").val().trim();
		if(name != '' && coor!= '' && coorName != '' && time != '' && type != '' ){
			var rtn;
			$.ajax({
				 async:false,
	             type: "POST", //POST
	             url:"<%=basePath%>fore/signEvent/publishSign.do",
	             data: {name:name, coordinate:coor,coordinateName:coorName,time:time,signType:type}, //组装参数
	             dataType: "json",
	             success: function(data){
	            	 rtn = data;
	             }
	         });
			if(rtn == true){
				alert('提交成功');
				window.location.reload();
			}else{
				alert('提交失败...');
			}
		}else{
			alert("请输入完整信息");
		}
		
	}
	</script>
</head>
<body>


	<div class="list-group" >
		  <!-- <div class="list-group-item ">
		   	<img class="img-responsive logo_icon" src="<%=basePath%>images/wode.png">
		    <span class="name_item">我的签到</span>
		  	<img data-toggle="modal" data-target="#myModal"
		  		 class="img-responsive icon pull-right add_sign" src="<%=basePath%>images/add.png">	
		  </div> -->
		  <% 
		  	List<SignEvent> sList = (List<SignEvent>)request.getAttribute("sList");
			  if(sList != null && sList.size() > 0){
				  for(SignEvent sign : sList){
					%>
					<a  href="<%=basePath%>fore/signEvent/selDetailById.do?id=<%=sign.getId()%>" class="list-group-item ">
					   	<img class="img-responsive icon" src="<%=basePath%>images/huodong.png">
					    <span class="a_item"><%=sign.getName() %> </span>
					   	<img class="img-responsive icon pull-right " src="<%=basePath%>images/success.png">
					  </a>
					<%
				  }
			  }else{
		  %>
		  		未查询到任何签到发布信息
		  <%
			  }
		  %>
	</div>
	
	<!-- 页面顶端导航栏 -->
	<div class="nav-area">
		<img class="left-icon"  src="<%=basePath%>images/back.png" onClick="back()">	
		<span class="nav-title">签到列表</span>	
		<img class="right-icon" src="<%=basePath%>images/add.png" data-toggle="modal" data-target="#myModal">
	</div>
	
	<form      method="post">
		<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title text-center" id="myModalLabel">
						发布签到
					</h4>
				</div>
				<div class="modal-body">
					<div class="container-fluid">
					  <div class="row form-group">
					  	<div class="col-xs-4"><label >签到名称:</label></div>
						<div class="col-xs-8"><input type="text" class="form-control" placeholder="请输入签到名称" name="name" id="name"></div>
					  </div>
					  <!-- <div class="row form-group">
					  	<div class="col-xs-4"><label >发起人:</label></div>
						<div class="col-xs-8"><input type="text" class="form-control" placeholder="请输入签到发起人" name="signName"></div>
					  </div> -->
					   <div class="row form-group">
					  	<div class="col-xs-4"><label >签到地点:</label></div>
						<div class="col-xs-8 form-inline" onClick="getGeolocation()">
						    <div class="input-group">
						      <input type="text" class="form-control position" disabled="disabled" id="coordinate" placeholder="当前位置" name="coordinate" >
						      <div class="input-group-addon">∨</div>
						    </div>
						</div>
					  </div>
					   <div class="row form-group">
					  	<div class="col-xs-4"><label >地点名称:</label></div>
						<div class="col-xs-8 form-inline"  >
						    <div class="input-group">
						      <input type="text" class="form-control"  placeholder="地点名称"  id="coordinateName" name="coordinateName" >
						    </div>
						</div>
					  </div>
					  <div class="row form-group">
					  	<div class="col-xs-4"><label >签到时间:</label></div>
						<div class="col-xs-8">
							 <div class='input-group date' id='datetimepicker'>  
				                <input type='text' class="form-control" readonly="readonly" name="time" id="time" />  
				                <span class="input-group-addon">  
				                    <span class="glyphicon glyphicon-calendar"></span>  
				                </span>  
				            </div> 
						</div>
					  </div>
					  <div class="row form-group">
					  	<div class="col-xs-4"><label >签到类别:</label></div>
						<div class="col-xs-8">
							<select class="form-control" name="signType" id="signType">
							  <option value="50" >课程考勤</option>
							  <option value="51" >活动考勤</option>
							  <option value="52" >其他</option>
							</select>
						</div>
					  </div>
					</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<input type="button" onclick="tijiao()" class="btn btn-info" value="确认发布"  > 
				</div>
			</div>
		</div>
		</div>
	</div>
	</form> 
</body>
</html>