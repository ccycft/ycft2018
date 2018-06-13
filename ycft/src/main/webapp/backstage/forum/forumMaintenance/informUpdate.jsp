<%@page import="com.ycft.ycft.po.TitleContent"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/"+"backstage/";
	//没有backstage的路径
	String basePathNoBackstage = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";		
	%>
			
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="<%=basePath%>assets/css/bootstrap.css" />
<link rel="stylesheet" href="<%=basePath%>summernote/dist/summernote.css">
<title>论坛修改</title>

<script src="<%=basePath%>assets/js/jquery-1.10.2.js"></script> 
<script src="<%=basePath%>assets/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>summernote/dist/summernote.js"></script>

<script type="text/javascript">
  $(document).ready(function() {
  	$('.summernote').summernote({
          height: 400,
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
  function upd(){
  	var sHTML = $('.summernote').summernote('code');
  	dosubmit();
  	document.getElementById("updContentId").value=sHTML;
  	document.getElementById("updInform").submit();
  }
</script>
<style>
    	.form-group{
    		padding:15px;
    	}
    	/* .img-responsive {
		  display: inline-block;
		  height: auto;
		  max-width: 40%;
		} */
		#updImg{
			width:40px;
			height:40px;
		}
		.row{
			margin-top:30px;
		}
    </style>
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
	<%
		TitleContent tc = (TitleContent)request.getAttribute("tc");
	%>
	<form action="<%=basePath%>updInform.do" method="post" id="updInform" enctype="multipart/form-data">
		<input type="hidden" id="updContentId" name="text">
   		<input type="hidden" name="id" value="<%=tc.getId() %>">
   		<input type="hidden" name="tid" value="<%=tc.getId() %>">
   		<input type="hidden" name="imgName" value="<%=tc.getImgName()%>">
   		<div class="row">
			<div class="col-sm-1">
			</div>
			<div class="col-sm-1">
				标题
			</div>
			<div class="col-sm-2">
				<input type="text" name="name" value="<%=tc.getName() %>" class="form-control" id="updTitle"/>
			</div>
			<div class="col-sm-2">
			</div>
			<div class="col-sm-1">
				图片
			</div>
			<div class="col-sm-2">
				<input type="file" id="updFileId" name="updFile" class="form-control" onchange="updPreview(this)">
			</div>
			<!--标题图片预览的div  -->
			<div class="col-sm-2" id="updPreview">
				<img id="updImg" src="http://localhost:8080/photo/<%=tc.getImgName() %>" /> 
			</div>
			<div class="col-sm-1">
				<button type="button" class="btn btn-success" onclick="upd()">保存</button>
			</div>
		</div>
		<div class="form-group">
			<div class="summernote"><p><%=tc.getText() %></p></div>
	    </div>
	</form>
	<script type="text/javascript">
		//修改标题图片预览
	    function updPreview(file) {
	    	var updPre = document.getElementById("updPreview");
	        if (file.files && file.files[0]) {
	          var reader = new FileReader();
	          reader.onload = function(evt) {
	        	  updPre.innerHTML = '<img src="' + evt.target.result + '" style="width:40px;height:40px;"/>';
	          }
	          reader.readAsDataURL(file.files[0]);
	        }
	     }
    </script>
</body>
</html>