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
	$(document).ready(function(){
		var id = $("#fid").val();
		var cmt = $("#cmts").val();
		var html = '';
		if(cmt > 0 ){
			//如果评论数大于0 加载评论
			  //加载评论
			htmlobj=$.ajax({url:"<%=basePath%>fore/title/selComment.do?id="+id,async:false});
			var obj = JSON.parse(htmlobj.responseText);
			
			for(var i = 0 ; i< obj.length ; i++){
				html += '<div class="row">'+
				
					'<div class="col-xs-3 text-center">'+
						'<span class="a_item">' + obj[i].sname +' 说: </span>'+
					'</div>'+
					'<div class="col-xs-9 ">'+
						'<span>'+
						obj[i].content +
	<%-- 					评论时间			<%=comment.getTime() %> --%>
					'</span>'+
				'</div>'+
				'</div>';
			}
		}else{
			html = '暂无评论...';
		}
		
		$("#comment-wrapper").append(html);
		
		
		//  //写入c字段
        var fid1 = $("#fid").val();
        var isNull = localStorage.getItem(fid1+"");
        //如果fid等于这个id说明已经点过赞了
        if(typeof(isNull) && isNull == 'fid'){
        	$("#dianzan").attr('src', "<%=basePath%>images/dianzan.png"); 
        	$("#dianzan").remoteAttr("onclick");
        }
        
        
        
        $("#dianzan").click(function(){
    		var id = $("#fid").val();
    		htmlobj=$.ajax({url:"<%=basePath%>fore/title/dianzan.do?tid="+id ,async:false});
    		var rtn = htmlobj.responseText;
    		if(rtn == 1){
    			//变色
    			$("#dianzan").attr('src', "<%=basePath%>images/dianzan.png"); 
    			//加一
    			var old = parseInt($("#praise-cnt").text());
    			$("#praise-cnt").text((old+1));
    			//将文章ID   存入localstage  代表已经点过赞了
    			if(!window.localStorage){
    	            
    	            return false;
    	        }else{
    	            //主逻辑业务
    	        	var storage=window.localStorage;
    	            //写入c字段  格式   40:fid
    	            storage.setItem(id+"", "fid");
    	        }
    		}
    		
    	});
	})
	
	function pinglun(){
		
		var id = $("#fid").val();
		var content = $("#content").val();
		htmlobj=$.ajax({url:"<%=basePath%>fore/title/comment.do?tid="+id+"&content="+content,async:false});
		//alert(htmlobj);
		var rtn = htmlobj.responseText;
		if(rtn == 1){
			 
		 	//成功
			  var html =  '<div class="row">'+
							
							'<div class="col-xs-3 text-center">'+
								'<span class="a_item">' + '我' +' 说: </span>'+
							'</div>'+
							'<div class="col-xs-9 ">'+
								'<span>'+
								 content +
								 
							'</span>'+
						'</div>'+
						'</div>';
			
			$("#comment-wrapper").prepend(html);  
		}
	}
	 
</script>
</head>
<body >

	<!-- 页面顶端导航栏 -->
	<div class="nav-area" style="position:relative;top:0">
		<img class="left-icon"  src="<%=basePath%>images/back.png" onClick="back()" style="position:absolute;left:0;">	
		<span class="nav-title">论坛详情</span>	
	</div>
		
		
	<%
		List<Forum> list = (List<Forum>)request.getAttribute("fList");
		if(list != null && list.size() > 0){
			Forum f = list.get(0);
			 
	%>
		<input type="hidden" value="<%=f.getId() %>" id="fid" />
		<input type="hidden" value="<%=f.getComment()%>" id="cmts" />
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
				<script>
		          
				</script>
				<div class="col-xs-1 col-xs-offset-5" id="dianzan-wrapper" >
					<img src="<%=basePath%>images/no_dianzan.png"  id="dianzan" class="min_icon"   >
				</div>
				<div class="col-xs-1">
					<span id="praise-cnt"><%=f.getPraise() %></span>
				</div>
			</div>
			
			 <div id="comment-wrapper">
			 
			 </div>
		
			 <div style="height:100px">
			 
			 </div>
		
			<div class="bottom—navs">
				 	<!-- 评论 -->
					<input class="bottom-input" type="text" id="content" style="width: 86%" placeholder="爱评论的人粉丝多~"/>
					<input class="" type="button" id="submit-comment" onclick="pinglun()" value="发送"/>
				 
			</div>
	
	
	
	
	<%
		}else{
			out.print("未查询到任何内容...");
		}
		
	%>

	</body>
</html>