<%@page import="com.ycft.ycft.system.LoadDomain"%>
<%@page import="com.ycft.ycft.po.TitleContent"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>活动维护</title>
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
    <!-- Summernot Js -->
    <script type="text/javascript" src="<%=basePath%>summernote/dist/summernote.js"></script>
     <!-- Custom Js -->
    <script src="<%=basePath%>assets/js/custom-scripts.js"></script>
        <script>
            $(document).ready(function () {
                $('#dataTables-example').dataTable();
            });
            //上传标题图片预览
            function preview(file) {
                var prevDiv = document.getElementById('preview');
                if (file.files && file.files[0]) {
                  var reader = new FileReader();
                  reader.onload = function(evt) {
                    prevDiv.innerHTML = '<img src="' + evt.target.result + '" style="width:40px;height:40px;"/>';
                  }
                  reader.readAsDataURL(file.files[0]);
                }
             }
    </script>
    
    <script type="text/javascript">
    	function del(id,name){
    		if (confirm("您确认删除\""+name+"\"吗?")) {
    			window.location.href = "<%=basePath%>activityDel.do?id="+id;
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
            url : "<%=basePath%>upload.do", //图片上传出来的url，返回的是图片上传后的路径，http格式
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
    	dosubmit();
    	document.getElementById("contentId").value=sHTML;
    	document.getElementById("addInform").submit();
    }
    function validFile(id){
		var f_content = document.getElementById("fileEntry"+id).value;  
	    var fileext=f_content.substring(f_content.lastIndexOf("."),f_content.length);
	    var filename =  f_content.substring(f_content.lastIndexOf("\\")+1,f_content.length);
	    fileext=fileext.toLowerCase();
	    if (fileext!='.xls' ){  
	        alert("对不起，导入数据格式必须是xls格式文件哦，请您调整格式后重新上传，谢谢 ！");
	        
	    }else{
	    	alert("请仔细核对学号，如若错误则无法导入！");
	    	if(confirm('您将要导入 ['+filename+"] 文件?")){
	    		dosubmit();
	    		//开始导入
	    		document.getElementById("fileForm"+id).action="<%=basePath%>importActivityExcel.do";
	    		document.getElementById("fileForm"+id).submit();
	    	} else {
	    		return false;
	    	}
	    }  
	}
    
    function exportFile(id){
		if(confirm('导出 全部学生信息吗?')){
			document.getElementById("fileForm"+id).action="<%=basePath%>exportActivityExcel.do";
			document.getElementById("fileForm"+id).submit();
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
		xmlhttp.open("post","<%=basePath%>privilege.do",true);
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp.send("");
   	}
   	$(document).ready(function(){
		loadMenu();
   	});
    </script>
    <style>
    	.form-group{
    		padding:15px;
    	}
    	fieldset{
    		border:0 none;
    		padding:0;
    	}
    	.img-responsive{
    		display:inline-block;
    		height:auto;
    		max-width:20%;
    	}
    </style>
    <script type="text/javascript">
    	function update(id){
    		window.open("<%=basePath%>activityUpdate.do?id="+id);
    	}
    	function filter(id){
    	    var html=$($("#test"+id).val());
    	    $("#test"+id).val(html.text());
    	    $("#remove"+id).removeAttr("onclick");
    	}
    </script>
    <script type="text/javascript">
    	function cTop(){
    		var scrollTop=document.documentElement.scrollTop||document.body.scrollTop;
			if (scrollTop==0) {
				document.documentElement.scrollTop=document.body.scrollTop=15;
    		}
    		timer=setInterval(function(){
                var scrollTop=document.documentElement.scrollTop||document.body.scrollTop;
                var ispeed=Math.floor(-scrollTop/6);
                if(scrollTop==0){
                    clearInterval(timer);
                }
                document.documentElement.scrollTop=document.body.scrollTop=scrollTop+ispeed;
            },30)
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
<body onload="load()">
<%
	List<TitleContent> tcList = (List<TitleContent>)request.getAttribute("tcList");
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
</div>

<div id="page-wrapper" >
	<div class="header"> 
		<h1 class="page-header">
		    活动维护
		</h1>
		<ol class="breadcrumb">
			<li class="active">活动管理</li>
			<li class="active">活动维护</li>
		</ol> 
	</div>
	
	<div class="row">
		<div class="col-md-12">
		    <!-- Advanced Tables -->
		<div class="panel panel-default">
	    <div class="panel-heading">
	         	活动内容
	    </div>
	    <div class="panel-heading">
	        <input type="button" value="活动发布" class="btn btn-success" data-toggle="modal" data-target="#release" data-backdrop="static" onclick="cTop()"/>
	    </div>
	    <!-- 发布的弹出层 -->
		<div class="modal fade" id="release" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
		    <div class="modal-dialog" role="document">  
		        <div class="modal-content" >  
		            <div class="modal-header">  
		                <button type="button" class="close" data-dismiss="modal" aria-label="Close">  
		                    <span aria-hidden="true">×</span>  
		                </button>  
		                <h4 class="modal-title" id="myModalLabel">活动内容发布</h4>  
		            </div>
		            <form action="<%=basePath%>addActivity.do" method="post" id="addInform" enctype="multipart/form-data">
		            		<input type="hidden" id="contentId" name="text">
		            <div class="modal-body">
		            	<div class="row">
		            		<div class="col-sm-1">
		            		</div>
		            		<div class="col-sm-1">
		            			标题
		            		</div>
		            		<div class="col-sm-3">
		            			<input type="text" name="name" class="form-control" id="title"/>
		            		</div>
		            		<div class="col-sm-1">
		            			图片
		            		</div>
		            		<div class="col-sm-4">
		            			<input type="file" name="titleFile" class="form-control"  id="titleFile" onchange="preview(this)">
		            		</div>
		            		<!--标题图片预览的div  -->
		            		<div class="col-sm-2" id="preview">
		            		</div>
	            		</div>
        				<fieldset>
	                       <div class="form-group">
						      <div class="summernote"><p>开始编辑内容</p></div>
	                       </div>
	                    </fieldset>
		            </div>  
		            </form>
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
	                <% for (int i=0; i<tcList.size(); i++) {
	                %>
	                	<tr class="gradeA">
                            <td class="col-md-2"><%=tcList.get(i).getName() %></td>
                            <td class="col-md-2"><%=tcList.get(i).getTime() %></td>
                            <td class="col-md-1"><%=tcList.get(i).getSname() %></td>
                            <td class="col-md-2"><img class="img-responsive" src="<%=LoadDomain.domain %><%=tcList.get(i).getImgName() %>"/></td>
                            <td class="col-md-5">
                            	<input type="button" value="详情" class="btn btn-warning" data-toggle="modal" data-target="#details<%=tcList.get(i).getId()%>" onclick="filter('<%=tcList.get(i).getId()%>')" id="remove<%=tcList.get(i).getId()%>"/>
                            	<input type="button" value="修改" class="btn btn-primary" onclick="update('<%=tcList.get(i).getId()%>')"/>
                            	<input type="button" value="删除" class="btn btn-danger" onclick="del('<%=tcList.get(i).getId() %>','<%=tcList.get(i).getName()%>')"/>
                            	<input type="button" class="btn btn-success" data-toggle="modal" data-target="#entry<%=tcList.get(i).getId()%>" value="报名导入" />
                 				<input type="button" class="btn btn-success" value="报名导出" onclick="exportFile('<%=tcList.get(i).getId() %>')" />
                            </td>
                        </tr>
                        <!-- 详情的弹出层 -->
						<div class="modal fade" id="details<%=tcList.get(i).getId()%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
						    <div class="modal-dialog" role="document">  
						        <div class="modal-content">  
						            <div class="modal-header">  
						                <button type="button" class="close" data-dismiss="modal" aria-label="Close">  
						                    <span aria-hidden="true">×</span>  
						                </button>  
						                <h4 class="modal-title" id="myModalLabel">活动内容</h4>  
						            </div>  
						            <div class="modal-body">  
						            	<fieldset>
					                       <div class="row">
					                       		<div class="col-xs-12">
					                       			<%=tcList.get(i).getText() %>
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
	               		<!-- 导入的弹出层 -->
						<div class="modal fade" id="entry<%=tcList.get(i).getId()%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
						    <div class="modal-dialog" role="document">  
						        <div class="modal-content">  
						            <div class="modal-header">  
						                <button type="button" class="close" data-dismiss="modal" aria-label="Close">  
						                    <span aria-hidden="true">×</span>  
						                </button>  
						                <h4 class="modal-title" id="myModalLabel">导入活动报名人</h4>  
						            </div>
						            <form action="" method="post" id="fileForm<%=tcList.get(i).getId() %>" enctype="multipart/form-data"> 
						            	<input type="hidden" name="id" value="<%=tcList.get(i).getId() %>"/>  
							            <div class="modal-body">  
							            	<fieldset>
						            			<div class="form-group">
						                          <label class="col-sm-6 control-label" for="ds_host">活动标题：<%=tcList.get(i).getName() %></label>
						                       </div>
						                       <div class="form-group">
						                          <label class="col-sm-2 control-label" for="ds_host">导入需先下载模板</label>
						                          <div class="col-sm-4">
						                          	<a href="<%=basePath%>downloadActivityDemo.do" class ="btn btn-success">模版下载</a>
						                          </div>
						                          <label class="col-sm-2 control-label" for="ds_host">请选择导入的表格</label>
						                          <div class="col-sm-4">
						                          	<input type="file" name="file" onclick="javascript:importFile()"  id="fileEntry<%=tcList.get(i).getId() %>" style="vertical-align:middle" >
						                          </div>
						                       </div>
						                    </fieldset>
							            </div>  
							            <div class="modal-footer">  
							                <button type="submit" class="btn btn-info" onclick="return validFile('<%=tcList.get(i).getId() %>')">提交</button>  
							                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>  
							            </div>
						            </form>  
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

<!-- Morris Chart Js -->
<script src="<%=basePath%>assets/js/morris/raphael-2.1.0.min.js"></script>
<script src="<%=basePath%>assets/js/morris/morris.js"></script>

<script src="<%=basePath%>assets/js/easypiechart.js"></script>
<script src="<%=basePath%>assets/js/easypiechart-data.js"></script>

<script src="<%=basePath%>assets/js/Lightweight-Chart/jquery.chart.js"></script>

    <script>
		//控制图片宽度
		var width  = $(".modal-dialog").width() + $(".modal-body").width();
		$(".col-xs-12").find("img").width(width);
	</script>
</body>
</html>