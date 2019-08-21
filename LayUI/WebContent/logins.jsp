<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<!-- saved from url=(0024)https://bg.bjgjlc.com/#/ -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="renderer" content="webkit|ie-comp|ie-stand">
<!--<meta http-equiv="X-UA-Compatible" content="IE=9"/>-->
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
<link rel="shortcut icon" href="https://bg.bjgjlc.com/favicon.ico"
	type="image/x-icon">
<title>登录</title>
<link href="statics/login/spinkit.min.css" rel="stylesheet"
	media="screen">
<link rel="shortcut icon"
	href="https://bg.bjgjlc.com/web-assets/favicon.ico">
<link href="statics/login/antd-2dda4f83a300f981eb1f.css"
	rel="stylesheet">
<link href="statics/login//app-2dda4f83a300f981eb1f.css"
	rel="stylesheet">
</head>
<body>
	<main id="app">
	<section data-reactroot="" class="route-wrapper">
		<section class="login-view h100">
			<div class="rel login-left">
				<div class="login-logo">
					<img class="wp-10 login-logo-img" src="statics/login/logo.png">
				</div>
				<div class="bg-f bdr-5 p30">
					<!-- <form class="ant-form ant-form-horizontal react-ant-form"> -->
						<div class="ant-row ant-form-item react-ant-form-field">
							<div class="ant-col ant-form-item-label">
								<label for="username" class="ant-form-item-required"
									title="登录手机号">登录手机号</label>
							</div>
							<div class="ant-col ant-form-item-control-wrapper">
								<div class="ant-form-item-control">
									<span class="ant-form-item-children"><input type="text"
										placeholder="填写手机号" value=""  id="phone" name="phone" 
										data-__meta="[object Object]" data-__field="[object Object]"
										class="ant-input ant-input-lg"></span>
									<!-- react-empty: 15 -->
								</div>
							</div>
						</div>
						<div class="ant-row ant-form-item react-ant-form-field">
							<div class="ant-col ant-form-item-label">
								<label for="password" class="ant-form-item-required" title="密码">密码</label>
							</div>
							<div class="ant-col ant-form-item-control-wrapper">
								<div class="ant-form-item-control">
									<span class="ant-form-item-children"><input
										type="password" placeholder="填写密码" value="" id="password" name="password"
										data-__meta="[object Object]" data-__field="[object Object]"
										class="ant-input ant-input-lg"></span>
									<!-- react-empty: 23 -->
								</div>
							</div>
						</div>
						<div class="ant-row ant-form-item react-ant-form-submit">
							<!-- react-empty: 25 -->
							<div class="ant-col ant-form-item-control-wrapper">
								<div class="ant-form-item-control">
									<span class="ant-form-item-children"><button
											onclick="toSubmit()" id="submitBtn"
											class="ant-btn wp-10 mb0 ant-btn-primary ant-btn-lg">
											<span>登 录</span>
										</button></span>
									<!-- react-empty: 31 -->
								</div>
							</div>
						</div>
					<!-- </form> -->
					<footer class="tc mt10 lrfix_ ft">
						<span>
							<!-- react-text: 34 -->还没有账号 <!-- /react-text -->
						<a href="reg.jsp">注册</a>
						</span><a href="https://bg.bjgjlc.com/#">忘记密码？</a>
					</footer>
				</div>
				<footer class="abs b0 wp-10 lh-14 mb20 tc">
					<p>版权所有：慧展软件</p>
				</footer>
			</div>
			<div class="login-right">
				<lable class="login-lable1">搭建商系统平台</lable>
				<lable class="login-lable2">高效、便捷、多样性、人性化</lable>
				<lable class="login-lable3">集中统一管理，规范展会搭建流程，提高信息化效率，优化资源配置</lable>
				<img class="login-right-img" src="statics/login//bg-f8ef.jpg">
			</div>
			<div class="login-right2"></div>
		</section>
		<section class="modal-container">
			<div></div>
		</section>
	</section>
	</main>

	<!-- Dependencies -->
	<script src="statics/login/react.min.js"></script>
	<script src="statics/login/react-dom.min.js"></script>

	<!-- Main -->
	<script type="text/javascript"
		src="statics/login/vendors.1e438117700f9d89acc6.js"></script>
	<script type="text/javascript"
		src="statics/login/common-2dda4f83a300f981eb1f.min.js"></script>
	<!-- <script type="text/javascript"
		src="statics/login/app-2dda4f.bundle.js"></script> -->
		<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
	<script type="text/javascript">
	document.onkeydown = function(e) {
        e = e || window.event;
        if(e.keyCode == 13) {
        	$("#submitBtn").click();
            return false;
        }
    }
	function toSubmit(){
		var sj = $("#phone").val();
		var mm = $("#password").val();
		$.post("loginIn", {
			sj : sj,
			mm : mm
		}, function(result) {
			if (result=="loginLose") {
				alert("账号或密码错误")
            }else if(result=="loginStop"){
            	alert("您的账号还未审核，请联系工作人员");
            }else {
                location.href = 'toIndex'; //后台主页
            } 
		});
	}
	
	</script>
</body>
</html>