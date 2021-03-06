<%@page import="java.util.List"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>用户导入/出</title>
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
     <link rel="stylesheet" href="<%=basePath%>css/style.css">
    <script src="<%=basePath%>assets/js/jquery-1.10.2.js"></script>
    <!-- Bootstrap Js -->
    <script src="<%=basePath%>assets/js/bootstrap.min.js"></script>
    <script src="<%=basePath%>assets/js/morris/raphael-2.1.0.min.js"></script>
    <script src="<%=basePath%>assets/js/morris/morris.js"></script>
	
	
	<script src="<%=basePath%>assets/js/easypiechart.js"></script>
	<script src="<%=basePath%>assets/js/easypiechart-data.js"></script>
	
	 <script src="<%=basePath%>assets/js/Lightweight-Chart/jquery.chart.js"></script>
	
	<!-- Custom Js -->
    <script src="<%=basePath%>assets/js/custom-scripts.js"></script>
    <script src="<%=basePath%>assets/js/jquery.metisMenu.js"></script>
    <link rel="stylesheet" href="<%=basePath %>assets/js/Lightweight-Chart/cssCharts.css">
   	<script src="<%=basePath%>assets/js/morris/raphael-2.1.0.min.js"></script>
	<script src="<%=basePath%>assets/js/morris/morris.js"></script>
	<script src="<%=basePath%>assets/js/easypiechart.js"></script>
	<script src="<%=basePath%>assets/js/easypiechart-data.js"></script>
	<script src="<%=basePath%>assets/js/Lightweight-Chart/jquery.chart.js"></script>
	 <script src="<%=basePath %>assets/bootstrapValidator/bootstrapValidator.min.js"></script>
<link href="<%=basePath %>assets/bootstrapValidator/bootstrapValidator.min.css" rel="stylesheet"/>
	
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
		xmlhttp.open("post","<%=basePath %>privilege.do",true);
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp.send("");
   	}
   	$(document).ready(function(){
		loadMenu();
   	});
    </script>
    <script type="text/javascript">
    $(function () {
        $('#addOneUser').bootstrapValidator({
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
                }
            }
        });
    });
    </script>
    <script type="text/javascript">
         var isCommitted = false;//表单是否已经提交标识，默认为false
         function dosubmit(){
             if(isCommitted==false){
                 isCommitted = true;//提交表单后，将表单是否已经提交标识设置为true
                 return true;//返回true让表单正常提交
             }else{
                 return false;//返回false那么表单将不提交
             }
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
             <a class="navbar-brand logout" href="<%=basePathNoBackStage %>logOut.do">注       销</a>
		<div id="sideNav" href=""><i class="fa fa-caret-right"></i></div>
            </div>
        </nav>
        <!--/. NAV TOP  -->
        <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
                </ul>

            </div>

        </nav>
        <!-- /. NAV SIDE  -->
      
		<div id="page-wrapper">
		  <div class="header"> 
                        <h1 class="page-header">
                            	用户信息导入/出
                        </h1>
						<ol class="breadcrumb">
					  <li class="active">用户管理</li>
					  <li class="active">用户信息导入/出</li>
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
	     	<form action="" enctype="multipart/form-data" method="post" id="fileForm">
				 <div class="form-group">
                 	<a href="<%=basePath %>downloadDemo.do" class ="btn btn-success">模版下载</a> 
                 </div>
                 <div class="row">
                 <label class="col-sm-4 control-label" for="ds_host">请先选择</label>
                 	<div class="form-group col-sm-4">
                 		<input type="file" name="file" onclick="javascript:importFile()"  id="file" style="vertical-align:middle" >
       				</div>
                 </div>
                 <div class="form-group">
                 
                 	<input  type="button" class="btn btn-success" onclick="validFile()" value="导入" />
                 	<input type="button" class="btn btn-success" value="导出" onclick="exportFile()" />
                 	<input type="button" class="btn btn-success" value="单个用户录入" data-toggle="modal" data-target="#addUser"/>
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
		                <h4 class="modal-title" id="myModalLabel">用户信息添加</h4>  
		            </div>    
		           <form action="<%=basePath %>addOneUser.do" method="post" id="addOneUser" onsubmit="dosubmit()">
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
		        				<label class="col-sm-2 control-label" for="ds_host">密码</label>
		        				<div class="form-group col-sm-4">
		        					<input class="form-control" id="psd" type="text" name="psd"/>
		        				</div>
		        			</div>
		        			<div>
		        				<label class="col-sm-2 control-label" for="ds_name">电话</label>
		        				<div class="form-group col-sm-4">
		        					 <input class="form-control" id="tel" type="text" name="tel"/>
		        				</div>
		        			</div>
	        			</div>
		            	<div class="row">
		        			<div>
		        				<label class="col-sm-2 control-label" for="ds_host">校区</label>
		        				<div class="form-group col-sm-4">
		        					<input class="form-control" id="school" type="text" name="school"/>
		        				</div>
		        			</div>
		        			<div>
		        				<label class="col-sm-2 control-label" for="ds_name">学院</label>
		        				<div class="form-group col-sm-4">
		        					 <ex:dict type="college"  name="college" classname="form-control" />
		        				</div>
		        			</div>
	        			</div>
		            	<div class="row">
		        			<div>
		        				<label class="col-sm-2 control-label" for="ds_host">系</label>
		        				<div class="form-group col-sm-4">
		        					<ex:dict type="department"  name="department" classname="form-control" />
		        				</div>
		        			</div>
		        			<div>
		        				<label class="col-sm-2 control-label" for="ds_name">专业</label>
		        				<div class="form-group col-sm-4">
		        					 <ex:dict type="profession"  name="profession" classname="form-control" />
		        				</div>
		        			</div>
	        			</div>
		            	<div class="row">
		        			<div>
		        				<label class="col-sm-2 control-label" for="ds_host">班级</label>
		        				<div class="form-group col-sm-4">
		        					<input class="form-control" id="cls" type="text" name="cls"/>
		        				</div>
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
        </div>
     </div>
     
 </div>  
	 

	
<script type="text/javascript">
    	function importFile(){
    		alert("您将要导入excel文件,导入学员信息前请下载并阅读导入模版，格式不符将会导致导入失败.");
    	}
    	function exportFile(){
    		if(confirm('导出 全部用户信息吗?')){
    			dosubmit();
    			document.getElementById("fileForm").action="<%=basePath %>exportExcel.do";
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
   		    		dosubmit();
   		    		document.getElementById("fileForm").action="<%=basePath %>importExcel.do";
   		    		document.getElementById("fileForm").submit();
   		    	}
   		    }  
   		 
    	}
   	</script>
	</body>
</html>