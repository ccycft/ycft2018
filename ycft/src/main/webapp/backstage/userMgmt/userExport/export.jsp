<%@page import="com.ycft.ycft.system.Menu"%>
<%@page import="com.ycft.ycft.po.Privilege"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/"+"backstage/";
	//没有backstage的路径
	String basePathNoBackstage = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	List<Privilege> privilegeList = Menu.pList;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>Export</title>
    <!-- Bootstrap Styles-->
    <link href="<%=basePath %>assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="<%=basePath %>assets/css/font-awesome.css" rel="stylesheet" />
    <!-- Morris Chart Styles-->
    <link href="<%=basePath %>assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
    <!-- Custom Styles-->
    <link href="<%=basePath %>assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="<%=basePath %>assets/js/Lightweight-Chart/cssCharts.css"> 
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
                <a class="navbar-brand" href="index.html"><strong>后台</strong></a>
				
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
        <!--/. NAV TOP  -->
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
                                <a href="<%=basePathNoBackstage%><%=privilegeList.get(i).getChildMenus().get(j).getmUrl()%>?id=<%=privilegeList.get(i).getChildMenus().get(j).getId() %>&pid=<%=privilegeList.get(i).getChildMenus().get(j).getpId()%>">
                                <%=privilegeList.get(i).getChildMenus().get(j).getmName() %></a>
                            </li>
                        <%}%>
                        </ul>
                    </li>
                    <% }%>
                </ul>

            </div>

        </nav>
        <!-- /. NAV SIDE  -->
      
		<div id="page-wrapper">
		  <div class="header"> 
                        <h1 class="page-header">
                            Dashboard <small>Welcome John Doe</small>
                        </h1>
						<ol class="breadcrumb">
					  <li><a href="#">Home</a></li>
					  <li><a href="#">Dashboard</a></li>
					  <li class="active">Data</li>
					</ol> 
									
		</div>
            <div id="page-inner">

		</div><!--/.row-->
		
         </div>
         <!-- /. ROW  -->
     </div>
     <!-- /. PAGE INNER  -->
    <script src="<%=basePath%>assets/js/jquery-1.10.2.js"></script>
    <!-- Bootstrap Js -->
    <script src="<%=basePath%>assets/js/bootstrap.min.js"></script>
	 
    <!-- Metis Menu Js -->
    <script src="<%=basePath%>assets/js/jquery.metisMenu.js"></script>
	<!-- Morris Chart Js -->
    <script src="<%=basePath%>assets/js/morris/raphael-2.1.0.min.js"></script>
    <script src="<%=basePath%>assets/js/morris/morris.js"></script>
	
	
	<script src="<%=basePath%>assets/js/easypiechart.js"></script>
	<script src="<%=basePath%>assets/js/easypiechart-data.js"></script>
	
	 <script src="<%=basePath%>assets/js/Lightweight-Chart/jquery.chart.js"></script>
	
	<!-- Custom Js -->
    <script src="<%=basePath%>assets/js/custom-scripts.js"></script>
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
</body>
</html>