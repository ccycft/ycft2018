<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
		<form action="importExcel.action" enctype="multipart/form-data" method="post" id="fileForm">
			<a href="downloadDemo.action" style="color: #83AFE2;text-decoration:underline;">模版下载</a> 	
			<input type="file" name="file" onclick="javascript:importFile()"  id="file" style="vertical-align:middle" >
			<!-- 哈哈哈哈 -->
			<br />
			<input  type="button" onclick="validFile()"  style="color: #fff;" value="导入" />
			<input type="button" value="导出" onclick="exportFile()" />
		</form>	
</body>
</html>