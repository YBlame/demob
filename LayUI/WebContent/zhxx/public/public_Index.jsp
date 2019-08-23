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
<link rel="stylesheet" href="statics/css/common.css" media="all">
</head>
    <div class="layui-fluid">
			<input id="guid" name="guid" style="display: none"
				value="<%=request.getParameter("guid")%>">
			<!-- 表名称 -->
			<input type="hidden" id="bmc" value="<%=request.getParameter("bmc")%>">
			<!-- flag判断值 -->
			<input type="hidden" id="flag" value="<%=request.getParameter("flag")%>">
			<input type="hidden" id="zhxxGuid" value="<%=request.getParameter("zhxxGuid")%>">
			<fieldset class="layui-elem-field layui-field-title"
				 style="margin-top: 20px;">
				<legend><%=request.getParameter("bmc")%></legend>
			</fieldset>
			<form class='layui-form' id="vform" onsubmit="return false" >
				<div id="demoTable" style='position:relative;'>
					<div id='button'  style="display: none" >
							&nbsp;&nbsp;&nbsp;<button type='button' id='reload_btn' class='layui-btn layui-inline' data-type='reload'>查询</button>
							&nbsp;<button type="reset" id='reset' class="layui-btn layui-btn-primary">重置</button>
					</div>
				</div>
			</form>
			<table class="layui-hide"  id="demo" lay-filter="test" style="height: 100%" ></table>
				</div>
			<script type="text/html" id="barDemo">
  					<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  					<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
			</script>
			<script type="text/html" id="toolbarDemo">
  				<div class="layui-btn-container">
    				<button type="button" class="layui-btn layui-btn-sm" lay-event="add">添加</button>
    				<button type="button" class="layui-btn layui-btn-warm layui-btn-sm" lay-event="update">修改</button>
    				<button type="button" class="layui-btn layui-btn-danger layui-btn-sm" lay-event="delete">删除</button>
				</div>
			</script>
		<script src="statics/layui/layui.js"></script>
		<script src="statics/js/concisejs.js"></script>
		<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
		<script src="statics/js/model/public/public_Index.js"></script>
</html>
