<%@page import="com.ycft.ycft.system.Core"%>
<%@page import="com.ycft.ycft.po.Title"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/" ;
	
	//文件路径 Core.PATH是访问图片的虚拟路径
	String photoPath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort() +  Core.PATH +"/" ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>通知</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="<%=basePath%>css/toast.css">
	<link rel="stylesheet" href="<%=basePath%>css/animate.css">
	<link rel="stylesheet" href="<%=basePath%>css/navs.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/toast.js"></script>
	
	<style>
		.tab-p{
		
			display: -webkit-box;
			-webkit-box-orient: vertical;
			-webkit-line-clamp: 7;
			overflow: hidden;
			text-align:left;
		}
		ul{
			padding:0px;
			margin:0px;
			list-style:none;
		}
	
	</style>
	<script>
	//获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath = window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName = window.document.location.pathname;
    var pos = curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPath = curWwwPath.substring(0, pos);
    //获取带"/"的项目名，如：/uimcardprj
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
    var basePath = localhostPath + projectName + "/";	
	function openDetail(id){
		window.open(basePath + 'fore/title/informDetail.do?id='+id,'_self');	
	}
	function back(){ 
		
		if(typeof(window.ceshi) != 'undefined'){
			//说明 可以调用安卓的返回功能
			window.ceshi.back(); 
		}else{
			window.history.back();
		}
		
	}
	
	
	function showtoastFromDocument(){
		showMessage('咩有更多喽~');
	}
	
	function showtoastFromDocumentCenter(){
		showMessage('慢些刷,少年~');
	}
	
	
	$(function(){
		
		var b = true ;
		var nowPage = 1;
		//滚动条到页面底部加载更多案例   
		$(window).scroll(function(){  
		      
		 var scrollTop = $(this).scrollTop();    //滚动条距离顶部的高度  
		 var scrollHeight = $(document).height();   //当前页面的总高度  
		 var clientHeight = $(this).height();    //当前可视的页面高度  
		 // console.log("top:"+scrollTop+",doc:"+scrollHeight+",client:"+clientHeight);  
		 if(scrollTop + clientHeight >= scrollHeight){   //距离顶部+当前高度 >=文档总高度 即代表滑动到底部   
		     //滚动条到达底部  
		     //alert('开始加载....')  ;
		 	//开始ajax请求下一页
		 	 ++nowPage;
			 htmlobj=$.ajax({url:"<%=basePath%>fore/title/loadInformByPage.do?nowPage="+nowPage,async:false});
			 var json = (htmlobj.responseText);
			 //alert(json);
			 var obj = JSON.parse(json);
			 var container = $('.container-fluid');
			 
			 for(var i = 0 ; i < obj.length ;i++){
				container.append("<div id='sign_div' class='row' onclick='details(this)'><form action='<%=basePath%>fore/signEvent/selDetail.do' method='post' ><input type='hidden' value='"+obj[i].id+"' name='id' /><input type='hidden' value='"+obj[i].name+"' name='name' /><input type='hidden' value='"+obj[i].time+"' name='time' /><input type='hidden' value='"+obj[i].state +"' name='state' /><input type='hidden' value='"+obj[i].sname+"' name='sname' /><input type='hidden' value='"+obj[i].coordinate+"' name='coordinate' /><input type='hidden' value='"+obj[i].coordinateName+"'  name='coordinateName' /><input type='hidden' value='"+obj[i].uid+"'  name='userid' /></form><div class='col-xs-12'><div class='thumbnail'><img class='img-rounded' src='<%=basePath%>images/t1.jpg' alt='...'><h4 id='course_title' >"+obj[i].name+"</h4><div class='row'><div class='col-xs-8'><ul class='none_style'><li class=''>签到时间："+obj[i].time+"</li><li class=''> 主 办 方："+obj[i].sname+"</li><li class=''>签到地点："+obj[i].coordinateName+"</li></ul></div><div id='' class='col-xs-4 sign_btn'><a  class='btn btn-info btn-lg signBtn' data-complete-text='"+obj[i].state+"'>"+obj[i].state+"</a> </div></div></div></div></div><hr>");
			 } 
			 
			 if(obj.length == 0 &&  b){
				 b = false;
				 showtoastFromDocument();
			 }
			 
		 }else if(scrollTop<=0){  
		    //滚动条到达顶部  
		 //滚动条距离顶部的高度小于等于0 TODO  
		     if(!b){
		    	 b = true;
		    	 showtoastFromDocumentCenter();
		     }
		 }  
		 
		}); 
	
	});
	
	
	//华丽的分割线-------------------------------------------------------------------------------------
	
	</script>
</head>
<body class="text-center">
	
	
	
	<div id="scroller" class="container-fluid">
		
		<ul id="thislist">
			<%
					 		List<Title> tList = (List<Title>)request.getAttribute("tList");
					 	  	
					 		if(tList != null && tList.size() > 0){
					 			for(Title t : tList){
					 			%>
			<li>
				<div class="row" >
					 <div class="col-xs-12">
					 	  
				 				<div class="row" onclick="openDetail('<%=t.getId()%>')">
							      <div class="col-xs-7 ">
								      <div class="thumbnail">
								      	<img  src="<%=photoPath%><%=t.getImgName() %>" alt="...">
								  	  </div>
							      </div>
							     <div class="col-xs-5 ">
								       	<p class="tab-p">
								       		<%=t.getName() %>
										</p>
							      </div>
						      </div>
						      <div class="row">
						      		<div class="col-xs-6">
						      			<span style="float:left"><%=t.getUser() %></span>
						      		</div>
						      		<div class="col-xs-6">
						      			<span style="float:right"><%=t.getTime() %></span>
						      		</div>
						      </div>
						      
						      <hr><!--    华丽丽的分割线———————————————————————————————————— -->
					 			<%
					 			}
					 		}
					 	   %> 
					 </div>
				</div>
			</li>
			
		</ul>
	</div>
	
	<!-- 页面顶端导航栏 -->
	<div class="nav-area">
		<img class="left-icon"  src="<%=basePath%>images/back.png" onClick="back()">	
		<span class="nav-title">校园通知</span>	
		<a href="<%=basePath%>fore/index/index.do"><img class="right-icon" src="<%=basePath%>images/backhome.png"></a>
	</div>
	
</body>
</html>