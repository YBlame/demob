<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<link rel="stylesheet" href="statics/css/exseen.css">
<link rel="stylesheet" href="statics/layui/css/layui.css" media="all">
<style type="text/css">
.layui-form-label{
	width:200px;
}

.layui-input-block {
	margin-left: 37.5%;
}

.layui-quote-nm {
	width: 30%;
	margin-left: 37.5%;
}
</style>
</head>
<link rel="stylesheet" href="statics/layui/admin.css" media="all">
<link rel="stylesheet" href="statics/css/index.css" media="all">
</head>
<body>
	<div class="layui-fluid">
		<div class="layui-card">
			<div class="layui-card-header"><%=request.getParameter("bmc")%>-编辑
			</div>
			<div class="layui-card-body" style="padding: 15px;">
				<input id="guid" style="display: none" value="<%=request.getParameter("guid")%>"> <input id="guidBmodel" style="display: none" value="<%=request.getParameter("guidBmodel")%>"> <input id="flag" style="display: none" value="<%=request.getParameter("flag")%>">
				<form id="layui-form" class="layui-form  layui-form-pane" action="doc/doc_doEdit" onsubmit="return fomrSubmit(this);" method="post"></form>
			</div>
			<div class="rightdiv" style="display: none; z-index: 999">
		      <ul id='ulList_fzr'>
		      </ul>
		    </div>
		</div>
	</div>
	<script src="statics/layui/laydate/laydate.js"></script>
	<script src="statics/layui/layui.js"></script>
	<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
	<script src="statics/js/concisejs.js"></script>
	<script src="statics/js/model/doc_edit.js"></script>
</body>
</html>
