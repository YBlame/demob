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
<link rel="stylesheet" href="statics/layui/admin.css" media="all">
 <link rel="stylesheet" href="statics/css/index.css" media="all">
<style>
.layui-upload-img {
	width: 92px;
	height: 92px;
	margin: 0 10px 10px 0;
}

span {
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="layui-fluid">
		<div class="layui-card">
			<div class="layui-card-header"><%=request.getParameter("bmc")%>-编辑
			</div>
			<div class="layui-card-body" style="padding: 15px;">
			<input id="this" style="display: none" name="this" value="<%=request.getParameter("bm")%>">
			<input id="type" style="display: none" name="type" value="<%=request.getParameter("type")%>">
			<input id="zt" style="display: none" name="zt" value="<%=request.getParameter("zt")%>">
				 <input id="guidBmodel" style="display: none" value="<%=request.getParameter("guidBmodel")%>"> <input id="flag" style="display: none" value="<%=request.getParameter("flag")%>">
				<form id="layui-form" class="layui-form layui-form-pane" action="" onsubmit="return false;" lay-filter="component-form-group" method="post">
					<input id="bmc" style="display: none" name="bmc" value="<%=request.getParameter("bmc")%>">
					<input id="guid" style="display: none" name="guid" value="<%=request.getParameter("guid")%>">
				</form>
			</div>
		</div>
	</div>
	<script src="statics/layui/laydate/laydate.js"></script>
	<script src="statics/layui/layui.js"></script>
	<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
	<script src="statics/js/concisejs.js"></script>
	<script src="statics/js/model/dj/public_edit.js"></script>
	<script>
		$(document).on(
			"mouseenter mouseleave",
			".file-iteme",
			function (event) {
				if (event.type === "mouseenter") {
					//鼠标悬浮			
					var top = $(this).offset().top;
					var left = $(this).offset().left;
					$(this).children().first().next().css("top", top - 23)
						.css("left", left + 10).show();
					$(this).children().first().next().next().css("top",
						top - 23).css("left", left + 40).show();
					$(this).css("background-color", "rgba(0,0,0,0.5)");
					$(this).children().first().css("opacity", "0.5");
				}
				if (event.type === "mouseleave") {
					//鼠标离开
					$(this).children().first().next().hide();
					$(this).children().first().next().next().hide();
					$(this).css("background-color", "");
					$(this).children().first().css("opacity", "1");
				}
			});

		function del(event){
			var img  = $(event).parent().find("img").attr("src");//拿到删除的图片路径
			var input = $(event).parent().parent().find("input").attr("id");//拿到全局input
			var btn = $(event).parent().parent().find("button").attr("id");
			var inputVal  = $("#"+input+"").val();
			var imgDel = img+",",
			inputVal = inputVal.replace(imgDel, '');
			$("#"+input+"").val(inputVal)
			inputVal =$("#"+input+"").val();
			if(inputVal == "" || inputVal == null || inputVal == undefined){
				$("#"+btn+"").css({margin:"auto",display:"block"}) 
			}
			$(event).parent().remove();		
			
		}
	</script>
</body>

</html>
