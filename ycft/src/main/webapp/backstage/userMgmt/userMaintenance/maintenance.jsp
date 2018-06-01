<%@page import="com.ycft.ycft.po.Role"%>
<%@page import="com.ycft.ycft.po.Privilege"%>
<%@page import="com.ycft.ycft.system.Menu"%>
<%@page import="java.util.List"%>
<%@page import="com.ycft.ycft.po.User"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
        <script>
            $(document).ready(function () {
                $('#dataTables-example').dataTable();
            });
    </script>
    
    <script type="text/javascript">
    	function del(id,name){
    		if (confirm("您确认删除"+name+"吗?")) {
    			var xmlhttp = new XMLHttpRequest();
	    		xmlhttp.onreadystatechange = function(){
	    			if(xmlhttp.readyState == 4){
	    				var data= xmlhttp.responseText;
	    				if (data == 1) {
	    					alert("删除成功！");
	    					document.location.reload();
	    				} else {
	    					alert("删除失败！");
	    	    		}
	    			}
	    		};
	    		xmlhttp.open("post","userDel.do",true);
	    		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	    		xmlhttp.send("id="+id);
    		}
    	}
    
    </script>
    <style>
    	.form-group{
    		
    		padding:15px;
    	
    	}
    
    </style>
    
    <script type="text/javascript">
    function check(){
    	var password = $("#password").val().trim();
    	var repassword  = $("#repassword").val().trim(); 
    	if (password != repassword) {
    		alert("两次密码不一致！");
    		$("#password").focus();
    		return false;
  	  }
    }
    </script>
    <script type="text/javascript">
    	function load(){
    		document.getElementById("dataTables-example_paginate").onclick=function(){
    			timer=setInterval(function(){
                  var scrollTop=document.documentElement.scrollTop||document.body.scrollTop;
                  var ispeed=Math.floor(-scrollTop/6);
                  if(scrollTop==0){
                      clearInterval(timer);
                  }
                  document.documentElement.scrollTop=document.body.scrollTop=scrollTop+ispeed;
               },0)
    		}
    	}
   </script>
<title>Insert title here</title>
</head>
<body onload="load()">
<%
	List<User> uList = (List<User>)request.getAttribute("uList");
	List<Role> rList = (List<Role>)request.getAttribute("rList");
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
<div id="page-wrapper" >
	<div class="header"> 
		<h1 class="page-header">
		    用户管理
		</h1>
		<ol class="breadcrumb">
			<li class="active">用户管理</li>
			<li class="active">用户维护</li>
		</ol> 
	</div>
	
	<div class="row">
		<div class="col-md-12">
		    <!-- Advanced Tables -->
		<div class="panel panel-default">
	    <div class="panel-heading">
	         	用户信息
	    </div>
	    <div class="panel-body">
	        <div class="table-responsive">
	            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
	                <thead>
	                    <tr>
	                        <th>学号</th>
	                        <th>电话</th>
	                        <th>专业</th>
	                        <th>姓名</th>
	                        <th>操作</th>
	                    </tr>
	                </thead>
	                <tbody>
	                <% for (int i=0; i<uList.size(); i++) {
	                %>
	                	<tr class="gradeA">
                            <td class="col-md-2"><%=uList.get(i).getSno() %></td>
                            <td class="col-md-2"><%=uList.get(i).getTel() %></td>
                            <td class="col-md-2"><%=uList.get(i).getProfession() %></td>
                            <td class="col-md-2"><%=uList.get(i).getSname() %></td>
                            <td class="col-md-2">
                            	<input type="button" value="详情" class="btn btn-warning" data-toggle="modal" data-target="#details<%=uList.get(i).getId()%>"/>
                            	<input type="button" value="修改" class="btn btn-primary" data-toggle="modal" data-backdrop="static" data-target="#update<%=uList.get(i).getId()%>"/>
                            	<input type="button" value="删除" class="btn btn-danger" onclick="del('<%=uList.get(i).getId() %>','<%=uList.get(i).getSname()%>')"/>
                            </td>
                        </tr>
                        <!-- 详情的弹出层 -->
						<div class="modal fade" id="details<%=uList.get(i).getId()%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
						    <div class="modal-dialog" role="document">  
						        <div class="modal-content">  
						            <div class="modal-header">  
						                <button type="button" class="close" data-dismiss="modal" aria-label="Close">  
						                    <span aria-hidden="true">×</span>  
						                </button>  
						                <h4 class="modal-title" id="myModalLabel">学生信息详情</h4>  
						            </div>  
						            <div class="modal-body">  
						            	<fieldset>
					                       <div class="form-group">
					                          <label class="col-sm-2 control-label" for="ds_host">姓名</label>
					                          <div class="col-sm-4">
					                             <input class="form-control" id="ds_host" type="text" value="<%=uList.get(i).getSname() %>"/>
					                          </div>
					                          <label class="col-sm-2 control-label" for="ds_name">学号</label>
					                          <div class="col-sm-4">
					                             <input class="form-control" id="ds_name" type="text" value="<%=uList.get(i).getSno() %>"/>
					                          </div>
					                       </div>
					                       <div class="form-group">
					                          <label class="col-sm-2 control-label" for="ds_host">电话</label>
					                          <div class="col-sm-4">
					                             <input class="form-control" id="ds_host" type="text" value="<%=uList.get(i).getTel() %>"/>
					                          </div>
					                          <label class="col-sm-2 control-label" for="ds_name">校区</label>
					                          <div class="col-sm-4">
					                             <input class="form-control" id="ds_name" type="text" value="<%=uList.get(i).getSchool() %>"/>
					                          </div>
					                       </div>
					                       <div class="form-group">
					                          <label class="col-sm-2 control-label" for="ds_host">学院</label>
					                          <div class="col-sm-4">
					                             <input class="form-control" id="ds_host" type="text" value="<%=uList.get(i).getCollege() %>"/>
					                          </div>
					                          <label class="col-sm-2 control-label" for="ds_name">系</label>
					                          <div class="col-sm-4">
					                             <input class="form-control" id="ds_name" type="text" value="<%=uList.get(i).getDepartment() %>"/>
					                          </div>
					                       </div>
					                       <div class="form-group">
					                          <label class="col-sm-2 control-label" for="ds_host">专业</label>
					                          <div class="col-sm-4">
					                             <input class="form-control" id="ds_host" type="text" value="<%=uList.get(i).getProfession() %>"/>
					                          </div>
					                          <label class="col-sm-2 control-label" for="ds_name">班级</label>
					                          <div class="col-sm-4">
					                             <input class="form-control" id="ds_name" type="text" value="<%=uList.get(i).getCls() %>"/>
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
						<div class="modal fade" id="update<%=uList.get(i).getId()%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
						    <div class="modal-dialog" role="document">  
						        <div class="modal-content">  
						            <div class="modal-header">  
						                <button type="button" class="close" data-dismiss="modal" aria-label="Close">  
						                    <span aria-hidden="true">×</span>  
						                </button>  
						                <h4 class="modal-title" id="myModalLabel">学生信息修改</h4>  
						            </div>
						            <form action="update.do" method="post" id="updateForm"> 
						            	<input type="hidden" name="id" value="<%=uList.get(i).getId() %>"/>  
							            <div class="modal-body">  
							            	<fieldset>
						                       <div class="form-group">
						                          <label class="col-sm-2 control-label" for="ds_host">姓名</label>
						                          <div class="col-sm-4">
						                             <input class="form-control" id="ds_host" type="text" value="<%=uList.get(i).getSname() %>" name="sname"/>
						                          </div>
						                          <label class="col-sm-2 control-label" for="ds_name">学号</label>
						                          <div class="col-sm-4">
						                             <input class="form-control" id="ds_name" type="text" value="<%=uList.get(i).getSno() %>" name="sno"/>
						                          </div>
						                       </div>
						                       <div class="form-group">
						                          <label class="col-sm-2 control-label" for="ds_host">修改密码</label>
						                          <div class="col-sm-4">
						                             <input class="form-control" id="password" type="password" placeholder="不填则不修改"  name="psd"/>
						                          </div>
						                          <label class="col-sm-2 control-label" for="ds_name">确认密码</label>
						                          <div class="col-sm-4">
						                             <input class="form-control" id="repassword" type="password" placeholder="不填则不修改"/>
						                          </div>
					                       	   </div>
						                       <div class="form-group">
						                          <label class="col-sm-2 control-label" for="ds_host">电话</label>
						                          <div class="col-sm-4">
						                             <input class="form-control" id="ds_host" type="text" value="<%=uList.get(i).getTel() %>" name="tel"/>
						                          </div>
						                          <label class="col-sm-2 control-label" for="ds_name">校区</label>
						                          <div class="col-sm-4">
						                             <input class="form-control" id="ds_name" type="text" value="<%=uList.get(i).getSchool() %>" name="school"/>
						                          </div>
						                       </div>
						                       <div class="form-group">
						                          <label class="col-sm-2 control-label" for="ds_host">学院</label>
						                          <div class="col-sm-4">
						                          	<ex:dict type="college"  name="college" defaultvalue="<%=uList.get(i).getCollege() %>" classname="form-control" />
						                          </div>
						                          <label class="col-sm-2 control-label" for="ds_name">系</label>
						                          <div class="col-sm-4">
						                             <ex:dict type="department"  name="department" defaultvalue="<%=uList.get(i).getDepartment() %>" classname="form-control" />
						                          </div>
						                       </div>
						                       <div class="form-group">
						                          <label class="col-sm-2 control-label" for="ds_host">专业</label>
						                          <div class="col-sm-4">
						                          	 <ex:dict type="profession" name="profession" defaultvalue="<%=uList.get(i).getProfession() %>" classname="form-control" />
						                          </div>
						                          <label class="col-sm-2 control-label" for="ds_name">班级</label>
						                          <div class="col-sm-4">
						                             <input class="form-control" id="ds_name" type="text" value="<%=uList.get(i).getCls() %>" name="cls"/>
						                          </div>
						                       </div>
						                       <div class="form-group">
					                       			<label class="col-sm-2 control-label" for="ds_host">角色权限</label>
					                       			<div class="col-sm-4">
					                       				<select class="form-control" name="rname">
					                       					<option>不选则不修改</option>
					                       				<%
					                       					for (int j = 0; j < rList.size(); j++) {
					                       				%>
					                       					<option><%=rList.get(j).getRname() %></option>
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
						</form>
	                <%	
	                }%>
	                </tbody>
	            </table>
	        </div>
	    </div>
	</div>
	<!--End Advanced Tables -->
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
</body>
</html>