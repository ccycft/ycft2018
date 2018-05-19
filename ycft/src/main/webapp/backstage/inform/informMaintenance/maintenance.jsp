<%@page import="com.ycft.ycft.system.Menu"%>
<%@page import="com.ycft.ycft.po.Privilege"%>
<%@page import="com.ycft.ycft.po.Title"%>
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
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- Bootstrap Styles-->
    <link href="<%=basePath%>assets/css/bootstrap.css" rel="stylesheet" />
     <!-- FontAwesome Styles-->
    <link href="<%=basePath%>assets/css/font-awesome.css" rel="stylesheet" />
    <!-- Custom Styles-->
    <link href="<%=basePath%>assets/css/custom-styles.css" rel="stylesheet" />
     <!-- Google Fonts-->
    <link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
     <!-- TABLE STYLES-->
    <link href="<%=basePath%>assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
	<!-- Summernot Styles -->
    <link rel="stylesheet" href="<%=basePath%>summernote/dist/summernote.css">

	<!-- jQuery Js -->
    <script src="<%=basePath%>assets/js/jquery-1.10.2.js"></script>
      <!-- Bootstrap Js -->
    <script src="<%=basePath%>assets/js/bootstrap.min.js"></script>
    <!-- Metis Menu Js -->
    <script src="<%=basePath%>assets/js/jquery.metisMenu.js"></script>
     <!-- DATA TABLE SCRIPTS -->
    <script src="<%=basePath%>assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="<%=basePath%>assets/js/dataTables/dataTables.bootstrap.js"></script>
    <!-- Summernot Js -->
    <script type="text/javascript" src="<%=basePath%>summernote/dist/summernote.js"></script>
     <!-- Custom Js -->
    <script src="<%=basePath%>assets/js/custom-scripts.js"></script>
        <script>
            $(document).ready(function () {
                $('#dataTables-example').dataTable();
            });
    </script>
    
    <script type="text/javascript">
    	function del(id,name){
    		if (confirm("您确认删除\""+name+"\"吗?")) {
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
	    		xmlhttp.open("post","informDel.do",true);
	    		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	    		xmlhttp.send("id="+id);
    		}
    	}
    
    </script>
    <script type="text/javascript">
    $(document).ready(function() {
    	$('.summernote').summernote({
            height: 300,
            lang: 'zh-CN',
            focus:true,
            toolbar: [
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']],
                ['insert', ['picture', 'video']]
            ],
            callbacks: {
                onImageUpload: function(files, editor, $editable) {
                    sendFile(files);
                }
            }
        });
    });
  //富文本编辑器
    function sendFile(files, editor, $editable) {
    	$(".note-toolbar.btn-toolbar").append('正在上传图片'); 
        var data = new FormData();
        data.append("file", files[0]);
        $.ajax({
            data : data,
            type : "POST",
            url : "../upload.do", //图片上传出来的url，返回的是图片上传后的路径，http格式
            cache : false,
            contentType : false,
            processData : false,
            success: function(data) {
                var newData=eval("("+data+")");
            $('.summernote').summernote('editor.insertImage', newData.path); 
            },
            error:function(){
                alert("上传失败");
            } 
        });
    } 
    function refer(){
    	var sHTML = $('.summernote').summernote('code');
    	  alert(sHTML);
    }
    
  </script>
    <style>
    	.form-group{
    		padding:15px;
    	
    	}
    </style>
<title>Insert title here</title>
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
</div>
<%
	List<Title> tList = (List<Title>)request.getAttribute("tList");
%>
<div id="page-wrapper" >
	<div class="header"> 
		<h1 class="page-header">
		    通知维护
		</h1>
		<ol class="breadcrumb">
			<li class="active">通知管理</li>
			<li class="active">通知维护</li>
		</ol> 
	</div>
	
	<div class="row">
		<div class="col-md-12">
		    <!-- Advanced Tables -->
		<div class="panel panel-default">
	    <div class="panel-heading">
	         	通知内容
	    </div>
	    <div class="panel-heading">
	        <input type="button" value="通知发布" class="btn btn-success" data-toggle="modal" data-target="#release" data-backdrop="static"/>
	    </div>
	    <!-- 发布的弹出层 -->
		<div class="modal fade" id="release" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
		    <div class="modal-dialog" role="document">  
		        <div class="modal-content" >  
		            <div class="modal-header">  
		                <button type="button" class="close" data-dismiss="modal" aria-label="Close">  
		                    <span aria-hidden="true">×</span>  
		                </button>  
		                <h4 class="modal-title" id="myModalLabel">通知内容发布</h4>  
		            </div>
		            <div class="modal-body">  
        				<fieldset>
	                       <div class="form-group">
							  <h4> <i class="note-icon-summernote"></i>编辑器
							      <span class="label label-info">编辑器版本3.0.7</span>
							      <span class="label label-success"></span>
						      </h4>
						      <div class="summernote"><p>开始编辑内容</p></div>
	                       </div>
	                    </fieldset>
		            </div>  
		            <div class="modal-footer">
		                <button type="button" class="btn btn-success" onclick="refer()">发布</button>  
		                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>  
		            </div>  
		        </div>  
		    </div>  
		</div>
	    <div class="panel-body">
	        <div class="table-responsive">
	            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
	                <thead>
	                    <tr>
	                        <th>标题</th>
	                        <th>发布时间</th>
	                        <th>作者名</th>
	                        <th>图片</th>
	                        <th>操作</th>
	                    </tr>
	                </thead>
	                <tbody>
	                <% for (int i=0; i<tList.size(); i++) {
	                %>
	                	<tr class="gradeA">
                            <td><%=tList.get(i).getName() %></td>
                            <td><%=tList.get(i).getTime() %></td>
                            <td><%=tList.get(i).getUser() %></td>
                            <td><%=tList.get(i).getImgName() %></td>
                            <td class="col-md-2">
                            	<input type="button" value="详情" class="btn btn-warning" data-toggle="modal" data-target="#details<%=tList.get(i).getId()%>"/>
                            	<input type="button" value="修改" class="btn btn-primary" data-toggle="modal" data-backdrop="static" data-target="#update<%=tList.get(i).getId()%>"/>
                            	<input type="button" value="删除" class="btn btn-danger" onclick="del('<%=tList.get(i).getId() %>','<%=tList.get(i).getName()%>')"/>
                            </td>
                        </tr>
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