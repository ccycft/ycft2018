<%@page import="com.ycft.ycft.po.DictDepict"%>
<%@page import="com.ycft.ycft.system.Menu"%>
<%@page import="com.ycft.ycft.po.Privilege"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
    		+ request.getServerName() + ":" + request.getServerPort()
    		+ path + "/backstage/";
    String basePathNoBackStage = request.getScheme() + "://"
    		+ request.getServerName() + ":" + request.getServerPort()
    		+ path + "/";
    %>
    <%
	List<Privilege> privilegeList = Menu.pList;
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" >
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap Styles-->
<link href="<%=basePath%>assets/css/bootstrap.css" rel="stylesheet" />
<!-- FontAwesome Styles-->
<link href="<%=basePath%>assets/css/font-awesome.css" rel="stylesheet" />
<!-- Morris Chart Styles-->

<!-- Custom Styles-->
<link href="<%=basePath%>assets/css/custom-styles.css" rel="stylesheet" />
<!-- Google Fonts-->
<link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
  <!-- TABLE STYLES-->
<link href="<%=basePath%>assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />

<!-- jQuery Js -->

<script src="<%=basePath%>assets/js/jquery-3.2.0.min.js"></script>
<!-- Bootstrap Js -->
<script src="<%=basePath%>assets/js/bootstrap.min.js"></script>
<!-- Metis Menu Js -->
<script src="<%=basePath%>assets/js/jquery.metisMenu.js"></script>
<!-- DATA TABLE SCRIPTS -->
<script src="<%=basePath%>assets/js/dataTables/jquery.dataTables.js"></script>
<script src="<%=basePath%>assets/js/dataTables/dataTables.bootstrap.js"></script>
<!-- Custom Js -->
<script src="<%=basePath%>assets/js/custom-scripts.js"></script>
<script src="<%=basePath %>assets/bootstrapValidator/bootstrapValidator.min.js"></script>
<link href="<%=basePath %>assets/bootstrapValidator/bootstrapValidator.min.css" rel="stylesheet"/>
<title>Insert title here</title>
<script>
	$(document).ready(function () {
	    $('#dataTables-example').dataTable();
	});
</script>
<script type="text/javascript">
	function enabledDict(id){
		if (confirm("确定要启用该选项吗？")) {
			window.location.href="enabledDict.do?id="+id;
		}
	}
	function disabledDict(id){
		if (confirm("确定要禁用该选项吗？")) {
			window.location.href="disabledDict.do?id="+id;
		}
	}
	$(function(){
		$("#dictType").change(function(){
			var dictType = $("#dictType").val();
			 $.ajax({
				url: 'dictTypeAjax.do',
				type: 'post',
				dataType: 'json',
				data: {
					dictType: dictType,
				},
				success: function(res){
					if (res == "0") {
						alert("字典代码不可重复！");
						$("#dictType").focus();
					}
				},
				error: function(res){
					alert("请求失败");
				}
			});
		});
	});
</script>
<style type="text/css">
	#note{
		color:#f00;
	}
</style>
<script type="text/javascript">
 	$(function(){
 		document.getElementById("dataTables-example_paginate").onclick=function(){
 			timer=setInterval(function(){
               var scrollTop=document.documentElement.scrollTop||document.body.scrollTop;
               var ispeed=Math.floor(-scrollTop/6);
               if(scrollTop==0){
                   clearInterval(timer);
               }
               document.documentElement.scrollTop=document.body.scrollTop=scrollTop+ispeed;
            },0);
 		}
 	})
</script>
<script type="text/javascript">
$(function () {
    $('#addDictType').bootstrapValidator({
        fields: {
            dictType: {
                message: '类型代码验证失败',
                validators: {
                    notEmpty: {
                        message: '类型代码不能为空'
                    },
                    stringLength: {
                        min: 1,
                        max: 16,
                        message: '类型代码长度必须在1到16位之间'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z]+$/,
                        message: '类型代码只为英文'
                    }
                }
            },
            dictTypeName: {
                message: '类型名称验证失败',
                validators: {
                    notEmpty: {
                        message: '类型名称不能为空'
                    },
                    stringLength: {
                    	min: 1,
                    	max: 20,
                    	message: '类型名称长度必须在1到20位之间'
                    }
                }
            },
            dictName: {
            	message: '字典项验证失败',
                validators: {
                    notEmpty: {
                        message: '字典项不能为空'
                    },
                    stringLength: {
                    	min: 1,
                    	max: 20,
                    	message: '字典项长度必须在1到20位之间'
                    }
                }
            },
            sort: {
                message: '排序验证失败',
                validators: {
                    notEmpty: {
                        message: '排序不能为空'
                    },
                    stringLength: {
                    	min: 1,
                    	max: 3,
                    	message: '排序长度必须在1到3位之间'
                    },
                    regexp: {
                    	regexp: /^[0-9]+$/,
                    	message: '排序只能为数字'
                    }
                }
            }
        }
    });
});
</script>
<script type="text/javascript">
$(function () {
    $('#addForm').bootstrapValidator({
        fields: {
            dictName: {
            	message: '字典项验证失败',
                validators: {
                    notEmpty: {
                        message: '字典项不能为空'
                    },
                    stringLength: {
                    	min: 1,
                    	max: 20,
                    	message: '字典项长度必须在1到20位之间'
                    }
                }
            },
            sort: {
                message: '排序验证失败',
                validators: {
                    notEmpty: {
                        message: '排序不能为空'
                    },
                    stringLength: {
                    	min: 1,
                    	max: 3,
                    	message: '排序长度必须在1到3位之间'
                    },
                    regexp: {
                    	regexp: /^[0-9]+$/,
                    	message: '排序只能为数字'
                    }
                }
            }
        }
    });
});
</script>
<script type="text/javascript">
$(function () {
    $('#updateForm').bootstrapValidator({
        fields: {
            dictName: {
            	message: '字典项验证失败',
                validators: {
                    notEmpty: {
                        message: '字典项不能为空'
                    },
                    stringLength: {
                    	min: 1,
                    	max: 20,
                    	message: '字典项长度必须在1到20位之间'
                    }
                }
            },
            sort: {
                message: '排序验证失败',
                validators: {
                    notEmpty: {
                        message: '排序不能为空'
                    },
                    stringLength: {
                    	min: 1,
                    	max: 3,
                    	message: '排序长度必须在1到3位之间'
                    },
                    regexp: {
                    	regexp: /^[0-9]+$/,
                    	message: '排序只能为数字'
                    }
                }
            }
        }
    });
});
</script>
<script type="text/javascript">
	function addAssignment(id,dictType,title){
		document.getElementById("addForm").reset();
		$("#addId").attr("value",id);
		$("#addDictItemType").attr("value",dictType);
		$("#addTitle").html("新增的类型代码为："+title);
	}

</script>
<script type="text/javascript">
	function updateAssignment(id,dictName,sort,title){
		document.getElementById("updateForm").reset();
		$("#updateId").attr("value",id);
		$("#updateDictName").attr("value",dictName);
		$("#updateSort").attr("value",sort);
		$("#updateTitle").html("修改的类型代码为："+title);
	}

</script>
</head>
<body>
<%
	List<DictDepict> ddList = (List<DictDepict>)request.getAttribute("ddList");
%>
<div id="wrapper">
	<nav class="navbar navbar-default top-navbar" role="navigation">
	    <div class="navbar-header">
	        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
	            <span class="sr-only">Toggle navigation</span>
	            <span class="icon-bar"></span>
	            <span class="icon-bar"></span>
	            <span class="icon-bar"></span>
	        </button>
	        <a class="navbar-brand" href="jump.do"><strong>返回首页</strong></a>
		
			<div id="sideNav" href=""><i class="fa fa-caret-right"></i></div>
         </div>

          <ul class="nav navbar-top-links navbar-right">
              <li class="dropdown">
                  <ul class="dropdown-menu dropdown-alerts">
                      <li>
                          <a href="#">
                              <div>
                                  <i class="fa fa-comment fa-fw"></i> New Comment
                                  <span class="pull-right text-muted small">4 min</span>
                              </div>
                          </a>
                      </li>
                      <li class="divider"></li>
                      <li>
                          <a href="#">
                              <div>
                                  <i class="fa fa-twitter fa-fw"></i> 3 New Followers
                                  <span class="pull-right text-muted small">12 min</span>
                              </div>
                          </a>
                      </li>
                      <li class="divider"></li>
                      <li>
                          <a href="#">
                              <div>
                                  <i class="fa fa-envelope fa-fw"></i> Message Sent
                                  <span class="pull-right text-muted small">4 min</span>
                              </div>
                          </a>
                      </li>
                      <li class="divider"></li>
                      <li>
                          <a href="#">
                              <div>
                                  <i class="fa fa-tasks fa-fw"></i> New Task
                                  <span class="pull-right text-muted small">4 min</span>
                              </div>
                          </a>
                      </li>
                      <li class="divider"></li>
                      <li>
                          <a href="#">
                              <div>
                                  <i class="fa fa-upload fa-fw"></i> Server Rebooted
                                  <span class="pull-right text-muted small">4 min</span>
                              </div>
                          </a>
                      </li>
                      <li class="divider"></li>
                      <li>
                          <a class="text-center" href="#">
                              <strong>See All Alerts</strong>
                              <i class="fa fa-angle-right"></i>
                          </a>
                      </li>
                  </ul>
                  <!-- /.dropdown-alerts -->
          </li>
          <!-- /.dropdown -->
          <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
                  <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
              </a>
              <ul class="dropdown-menu dropdown-user">
                  <li><a href="#"><i class="fa fa-user fa-fw"></i> User Profile</a>
                  </li>
                  <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
                  </li>
                  <li class="divider"></li>
                  <li><a href="#"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                  </li>
              </ul>
              <!-- /.dropdown-user -->
          </li>
          <!-- /.dropdown -->
      </ul>
  </nav>
  <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">
                <%for(int i = 0;i<privilegeList.size();i++){
                	%>
                	<li id="<%=privilegeList.get(i).getId()%>">
                    <a href="#"><%=privilegeList.get(i).getIcon()%><span id="sp<%=privilegeList.get(i).getId()%>"><%=privilegeList.get(i).getmName() %></span><span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                    <%for(int j = 0;j<privilegeList.get(i).getChildMenus().size();j++){
                    	%>
                        <li id="<%=privilegeList.get(i).getChildMenus().get(j).getId()%>">
                            <a href="<%=basePathNoBackStage%><%=privilegeList.get(i).getChildMenus().get(j).getmUrl()%>?id=<%=privilegeList.get(i).getChildMenus().get(j).getId() %>&pid=<%=privilegeList.get(i).getChildMenus().get(j).getpId()%>">
                            <%=privilegeList.get(i).getChildMenus().get(j).getmName() %></a>
                        </li>
                    <%}%>
                    </ul>
                </li>
                <% }%>
            </ul>

        </div>

    </nav>
	<div id="page-wrapper" >
		<div class="header"> 
			<h1 class="page-header">
			    系统设置
			</h1>
			<ol class="breadcrumb">
				<li class="active">系统设置</li>
				<li class="active">数据字典维护</li>
			</ol> 
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
							字典信息
					</div>
					<div class="panel-heading">
				        <input type="button" value="新增字典" class="btn btn-success" data-toggle="modal" data-target="#addType" data-backdrop="static"/>
				    </div>
				    <!-- 新增字典的弹出层 -->
					<div class="modal fade" id="addType" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
					    <div class="modal-dialog" role="document">  
					        <div class="modal-content">  
					            <div class="modal-header">  
					                <button type="button" class="close" data-dismiss="modal" aria-label="Close">  
					                    <span aria-hidden="true">×</span>  
					                </button>  
					                <h4 class="modal-title" id="myModalLabel">新增字典</h4>  
					            </div>
					            <form action="addDictType.do" method="post" id="addDictType"> 
					            	<input type="hidden" name="dictCode" value="<%=ddList.get(ddList.size()-1).getId() + "-" + ddList.get(ddList.size()-1).getdList().get(ddList.get(ddList.size()-1).getdList().size()-1).getId() %>">
						            <div class="modal-body">  
						            	<fieldset>
						            		<div class="row">
						            			<div>
						            				<label class="col-sm-2 control-label" for="ds_host">类型代码</label>
						            				<div class="form-group col-sm-4">
							                             <input class="form-control" id="dictType" type="text" name="dictType"/>
							                       </div>
						            			</div>
						            			<div>
						            				<label class="col-sm-2 control-label" for="ds_name">类型名称</label>
						            				<div class="form-group col-sm-4">
						                             	<input class="form-control" id="ds_name" type="text" name="dictTypeName"/>
						                      	 	</div>	
						            			</div>
						            		</div> 
						            		<div class="row">
						            			<div>
						            				<label class="col-sm-2 control-label" for="ds_host">字典项</label>
						            				<div class="form-group col-sm-4">
							                             <input class="form-control" id="dictName" type="text" name="dictName"/>
							                       </div>
						            			</div>
						            			<div>
						            				<label class="col-sm-2 control-label" for="ds_name">排序</label>
						            				<div class="form-group col-sm-4">
						                             	<input class="form-control" id="sort" type="text" name="sort"/>
						                      	 	</div>	
						            			</div>
						            		</div> 
						            		<div class="row">
						            			<div>
						            				<label class="col-sm-2 control-label" for="ds_host">备注</label>
						            				<div class="form-group col-sm-4">
							                             <input class="form-control" id="remark" type="text" name="remark"/>
							                       </div>
						            			</div>
						            		</div> 
					                    </fieldset>
						            </div>  
						            <div class="modal-footer">  
						                <button type="submit" class="btn btn-info">确定</button>  
						                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>  
						            </div>
					            </form>  
					        </div>  
					    </div>  
					</div>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-striped table-bordered table-hover" id="dataTables-example">
								<thead>
									<tr>
										<th>类型</th>
										<th>类型代码</th>
										<th>字典项</th>
										<th>排序</th>
										<th>是否可用</th>
										<th>描述</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<%
										for (int i = 0; i < ddList.size(); i++) {
											for (int j = 0; j < ddList.get(i).getdList().size(); j++){
									%>
										<tr class="gradeA">
				                            <td class="col-md-2"><%=ddList.get(i).getDictTypeName() %></td>
				                            <td class="col-md-1"><%=ddList.get(i).getDictType() %></td>
				                            <td class="col-md-2"><%=ddList.get(i).getdList().get(j).getDictName() %></td>
				                            <td class="col-md-1"><%=ddList.get(i).getdList().get(j).getSort() %></td>
				                            <td class="col-md-1"><%=ddList.get(i).getdList().get(j).getEnabled() %></td>
				                            <td class="col-md-2"><%=ddList.get(i).getRemark() %></td>
				                            <td class="col-md-3">
				                            	<input type="button" value="新增字典项" class="btn btn-success" data-toggle="modal" data-backdrop="static" data-target="#addModal" onclick="addAssignment('<%=ddList.get(i).getdList().get(ddList.get(i).getdList().size()-1).getId() %>','<%=ddList.get(i).getDictType() %>','<%=ddList.get(i).getDictType() %>')"/>
				                            	<input type="button" value="修改" class="btn btn-primary" data-toggle="modal" data-backdrop="static" data-target="#updateModal" onclick="updateAssignment('<%=ddList.get(i).getdList().get(j).getId()%>','<%=ddList.get(i).getdList().get(j).getDictName() %>','<%=ddList.get(i).getdList().get(j).getSort()%>','<%=ddList.get(i).getDictType() %>')"/>
				                            	<%
				                            		if (ddList.get(i).getdList().get(j).getEnabled().equals("1")) {
				                            	%>
				                            	<input type="button" value="禁用" class="btn btn-danger" onclick="disabledDict('<%=ddList.get(i).getdList().get(j).getId()%>')"/>
				                            	<%		
				                            		} else {
				                            	%>
				                            	<input type="button" value ="启用" class="btn btn-success" onclick="enabledDict('<%=ddList.get(i).getdList().get(j).getId()%>')">
				                            	<%		
				                            		}
				                            	%>
				                            </td>
				                        </tr>
									<%	
											}
										}
									%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 新增字典项的弹出层 -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
 <div class="modal-dialog" role="document">  
     <div class="modal-content">  
         <div class="modal-header">  
             <button type="button" class="close" data-dismiss="modal" aria-label="Close">  
                 <span aria-hidden="true">×</span>  
             </button>  
             <h4 class="modal-title" id="addTitle"></h4>  
         </div>
         <form action="addDictItem.do" method="post" id="addForm"> 
         	<input type="hidden" name="id" id="addId"/> 
         	<input type="hidden" name="dictType" id="addDictItemType"/>   
          <div class="modal-body">  
          	<fieldset>
               <div class="row">
	               	<div>
	               		<label class="col-sm-2 control-label" for="ds_host">字典项</label>
	               		<div class="form-group col-sm-4">
	                      <input class="form-control" id="addDictName" type="text" name="dictName"/>
	                   </div>
	               	</div>
	               	<div>
	               		<label class="col-sm-2 control-label" for="ds_name">排序</label>
	               		<div class="form-group col-sm-4">
	               			<input class="form-control" id="addSort" type="text" name="sort"/>
	               		</div>
	               	</div>
               </div>
            </fieldset>
          </div>  
          <div class="modal-footer">  
              <button type="submit" class="btn btn-info">保存</button>  
	                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>  
	            </div>
            </form>  
        </div>  
    </div>  
</div>
<!-- 修改的弹出层 -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
 <div class="modal-dialog" role="document">  
     <div class="modal-content">  
         <div class="modal-header">  
             <button type="button" class="close" data-dismiss="modal" aria-label="Close">  
                 <span aria-hidden="true">×</span>  
             </button>  
             <h4 class="modal-title" id="updateTitle"></h4>  
         </div>
         <form action="updateDict.do" method="post" id="updateForm"> 
         	<input type="hidden" name="id" id="updateId"/>  
          <div class="modal-body">  
          	<fieldset>
               <div class="row">
	               	<div>
	               		<label class="col-sm-2 control-label" for="ds_host">字典项</label>
	               		<div class="form-group col-sm-4">
	                      <input class="form-control" id="updateDictName" type="text" name="dictName"/>
	                   </div>
	               	</div>
	               	<div>
	               		<label class="col-sm-2 control-label" for="ds_name">排序</label>
	               		<div class="form-group col-sm-4">
	               			<input class="form-control" id="updateSort" type="text" name="sort"/>
	               		</div>
	               	</div>
               </div>
            </fieldset>
          </div>  
          <div class="modal-footer">  
              <button type="submit" class="btn btn-info">保存</button>  
	                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>  
	            </div>
            </form>  
        </div>  
    </div>  
</div>
<!-- Morris Chart Js -->
    <script src="<%=basePath%>assets/js/morris/raphael-2.1.0.min.js"></script>
    <script src="<%=basePath%>assets/js/morris/morris.js"></script>
	
	<script src="<%=basePath%>assets/js/easypiechart.js"></script>
	<script src="<%=basePath%>assets/js/easypiechart-data.js"></script>
	
	 <script src="<%=basePath%>assets/js/Lightweight-Chart/jquery.chart.js"></script>
	
<script type="text/javascript">
//监听被点击的一级菜单
	$(function(){   
		var id = "#sp"+ ${param.pid};
	    $(id).trigger("click");  
	}); 
    var urlstatus=false;
    var count = 0;
    $(".nav-second-level li a").each(function () {  
      if ($(".nav-second-level li:eq("+count+++")").attr('id') == ${param.id}) {
        $(this).addClass('active-menu'); 
        urlstatus = true;
      } else {
        $(this).removeClass('active-menu');
      }
    });
</script>
</body>
</html>