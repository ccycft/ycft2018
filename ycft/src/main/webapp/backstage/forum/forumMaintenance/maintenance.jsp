<%@page import="com.ycft.ycft.po.TitleContent"%>
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
	String basePathNoBackStage = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
	    		xmlhttp.open("post","<%=basePath%>forumDel.do",true);
	    		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	    		xmlhttp.send("id="+id);
    		}
    	}
    	//评论的详情
    	function commentDetail(id){
			var xmlhttp = new XMLHttpRequest();
			xmlhttp.onreadystatechange  = function(){
				if(xmlhttp.readyState == 4){
					var data = xmlhttp.responseText;
					var dataObj=eval("("+data+")");//转换为json对象 
					appendLi(dataObj);
				}
			};
			xmlhttp.open("post","<%=basePath%>selComment.do",true);
    		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    		xmlhttp.send("id="+id);
    	}
    	//把li追加到页面上
    	function appendLi(tt) {  
            var json = eval(tt); //数组     
            var tt = "";  
            $.each(json, function (index) {  
                //循环获取数据    
                var user = json[index].user;
                var time = json[index].time;
                var commentListId = json[index].commentList[0].id;
                var commentListContent = json[index].commentList[0].content;
                tt += "<li style='list-style-type:none;' id='li"+commentListId+"' onclick='delComment(this.id)'><span style='color:#295c9d'>" + user + " </span> : " + commentListContent + "</li>";  
            });  
            $("#list").html('');
            $("#list").html(tt);
        }
    	//删除评论
    	function delComment(id){
			var temp = document.getElementById(id).innerHTML;
			//要截取的长度
			var length = temp.indexOf("</span> :")-temp.indexOf(">")-1;
			//截取名字
			var name = temp.substr(temp.indexOf(">")+1,length);
    		if (confirm("您确认删除\""+name+"的评论\"吗?")) {
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
	    		xmlhttp.open("post","<%=basePath%>commentDel.do",true);
	    		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	    		xmlhttp.send("id="+id);
    		}
    	}
    	//把滚动条移动到最上面
    	function cTop(){
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
    <style>
    	.form-group{
    		padding:15px;
    	}
    	fieldset{
    		border:0 none;
    		padding:0;
    	}
    	.img-responsive {
		  display: inline-block;
		  height: auto;
		  max-width: 20%;
		}
		#list{
			background: #ededed;
		}
    </style>
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
<title>Insert title here</title>
</head>
<body onload="load()">
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
<%
	List<TitleContent> tcList = (List<TitleContent>)request.getAttribute("tcList");
%>
<div id="page-wrapper" >
	<div class="header"> 
		<h1 class="page-header">
		    论坛维护
		</h1>
		<ol class="breadcrumb">
			<li class="active">论坛管理</li>
			<li class="active">论坛维护</li>
		</ol> 
	</div>
	
	<div class="row">
		<div class="col-md-12">
		    <!-- Advanced Tables -->
		<div class="panel panel-default">
	    <div class="panel-heading">
	         	论坛内容
	    </div>
	    <div class="panel-body">
	        <div class="table-responsive">
	            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
	                <thead>
	                    <tr>
	                        <th>标题</th>
	                        <th>发布时间</th>
	                        <th>作者名</th>
	                        <th>操作</th>
	                    </tr>
	                </thead>
	                <tbody>
	                <% for (int i=0; i<tcList.size(); i++) {
	                %>
	                	<tr class="gradeA">
                            <td class="col-md-2"><%=tcList.get(i).getName() %></td>
                            <td class="col-md-2"><%=tcList.get(i).getTime() %></td>
                            <td class="col-md-2"><%=tcList.get(i).getUser() %></td>
                            <td class="col-md-2">
                            	<input type="button" value="论坛详情" class="btn btn-warning" data-toggle="modal" data-target="#details<%=tcList.get(i).getId()%>" onclick="commentDetail('<%=tcList.get(i).getId()%>')" id="remove<%=tcList.get(i).getId()%>"/>
                            	<input type="button" value="删除" class="btn btn-danger" onclick="del('<%=tcList.get(i).getId() %>','<%=tcList.get(i).getName()%>')"/>
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
						                <h4 class="modal-title" id="myModalLabel">论坛内容</h4>  
						            </div>  
						            <div class="modal-body">  
						            	<fieldset>
					                       <div class="row">
					                       		<div class="col-xs-11">
					                       			<%=tcList.get(i).getText() %>
					                       		</div>
					                       </div>
					                       <ul id="list">
					                       </ul>
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
    <script>
		//控制图片宽度
		var width  = $(".modal-dialog").width() + $(".modal-body").width();
		$(".col-xs-11").find("img").width(width);
	</script>
</body>
</html>