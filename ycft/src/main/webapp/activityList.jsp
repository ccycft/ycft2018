<%@page import="com.ycft.ycft.system.Core"%>
<%@page import="java.util.List"%>
<%@page import="com.ycft.ycft.po.Title"%>
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
<title>活动</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="<%=basePath%>css/toast.css">
	<link rel="stylesheet" href="<%=basePath%>css/animate.css">
    <link rel="stylesheet" href="<%=basePath%>css/navs.css">
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/activity.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/toast.js"></script>
    <style>
	    .activity_img{
			width:100%;
		}
		.icon{
			width:1.8rem;
		}
		.row{
			padding-bottom:1rem;
			padding-top:1rem;
			
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
		function openDetails(id){
			window.open(basePath + 'fore/title/activityDetail.do?id='+id,'_self');	
			
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
			    // alert('开始加载....');
			 	//开始ajax请求下一页
			 	 ++nowPage;
				 htmlobj=$.ajax({url:"<%=basePath%>fore/title/loadActivityByPage.do?nowPage="+nowPage,async:false});
				 var json = (htmlobj.responseText);
				 var obj = JSON.parse(json);
				 var container = $('body');
				 var html = '';
				 for(var i = 0 ; i < obj.length ;i++){
					html +=  '<div class="row" onclick="openDetails('+obj[i].id+')">'+
								'<div  class="col-xs-10 activity_img">'+
	     							'<img class=" img-rounded  activity_img" src="<%=photoPath%>'+obj[i].imgName+'" alt="...">'+
	  							'</div>'+
							 '</div>'+
							'<div class="row" onclick="openDetails('+obj[i].id+')">'+
								'<div id="info" class="col-xs-7">'+
					     			'<span>'+obj[i].id+'</span>'+
					  			'</div>'+
					  			'<div id="renshu" class="col-xs-5">'+
					     			'<img class="icon" src="<%=basePath%>images/renshu.png" >'+
					     			'<span>已有 '+obj[i].cnt+'人参加<span>'+
					  			'</div>'+
							'</div>'+
							'<hr>';
				 }
				 container.append(html);
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
		
	
	</script>
</head>
<body>
	
	<div class="container-fluid">
		
		<!--    华丽丽的分割线———————————————————————————————————— -->
		
			<%
				List<Title> tList =  (List<Title>)request.getAttribute("tList");
				if(tList != null && tList.size() > 0 ){
					for(Title title : tList){
					%>
					<div class="row" onclick="openDetails('<%=title.getId()%>')">
						<div  class="col-xs-10 activity_img">
			     				 <img class=" img-rounded  activity_img" src="<%=photoPath%><%=title.getImgName()%>" alt="...">
			  			</div>
					</div>
					<div class="row" onclick="openDetails('<%=title.getId()%>')">
						<div id="info" class="col-xs-7">
			     			<span><%=title.getName() %></span>
			  			</div>
			  			<div id="renshu" class="col-xs-5">
			     			<img class="icon" src="<%=basePath%>images/renshu.png" >
			     			<span>我已参加该活动</span>
			  			</div>
					</div>
					<hr> <!--    华丽丽的分割线———————————————————————————————————— -->
					
					<%
					}
				}
			%> 
		</div>
			<!-- 页面顶端导航栏 -->
	<div class="nav-area">
		<img class="left-icon"  src="<%=basePath%>images/back.png" onClick="back()">	
		<span class="nav-title">活动 | 比赛</span>	
		<img class="right-icon" src="<%=basePath%>images/backhome.png">
	</div>
</body>
</html>