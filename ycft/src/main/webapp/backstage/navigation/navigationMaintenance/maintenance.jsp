<%@page import="com.ycft.ycft.po.Navigation"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
    		+ request.getServerName() + ":" + request.getServerPort()
    		+ path + "/" + "backstage/"; 
    String basePathNoBackStage = request.getScheme() + "://"
    		+ request.getServerName() + ":" + request.getServerPort()
    		+ path + "/";
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewPort" content="width=device-width initial-scale=1.0">
<title>Insert title here</title>
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
<link rel="stylesheet" href="<%=basePath%>css/style.css">
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
<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
<script src="http://cache.amap.com/lbs/static/es5.min.js"></script>
<script src="http://webapi.amap.com/maps?v=1.4.6&key=82a461d12ba64ec960f5fe838ccd10a5"></script>
<script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
<style type="text/css">
	.row {  
	  margin-top: 10px;  
	  margin-bottom: 10px;  
	} 
	#customize{
		height:330px;
	}
	#cue{
		color:#F00;
	}
	
</style>
<script type="text/javascript">
	function pointOver(id){
		//先清除已经有的点
		clearPoint();
		document.getElementById("id").value = id;
		alert("请在下面的地图上标记点信息");
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState == 4){
				var data = xmlhttp.responseText;
				var newData = eval("("+data+")");
				//未解析的数据
				var contextPositon = newData.coordinate;
				//按|拆分成数组
				var arr = contextPositon.split("|");
				var finalArr = [];
				//在把数组拆分成只带坐标点的数组
				for(var i = 0;i<arr.length;i++){
					var temp = arr[i].split(",");
					finalArr.push(temp[0]);//坐标
					finalArr.push(temp[1]);//坐标
					//把名称传到hidden里面
					var hiddenContent = $("#content").val();
			    	var content = temp[2];
			    	$("#content").val(hiddenContent +","+content);
				}
				//循环插入已有的点
				 for(var i = 0;i<finalArr.length;i=i+2){
					var lon = finalArr[i];
					var lat = finalArr[i+1];
					var lnglat = new AMap.LngLat(lon, lat);
				 	var marker = new AMap.Marker({
				            map: map,
				            position: lnglat //基点位置
			        }); 
			      markers.push(marker);
				} 
			}
		};
		xmlhttp.open("post","<%=basePathNoBackStage%>selNavigationById.do",true);
		xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		xmlhttp.send("id="+id);
	}
	//点击关闭的时候清除点
	function closeMarker(){
		var temp = markers[markers.length-1];
		map.remove(temp);
		markers.pop();
	}
</script>
    <script type="text/javascript">
	function getRootPath(){
		var curWwwPath=window.document.location.href;
		var pathName=window.document.location.pathname;
		var pos=curWwwPath.indexOf(pathName);
		var localhostPaht=curWwwPath.substring(0,pos);
		var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+2);
		return (localhostPaht+projectName);
	}
	//获取地址栏的id和pid
   	function getRequest() {
   	  var url = window.location.search; //获取url中"?"符后的字串
   	  var theRequest = new Object();
   	  if (url.indexOf("?") != -1) {
   	    var str = url.substr(1);
   	    strs = str.split("&");
   	    for(var i = 0; i < strs.length; i ++) {
   	      theRequest[strs[i].split("=")[0]]=decodeURI(strs[i].split("=")[1]);
   	    }
   	  }
   	  return theRequest;
   	}
	//加载菜单
   	function loadMenu(){
   		var xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState == 4){
				var data= xmlhttp.responseText;
				var menu = eval("("+data+")");
				//加载菜单
				var str = "";
				var id = getRequest().id;
				var pid = getRequest().pid;
				for(var i = 0; i<menu.length;i++){
					if(menu[i].id == pid){
						str += "<li id='"+menu[i].id+"' class='active'>"+
						"<a href='#'>"+menu[i].icon+"<span id='sp"+menu[i].id+"'>"+menu[i].mName+"</span><span class='fa arrow'></span></a>";
						var ul = "<ul class='nav nav-second-level collapse in'>";
						for(var j = 0;j<menu[i].childMenus.length;j++){
							if(menu[i].childMenus[j].id == id){
								ul += "<li id='"+menu[i].childMenus[j].id+"'><a class='active-menu' href='"+getRootPath()+menu[i].childMenus[j].mUrl+"?id="+menu[i].childMenus[j].id+"&pid="+menu[i].childMenus[j].pId+"'>"+menu[i].childMenus[j].mName+"</a></li>";
							}else{
								ul += "<li id='"+menu[i].childMenus[j].id+"'><a href='"+getRootPath()+menu[i].childMenus[j].mUrl+"?id="+menu[i].childMenus[j].id+"&pid="+menu[i].childMenus[j].pId+"'>"+menu[i].childMenus[j].mName+"</a></li>";
							}
						}
						str += ul + "</ul></li>";
					}else{
						str += "<li id='"+menu[i].id+"'>"+
						"<a href='#'>"+menu[i].icon+"<span id='sp"+menu[i].id+"'>"+menu[i].mName+"</span><span class='fa arrow'></span></a>";
						var ul = "<ul class='nav nav-second-level'>";
						for(var j = 0;j<menu[i].childMenus.length;j++){
						 	ul += "<li id='"+menu[i].childMenus[j].id+"'><a href='"+getRootPath()+menu[i].childMenus[j].mUrl+"?id="+menu[i].childMenus[j].id+"&pid="+menu[i].childMenus[j].pId+"'>"+menu[i].childMenus[j].mName+"</a></li>";
						}
						str += ul + "</ul></li>";
					}
				}
				$("#main-menu").html(str);
				$('#main-menu').metisMenu();
			}
		};
		xmlhttp.open("post","<%=basePathNoBackStage%>privilege.do",true);
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp.send("");
   	}
   	$(document).ready(function(){
		loadMenu();
   	});
    </script>
</head>
<body>

<div id="wrapper">
<nav class="navbar navbar-default top-navbar" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                 <a class="navbar-brand logout" href="<%=basePathNoBackStage %>logOut.do">注       销</a>
				
		<div id="sideNav" href=""><i class="fa fa-caret-right"></i></div>
            </div>
        </nav>
  <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
                </ul>

            </div>

        </nav>
        <div id="page-wrapper">
        	<div class="header">
				<h1 class="page-header">校园导航管理</h1>
				<ol class="breadcrumb">
					<li class="active">校园导航管理</li>
					<li class="active">校园导航维护</li>
				</ol>        	
        	</div>
        	<div class="row">
        		<div class="col-md-12">
	       			<div class="panel panel-default">
					    <div class="panel-heading">
					         	校园导航<span id="cue">(使用说明:请先点击页面上绿色的八个按钮中的一个，点击之后点击下面地图上为对应的地点赋值)</span>
					    </div>
						<div class="modal fade" id="mapName" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">  
						    <div class="modal-dialog" role="document">  
						        <div class="modal-content" >  
						            <div class="modal-header">  
						                <button type="button" class="close" data-dismiss="modal" aria-label="Close">  
						                    <span aria-hidden="true" onclick="closeMarker()">×</span>  
						                </button>  
						                <h4 class="modal-title" id="myModalLabel">请给您选的点命名</h4>  
						            </div>
						            <div class="modal-body">
						            	<div class="row">
						            		<div class="col-sm-3" id="preview">
						            		名称
						            		</div>
						            		<div class="col-sm-6">
						            			<input type="text" class="form-control" placeholder="" id="pointName" onblur="if(this.value == '')this.value='默认';" onclick="if(this.value == '默认')this.value='';" value="默认">
						            			<input type="hidden" id="content">
						            		</div>
					            		</div>
						            </div>  
						            <div class="modal-footer">
						                	<button type="button" class="btn btn-success" onclick="refer()" data-dismiss="modal">确定</button>
						                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="closeMarker()">关闭</button>  
						            </div>
						        </div>  
						    </div>  
						</div>
					    <div class="panel-body">
							<div class="col-md-12">
							<div class="row">
						  		<div class="col-md-3"><input type="button" value="报到地点" class="btn btn-success" id="btn1" onclick="pointOver(1)"/></div>
						  		<div class="col-md-3"><input type="button" value="体育馆" class="btn btn-success" id="btn5" onclick="pointOver(5)"/></div>
				    			<div class="col-md-3"><input type="button" value="报告厅" class="btn btn-success" id="btn2" onclick="pointOver(2)"/></div>
		    					<div class="col-md-3"><input type="button" value="超市" class="btn btn-success" id="btn4" onclick="pointOver(4)"/></div>
							</div>
							<div class="row">
						  		<div class="col-md-3"><input type="button" value="ATM取款机" class="btn btn-success" id="btn6" onclick="pointOver(6)"/></div>
		    			  		<div class="col-md-3"><input type="button" value="教学楼" class="btn btn-success" id="btn8" onclick="pointOver(8)"/></div>
				    			<div class="col-md-3"><input type="button" value="图书馆" class="btn btn-success" id="btn7" onclick="pointOver(7)"/></div>
				    			<div class="col-md-2"><input type="button" value="食堂" class="btn btn-success" id="btn3" onclick="pointOver(3)"/></div>
						  		<div class="col-md-1"><input type="button" value="确认" class="btn btn-primary" onclick="submitMap()"/></div>
							</div>
						    <div class="col-md-12" id="customize">
								<form action="<%=basePathNoBackStage %>navigationUpdate.do" method="post" id="navigationUpDate">
									<input type="hidden" name="id" id="id" />
									<input type="hidden" name="coordinate" id="coordinate"/>
								</form>
								<div id="container" ></div>
								<div id="myPageTop">
								    <table>
								        <tr>
								            <td>
								                <label>按关键字搜索：</label>
								            </td>
								        </tr>
								        <tr>
								            <td>
								                <input type="text" placeholder="请输入关键字进行搜索" id="tipinput">
								            </td>
								        </tr>
								    </table>
								</div>
								<div class="button-group">
								    <input type="button" class="button" value="清空所有选中点" onclick="clearPoint()" />
								</div>
							</div>		
					    </div>
					</div>
        		</div>
        	</div>
        </div>

</div>

<!-- Morris Chart Js -->
<script src="<%=basePath%>assets/js/morris/raphael-2.1.0.min.js"></script>
<script src="<%=basePath%>assets/js/morris/morris.js"></script>

<script src="<%=basePath%>assets/js/easypiechart.js"></script>
<script src="<%=basePath%>assets/js/easypiechart-data.js"></script>

<script src="<%=basePath%>assets/js/Lightweight-Chart/jquery.chart.js"></script>
	
<script>
	var map;
	//用来存储标记点的信息
    var markers = [], positions = [];
	map = new AMap.Map("container", {
	    resizeEnable: true,
	     center: [125.277062,43.823759],
	     zoom: 16
	 });
	//设置搜索联想与poi对接
    AMap.plugin(['AMap.Autocomplete','AMap.PlaceSearch'],function(){
	     var autoOptions = {
	          city: "", //城市，默认全国
	          input: "tipinput"//使用联想输入的input的id
	     };
	     autocomplete= new AMap.Autocomplete(autoOptions);
	     AMap.event.addListener(autocomplete, "select", function(e){
	           //TODO 针对选中的poi实现自己的功能
	           map.setCenter(e.poi.location);
	     });
	});
    
    //地图绑定鼠标右击事件——弹出
    map.on('click', function(e) {
    	$("#mapName").modal();
        contextMenuPositon = e.lnglat;
    	console.log(e.lnglat+'');
         var marker = new AMap.Marker({
            map: map,
            position: contextMenuPositon //基点位置
        });
      markers.push(marker);
      positions.push(contextMenuPositon);
    });
    //把地点的值放在hidden中
    function refer(){
    	var hiddenContent = $("#content").val();
    	var content = $("#pointName").val();
    	$("#pointName").val("");
    	$("#content").val(hiddenContent +","+content);
    }
    //删除所有标记的点 
    function clearPoint(){
    	map.remove(markers);
    	//清空markers
        markers.length = 0;
    	$("#content").val("");
    }
    //把地点的坐标存在隐藏域里
    function submitMap(){
    	var hiddenContent = $("#content").val();
    	var contentArray = hiddenContent.split(",");
    	var data  = "";
    	//125.286283,43.824238,报道点A|125.286304,43.824632,报到点B|125.286315,43.82375,报道点C
    	for(var i = 0;i<markers.length;i++){
    		if(i == markers.length -1){
    			data += markers[i].getPosition()+","+contentArray[i+1];
    		}else{
    			data += markers[i].getPosition()+","+contentArray[i+1]+"|";
    		}
    	}
    	$("#coordinate").val(data);
    	$("#navigationUpDate").submit();
    }
</script>
</body>
</html>