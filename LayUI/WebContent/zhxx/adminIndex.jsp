<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>慧展软件管理后台</title>
<meta ZHMC="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta ZHMC="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="statics/layui/css/layui.css" media="all">

</head>
<body>
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
   <div class="layui-logo">慧展</div>
   <div title="菜单缩放" class="kit-side-fold"><i class="fa fa-navicon" aria-hidden="true"></i></div>
	   <ul class="layui-nav layui-layout-left" lay-filter="top_expo_nav" id="top_expo_nav">
	      <!-- <li class="layui-nav-item layadmin-flexible" lay-unselect>
            <a href="javascript:;" layadmin-event="flexible" title="侧边伸缩">
              <i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
            </a>
          </li> -->
	      <li class="layui-nav-item" id ="zhxx">
	      
	      </li>
	    </ul>
		<ul class="layui-nav layui-layout-right">
		      <li class="layui-nav-item">
		        <a href="javascript:;">
		        	<%String user = request.getSession().getAttribute("user").toString();%>  
					<%=user %>  
					<%String role = request.getSession().getAttribute("role").toString();%>  
						，<%=role %>  
		        </a>
		      </li>
		      <li class="layui-nav-item"><a href="javascript:userOut();" target="_parent">退出</a></li>
  		</ul>
	</div>
  
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
    <div title="菜单缩放" class="kit-side-fold"><i class="fa fa-navicon" aria-hidden="true"></i></div>
       
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree site-demo-nav" lay-filter="test">
       			<li class="layui-nav-item layui-nav-itemed" >
       			 	<a href="javascript:;">展会管理</a>
			            <dl class="layui-nav-child" >
			               <dd><a href="javascript:findZhxx();" data-url="">展会信息</a></dd>
			            <dd><a href="javascript:toZggl();" data-url="toMenu">展馆管理</a></dd>
			            <dd><a href="javascript:toZwgl();" data-url="">展位管理</a></dd>
			             <dd><a href="javascript:toZhgg();" data-url="">消息通知</a></dd>
			              <dd><a href="javascript:findFybz();" data-url="">费用标准</a></dd>
			              <dd><a href="javascript:findRddjs();" data-url="">入围搭建商</a></dd>
			          </dl>
		        </li>
				 <li class="layui-nav-item layui-nav-itemed">
			          <a href="javascript:;">系统设置</a>
			          <dl class="layui-nav-child" id="system" >
			            <dd><a href="javascript:toSystem();" data-url="toMenu">菜单管理</a></dd>
			            <dd><a href="javascript:toRule();" data-url="">权限管理</a></dd>
			             <dd><a href="javascript:toSyrgl();" data-url="">人员管理</a></dd>
			          </dl>
		        </li>
			</ul>
    </div>
  </div>
	<div class="layui-body">
    <!-- 内容主体区域 -->
    	<div style="width: 99%; height: 100%">
    		<iframe src="findZhxx" frameborder="0" id="demoAdmin"
		style="width: 99%; height: 99%"></iframe>
		</div>
 	 </div>
	<div class="layui-footer" style="text-align:  center;">
			<!-- 底部固定区域 -->
			© - 慧展软件
	</div>
</div>
	<script src="statics/layui/layui.js"></script>
	<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
	<script src="statics/js/concisejs.js"></script>
	<script type="text/javascript" src="statics/js/model/adminIndex.js"></script>
</body>
</html>