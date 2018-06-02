<%@page import="com.ycft.ycft.po.Title"%>
<%@page import="com.ycft.ycft.po.SlideContent"%>
<%@page import="com.ycft.ycft.system.Menu"%>
<%@page import="com.ycft.ycft.po.Privilege"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
    		+ request.getServerName() + ":" + request.getServerPort()
    		+ path + "/backstage/";
    String basePathNoBackStage = request.getScheme() + "://"
    		+ request.getServerName() + ":" + request.getServerPort()
    		+ path + "/";
    %>
    <%
	List<Privilege> privilegeList = Menu.pList;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1.0">
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
<style type="text/css">
	.img-responsive {
		  display: inline-block;
		  height: auto;
		  max-width: 20%;
		}
</style>
</head>
<body>
<%
	List<SlideContent> scList = (List<SlideContent>)request.getAttribute("scList");
	List<Title> tList = (List<Title>)request.getAttribute("tList");
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
			</li>
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
	    </ul>
	</nav>
  	<nav class="navbar-default navbar-side" role="navigation">
	    <div class="sidebar-collapse">
	        <ul class="nav" id="main-menu">
	            <%for(int i = 0;i<privilegeList.size();i++){
	            	%>
	            	<li id="<%=privilegeList.get(i).getId()%>">
	                <a href="#"><%=privilegeList.get(i).getIcon()%><span id="sp<%=privilegeList.get(i).getId()%>"><%=privilegeList.get(i).getmName() %></span><span class="fa arrow"></span></a>
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
			<h1 class="page-header">
			    广告窗管理
			</h1>
			<ol class="breadcrumb">
				<li class="active">广告窗管理</li>
				<li class="active">广告窗维护</li>
			</ol> 
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
				    <div class="panel-heading">
				         	广告窗信息
				    </div>
				    <div class="panel-body">
				        <div class="table-responsive">
				            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
				                <thead>
				                    <tr>
		                   		 		<th>发布时间</th>
				                        <th>轮播图</th>
				                        <th>操作</th>
				                    </tr>
				                </thead>
				                <tbody>
				                	<%
				                	for (int i = 0; i < scList.size(); i++) {
				                	%>
				                	<tr class="gradeA">
			                            <td class="col-md-4"><%=scList.get(i).getTime() %></td>
			                            <td class="col-md-4"><img class="img-responsive" src="http://localhost:8080/photo/<%=scList.get(i).getName() %>"/></td>
			                            <td class="col-md-4">
			                            	<input type="button" value="内容详情" class="btn btn-warning" data-toggle="modal" data-target="#details<%=scList.get(i).getId()%>"/>
			                            	<input type="button" value="修改" class="btn btn-primary" data-toggle="modal" data-backdrop="static" data-target="#update<%=scList.get(i).getId()%>"/>
			                            </td>
			                        </tr>
			                        <!-- 详情的弹出层 -->
									<div class="modal fade" id="details<%=scList.get(i).getId()%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
									    <div class="modal-dialog" role="document">  
									        <div class="modal-content">  
									            <div class="modal-header">  
									                <button type="button" class="close" data-dismiss="modal" aria-label="Close">  
									                    <span aria-hidden="true">×</span>  
									                </button>  
									                <h4 class="modal-title" id="myModalLabel">文章内容</h4>  
									            </div>  
									            <div class="modal-body">  
									            	<fieldset>
								                       <div class="row">
								                       		<div class="col-xs-11">
								                       			<%=scList.get(i).getText() %>
								                       		</div>
								                       </div>
								                    </fieldset>
									            </div>  
									            <div class="modal-footer">  
									                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>  
									            </div>  
									        </div>  
									    </div>  
									</div>
									<!-- 修改的弹出层 -->
									<div class="modal fade" id="update<%=scList.get(i).getId()%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
									    <div class="modal-dialog" role="document">  
									        <div class="modal-content">  
									            <div class="modal-header">  
									                <button type="button" class="close" data-dismiss="modal" aria-label="Close">  
									                    <span aria-hidden="true">×</span>  
									                </button>  
									                <h4 class="modal-title" id="myModalLabel">广告窗修改</h4>  
									            </div>
									            <form action="uploadAdvertisingWindow.do" method="post" id="updateForm" enctype="multipart/form-data"> 
										            <input type="hidden" name="id" value="<%=scList.get(i).getId()%>"/>
										            <div class="modal-body">  
										            	<fieldset>
									                       <div class="form-group">
									                          <label class="col-sm-2 control-label" for="ds_host">轮播图</label>
									                          <div class="col-sm-4">
									                             <input type="file" name="titleFile" class="form-control"  id="titleFile" onchange="preview(this)">
									                          </div>
							                       			  <label class="col-sm-2 control-label" for="ds_host">文章名</label>
							                       			  <div class="col-sm-4">
							                       				  <select class="form-control" name="cid">
							                       				   	  <option value="0">不选则不修改</option>
							                       				  <%
							                       					  for (int j = 0; j < tList.size(); j++) {
							                       				  %>
							                       					  <option value="<%=tList.get(j).getId()%>"><%=tList.get(j).getName() %></option>
							                       				  <%		
							                       					  }
							                       				  %>
							                       				  </select>
								                          	  </div>
									                       </div>
									                    </fieldset>
										            </div>  
										            <div class="modal-footer">  
										                <button type="submit" class="btn btn-info" onclick="return check()">保存</button>  
										                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>  
										            </div>
									            </form>  
									        </div>  
									    </div>  
									</div>
			                        <%	
				                	}
				                	%>
				                </tbody>
				    		</table>
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
	//控制图片宽度
	var width  = $(".modal-dialog").width() + $(".modal-body").width();
	$(".col-xs-11").find("img").width(width);
</script>
</body>
</html>