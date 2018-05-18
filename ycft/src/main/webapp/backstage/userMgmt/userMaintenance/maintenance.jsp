<%@page import="java.util.List"%>
<%@page import="com.ycft.ycft.po.User"%>
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
        <script>
            $(document).ready(function () {
                $('#dataTables-example').dataTable();
            });
    </script>
         <!-- Custom Js -->
    <script src="assets/js/custom-scripts.js"></script>
    
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
<title>Insert title here</title>
</head>
<body>
<%
	List<User> uList = (List<User>)request.getAttribute("uList");
%>
<div id="page-wrapper" >
	<div class="header"> 
		<h1 class="page-header">
		    用户维护
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
                            <td><%=uList.get(i).getSno() %></td>
                            <td><%=uList.get(i).getTel() %></td>
                            <td><%=uList.get(i).getProfession() %></td>
                            <td><%=uList.get(i).getSname() %></td>
                            <td class="col-md-2">
                            	<input type="button" value="详情" class="btn btn-warning" data-toggle="modal" data-target="#details<%=uList.get(i).getId()%>"/>
                            	<input type="button" value="修改" class="btn btn-primary" data-toggle="modal" data-target="#update<%=uList.get(i).getId()%>"/>
                            	<input type="button" value="删除" class="btn btn-danger" onclick="del('<%=uList.get(i).getId() %>','<%=uList.get(i).getSname()%>')"/>
                            </td>
                        </tr>
                        <!-- 删除的弹出层 -->
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
						                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
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
						            <form action="update.do" method="post"> 
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
						                             <input class="form-control" id="ds_host" type="text" value="<%=uList.get(i).getCollege() %>" name="college"/>
						                          </div>
						                          <label class="col-sm-2 control-label" for="ds_name">系</label>
						                          <div class="col-sm-4">
						                             <input class="form-control" id="ds_name" type="text" value="<%=uList.get(i).getDepartment() %>" name="department"/>
						                          </div>
						                       </div>
						                       <div class="form-group">
						                          <label class="col-sm-2 control-label" for="ds_host">专业</label>
						                          <div class="col-sm-4">
						                             <input class="form-control" id="ds_host" type="text" value="<%=uList.get(i).getProfession() %>" name="profession"/>
						                          </div>
						                          <label class="col-sm-2 control-label" for="ds_name">班级</label>
						                          <div class="col-sm-4">
						                             <input class="form-control" id="ds_name" type="text" value="<%=uList.get(i).getCls() %>" name="cls"/>
						                          </div>
						                       </div>
						                    </fieldset>
							            </div>  
							            <div class="modal-footer">  
							                <button type="submit" class="btn btn-info">保存</button>  
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
</body>
</html>