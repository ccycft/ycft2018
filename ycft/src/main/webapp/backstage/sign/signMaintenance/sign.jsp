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
<meta name="viewport" content="width=device-width initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<title>Insert title here</title>
<script type="text/javascript">
	function load(){
		$("#button").modal();
	}
	function closeWindow(){
		window.location.href = "selSignEvent.do";		
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
<body onload="load()">
<%
	String result = (String)request.getAttribute("result");
	int numerator = (Integer)request.getAttribute("numerator");
	String name = (String)request.getAttribute("name");
%>
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
			<h1 class="page-header">签到管理</h1>
			<ol class="breadcrumb">
				<li class="active">签到管理</li>
				<li class="active">签到维护</li>
			</ol>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
				    <div class="panel-heading">
				         	统计
				    </div>
				    <div class="modal fade" id="button" tabindex="-1" role="dialog" aria-labelledby="myModelLabel" data-backdrop="static">
				    	<div class="modal-dialog" role="document">  
					        <div class="modal-content">  
					            <div class="modal-header">  
					                <button type="button" class="close" data-dismiss="modal" aria-label="Close">  
					                    <span aria-hidden="true" onclick="closeWindow()">×</span>  
					                </button>  
					                <h4 class="modal-title" id="myModalLabel">统计</h4>  
					            </div>  
					            <div class="modal-body">  
					            	<fieldset>
				                       <div class="form-group">
					                       <label class="col-sm-1 control-label" for="ds_name"><%=name %></label>
		                       		   		<div class="col-sm-5">
						                       <div class="panel panel-primary text-center no-boder blue">
											       <div class="panel-right">
													   <h3><%=numerator %></h3>
											           <strong>签到人数</strong>
											        </div>
									    		</div>
					    			   		</div>
					    			   		<label class="col-sm-1 control-label" for="ds_name">出勤率</label>
				                      		<div class="col-xs-6 col-sm-5">
												<div class="panel panel-default">
													<div class="panel-body easypiechart-panel">
														<div class="easypiechart" id="easypiechart-orange" data-percent="<%=result %>" ><span class="percent"><%=result %>%</span>
														</div>
													</div>
												</div>
											</div>
				                       </div>
				                    </fieldset>
					            </div>  
					            <div class="modal-footer">  
					                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="closeWindow()">关闭</button>  
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
</div>
</body>
</html>