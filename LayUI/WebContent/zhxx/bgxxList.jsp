<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet" href="statics/layui/css/layui.css" media="all">
</head>
<body>
	<div class="layui-fluid">
		<input id="" name="guidBmodel" style="display: none"
			value="<%=request.getParameter("guidBmodel")%>"> <input id="guid" name="guid"
			style="display: none" value="<%=request.getParameter("guid")%>">
		<!-- flag判断值 -->
		<input type="hidden" id="flag" value="<%=request.getParameter("flag")%>">
		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
			<legend>报馆信息审核</legend>
		</fieldset>
		<table class="layui-hide" id="demo" lay-filter="test"></table>
		<script type="text/html" id="toolbarDemo">
  				<div class="layui-btn-container">
				</div>
			</script>
		<script src="statics/layui/layui.js"></script>
		<script src="statics/js/concisejs.js"></script>
		<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
		<script src="statics/js/model/gzry_Index.js"></script>
	</div>
</body>
</html>
