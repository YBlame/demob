<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="renderer" content="webkit|ie-comp|ie-stand">
<!--<meta http-equiv="X-UA-Compatible" content="IE=9"/>-->
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
<link rel="shortcut icon" href="https://bg.bjgjlc.com/favicon.ico"
	type="image/x-icon">
<title>新用户注册</title>
<link href="statics/login/spinkit.min.css" rel="stylesheet"
	media="screen">
<link rel="shortcut icon"
	href="https://bg.bjgjlc.com/web-assets/favicon.ico">
<link href="statics/login/antd-2dda4f83a300f981eb1f.css"
	rel="stylesheet">
<link href="statics/login/app-2dda4f83a300f981eb1f.css" rel="stylesheet">
<link rel="stylesheet" href="statics/layui/css/layui.css" media="all">
<style type="text/css">
   .layui-upload-img {
    width: 92px;
    height: 92px;
    margin: 0 10px 10px 0;
}
span{cursor: pointer;}
 
</style>
</head>
<body>
	<main id="app">
	<section data-reactroot="" class="route-wrapper">
		<!-- react-empty: 56 -->
		<!-- react-empty: 51 -->
		<!-- react-empty: 139 -->
		<div class="step2 illegal-records-add register-view">
			<header class="z3 rel exw-header ant-layout-header">
				<nav class="app-col auto rel h100 lrfix_ ">
					<a href="https://bg.bjgjlc.com/#/admin/dashboards/index"
						class="login-logo"><img class="wp-10"  style="height: 68px;width: 185px;"
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
						<!-- react-empty: 154 -->
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
			<div class="wp-8 auto p20 bg-f bd">
				<h3 class="mb10">
					<a href="login.jsp"><i aria-label="图标: left"
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
					<div class="ant-steps-item ant-steps-item-finish">
						<div class="ant-steps-item-tail"></div>
						<div class="ant-steps-item-icon">
							<span class="ant-steps-icon"><i aria-label="图标: check"
								class="anticon anticon-check ant-steps-finish-icon"><svg
										viewBox="64 64 896 896" class="" data-icon="check" width="1em"
										height="1em" fill="currentColor" aria-hidden="true"
										focusable="false">
										<path
											d="M912 190h-69.9c-9.8 0-19.1 4.5-25.1 12.2L404.7 724.5 207 474a32 32 0 0 0-25.1-12.2H112c-6.7 0-10.4 7.7-6.3 12.9l273.9 347c12.8 16.2 37.4 16.2 50.3 0l488.4-618.9c4.1-5.1.4-12.8-6.3-12.8z"></path></svg></i></span>
						</div>
						<div class="ant-steps-item-content">
							<div class="ant-steps-item-title">手机注册验证</div>
						</div>
					</div>
					<div class="ant-steps-item ant-steps-item-process">
						<div class="ant-steps-item-tail"></div>
						<div class="ant-steps-item-icon">
							<span class="ant-steps-icon">2</span>
						</div>
						<div class="ant-steps-item-content">
							<div class="ant-steps-item-title">个人和公司信息</div>
						</div>
					</div>
				</div>
				<form action="" method="post" id="insertUser">
					<input type="text" id="sj" name="sj" style="display: none"/>
					<input type="text" id="mm" name="mm" style="display: none"/>
					<div class="details-component ">
						<div class="details-component-body ">
							<div
								class="details-component-title details-component-line-margin  ">个人信息</div>
							<div class="ant-row details-component-merger ">
								<div class="ant-col ant-col-12">
									<div
										class="ant-row details-component-info details-component-line-margin  details-component-inputinfo">
										<div title="姓名" class="ant-col ant-col-6 info-text">姓名</div>
										<div data-helper="验证错误" class="ant-col ant-col-18">
											<input type="text" placeholder="填写姓名" name="NAME" id="name"
												class="ant-input ant-input-lg bitian">
										</div>
									</div>
								</div>
								<div class="ant-col ant-col-12">
									<div
										class="ant-row details-component-info details-component-line-margin  details-component-inputinfo">
										<div title="职务" class="ant-col ant-col-6 info-text">职务</div>
										<div data-helper="验证错误" class="ant-col ant-col-18">
											<input type="text" placeholder="职务(选填)" name="ZW" id="zw"
												class="ant-input ant-input-lg ">
										</div>
									</div>
								</div>
							</div>
							<div class="ant-row details-component-merger ">
								<div class="ant-col ant-col-12">
									<div
										class="ant-row details-component-info details-component-line-margin  details-component-inputinfo">
										<div title="身份证号" class="ant-col ant-col-6 info-text">身份证号</div>
										<div data-helper="验证错误" class="ant-col ant-col-18">
											<input type="text" placeholder="填写身份证号" name="SFZ" id="sfz"
												class="ant-input ant-input-lg bitian">
										</div>
									</div>
								</div>
								<div class="ant-col ant-col-12">
									<div
										class="ant-row details-component-info details-component-line-margin  details-component-inputinfo">
										<div title="微信号" class="ant-col ant-col-6 info-text">微信号</div>
										<div data-helper="验证错误" class="ant-col ant-col-18">
											<input type="text" placeholder="微信号(选填)" name="WXH" id="wxh"
												class="ant-input ant-input-lg">
										</div>
									</div>
								</div>
							</div>
							<div class="ant-row details-component-merger ">
								<div class="ant-col ant-col-12">
									<div
										class="ant-row details-component-info details-component-line-margin  details-component-inputinfo">
										<div title="邮箱" class="ant-col ant-col-6 info-text">邮箱</div>
										<div data-helper="验证错误" class="ant-col ant-col-18">
											<input type="text" placeholder="填写邮箱" name="EMAIL" id="email"
												class="ant-input ant-input-lg bitian">
										</div>
									</div>
								</div>
								<div class="ant-col ant-col-12"></div>
							</div>
							<div
								class="ant-row details-component-info details-component-line-margin  details-component-inputinfo">
								<div title="邮寄地址" class="ant-col ant-col-3 info-text">邮寄地址</div>
								<div data-helper="验证错误" class="ant-col ant-col-21">
									<input type="text" placeholder="填写邮寄地址" name="YJDZ" id="yjdz"
										class="ant-input ant-input-lg bitian">
								</div>
							</div>
							<div class="details-component-notedraggerinfo ">
								<p>
									<span class="info-text">身份证扫描件</span>
								</p>
								<!-- 			<div
									class="ant-row details-component-info details-component-line-margin  details-component-draggerinfo    empty-list">
									<div title="" class="ant-col ant-col-0 info-text"></div>
									<div data-helper="请选择需要上传的文件" class="ant-col ant-col-24">
										<span class=""><div
												class="ant-upload-list ant-upload-list-picture-card"></div>
											<div
												class="ant-upload ant-upload-select ant-upload-select-picture-card">
												<span tabindex="0" class="ant-upload" role="button"><input
													type="file" accept=".jpg,.png,.jpeg" multiple=""
													style="display: none;">
													<p class="ant-upload-hint">
														<span>加盖公章的个人身份证扫描件</span><span class="required-text">(必选)</span>
														<button type="button" class="ant-btn ant-btn-lg">
															<span>添加文件</span>
														</button>
													</p></span>
											</div></span>
										react-empty: 233
									</div>
								</div> -->
	
								<div id='sndc'>
									<div class="layui-form-item">
										<div class="layui-upload">
											<blockquote class="layui-elem-quote layui-quote-nm"
												style="margin-top: 10px;">
												身份证扫描件预览图：
												<div class="layui-upload-list" id="sfzDiv">
												<input id='sfzsmj' name='sfzsmj' style='display: none' lay-verify="required" lay-reqtext="身份证扫描件不能为空"  />
													<button type="button" class="layui-btn"
														style="display: block; margin: 0 auto" id="sfzsmjBtn">加盖公章的个人身份证扫描件</button>
												</div>
											</blockquote>
										</div>
									</div>
								</div>
								<p class="details-component-line-margin"
									style="margin-bottom: 0px;">注意：请上传加盖公章的个人身份证的正反面扫描件，单个图片不超过1M</p>
							</div>
							<div
								class="details-component-divider ant-divider ant-divider-horizontal"></div>
							<div
								class="details-component-title details-component-line-margin  ">公司信息</div>
							<div class="ant-row details-component-merger ">
								<div class="ant-col ant-col-12">
									<div
										class="ant-row details-component-info details-component-line-margin  details-component-inputinfo">
										<div title="公司名称" class="ant-col ant-col-6 info-text">公司名称</div>
										<div data-helper="验证错误" class="ant-col ant-col-18">
											<input type="text" placeholder="填写公司名称" name="GSMC" id="gsmc"
												class="ant-input ant-input-lg bitian">
										</div>
									</div>
								</div>
								<div class="ant-col ant-col-12">
									<div
										class="ant-row details-component-info details-component-line-margin  details-component-inputinfo">
										<div title="传真" class="ant-col ant-col-6 info-text">传真</div>
										<div data-helper="验证错误" class="ant-col ant-col-18">
											<input type="text" placeholder="传真(选填)" name="CZ" id="cz"
												class="ant-input ant-input-lg">
										</div>
									</div>
								</div>
							</div>
							<div
								class="ant-row details-component-info details-component-line-margin  details-component-inputinfo">
								<div title="办公地址" class="ant-col ant-col-3 info-text">办公地址</div>
								<div data-helper="验证错误" class="ant-col ant-col-21">
									<input type="text" placeholder="填写办公地址" name="BGDZ" id="bgdz"
										class="ant-input ant-input-lg bitian">
								</div>
							</div>
							<div class="ant-row details-component-merger ">
								<div class="ant-col ant-col-12">
									<div
										class="ant-row details-component-info details-component-line-margin  details-component-inputinfo">
										<div title="法人姓名" class="ant-col ant-col-6 info-text">法人姓名</div>
										<div data-helper="验证错误" class="ant-col ant-col-18">
											<input type="text" placeholder="填写法人姓名" name="FRXM" id="frxm"
												class="ant-input ant-input-lg bitian">
										</div>
									</div>
								</div>
								<div class="ant-col ant-col-12">
									<div
										class="ant-row details-component-info details-component-line-margin  details-component-inputinfo">
										<div title="法人手机号" class="ant-col ant-col-6 info-text">法人手机号</div>
										<div data-helper="验证错误" class="ant-col ant-col-18">
											<input type="text" placeholder="填写法人手机号" name="FRSJH" id="frsjh"
												class="ant-input ant-input-lg bitian">
										</div>
									</div>
								</div>
							</div>
							<div class="ant-row details-component-merger ">
								<div class="ant-col ant-col-12">
									<div
										class="ant-row details-component-info details-component-line-margin  details-component-inputinfo">
										<div title="法人身份证号" class="ant-col ant-col-6 info-text">法人身份证号</div>
										<div data-helper="验证错误" class="ant-col ant-col-18">
											<input type="text" placeholder="填写法人身份证号" name="FRSFZ" id="frsfz"
												class="ant-input ant-input-lg bitian">
										</div>
									</div>
								</div>
								<div class="ant-col ant-col-12">
									<div
										class="ant-row details-component-info details-component-line-margin  details-component-inputinfo">
										<div title="法人座机" class="ant-col ant-col-6 info-text">法人座机</div>
										<div data-helper="验证错误" class="ant-col ant-col-18">
											<input type="text" placeholder="法人座机(选填)" name="FRZJ" id="frzj"
												class="ant-input ant-input-lg">
										</div>
									</div>
								</div>
							</div>
							<div class="details-component-notedraggerinfo ">
								<p></p>
								<!-- 			<div
									class="ant-row details-component-info details-component-line-margin  details-component-draggerinfo    empty-list">
									<div title="" class="ant-col ant-col-0 info-text"></div>
									<div data-helper="请选择需要上传的文件" class="ant-col ant-col-24">
										<span class=""><div
												class="ant-upload-list ant-upload-list-picture-card"></div>
											<div
												class="ant-upload ant-upload-select ant-upload-select-picture-card">
												<span tabindex="0" class="ant-upload" role="button"><input
													type="file" accept=".JPG" multiple="" style="display: none;">
													<p class="ant-upload-hint">
														<span>营业执照</span><span class="required-text">(必选)</span>
														<button type="button" class="ant-btn ant-btn-lg">
															<span>添加文件</span>
														</button>
													</p></span>
											</div></span>
										react-empty: 293
									</div>
								</div> -->
								<div id='sndc'>
									<div class="layui-form-item">
										<div class="layui-upload">
											<blockquote class="layui-elem-quote layui-quote-nm"
												style="margin-top: 10px;">
												营业执照：
												<div class="layui-upload-list" id="yyzzDiv">
												<input id='yyzz' name='yyzz' style='display: none' lay-verify="required" lay-reqtext="营业执照不能为空"  />
													<button type="button" class="layui-btn"
														style="display: block; margin: 0 auto" id="yyzzBtn">营业执照</button>
												</div>
											</blockquote>
										</div>
									</div>
								</div>
								<p class="details-component-line-margin"
									style="margin-bottom: 0px;">注意：单个图片不超过1M，支持JPG格式。</p>
							</div>
							<div class="details-component-notedraggerinfo ">
								<p></p>
								<!-- 	<div
									class="ant-row details-component-info details-component-line-margin  details-component-draggerinfo    empty-list">
									<div title="" class="ant-col ant-col-0 info-text"></div>
									<div data-helper="请选择需要上传的文件" class="ant-col ant-col-24">
										<span class=""><div
												class="ant-upload-list ant-upload-list-picture-card"></div>
											<div
												class="ant-upload ant-upload-select ant-upload-select-picture-card">
												<span tabindex="0" class="ant-upload" role="button"><input
													type="file" accept=".JPG" multiple="" style="display: none;">
												<p class="ant-upload-hint">
														<span>上传法人身份证</span><span class="required-text">(必选)</span>
														<button type="button" class="ant-btn ant-btn-lg">
															<span>添加文件</span>
														</button>
													</p></span>
											</div></span>
										react-empty: 304
									</div> -->
	
								<div id='sndc'>
									<div class="layui-form-item">
										<div class="layui-upload">
											<blockquote class="layui-elem-quote layui-quote-nm"
												style="margin-top: 10px;">
												法人身份证：
												<div class="layui-upload-list" id="frsfzDiv">
												<input id='frsfzz' name='frsfzz' style='display: none' lay-verify="required" lay-reqtext="法人身份证不能为空"  />
													<button type="button" class="layui-btn"
														style="display: block; margin: 0 auto" id="frsfzzBtn">上传法人身份证</button>
												</div>
											</blockquote>
										</div>
									</div>
								</div>
							</div>
							<p class="details-component-line-margin"
								style="margin-bottom: 0px;">注意：请上传法人身份证扫描件，单个图片不超过1M，支持JPG格式。
	
							</p>
						</div>
					</div>
					<div class="details-component-tools ">
						<button type="button" class="ant-btn ant-btn-primary ant-btn-lg" onclick="toSubmit()" style="float: right;">
							<span>提交审核</span>
						</button>
					</div>
				</form>
			</div>
		</div>
		</div>
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

	<style>
html body { -
	-antd-wave-shadow-color: rgb(44, 136, 196);
}
</style>
	<div>
		<div data-reactroot="" class="ant-message">
			<span></span>
		</div>
	</div>
	<script src="statics/layui/layui.js"></script>
	<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
	<script src="statics/js/concisejs.js"></script>
	<script language="javascript">
        //防止页面后退
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
    </script>
	<script>
	$(document).ready(function(){
	    var sj = cj.getCookie('user_phone');
	    var mm =cj.getCookie('user_mm');
	    $("#sj").val(sj);
	    $("#mm").val(mm);
	  })
		layui.use([ "jquery", "upload", "form", "layer", "element" ],function() {
							var form = layui.form, element = layui.element, layer = layui.layer, upload = layui.upload;

							//多图片上传
							/*身份证*/
							upload.render({
										elem : '#sfzsmjBtn',
										url : 'uploadPic',
										multiple : true,
										size: 1024, //限制文件大小，单位 KB
										before: function (obj) {
							                //预读本地文件示例，不支持ie8
							                obj.preview(function (index, file, result) {
							                    $("#sfzsmjBtn").removeAttr("style");
							                });
							            }, 
										done : function(res) {										
											var imgData = res.data.src
											var sfzsmjData = $('#sfzsmj').val();
											sfzsmjData +=imgData+","
							            	$("#sfzsmj").val(sfzsmjData);
											 $('#sfzsmjBtn').before("<div class='file-iteme' style='width: 92px;height: 92px;display:inline-block;margin-right: 10px;'><img src='"+ res.data.src +"' id='sfzImg' alt=''  style='margin-bottom: 5px;position:relative;' class='layui-upload-img uploader-list'>  <span class='info' style='position:absolute;z-index:10;display:none'><a href='"+res.data.src+"' target='_blank'><image src='statics/login/prew.png'></image></a></span><span class='info' style='position:absolute;z-index:10;display:none' onclick='del(this)'><image src='statics/login/del.png'></image></span></div>");
										}
									});
							/*营业执照*/
							upload.render({
										elem : '#yyzzBtn',
										url : 'uploadPic',
										multiple : true,
										size: 1024, //限制文件大小，单位 KB
										before: function (obj) {
							                //预读本地文件示例，不支持ie8
							                obj.preview(function (index, file, result) {
							                    $("#yyzzBtn").removeAttr("style");
							                });
							            }, 
										done : function(res) {
											var imgData = res.data.src
											var yyzzData = $('#yyzz').val();
											yyzzData +=imgData+","
							            	$("#yyzz").val(yyzzData);
											$('#yyzzBtn').before("<div class='file-iteme' style='width: 92px;height: 92px;display:inline-block;margin-right: 10px;'><img src='"+ res.data.src +"' id='yyzzImg' alt=''  style='margin-bottom: 5px;position:relative;' class='layui-upload-img uploader-list'>  <span class='info' style='position:absolute;z-index:10;display:none'><a href='"+res.data.src+"' target='_blank'><image src='statics/login/prew.png'></image></a></span><span class='info' style='position:absolute;z-index:10;display:none' onclick='del(this)'><image src='statics/login/del.png'></image></span></div>");
											
										
										}
									});
							/*法人身份证*/
							upload.render({
										elem : '#frsfzzBtn',
										url : 'uploadPic',
										multiple : true,
										size: 1024, //限制文件大小，单位 KB
										before: function (obj) {
							                //预读本地文件示例，不支持ie8
							                obj.preview(function (index, file, result) {
							                    $("#frsfzzBtn").removeAttr("style");
							                });
							            }, 
										done : function(res) {
											var imgData = res.data.src
											var frsfData = $('#frsfzz').val();
											frsfData +=imgData+","
							            	$("#frsfzz").val(frsfData);
											$('#frsfzzBtn').before("<div class='file-iteme' style='width: 92px;height: 92px;display:inline-block;margin-right: 10px;'><img src='"+ res.data.src +"' id='frsfzz' alt=''  style='margin-bottom: 5px;position:relative;' class='layui-upload-img uploader-list'>  <span class='info' style='position:absolute;z-index:10;display:none'><a href='"+res.data.src+"' target='_blank'><image src='statics/login/prew.png'></image></a></span><span class='info' style='position:absolute;z-index:10;display:none' onclick='del(this)'><image src='statics/login/del.png'></image></span></div>");
											
										}
									});
						});
	
	/*校验非空*/
	function Validate() {
	    var success = true;
	    /*必填信息完整性*/
	    $('.bitian').each(function () {
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
	    /*邮箱格式不正确*/
	    var reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
		if(!reg.test($.trim($('#email').val()))){
			alert("邮箱格式不正确");
			$("#email").focus();
			return false;
		}
		/*身份证不正确*/
		var format = /^(([1][1-5])|([2][1-3])|([3][1-7])|([4][1-6])|([5][0-4])|([6][1-5])|([7][1])|([8][1-2]))\d{4}(([1][9]\d{2})|([2]\d{3}))(([0][1-9])|([1][0-2]))(([0][1-9])|([1-2][0-9])|([3][0-1]))\d{3}[0-9xX]$/;
		if(!format.test($.trim($('#sfz').val()))){
			alert("身份证格式不正确");
			$("#sfz").focus();
			return false;
		}
		/*法人手机号格式不正确*/
	 	var regphone = new RegExp(/^1[0-9]{10}$/);
	    if (!regphone.test($.trim($('#frsjh').val()))) {
	        alert('法人手机号格式不正确');
	        $('#frsjh').focus();
	        return false;
	    }
		if(!format.test($.trim($('#frsfz').val()))){
			alert("法人身份证格式不正确");
			$("#frsfz").focus();
			return false;
		}
		var sfzz = $("#sfzsmj").val(); 
		if(!sfzz){
			alert("请上传身份证扫描件");
			$("#sfzz").focus();
			return false;
		}
		var yyzzz = $("#yyzz").val(); 
		if(!yyzzz){
			alert("请上传营业执照");
			$("#yyzzDiv").focus();
			return false;
		}
		var frsf = $("#frsfz").val(); 
		if(!frsf){
			alert("请上传法人身份证照");
			$("#frsf").focus();
			return false;
		}
		
	    return true;
	}
	/*用户注册方法*/
	function toSubmit(){
		var formData=$("form").serialize();//用jquery 获取你的form对象  后边是序化
		if (!Validate()) return;
		 $.ajax({
			 type:"POST",
			 url: "userInsert",
			 data:formData,
			 success: function(data){
			       if(data=="1"){
			         alert("注册成功，联系或等待管理员审核");
			         window.location = "logins.jsp";
			        }else if(data=="-500"){
			        	alert("链接有误，请联系主场管理人员!");
			        }else{
			         //失败执行的代码
			        alert("注册失败，请重试");
			        }
			      }
		 })
		
	}
	</script>
	<script>
		$(document).on("mouseenter mouseleave", ".file-iteme", function(event) {
			if (event.type === "mouseenter") {
				//鼠标悬浮			
				var top=$(this).offset().top;
				var left=$(this).offset().left;
				$(this).children().first().next().css("top",top+35).css("left",left+25).show();
				$(this).children().first().next().next().css("top",top+35).css("left",left+55).show();
				$(this).css("background-color","rgba(0,0,0,0.5)");
				$(this).children().first().css("opacity","0.5"); 		
			}
			if (event.type === "mouseleave") {
				//鼠标离开
				$(this).children().first().next().hide();
				$(this).children().first().next().next().hide();
			$(this).css("background-color",""); 
			$(this).children().first().css("opacity","1"); 
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


