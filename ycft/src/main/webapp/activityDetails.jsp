<%@page import="java.net.URLDecoder"%>
<%@page import="com.ycft.ycft.system.Core"%>
<%@page import="com.ycft.ycft.po.TitleContent"%>
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
<meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

   	<link rel="stylesheet" href="<%=basePath%>css/navs.css">
    <link rel="stylesheet" href="<%=basePath%>assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/activity.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/bootstrap/js/bootstrap.min.js"></script>
    <style>
    	
		.activity_img{
			width:100%;
		}
		#activity_btn{
			text-align:center;
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
		.none_style{
			list-style-type:none;
			padding-left:1rem;
			padding-top:1rem;
			line-height:3rem;
			font-weight: bold;
			font-size:1.5rem;
		}
	</style>
	<script>
		$(document).ready(function(){
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
			
			$("#confirm").click(function(){
				//确认报名
				var uid = $("#uid").val();
				var tid = $("#tid").val();
				htmlobj=$.ajax({url: basePath + "fore/title/joinActivity.do?tid="+tid+"&uid="+uid,async:false});
				var isSuccess = (htmlobj.responseText);
				if(isSuccess == 1){
					alert("报名成功...");
				}else if(isSuccess == 2){
					alert("您已经报过名了，请勿重复报名谢谢..");
				} else{
					alert("报名失败请稍候重试...");
				}
				$("#close").click();
			});
		});
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
<body>
		<!-- 页面顶端导航栏 -->
	<div class="nav-area">
		<img class="left-icon"  src="<%=basePath%>images/back.png" onClick="back()">	
		<span class="nav-title">活动详情</span>	
		<img class="right-icon" src="<%=basePath%>images/backhome.png" onClick="window.history.back();">
	</div>

	<div class="container-fluid">
		<%
			TitleContent con = (TitleContent)request.getAttribute("titleContent");
			if(con != null){
		%>
				<div class="row">
					<div  class="col-xs-12 activity_img">
		     				 <img class=" img-rounded  activity_img" src="<%=basePath%>images/jiaowu.jpg" alt="...">
		  			</div>
		  			<div class="col-xs-12">
						<ul class="none_style">
							<li class=""><%=con.getName()%></li>
						<!--<li class="">活动地点： 经信九阶</li>
							<li class="">活动时间：2018.5.18</li>	
							<li class="">活动主办方：吉林大学经管学院</li>	
							<li class="">联系方式：到场报名即可</li>	
							<li class="">活动内容描述：</li>	 -->
						</ul>								
					</div>
				</div>
				<div class="row context">
					<div class="col-xs-12">
						<%=con.getText()%>
						<!-- <p class="text-area">
						现在的社会是一个高速发展的社会，科技发达，信息流通，人们之间的交流越来越密切，生活也越来越方便，大数据就是这个高科技时代的产物。 [11]  阿里巴巴创办人马云来台演讲中就提到，未来的时代将不是IT时代，而是DT的时代，DT就是Data Technology数据科技，显示大数据对于阿里巴巴集团来说举足轻重。 [12]
						</p> 
						<p class="text-area">
						有人把数据比喻为蕴藏能量的煤矿。煤炭按照性质有焦煤、无烟煤、肥煤、贫煤等分类，而露天煤矿、深山煤矿的挖掘成本又不一样。与此类似，大数据并不在“大”，而在于“有用”。价值含量、挖掘成本比数量更为重要。对于很多行业而言，如何利用这些大规模数据是赢得竞争的关键。 [13] 
						</p>
						<p class="text-area">
						大数据的价值体现在以下几个方面：
						</p>
						<ol>
							<li>对大量消费者提供产品或服务的企业可以利用大数据进行精准营销</li>
							<li>做小而美模式的中小微企业可以利用大数据做服务转型</li>
							<li>面临互联网压力之下必须转型的传统企业需要与时俱进充分利用大数据的价值</li>
						</ol>
						<p class="text-area">	
							不过，“大数据”在经济发展中的巨大意义并不代表其能取代一切对于社会问题的理性思考，科学发展的逻辑不能被湮没在海量数据中。著名经济学家路德维希·冯·米塞斯曾提醒过：“就今日言，有很多人忙碌于资料之无益累积，以致对问题之说明与解决，丧失了其对特殊的经济意义的了解。”这确实是需要警惕的。
							在这个快速发展的智能硬件时代，困扰应用开发者的一个重要问题就是如何在功率、覆盖范围、传输速率和成本之间找到那个微妙的平衡点。企业组织利用相关数据和分析可以帮助它们降低成本、提高效率、开发新产品、做出更明智的业务决策等等。
						</p> -->
					</div>
				</div>
				
				<hr>
				
				<div class="row">
					<div id="activity_btn" class="col-xs-12">
					
						<a class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">点击报名</a>
					
					</div>
				</div>
				
				<hr>	
			</div>
			
				<!-- 模态框（Modal） -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
								&times;
							</button>
							<h4 class="modal-title" id="myModalLabel">
								互联网+网页设计大赛
							</h4>
						</div>
						<% 
							//获取cookie找到用户信息
							 Cookie[] cookies = request.getCookies();
							 String uid = "";
							 String name = "";
							 String sno = "";
							 String tel = "";
							 if(cookies != null){
								 
								 for(Cookie cookie : cookies){
									 //用户id
									 if(cookie.getName().equals("uid")){
										 uid = cookie.getValue();
									 }if(cookie.getName().equals("sno")){
										 //学号
										sno = cookie.getValue();
									 }if(cookie.getName().equals("sname")){
										 //姓名
										 name =  URLDecoder.decode(cookie.getValue(), "UTF-8");
									 }if(cookie.getName().equals("tel")){
										 //电话
										 tel = cookie.getValue();
									 }
								 }
						 %>
						 	 <div class="modal-body">
										<div class="list-group">
											<input type="hidden" value="<%=uid%>" name="uid" id="uid"/>
											<input type="hidden" value="<%=con.getId()%>" name="tid" id="tid"/>
											<div class="list-group-item">
												 姓名: <%=name %>
											</div>
											<div class="list-group-item">
												 学号: <%=sno %>
											</div>
											<div class="list-group-item">
												 电话: <%=tel %>
											</div>
											<div class="list-group-item">
												 …
											</div>
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" id="close" class="btn btn-default" data-dismiss="modal">关闭
										</button>
										<button type="button" class="btn btn-info" id="confirm">
											确认报名
										</button>
									</div>
						 <%
							 }else{
								 //cookie被清除了，去登录让他
							 }
						%>
						
					</div>
				</div>
		<%
			}else{
				out.print("未查询到内容...");
			}
		%>
		
	</div>
	<script>
		//控制图片宽度
		var width  = $(".col-xs-12").width();
		$(".col-xs-12").find("img").width(width);
	</script>
	
</body>
</html>