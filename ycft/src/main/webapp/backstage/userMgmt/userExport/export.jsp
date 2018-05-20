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
<%@ taglib prefix="ex" uri="/WEB-INF/dict.tld"%>
<%@ taglib prefix="cs" uri="/WEB-INF/codeswitch.tld"%>
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
        <style>
    	.padding{
    		
    		padding:15px;
    	}
    </style>
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
                <a class="navbar-brand" href="<%=basePathNoBackstage %>jump.do"><strong>返回首页</strong></a>
				
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
                            	学生信息导入/出
                        </h1>
						<ol class="breadcrumb">
					  <li class="active">用户管理</li>
					  <li class="active">学生信息导入/出</li>
					</ol> 
		</div>
		<div class="row">
		<div class="col-md-12">
		    <!-- Advanced Tables -->
		<div class="panel panel-default">
	    <div class="panel-heading">
	    </div>
	     <div class="panel-body">
	     	<div>
	     	<div class="col-lg-3">
	     	<form action="<%=basePathNoBackstage%>importExcel.do" enctype="multipart/form-data" method="post" id="fileForm">
				 <div class="form-group">
                 	<a href="<%=basePathNoBackstage%>downloadDemo.do" class ="btn btn-success">模版下载</a> 
                 </div>
                 <div class="form-group">
                 	<input type="file" name="file" onclick="javascript:importFile()"  id="file" style="vertical-align:middle" >
                 </div>
                 <div class="form-group">
                 
                 	<input  type="button" class="btn btn-success" onclick="validFile()" value="导入" />
                 	<input type="button" class="btn btn-success" value="导出" onclick="exportFile()" />
                 	<input type="button" class="btn btn-success" value="单个学生录入" data-toggle="modal" data-target="#addUser"/>
                 </div>
			</form>
			</div>
			<div class="modal fade" id="addUser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">  
		        <div class="modal-content">  
		            <div class="modal-header">  
		                <button type="button" class="close" data-dismiss="modal" aria-label="Close">  
		                    <span aria-hidden="true">×</span>  
		                </button>  
		                <h4 class="modal-title" id="myModalLabel">学生信息详情</h4>  
		            </div>    
		             <form action="<%=basePathNoBackstage%>addOneUser.do" method="post">
		            <div class="modal-body">  
		            	<fieldset>
                    <div class="form-group padding">
                        <label class="col-sm-2 control-label" for="ds_host">姓名</label>
                        <div class="col-sm-4">
                           <input class="form-control" id="ds_host" type="text" name="sname"/>
                        </div>
                        <label class="col-sm-2 control-label" for="ds_name">学号</label>
                        <div class="col-sm-4">
                           <input class="form-control" id="ds_name" type="text" name="sno"/>
                        </div>
                     </div>
                     <div class="form-group padding">
                        <label class="col-sm-2 control-label" for="ds_host">密码</label>
                        <div class="col-sm-4">
                           <input class="form-control" id="ds_host" type="text" name="psd"/>
                        </div>
                        <label class="col-sm-2 control-label" for="ds_name">电话</label>
                        <div class="col-sm-4">
                           <input class="form-control" id="ds_name" type="text" name="tel"/>
                        </div>
                     </div>
                     <div class="form-group padding">
                        <label class="col-sm-2 control-label" for="ds_host">校区</label>
                        <div class="col-sm-4">
                           <input class="form-control" id="ds_host" type="text" name="school"/>
                        </div>
                        <label class="col-sm-2 control-label" for="ds_name">学院</label>
                        <div class="col-sm-4">
                           <ex:dict type="college"  name="college" classname="form-control" />
                        </div>
                     </div>
                     <div class="form-group padding">
                        <label class="col-sm-2 control-label" for="ds_host">系</label>
                        <div class="col-sm-4">
                           <ex:dict type="department"  name="department" classname="form-control" />
                        </div>
                        <label class="col-sm-2 control-label" for="ds_name">专业</label>
                        <div class="col-sm-4">
                           <ex:dict type="profession"  name="profession" classname="form-control" />
                        </div>
                     </div>
                    <div class="form-group padding">
                        <label class="col-sm-2 control-label" for="ds_host">班级</label>
                        <div class="col-sm-4">
                           <input class="form-control" id="ds_host" type="text" name="cls"/>
                        </div>
                     </div>
                    </fieldset>
            	</div>
             </form>
		            <div class="modal-footer">  
			            <button type="submit" class="btn btn-default">保存</button>
	                    <button type="reset" class="btn btn-default">重置</button>
		                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>  
		            </div>  
		 	</div>
	    </div>
	    </div>
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
        <script>
    	function importFile(){
    		alert("您将要导入excel文件,导入学员信息前请下载并阅读导入模版，格式不符将会导致导入失败.");
    	}
    	function exportFile(){
    		if(confirm('导出 全部学生信息吗?')){
    			document.getElementById("fileForm").action="<%=basePathNoBackstage%>exportExcel.do";
    			document.getElementById("fileForm").submit();
    		}
    	}
    	function validFile(){
    		var f_content = document.getElementById("file").value;  
   		    var fileext=f_content.substring(f_content.lastIndexOf("."),f_content.length);
   		    var filename =  f_content.substring(f_content.lastIndexOf("\\")+1,f_content.length);
   		    fileext=fileext.toLowerCase();
   		    if (fileext!='.xls' ){  
   		        alert("对不起，导入数据格式必须是xls格式文件哦，请您调整格式后重新上传，谢谢 ！");
   		        
   		    }else{
   		    	if(confirm('您将要导入 ['+filename+"] 文件?")){
   		    		//开始导入
   		    		alert("开始提交");
   		    		document.getElementById("fileForm").submit();
   		    	}
   		    }  
   		 
    	}
    
    </script>
</body>
</html>