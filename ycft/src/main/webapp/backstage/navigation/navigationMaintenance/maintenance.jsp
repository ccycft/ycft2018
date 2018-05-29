<%@page import="com.ycft.ycft.po.Navigation"%>
<%@page import="com.ycft.ycft.system.Menu"%>
<%@page import="com.ycft.ycft.po.Privilege"%>
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
    <%
	List<Privilege> privilegeList = Menu.pList;
    List<Navigation> nList = (List<Navigation>)request.getAttribute("nList");
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
</style>
<script type="text/javascript">
	function pointOver(id){
		document.getElementById("id").value = id;
		//markers = 
		alert("请在下面的地图上标记点信息");
	}

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
                <a class="navbar-brand" href="jump.do"><strong>返回首页</strong></a>
				
		<div id="sideNav" href=""><i class="fa fa-caret-right"></i></div>
            </div>

            <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                    <ul class="dropdown-menu dropdown-alerts">
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-comment fa-fw"></i> New Comment
                                    <span class="pull-right text-muted small">4 min</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-twitter fa-fw"></i> 3 New Followers
                                    <span class="pull-right text-muted small">12 min</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-envelope fa-fw"></i> Message Sent
                                    <span class="pull-right text-muted small">4 min</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-tasks fa-fw"></i> New Task
                                    <span class="pull-right text-muted small">4 min</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-upload fa-fw"></i> Server Rebooted
                                    <span class="pull-right text-muted small">4 min</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a class="text-center" href="#">
                                <strong>See All Alerts</strong>
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </li>
                    </ul>
                    <!-- /.dropdown-alerts -->
                </li>
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="#"><i class="fa fa-user fa-fw"></i> User Profile</a>
                        </li>
                        <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="#"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
        </nav>
  <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
                    <%for(int i = 0;i<privilegeList.size();i++){
                    	%>
                    	<li id="<%=privilegeList.get(i).getId()%>">
                        <a href="#"><i class="fa fa-sitemap"></i><span id="sp<%=privilegeList.get(i).getId()%>"><%=privilegeList.get(i).getmName() %></span><span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                        <%for(int j = 0;j<privilegeList.get(i).getChildMenus().size();j++){
                        	%>
                            <li id="<%=privilegeList.get(i).getChildMenus().get(j).getId()%>">
                                <a href="<%=basePathNoBackStage%><%=privilegeList.get(i).getChildMenus().get(j).getmUrl()%>?id=<%=privilegeList.get(i).getChildMenus().get(j).getId() %>&pid=<%=privilegeList.get(i).getChildMenus().get(j).getpId()%>">
                                <%=privilegeList.get(i).getChildMenus().get(j).getmName() %></a>
                            </li>
                        <%}%>
                        </ul>
                    </li>
                    <% }%>
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
					         	校园导航
					    </div>
					     <!-- 发布的弹出层 -->
						<div class="modal fade" id="mapName" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
						    <div class="modal-dialog" role="document">  
						        <div class="modal-content" >  
						            <div class="modal-header">  
						                <button type="button" class="close" data-dismiss="modal" aria-label="Close">  
						                    <span aria-hidden="true">×</span>  
						                </button>  
						                <h4 class="modal-title" id="myModalLabel">请给您选的点命名</h4>  
						            </div>
						            <div class="modal-body">
						            	<div class="row">
						            		<div class="col-sm-6">
						            			<input type="text" class="form-control" placeholder="请给您选的点命名" id="pointName">
						            			<input type="text" id="content">
						            		</div>
						            		<div class="col-sm-6" id="preview">
						            		</div>
					            		</div>
						            </div>  
						            <div class="modal-footer">
						                	<button type="button" class="btn btn-success" onclick="refer()" data-dismiss="modal">确定</button>
						                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>  
						            </div>
						        </div>  
						    </div>  
						</div>
					    <div class="panel-body">
							<div class="col-md-12">
						    	<div class="row">
						    		<div class="col-md-2"><input type="button" value="体育馆" class="btn btn-success" onclick="pointOver(5)"/></div>
						    		<div class="col-md-2"><input type="button" value="报告厅" class="btn btn-success" onclick="pointOver(2)"/></div>
						    		<div class="col-md-2"><input type="button" value="报到地点" class="btn btn-success" onclick="pointOver(1)"/></div>
						    		<div class="col-md-2"><input type="button" value="ATM" class="btn btn-success" onclick="pointOver(6)"/></div>
						    		<div class="col-md-2"><input type="button" value="超市" class="btn btn-success" onclick="pointOver(4)"/></div>
						    		<div class="col-md-2"><input type="button" value="食堂" class="btn btn-success" onclick="pointOver(3)"/></div>
							  	</div>
						    	<div class="row">
						    		<div class="col-md-2"><input type="button" value="图书馆" class="btn btn-success" onclick="pointOver(7)"/></div>
						    		<div class="col-md-2"><input type="button" value="教学楼" class="btn btn-success" onclick="pointOver(8)"/></div>
						    		<div class="col-md-4"></div>
						    		<div class="col-md-2"><input type="button" value="确认" class="btn btn-primary" onclick="clickMap()"/></div>
						    		<div class="col-md-2"><input type="button" value="删除" class="btn btn-danger"/></div>
							  	</div>
						    </div>
						    <div class="col-md-12" id="customize">
								<form action="<%=basePathNoBackStage %>navigationUpdate.do" method="post" id="navigationUpDate">
									<input type="hidden" name="id" id="id" />
									<input type="hidden" name="coordinate" id="coordinate"/>
								</form>
								<div id="container" ></div>
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
	
<script type="text/javascript">
	//监听被点击的一级菜单
	$(function(){   
		var id = "#sp"+ ${param.pid};
	    $(id).trigger("click");  
	}); 
    var urlstatus=false;
    var count = 0;
    $(".nav-second-level li a").each(function () {  
      if ($(".nav-second-level li:eq("+count+++")").attr('id') == ${param.id}) {
        $(this).addClass('active-menu'); 
        urlstatus = true;
      } else {
        $(this).removeClass('active-menu');
      }
    });
</script>
<script>
	var map = new AMap.Map("container", {
	    resizeEnable: true,
	     center: [126.568923,43.924275],
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
	           //placeSearch.search(e.poi.name);
	           map.setCenter(e.poi.location);
	     });
	});
    
    var contextMenu = new AMap.ContextMenu();  //创建右键菜单
	//用来存储标记点的信息
    var markers = [], positions = [];
    //地图绑定鼠标右击事件——弹出右键菜单	
    map.on('click', function(e) {
    	$("#mapName").modal();
    	var content1 = document.getElementById("pointName").value;
        contextMenuPositon = e.lnglat;
    	console.log(e.lnglat+'');
         var marker = new AMap.Marker({
            map: map,
            position: contextMenuPositon //基点位置
        });
         marker.content = content1;
      markers.push(marker);
      positions.push(contextMenuPositon);
      console.log(markers[0].content);
    });
    //把地点的值放在hidden中
    function refer(){
    	var hiddenContent = document.getElementById("content").value;
    	var content = document.getElementById("pointName").value;
    	$("#pointName").val("");
    	document.getElementById("content").value = hiddenContent +","+content;
    }
    //删除所有标记的点 
   AMap.event.addDomListener(document.getElementById('clearMarker'), 'click', function() {
        map.remove(markers);
        markers = null;
    }, false);
    //把地点的坐标存在隐藏域里
    function clickMap(){
    	var hiddenContent = document.getElementById("content").value;
    	var contentArray = hiddenContent.split(",");
    	alert(contentArray);
    	var data  = "";
    	//125.286283,43.824238,报道点A|125.286304,43.824632,报到点B|125.286315,43.82375,报道点C
    	for(var i = 0;i<markers.length;i++){
    		if(i == markers.length -1){
    			data += markers[i].getPosition()+","+contentArray[i+1];
    		}else{
    			data += markers[i].getPosition()+","+contentArray[i+1]+"|";
    		}
    	}
    	document.getElementById("coordinate").value = data;
    	document.getElementById("navigationUpDate").submit();
    }
</script>
</body>
</html>