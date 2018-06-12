<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/" ;
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="./css/navs.css">
	<style>
	
		#forum-title{
			font-size:2rem;
			height:4rem;
		}	
		#forum-content{
			border-bottom:solid 1px #ccc;
			font-size:1.5rem;
		}
		.form-control{
			
			border:none;
		}
		.add-icon{
			
			height:100%;
			width:10rem;
		}
		.forum-img{
			padding-left: 8px;
		}
		
        .z_file input::-webkit-file-upload-button {
            border: none;
            position: absolute;
            opacity:0;
        }
        
        .z_file input#file {
        
            display: block;
            border: 0;
            vertical-align: middle;
        }
        .ps-text{
       		color:#ccc;
        }
        
	</style>
	
	<script type="text/javascript">

 		/* img-responsive center-block */
 		
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
 		
 
   /*   function imgRemove() {
    	 
         var imgList = document.getElementsByClassName("z_addImg");
         var mask = document.getElementsByClassName("z_mask")[0];
         var cancel = document.getElementsByClassName("z_cancel")[0];
         var sure = document.getElementsByClassName("z_sure")[0];
         for (var j = 0; j < imgList.length; j++) {
             imgList[j].index = j;
             imgList[j].onclick = function() {
                 var t = this;
                 mask.style.display = "block";
                 cancel.onclick = function() {
                     mask.style.display = "none";
                 };
                 sure.onclick = function() {
                     mask.style.display = "none";
                     t.style.display = "none";
                 };
             }
         };
     }; */

     
     
		function showBigImg(){
			
    	 	if(false){
				
				var imgSrc = $('.add-icon').attr('src');
				$('.showBig').attr('src',urlTest);
				$('#myModal').modal('toggle'); 
			}
    	 	
		}
			
		function doCommit(){
			
			
			
			
		}
		
	</script>
	
</head>
<body class="container-fluid">
	
	<!-- 页面顶端导航栏 -->
	<div class="nav-area">
		<img class="left-icon"  src="./images/back.png" onClick="back()">	
		<span class="nav-title">我要发布</span>	
		<img class="right-icon" src="./images/right.png" onClick="doCommit()">
	</div>
	
	
	<form class="form-horizontal" method="post" enctype="multipart/form-data" action="http://192.168.1.200:8080/ycft/fore/title/addForum.do">
	  <div class="form-group">
    	<div class="col-xs-12">
      		<input type="text" name="name" class="form-control" id="forum-title" placeholder="请输入标题">
    	</div>
  	  </div>
  	  	<hr>
	  <div class="form-group">
	    <div class="col-xs-12">
	    	<textarea name="text" class="form-control" id="forum-content" rows="10" placeholder="快来说点啥~"></textarea>
	    </div>
	  </div>
	  <div class="form-group" style="margin-bottom:0px">
		   
		   	 <div class="col-xs-4 forum-img z_file" >
		    	 <input type="file" name="files" id="file" value="" accept="image/*" multiple="multiple" onchange="imgChange();" />
		    	
		    	<label class="labInput" for="file">　　 
			　　　　<img src="<%=basePath%>images/z_add.png" id="img_1"  name="imgName" alt="" class="add-icon" onclick="showBigImg()"> 　　
			　　</label> 
		     </div>
		     
		   	<div class="col-xs-4 forum-img" >
	    		<label class="labInput" >　　 

			　　　　<img src="<%=basePath%>images/z_add_hidden.png" id="img_2"  name="imgName" alt="" class="add-icon" onclick="showBigImg()"> 　　

			　　</label> 
		    </div>
		    
		    <div class="col-xs-4 forum-img" >
		    	<label class="labInput" >　　 

			　　　　<img src="<%=basePath%>images/z_add_hidden.png" id="img_3" name="imgName" alt="" class="add-icon" onclick="showBigImg()"> 　　
			　　
				</label> 
		    </div>
		    
	  </div>
	  <label class="ps-text">最多可以上传 3 张图呦~</label>
	  <input type="submit" value="确认发布" class="btn btn-info"/>
	</form>
	
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" nama="imgName" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					
				</div>
				<div class="modal-body">
					<img id="showBig" class="img-responsive center-block" />
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button type="button" class="btn btn-info">
						删除图片
					</button>
				</div>
			</div>
		</div>
	</div>
</body>


</html>