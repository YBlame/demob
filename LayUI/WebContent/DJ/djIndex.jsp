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
	   <ul class="layui-nav layui-layout-left" lay-filter="top_expo_nav" id="top_expo_nav">
	      <li class="layui-nav-item" id ="zhxx">
	      </li>
	    </ul>
		<ul class="layui-nav layui-layout-right">
		      <li class="layui-nav-item">
		        <a href="javascript:;">
		        	<%String user = request.getSession().getAttribute("user").toString();%>  
					<%=user %>  
					<%String role = request.getSession().getAttribute("role").toString();%>  
						&nbsp;<%=role %>  
		        </a>
		      </li>
		      <li class="layui-nav-item"><a href="javascript:userOut();">退出</a></li>
  		</ul>
	</div>
  
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree site-demo-nav" lay-filter="test" id="leftMenu">
       			<li class="layui-nav-item layui-nav-itemed" id="indexJSP">
					<a class="" href="javascript:toIndex();">
						<i class="layui-icon layui-icon-home"></i>
                		<cite>主页</cite>
					</a>
				</li>
				<li class="layui-nav-item layui-nav-itemed" >
       			 	<a href="javascript:toUserInfo();">基本信息</a>
		        </li>
		        <li class="layui-nav-item layui-nav-itemed" >
       			 	<a href="javascript:toBgxx();">我要报馆</a>
		        </li>
		</ul>
    </div>
  </div>
	<div class="layui-body">
    <!-- 内容主体区域 -->
    	<div style="width: 99%; height: 100%">
    		<iframe src="DJ/index.jsp" frameborder="0" id="demoAdmin"
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
	<script src="statics/js/concisejs.js"></script><!-- 
	<script src="statics/js/model/index/indexBgxx.js"></script>
	<script src="statics/js/model/index/indexXxtz.js"></script> -->
	<script src="statics/js/model/djIndex.js"></script>
	
</body>
</html>