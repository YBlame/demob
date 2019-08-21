<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<!-- saved from url=(0038)https://bg.bjgjlc.com/#/registers/main -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
<title>新用户注册</title>
<link href="statics/login/spinkit.min.css" rel="stylesheet"
	media="screen">
<link rel="shortcut icon"
	href="https://bg.bjgjlc.com/web-assets/favicon.ico">
<link href="statics/login/antd-2dda4f83a300f981eb1f.css"
	rel="stylesheet">
<link href="statics/login/app-2dda4f83a300f981eb1f.css" rel="stylesheet">
<script src="statics/js/dj/jquery-1.7.1.js"></script>
<style type="text/css">
span{cursor: pointer;}
 
</style>
</head>
<body>
	<main id="app">
	<section data-reactroot="" class="route-wrapper">
		<!-- react-empty: 56 -->
		<!-- react-empty: 51 -->
		<div class="step1 illegal-records-add register-view">
			<header class="z3 rel exw-header ant-layout-header">
				<nav class="app-col auto rel h100 lrfix_ ">
					<a href="login.jsp"
						><img class="wp-10" style="height: 68px;width: 185px;"
						src="statics/login/logo.png"></a>
					<div hidden=""
						class="h100 lh-20 webkit-sassui-vim-center mr30 right">
						<div class="webkit-sassui-icon-text exhibition-selector"
							style="width: 246px;">
							<i aria-label="图标: environment-o"
								class="anticon anticon-environment-o mr10 dtbc"
								style="font-size: 40px;"><svg viewBox="64 64 896 896"
									class="" data-icon="environment" width="1em" height="1em"
									fill="currentColor" aria-hidden="true" focusable="false">
									<path
										d="M854.6 289.1a362.49 362.49 0 0 0-79.9-115.7 370.83 370.83 0 0 0-118.2-77.8C610.7 76.6 562.1 67 512 67c-50.1 0-98.7 9.6-144.5 28.5-44.3 18.3-84 44.5-118.2 77.8A363.6 363.6 0 0 0 169.4 289c-19.5 45-29.4 92.8-29.4 142 0 70.6 16.9 140.9 50.1 208.7 26.7 54.5 64 107.6 111 158.1 80.3 86.2 164.5 138.9 188.4 153a43.9 43.9 0 0 0 22.4 6.1c7.8 0 15.5-2 22.4-6.1 23.9-14.1 108.1-66.8 188.4-153 47-50.4 84.3-103.6 111-158.1C867.1 572 884 501.8 884 431.1c0-49.2-9.9-97-29.4-142zM512 880.2c-65.9-41.9-300-207.8-300-449.1 0-77.9 31.1-151.1 87.6-206.3C356.3 169.5 431.7 139 512 139s155.7 30.5 212.4 85.9C780.9 280 812 353.2 812 431.1c0 241.3-234.1 407.2-300 449.1zm0-617.2c-97.2 0-176 78.8-176 176s78.8 176 176 176 176-78.8 176-176-78.8-176-176-176zm79.2 255.2A111.6 111.6 0 0 1 512 551c-29.9 0-58-11.7-79.2-32.8A111.6 111.6 0 0 1 400 439c0-29.9 11.7-58 32.8-79.2C454 338.6 482.1 327 512 327c29.9 0 58 11.6 79.2 32.8C612.4 381 624 409.1 624 439c0 29.9-11.6 58-32.8 79.2z"></path></svg></i><span
								class="dtbc"></span><i aria-label="图标: down"
								class="anticon anticon-down"><svg viewBox="64 64 896 896"
									class="" data-icon="down" width="1em" height="1em"
									fill="currentColor" aria-hidden="true" focusable="false">
									<path
										d="M884 256h-75c-5.1 0-9.9 2.5-12.9 6.6L512 654.2 227.9 262.6c-3-4.1-7.8-6.6-12.9-6.6h-75c-6.5 0-10.3 7.4-6.5 12.7l352.6 486.1c12.8 17.6 39 17.6 51.7 0l352.6-486.1c3.9-5.3.1-12.7-6.4-12.7z"></path></svg></i>
						</div>
						<!-- react-empty: 71 -->
						<div class="mx30 ant-divider ant-divider-vertical"
							style="height: 70%;"></div>
						<span class="f20 ant-dropdown-trigger"><i
							aria-label="图标: user" class="anticon anticon-user"><svg
									viewBox="64 64 896 896" class="" data-icon="user" width="1em"
									height="1em" fill="currentColor" aria-hidden="true"
									focusable="false">
									<path
										d="M858.5 763.6a374 374 0 0 0-80.6-119.5 375.63 375.63 0 0 0-119.5-80.6c-.4-.2-.8-.3-1.2-.5C719.5 518 760 444.7 760 362c0-137-111-248-248-248S264 225 264 362c0 82.7 40.5 156 102.8 201.1-.4.2-.8.3-1.2.5-44.8 18.9-85 46-119.5 80.6a375.63 375.63 0 0 0-80.6 119.5A371.7 371.7 0 0 0 136 901.8a8 8 0 0 0 8 8.2h60c4.4 0 7.9-3.5 8-7.8 2-77.2 33-149.5 87.8-204.3 56.7-56.7 132-87.9 212.2-87.9s155.5 31.2 212.2 87.9C779 752.7 810 825 812 902.2c.1 4.4 3.6 7.8 8 7.8h60a8 8 0 0 0 8-8.2c-1-47.8-10.9-94.3-29.5-138.2zM512 534c-45.9 0-89.1-17.9-121.6-50.4S340 407.9 340 362c0-45.9 17.9-89.1 50.4-121.6S466.1 190 512 190s89.1 17.9 121.6 50.4S684 316.1 684 362c0 45.9-17.9 89.1-50.4 121.6S557.9 534 512 534z"></path></svg></i><i
							aria-label="图标: down" class="anticon anticon-down"><svg
									viewBox="64 64 896 896" class="" data-icon="down" width="1em"
									height="1em" fill="currentColor" aria-hidden="true"
									focusable="false">
									<path
										d="M884 256h-75c-5.1 0-9.9 2.5-12.9 6.6L512 654.2 227.9 262.6c-3-4.1-7.8-6.6-12.9-6.6h-75c-6.5 0-10.3 7.4-6.5 12.7l352.6 486.1c12.8 17.6 39 17.6 51.7 0l352.6-486.1c3.9-5.3.1-12.7-6.4-12.7z"></path></svg></i></span>
					</div>
				</nav>
			</header>
			<div
				class="wp-8 trbl0 abs p20 bg-f webkit-sassui-transform-center-x bd">
				<h3 class="mb10">
					<a href="logins.jsp"><i aria-label="图标: left"
						class="anticon anticon-left"><svg viewBox="64 64 896 896"
								class="" data-icon="left" width="1em" height="1em"
								fill="currentColor" aria-hidden="true" focusable="false">
								<path
									d="M724 218.3V141c0-6.7-7.7-10.4-12.9-6.3L260.3 486.8a31.86 31.86 0 0 0 0 50.3l450.8 352.1c5.3 4.1 12.9.4 12.9-6.3v-77.3c0-4.9-2.3-9.6-6.1-12.6l-360-281 360-281.1c3.8-3 6.1-7.7 6.1-12.6z"></path></svg></i><span>返回登录</span></a>
				</h3>
				<h2 class="f20 mb20 b">注册新用户</h2>
				<div
					class="ant-steps ant-steps-horizontal ant-steps-label-horizontal"
					style="width: 50%;">
					<div class="ant-steps-item ant-steps-item-process">
						<div class="ant-steps-item-tail"></div>
						<div class="ant-steps-item-icon">
							<span class="ant-steps-icon">1</span>
						</div>
						<div class="ant-steps-item-content">
							<div class="ant-steps-item-title">手机注册验证</div>
						</div>
					</div>
					<div class="ant-steps-item ant-steps-item-wait">
						<div class="ant-steps-item-tail"></div>
						<div class="ant-steps-item-icon">
							<span class="ant-steps-icon">2</span>
						</div>
						<div class="ant-steps-item-content">
							<div class="ant-steps-item-title">个人和公司信息</div>
						</div>
					</div>
				</div>
				<div class="blank-40"></div>
				<div class="mb20_ mb__ form-view">
					<div class="ant-row-flex ant-row-flex-middle">
						<div class="ant-col ant-col-4">
							<strong class="f14 c-gray"><span class="c-red">*</span>
								<!-- react-text: 107 -->登录手机号:<!-- /react-text --></strong>
						</div>
						<div class="ant-col ant-col-7">
							<input type="text" placeholder="登录手机号" value=""
								class="x-input ant-input ant-input-lg" name="phone" id="phone">
						</div>
						<div class="ant-col ant-col-3">
							<button id="btn" type="button" onclick="SendSmsCpatcha()"
								class="ant-btn ml10 ant-btn-primary ant-btn-lg">
								<span>发送验证码</span>
							</button>
						</div>
					</div>
					<div class="ant-row-flex ant-row-flex-middle">
						<div class="ant-col ant-col-4">
							<strong class="f14 c-gray"><span class="c-red">*</span>
								<!-- react-text: 117 -->手机验证码:<!-- /react-text --></strong>
						</div>
						<div class="ant-col ant-col-7">
							<input type="text" value="" placeholder="手机验证码"
								class="x-input ant-input ant-input-lg" name="yzm">
						</div>
					</div>
					<div class="ant-row-flex ant-row-flex-middle">
						<div class="ant-col ant-col-4">
							<strong class="f14 c-gray"><span class="c-red">*</span>
								<!-- react-text: 124 -->密码:<!-- /react-text --></strong>
						</div>
						<div class="ant-col ant-col-7">
							<input type="password" placeholder="密码" value=""
								class="x-input ant-input ant-input-lg" name="mm">
						</div>
					</div>
					<div class="ant-row-flex ant-row-flex-middle">
						<div class="ant-col ant-col-4">
							<strong class="f14 c-gray"><span class="c-red">*</span>
								<!-- react-text: 131 -->再次输入密码:<!-- /react-text --></strong>
						</div>
						<div class="ant-col ant-col-7">
							<input type="password" placeholder="再次输入密码" value=""
								class="x-input ant-input ant-input-lg" name="qrmm">
						</div>
					</div>
					<footer class="tl">
						<div class="ant-row">
							<div class="ant-col ant-col-7 ant-col-offset-4">
								<button type="button" class="ant-btn ant-btn-primary ant-btn-lg"
									style="width: 120px;">

									<a id="nextRegister" onclick="LoginOne()"><span>下一步</span></a>
								</button>
							</div>
						</div>
					</footer>
				</div>
			</div>
		</div>
		<!-- react-empty: 53 -->
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
	<!-- 	<script type="text/javascript"
		src="statics/login/app-2dda4f.bundle.js"></script> -->
</body>
</html>

<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
<script src="statics/js/concisejs.js"></script>
<script type="text/javascript">
$(function () {


});

//获取短信验证码
function SendSmsCpatcha() {
    var phoneNumber = $('[name=phone]');
    if ($.trim(phoneNumber.val()) === '') {
        alert('请填写完整');
        phoneNumber.css({ 'borderColor': 'red' }).focus();
        return;
    }
    $.ajax({
        type: 'POST',
        url: 'dj/SendSmsCaptchaForRegister?tick=' + new Date().getTime(),
        cache: false,
        data: {'phoneNumber': $.trim(phoneNumber.val()) },
        dataType: 'JSON',
        success: function (data) {
            //ChangeCaptcha();
            
            if (data.success) {
                $('[name=sms-captcha]').focus();
                Countdown();
            }else{
            	alert(data.msg)
            }
        }
    });
}

//倒计时
var clock;
function Countdown() {
    var btn = $('#btn');
    var nums = 59;
    btn.css('color', 'white').removeAttr('onclick').html('重新获取(' + nums + ')');
    clock = setInterval(function () {
        nums--;
        if (nums > 0) {
            btn.html('重新获取(' + nums + ')');
        } else {
            clearInterval(clock);
            btn.css('color', 'white').attr('onclick', 'SendSmsCpatcha()').html('获取验证码');
            nums = 59;
        }
    }, 1000);
}

function LoginOne() {
    var phone = $.trim($('[name=phone]').val());
    var mm = $.trim($('[name=mm]').val());
    if (!Validate()) return;
    cj.setCookie('user_phone', phone, 365);
    cj.setCookie('user_mm', mm, 365);
    $("#nextRegister").attr("href","register.jsp");
}

function Validate() {
    var success = true;
    $('.x-input').each(function () {
        var JQthis = $(this);
        if ($.trim(JQthis.val()) === '') {
            alert('请填写完整');
            JQthis.focus();
            success = false;
            return false;
        }
        return true;
    });
    if (!success) return false;
    var regphone = new RegExp(/^1[0-9]{10}$/);
    if (!regphone.test($.trim($('#phone').val()))) {
        alert('手机号格式不正确');
       // $('#phone').css({ 'borderColor': 'red' }).focus();
        $('#phone').focus();
        return false;
    }
    if ($.trim($('[name=mm]').val())!=$.trim($('[name=qrmm]').val())) {
        alert('两次密码输入不一致，请重新输入'); 
        $('[name=mm]').focus();
        return false;
    }
    return true;
}

	
</script>