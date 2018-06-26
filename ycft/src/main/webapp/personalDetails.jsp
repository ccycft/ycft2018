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
<title>校园通</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/navs.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript">
	
	var imgCount = 0 ;
	function imgChange(){
			
			var file = document.getElementById("file");
			var fileList = file.files;
			var iconList = document.getElementsByClassName('add-icon');
			var labList =  document.getElementsByClassName('labInput');
			if(fileList.length <= 3){
				//遍历选中的所有图的url
		 		for(var i = 0 ; i < fileList.length ; i++){
		 	 		iconList[imgCount].setAttribute("src", window.URL.createObjectURL(file.files[i])); 
		 	 		labList[imgCount].setAttribute("for","123");
		 	 		labList[imgCount].style.height="100%";
		 	 		labList[imgCount].style.width="10rem";
		 	 		imgCount++;
		 		}
			}else{
				alert("最多可以上传 3 张图片呦~");
			}
		}

</script>
<style type="text/css">
	.context{
	
		margin-top:1rem;
		font-size:2rem;
		line-height:3.5rem;
	}
	
	.form-group input{
		
		height:4rem;
		font-size:2rem;
	}
	
	.z_file input::-webkit-file-upload-button {
            border: none;
            position: absolute;
            opacity:0;
        }
        
        .z_file input#file {
        
            display: none;
            border: 0;
            vertical-align: middle;
        }

</style>
</head>
<body class="container-fluid text-center">
	
	<form>
		<div class="context">
		
			<div class="row form-group">
				<div class="col-xs-4"><label >昵称:</label></div>
				<div class="col-xs-8"><input type="text" class="form-control" placeholder="请输入签到名称" name="signTitle"></div>
			</div>
			
			<div class="row form-group">
				<div class="col-xs-4"><label >手机号:</label></div>
				<div class="col-xs-8"><input type="text" class="form-control" placeholder="请输入签到发起人" name="signName"></div>
			</div>
			
			<hr>
			
			<div class="row form-group">
				<div class="col-xs-4"><label >旧密码:</label></div>
				<div class="col-xs-8"><input type="text" class="form-control" placeholder="请输入签到发起人" name="signName"></div>
			</div>
			
			<div class="row form-group">
				<div class="col-xs-4"><label >新密码:</label></div>
				<div class="col-xs-8"><input type="text" class="form-control" placeholder="请输入签到发起人" name="signName"></div>
			</div>
			
			<hr>
			
			<div class="row form-group">
				<div class="col-xs-4 forum-img z_file" >
			    	<input type="file" name="files" id="file" value="" accept="image/*" multiple="multiple" onchange="imgChange();" />
			    	
			    	<label class="labInput" for="file">　　 
				　　　　<img src="<%=basePath%>images/z_add.png" id="img_1"  name="imgName" alt="" class="add-icon" > 　　
				　　</label> 
			    </div>
			</div>
			
			<div class="row">
				<input type="submit" value="确认发布" class="btn btn-info"/>
			</div>
			
		</div>
	</form>
	
	<div class="nav-area">
		<img class="left-icon"  src="<%=basePath%>images/back.png" onclick="back()">	
			<span class="nav-title">个人信息</span>	
		<img class="right-icon" src="<%=basePath%>images/success.png">
	</div>
	
</body>
</html>