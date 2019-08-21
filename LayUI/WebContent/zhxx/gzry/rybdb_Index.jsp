<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<link rel="stylesheet" href="statics/layui/css/layui.css" media="all">
</head>

    <div class="layui-fluid">
			<input id="" name="guidBmodel" style="display: none"
				value="<%=request.getParameter("guidBmodel")%>" >
			<input id="guid" name="guid" style="display: none"
				value="<%=request.getParameter("guid")%>">
			<!-- 表名称 -->
			<input type="hidden" id="bmc" value="<%=request.getParameter("bmc")%>">
			<input type="hidden" id="bm" value="<%=request.getParameter("bm")%>">
			<input type="hidden" id="zhxx" value="<%=request.getParameter("zhxx")%>">
			<input type="hidden" id="typeDj" value="<%=request.getParameter("typeDj")%>">
			<!-- flag判断值 -->
			<input type="hidden" id="flag" value="<%=request.getParameter("flag")%>">
			<fieldset class="layui-elem-field layui-field-title"
				 style="margin-top: 20px;">
				<legend><%=request.getParameter("bmc")%></legend>
			</fieldset>
			<form class='layui-form' id="vform" onsubmit="return false" >
				<div id="demoTable">
					<div id='button'  style="display: none;float:left;" >
							&nbsp;&nbsp;&nbsp;<button type='button' id='reload_btn' class='layui-btn layui-inline' data-type='reload'>搜索</button>
							&nbsp;<button type="reset" id='reset' class="layui-btn layui-btn-primary">重置</button>
					</div>
				</div>
			</form>
			<table class="layui-hide"  id="demo" lay-filter="test"></table>
				</div>		
			
		<script src="statics/layui/layui.js"></script>
		<script src="statics/js/concisejs.js"></script>
		<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
		<script src="statics/js/model/gzry/rybdb_Index.js"></script>
</html>
