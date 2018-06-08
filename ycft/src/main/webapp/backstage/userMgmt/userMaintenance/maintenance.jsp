<%@page import="com.ycft.ycft.po.Role"%>
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
	String basePathNoBackStage = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
    <script src="<%=basePath %>assets/bootstrapValidator/bootstrapValidator.min.js"></script>
<link href="<%=basePath %>assets/bootstrapValidator/bootstrapValidator.min.css" rel="stylesheet"/>
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
               },0);
    		}
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
    <script type="text/javascript">
    	function update(id,sname,sno,tel,school,college,department,profession,cls){
    		document.getElementById("updateForm").reset();
    		$("#id").attr("value",id);
    		$("#sname").attr("value",sname);
    		$("#sno").attr("value",sno);
    		$("#tel").attr("value",tel);
    		$("#school").attr("value",school);
    		$("#cls").attr("value",cls);
    	}
    
    </script>
    <script type="text/javascript">
    $(function () {
        $('#updateForm').bootstrapValidator({
            fields: {
            	sname: {
                	message: '姓名验证失败',
                    validators: {
                        notEmpty: {
                            message: '姓名不能为空'
                        },
                        stringLength: {
                        	min: 1,
                        	max: 10,
                        	message: '姓名长度必须在1到10位之间'
                        }
                    }
                },
                sno: {
                    message: '学号验证失败',
                    validators: {
                        notEmpty: {
                            message: '学号不能为空'
                        },
                        regexp: {
                        	regexp: /^[0-9]+$/,
                        	message: '学号只能为数字'
                        }
                    }
                },
                tel: {
                    message: '电话验证失败',
                    validators: {
                        notEmpty: {
                            message: '电话不能为空'
                        },
                        stringLength: {
                        	min: 11,
                        	max: 11,
                        	message: '请输入11位手机号'
                        },
                        digits: {
                        	message: '电话只能为数字'
                        }
                    }
                },
                psd: {
                	message: '密码验证失败',
                	validators: {
                		regexp: {
                            regexp: /^[a-zA-Z0-9_\.]+$/,
                            message: '密码只能由字母，数字，圆点和下划线组成'
                        }
                	}
                },
                confirmPsd: {
                	message: '确认密码严重失败',
                	validators: {
                		identical: {
                            field: 'psd',
                            message: '两次密码不一致'
                        }
                	}
                }
            }
        });
    });
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
                            	<input type="button" value="修改" class="btn btn-primary" data-toggle="modal" data-backdrop="static" data-target="#updateModal" 
                            	onclick="update('<%=uList.get(i).getId() %>','<%=uList.get(i).getSname() %>',
                            	'<%=uList.get(i).getSno() %>','<%=uList.get(i).getTel() %>',
                            	'<%=uList.get(i).getSchool() %>','<%=uList.get(i).getCollege() %>',
                            	'<%=uList.get(i).getDepartment() %>','<%=uList.get(i).getProfession() %>',
                            	'<%=uList.get(i).getCls() %>')"/>
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
<!-- 修改的弹出层 -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
<div class="modal-dialog" role="document">  
    <div class="modal-content">  
        <div class="modal-header">  
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">  
                <span aria-hidden="true">×</span>  
            </button>  
            <h4 class="modal-title" id="myModalLabel">学生信息修改</h4>  
        </div>
        <form action="update.do" method="post" id="updateForm"> 
        	<input type="hidden" name="id" id="id"/>  
        <div class="modal-body">  
        	<fieldset>
        		<div class="row">
        			<div>
        				<label class="col-sm-2 control-label" for="ds_host">姓名</label>
        				<div class="form-group col-sm-4">
        					<input class="form-control" id="sname" type="text" name="sname"/>
        				</div>
        			</div>
        			<div>
        				<label class="col-sm-2 control-label" for="ds_name">学号</label>
        				<div class="form-group col-sm-4">
        					<input class="form-control" id="sno" type="text" name="sno"/>
        				</div>
        			</div>
        		</div>
        		<div class="row">
        			<div>
        				<label class="col-sm-2 control-label" for="ds_host">修改密码</label>
        				<div class="form-group col-sm-4">
        					<input class="form-control" id="password" type="password" placeholder="不填则不修改"  name="psd"/>
        				</div>
        			</div>
        			<div>
        				<label class="col-sm-2 control-label" for="ds_name">确认密码</label>
        				<div class="form-group col-sm-4">
        					<input class="form-control" id="repassword" type="password" placeholder="不填则不修改" name="confirmPsd"/>
        				</div>
        			</div>
        		</div>
        		<div class="row">
        			<div>
        				<label class="col-sm-2 control-label" for="ds_host">电话</label>
        				<div class="form-group col-sm-4">
        					<input class="form-control" id="tel" type="text" name="tel"/>
        				</div>
        			</div>
        			<div>
        				<label class="col-sm-2 control-label" for="ds_name">校区</label>
        				<div class="form-group col-sm-4">
        					 <input class="form-control" id="school" type="text" name="school"/>
        				</div>
        			</div>
        		</div>
        		<div class="row">
        			<div>
        				<label class="col-sm-2 control-label" for="ds_host">学院</label>
        				<div class="form-group col-sm-4">
        					<ex:dict type="college"  name="college" id="college" defaultvalue="不选则不修改" classname="form-control" />
        				</div>
        			</div>
        			<div>
        				<label class="col-sm-2 control-label" for="ds_name">系</label>
        				<div class="form-group col-sm-4">
        					 <ex:dict type="department" id="department" defaultvalue="不选则不修改" name="department" classname="form-control" />
        				</div>
        			</div>
        		</div>
        		<div class="row">
        			<div>
        				<label class="col-sm-2 control-label" for="ds_host">专业</label>
        				<div class="form-group col-sm-4">
        					<ex:dict type="profession" id="profession" defaultvalue="不选则不修改" name="profession" classname="form-control" />
        				</div>
        			</div>
        			<div>
        				<label class="col-sm-2 control-label" for="ds_name">班级</label>
        				<div class="form-group col-sm-4">
        					 <input class="form-control" id="cls" type="text" name="cls"/>
        				</div>
        			</div>
        		</div>
        		<div class="row">
        			<div>
        				<label class="col-sm-2 control-label" for="ds_host">角色权限</label>
        				<div class="form-group col-sm-4">
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