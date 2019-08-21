<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="renderer" content="webkit">
<link rel="stylesheet" href="statics/css/exseen.css">
<link rel="stylesheet" href="statics/layui/css/layui.css">
<style type="text/css">
	.layui-form-label{
 width:35%;
}
/* .layui-form-item{
	margin-left: 35.5%;
} */
 .layui-input-block{
 margin-left:37.5%;
} 
.layui-quote-nm{
 width: 30%;
    margin-left: 37.5%;

}
</style>
</head>
<%String user = request.getSession().getAttribute("user").toString();%>  
<%String role = request.getSession().getAttribute("role").toString();%>  
		        
			<fieldset class="layui-elem-field layui-field-title">
				<legend><%=request.getParameter("bmc")%>-字段编辑
				&nbsp;</legend>
			</fieldset>
			<div class="site-text site-block">
				<form class="layui-form" action="zhxx/doAdd" method="post">
				<input id="guid" name="guid" style="display: none"
				value="<%=request.getParameter("guid")%>">
				<input id="bm" name="bm" style="display: none"
				value="<%=request.getParameter("bm")%>">
				<input id="bmc" name="bmc" style="display: none"
				value="<%=request.getParameter("bmc")%>">
					<div class="layui-form-item">
						<label class="layui-form-label">项目名</label>
						<div class="layui-input-inline">
							<input type="text" id="zdmc" name="zdmc" required value="${msg }"
								 placeholder="请输入项目名" 
								class="layui-input">
						</div>
						<div class="layui-form-mid layui-word-aux"></div>
					</div>
					
					<div class="layui-form-item">
						<label class="layui-form-label">表单类型</label>
						<div class="layui-input-inline">
							<select name="formtypes" id="formtypes" lay-filter="formtypes" lay-search>
								<option value="text">文本</option>
								<option value="textarea">多行文本</option>
								<option value="number">数字</option>
								<option value="date">日期</option>
								<option value="datetime">日期+时间</option>
								<option value="pic">图片</option>
								<option value="file">附件</option>
								<option value="select">下拉列表</option>
								<option value="radio">单项选择</option>
								<option value="checkbox">多项选择</option>
								<option value="country">国家</option>
								<option value="city">省市</option>
							</select>
						</div>
						<div class="layui-form-mid layui-word-aux" id='pic'></div>
					</div>
					<!-- <div class="layui-form-item" >
						<div class="layui-input-inline" id="formtypesOption">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">初始值</label>
						<div class="layui-input-inline">
							<input type="text" id="initVal" name="initVal" 
								 placeholder="select标签等的值(不用输入)" value="0"
							class="layui-input">
						</div>
						<div class="layui-form-mid layui-word-aux"></div>
						<div class="layui-form-mid layui-word-aux">此初始值无需填写,以表单类型为准</div>
					</div> -->
					<div class="layui-form-item">
						<label class="layui-form-label">必填项</label>
						<div class="layui-input-block">
							<input type="radio" name="isform" value="1" title="是" checked>
							<input type="radio" name="isform" value="0" title="否">
						</div>
						<div class="layui-form-mid layui-word-aux"></div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">备注</label>
						<div class="layui-input-inline">
							<input type="text" id="beizhu" name="beizhu" 
								onfocus="if (value ==''){value =''}"
								onblur="if (value ==''){value=''}" placeholder="请输入备注"
								class="layui-input">
						</div>
						<div class="layui-form-mid layui-word-aux"></div>
					</div>
					<div class="layui-form-item">
						<div class="layui-input-block">
							<button class="layui-btn" lay-submit lay-filter="formDemo" onclick="toSubmit">立即提交</button>
							<button type="reset" class="layui-btn layui-btn-primary" onclick="toBack()">返回</button>
						</div>
					</div>
				</form>
			</div>
		<script type="text/javascript" src="statics/layui/layui.js"></script>
		<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
		<script src="statics/js/model/exseen.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				var flag =<%=request.getParameter("flag")%>;
				if (flag == -404) {
					layui.use("layer", function() {
						var layer = layui.layer; //layer初始化
						layer.msg('数据字段已存在..');
					})
				}
			})
				function toBack(){
					window.history.back(-1);
				}
			</script>
		
</html>
