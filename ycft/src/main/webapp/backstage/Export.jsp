<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
    String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/"+"backstage/";
    //没有backstage的路径
	String basePathNoBackstage = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/"; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=basePath%>assets/css/bootstrap.css" rel="stylesheet" />
<script src="<%=basePath%>assets/js/jquery-1.10.2.js"></script>
      <!-- Bootstrap Js -->
    <script src="<%=basePath%>assets/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    /* 
     * 点击主菜单，子菜单显示；再次点击主菜单，子菜单隐藏
     * 需要编写代码，使得主菜单在装载时添加onclick事件，使得点击主菜单可以显示子菜单
     * 注册页面装载时执行的方法
     */
    $(document).ready(function(){
       //var uls = $("ul");
       //找到ul下的a节点
       var as = $("ul > a");
       as.click(function(){
           //首先找到当前ul中的li，然后让li显示出来
           //获取当前被点击的ul节点
           var aNode = $(this);
           //找到被点击ul节点下的所有li节点
           var lis = aNode.nextAll("li");
           //显示或隐藏ul的li子节点们
           lis.toggle("slow");
       });
    });
    </script>
    <style>
    	/*让所有的li都不显示小圆点，可以使用css标签选择器*/
li{
    /*使list前的小圆点消失*/
    list-style: none;
    /*缩进效果*/
    margin-left: 18px;
    /*隐藏菜单*/
    display: none;
}
a{
    /*文字的显示方式*/
    text-decoration: none;
}
    </style>
<title>Insert title here</title>
</head>
 <body>
    <ul>
        <a href="#" mce_href="#">我是菜单1</a>
        <li>我是子菜单1</li>
        <li>我是子菜单2</li>
    </ul>
    <ul>
        <a href="#" mce_href="#">我是菜单2</a>
        <li>我是子菜单3</li>
        <li>我是子菜单4</li>
    </ul>
    <div id="content"></div>
  </body>
</html>