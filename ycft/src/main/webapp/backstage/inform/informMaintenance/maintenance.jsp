<%@page import="com.ycft.ycft.po.Title"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/"+"backstage/";
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
	<link rel="stylesheet" href="../../assets/css/bootstrap.css" />
    <link rel="stylesheet" href="../../summernote/dist/summernote.css">

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
        <script>
            $(document).ready(function () {
                $('#dataTables-example').dataTable();
            });
    </script>
         <!-- Custom Js -->
    <script src="assets/js/custom-scripts.js"></script>
    
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
    <style>
    	.form-group{
    		
    		padding:15px;
    	
    	}
    
    </style>
<title>Insert title here</title>
</head>
<body>
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
	                             <input class="form-control" id="ds_host" type="text" />
	                          </div>
	                          <label class="col-sm-2 control-label" for="ds_name">学号</label>
	                          <div class="col-sm-4">
	                             <input class="form-control" id="ds_name" type="text" />
	                          </div>
	                       </div>
	                       <div class="form-group">
	                          <label class="col-sm-2 control-label" for="ds_host">电话</label>
	                          <div class="col-sm-4">
	                             <input class="form-control" id="ds_host" type="text" />
	                          </div>
	                          <label class="col-sm-2 control-label" for="ds_name">校区</label>
	                          <div class="col-sm-4">
	                             <input class="form-control" id="ds_name" type="text" />
	                          </div>
	                       </div>
	                       <div class="form-group">
	                          <label class="col-sm-2 control-label" for="ds_host">学院</label>
	                          <div class="col-sm-4">
	                             <input class="form-control" id="ds_host" type="text" />
	                          </div>
	                          <label class="col-sm-2 control-label" for="ds_name">系</label>
	                          <div class="col-sm-4">
	                             <input class="form-control" id="ds_name" type="text" />
	                          </div>
	                       </div>
	                       <div class="form-group">
	                          <label class="col-sm-2 control-label" for="ds_host">专业</label>
	                          <div class="col-sm-4">
	                             <input class="form-control" id="ds_host" type="text" />
	                          </div>
	                          <label class="col-sm-2 control-label" for="ds_name">班级</label>
	                          <div class="col-sm-4">
	                             <input class="form-control" id="ds_name" type="text" />
	                          </div>
	                       </div>
	                    </fieldset>
		            </div>  
		            <div class="modal-footer">  
		                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
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
</body>
</html>