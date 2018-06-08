<%@page import="com.ycft.ycft.po.Comment"%>
<%@page import="java.util.List"%>
<%@page import="com.ycft.ycft.po.Forum"%>
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
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="<%=basePath%>css/navs.css">
<title>论坛详情</title>
<style type="text/css">
	.icon{
			height:3.5rem;
			width:3.5rem;
		}
	.add-icon{
			
			height:100%;
			width:10rem;
			border:1px solid #ccc;
	}
	.forum-img{
		
			padding-left: 8px;
	}
	.forum-title{
			font-size:1.5rem;
			font-weight:bold;
	}	
	.forum-content{
	
		
	}
	.row{
		
		line-height:2rem;
		margin-top:1.5rem;
	}
	.min_icon{
		height:2rem;
		width:2rem;
	}
	
	.bottom—navs{
		width:100%;
		height:5rem;
		background:#fff;
		border-top:1px solid #ccc;
		position:fixed;
		bottom:0px;
		left:0px;
	}
	.bottom-input{
		width:100%;
		height:2.8rem;
		margin-top:1.1rem;
		border:1px solid #eee;
		border-top:none;
		border-radius:4rem;
	}
</style>
<script>
	function back(){ 
		
		if(typeof(window.ceshi) != 'undefined'){
			//说明 可以调用安卓的返回功能
			window.ceshi.back(); 
		}else{
			window.history.back();
		}
	}
</script>
</head>
<body class="container-fluid">

	<!-- 页面顶端导航栏 -->
	<div class="nav-area">
		<img class="left-icon"  src="<%=basePath%>images/back.png" onClick="back()">	
		<span class="nav-title">论坛详情</span>	
	</div>
		
		
	<%
		List<Forum> list = (List<Forum>)request.getAttribute("fList");
		if(list != null && list.size() > 0){
			Forum f = list.get(0);
			 
	%>
	
		<div class="row">
			
			<div class="col-xs-2 text-center">
				<img class="img-circle icon" src="<%=photoPath%>icon/<%=f.getUserImgName()%>">
			</div>
				
			<div class="col-xs-8" style="line-height:4rem;padding-left:0px;">
				<span><%=f.getUserName()%></span>
			</div>
			
		</div>
		
		<div class="row">
				<div class="col-xs-12 text-center">
					<span class="forum-title "><%=f.getName() %></span>
				</div>
		</div>
			
			<div class="row context ">
				<div class="col-xs-12">
					<p >
						<%=f.getText() %>
					</p>
				</div>
			</div>
			
			<div class="row">
			    <div class="col-xs-4 forum-img" >
			    	<img src="<%=basePath%>images/add.png" class="add-icon"/>
			    </div>
			    <div class="col-xs-4 forum-img" >
			    	<img src="<%=basePath%>images/add.png" class="add-icon"/>
			    </div>
			    <div class="col-xs-4 forum-img" >
			    	<img src="<%=basePath%>images/add.png" class="add-icon"/>
			    </div>
		  	</div>
			
			<div class="row" style="border-bottom:1px solid #ccc;line-height:2rem;margin-top:4rem;">
				<div class="col-xs-4" style="border-bottom:2px solid  #5bc0de;height:3rem;">
					<span class="forum-title">评论(<%=f.getComment()%>)</span>
				</div>
				<div class="col-xs-1 col-xs-offset-5" >
					<img src="<%=basePath%>images/dianzan.png"  class="min_icon">
				</div>
				<div class="col-xs-1">
					<span><%=f.getPraise() %></span>
				</div>
			</div>
			
			<%
				List<Comment> cList =  f.getCommentList() ; 
				if(cList != null && cList.size() > 0 ){
					for(Comment comment : cList){
			%>
					<div class="row">
	
						<div class="col-xs-3 text-center">
							<span class="a_item"><%=comment.getSname()%> 说: </span>
						</div>
						<div class="col-xs-9 ">
							<span>
								<%=comment.getContent() %>
<%-- 					评论时间			<%=comment.getTime() %> --%>
							</span>
						</div>
					</div>
			
			<%
					}
				}else{
					out.print("暂无评论");
				}
			%>
		
			 <div style="height:100px">
			 
			 </div>
		
			<div class="bottom—navs">
				<input class="bottom-input" type="text" placeholder="爱评论的人粉丝多~"/>
			</div>
	
	
	
	
	<%
		}else{
			out.print("未查询到任何内容...");
		}
		
	%>

	</body>
</html>