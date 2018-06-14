<%@page import="com.ycft.ycft.po.Forum"%>
<%@page import="java.util.List"%>
<%@page import="com.ycft.ycft.po.Title"%>
<%@page import="com.ycft.ycft.system.Core"%>
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

	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
   	  <link rel="stylesheet" href="<%=basePath%>css/toast.css">
	<link rel="stylesheet" href="<%=basePath%>css/animate.css">
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="<%=basePath%>css/navs.css">
	<script type="text/javascript" src="<%=basePath%>js/toast.js"></script>
	
	<style>
		.icon{
			
			height:3.8rem;
			width:3.8rem;
		}
		
		.context img{
			
			padding-top:0.5rem;
			padding-bottom:1.5rem;
		}
		.context p{
			
			text-indent:2em;
			display: -webkit-box;
			-webkit-box-orient: vertical;
			overflow: hidden;
			text-align:left;
		
		}
		.min_icon{
			
			height:2rem;
			width:2rem;
		}
		
		.context p{
		
			display: -webkit-box;
			-webkit-box-orient: vertical;
			-webkit-line-clamp: 2;
			overflow: hidden;
			text-align:left;
			line-height:2rem;
		}
		.row{
			margin-top:1rem;
			line-height:1rem;
		}
		.forum-title{
		
			font-size:1.5rem;
			font-weight:bold;
			display: -webkit-box;
			-webkit-box-orient: vertical;
			-webkit-line-clamp: 1;
			overflow: hidden;
			text-align:left;
			line-height:2rem;
		}
	</style>
	
<title>Forum</title>
<script type="text/javascript">

	function back(){ 
		
		if(typeof(window.ceshi) != 'undefined'){
			//说明 可以调用安卓的返回功能
			window.ceshi.back(); 
		}else{
			window.history.back();
		}
	}
	
	function addPost(){
		
		window.open('<%=basePath%>addPost.jsp','_self');
		
	}
	function openDetail(id){
		window.location.href = "<%=basePath%>fore/title/selDetail.do?id="+id;
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
			 htmlobj=$.ajax({url:"<%=basePath%>fore/title/selectForumByPage.do?nowPage="+nowPage,async:false});
			 var json = (htmlobj.responseText);
			 //alert(json);
			 var obj = JSON.parse(json);
			 var container = $('body');
			 
			 var html = '';
			 for(var i = 0 ; i < obj.length ;i++){
				html +=  '<div class="row " onclick="openDetail('+obj[i].id+')">'+
					
					'<div class="row" >'+
						
						'<div class="col-xs-4 text-right" style="width: 24.333333%;">'+
							'<img class="img-circle icon" src="<%=photoPath%>icon/' +obj[i].userImgName+'">'+
						'</div>'+
						
						'<div class="col-xs-6" >'+
							'<div class="row" style="line-height:0.5rem">'+
								'<span>' +obj[i].userName+ '</span>'+
							'</div>'+
							'<div class="row">'+
								'<span>' +obj[i].time+ '</span>'+
							'</div>'+
						'</div>'+
					
					'</div>'+
				
					'<div class="row">'+
						'<div   class="col-xs-10 col-xs-offset-1" style="margin-top:1rem;">'+
							'<span class="forum-title">' +obj[i].name+ '</span>'+
						'</div>'+
					'</div>'+
					
					'<div class="row context ">'+
						'<div class="col-xs-10 col-xs-offset-1">'+
							'<p>' +obj[i].text+ '</p>'+
						'</div>'+
					'</div>'+
					
					'<div class="row">'+
					
						'<div class="col-xs-1 col-xs-offset-7" >'+
							'<img src="<%=basePath%>images/dianzan.png"  class="min_icon">'+
						'</div>'+
						
						'<div class="col-xs-1" style="line-height: 2rem">'+
							'<span>' +obj[i].praise+ '</span>'+
						'</div>'+
						
						'<div class="col-xs-1 " >'+
							'<img src="<%=basePath%>images/pinglun.png"  class="min_icon">'+
						'</div>'+
						
						'<div class="col-xs-1" style="line-height: 2rem">'+
							'<span>' +obj[i].comment+ '</span>'+
						'</div>'+
						
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
	
	<!-- 页面顶端导航栏 -->
	<div class="nav-area" style="position:relative;top:0">
		<span class="nav-title">校园论坛</span>	
		<img class="right-icon" src="<%=basePath%>images/add.png" onClick="addPost()" style="position:absolute;right:0.6rem;">
	</div>
    <%
    	List<Forum> sList =  (List<Forum>)request.getAttribute("sList");
	    if(sList != null){
	    	for(Forum f : sList){
	 %>
	 			<div class="row " onclick="openDetail('<%=f.getId()%>')">
				
					<div class="row" >
						
						<div class="col-xs-4 text-right" style="width: 24.333333%;">
							<img class="img-circle icon" src="<%=photoPath + "icon/"%><%=f.getUserImgName()%>">
						</div>
						
						<div class="col-xs-6" >
							<div class="row" style="line-height:0.5rem">
								<span><%=f.getUserName()%></span>
							</div>
							<div class="row">
								<span><%=f.getTime() %></span>
							</div>
						</div>
					
					</div>
				
					<div class="row">
						<div   class="col-xs-10 col-xs-offset-1" style="margin-top:1rem;">
							<span class="forum-title"><%=f.getName() %></span>
						</div>
					</div>
					
					<div class="row context ">
						<div class="col-xs-10 col-xs-offset-1">
							<p><%=f.getText()%></p>
						</div>
					</div>
					
					<div class="row">
					
						<div class="col-xs-1 col-xs-offset-7" >
							<img src="<%=basePath%>images/dianzan.png"  class="min_icon">
						</div>
						
						<div class="col-xs-1" style="line-height: 2rem">
							<span><%=f.getPraise() %></span>
						</div>
						
						<div class="col-xs-1 " >
							<img src="<%=basePath%>images/pinglun.png"  class="min_icon">
						</div>
						
						<div class="col-xs-1" style="line-height: 2rem">
							<span><%=f.getComment() %></span>
						</div>
						
					</div>
					
			    </div>
			    
			    <hr>
	 
	 
	 <%
	 		}
	    }else{
	 %>
	 
	 	未查询到任何论坛文章...
	 
	 
	<%
	    }
    %>
  <%-- <jsp:include page="nav.jsp"></jsp:include> --%>
</body>
</html>