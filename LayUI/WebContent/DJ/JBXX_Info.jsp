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
<head>
<meta charset="utf-8">
<title>基本信息</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<link rel="stylesheet" href="statics/layui/css/layui.css" media="all">
<link rel="stylesheet" href="statics/layui/admin.css" media="all">
<style type="text/css">
#detailTbody tr:hover {
	background: #fff;
}

.layui-form-label {
	width: 110px;
}

/*     .uploader-list {
        margin-left: -15px;
    } */
.uploader-list .info {
	position: relative;
	margin-top: -25px;
	background-color: black;
	color: white;
	filter: alpha(Opacity = 80);
	-moz-opacity: 0.5;
	opacity: 0.5;
	width: 100px;
	height: 25px;
	text-align: center;
	display: none;
}

.uploader-list .handle {
	position: relative;
	background-color: #ff6a00;
	color: white;
	filter: alpha(Opacity = 80);
	-moz-opacity: 0.5;
	width: 100px;
	text-align: right;
	height: 18px;
	margin-bottom: -18px;
	display: none;
}

.uploader-list .handle span {
	margin-right: 5px;
}

.uploader-list .handle span:hover {
	cursor: pointer;
}

.uploader-list .file-iteme {
	margin: 12px 0 0 15px;
	padding: 1px;
	float: left;
}
</style>
</head>
<body>

	<div class="layui-fluid">
		<div class="layui-card">
			<div class="layui-card-header">个人信息</div>
			<div class="layui-card-body" style="padding: 15px;">
				<form class="layui-form layui-form-pane" action=""
					lay-filter="component-form-group">
					<input type="text" id="zhxxGuid" name="zhxxGuid"
						style="display: none" />
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label" style="width: 145px;">姓名</label>
							<div class="layui-input-inline">
								<input type="text" name="NAME" id="NAME" value="" readonly
									autocomplete="off" class="layui-input">
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label" style="width: 145px;">手机号码</label>
							<div class="layui-input-inline">
								<input type="text" name="SJ" id="SJ" value="" readonly
									autocomplete="off" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label" style="width: 145px;">微信号</label>
							<div class="layui-input-inline">
								<input type="text" name="WXH" id="WXH" value=""
									autocomplete="off" class="layui-input" readonly>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label" style="width: 145px;">邮箱</label>
							<div class="layui-input-inline">
								<input type="text" name="EMAIL" id="EMAIL" value="" readonly
									autocomplete="off" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label" style="width: 145px;">身份证号</label>
							<div class="layui-input-inline">
								<input type="text" name="SFZ" id="SFZ" value="" readonly
									autocomplete="off" class="layui-input">
							</div>
						</div>
					</div>

					<div class="layui-form-item">
						<label class="layui-form-label" style="width: 145px;;">身份证扫描件</label>
						<!-- 	<div id="sfzsmj_upload" class="layui-upload-drag upload"
								style="float: left"></div>
								 -->
						<div class='file-iteme' id="sfzsmj_item"></div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="layui-fluid">
		<div class="layui-card">
			<div class="layui-card-header">公司信息</div>
			<div class="layui-card-body" style="padding: 15px;">
				<form class="layui-form layui-form-pane" action=""
					lay-filter="component-form-group">
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label" style="width: 145px;">公司名称</label>
							<div class="layui-input-inline">
								<input type="text" name="GSMC" id="GSMC" value=""
									autocomplete="off" class="layui-input" readonly>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label" style="width: 145px;">传真</label>
							<div class="layui-input-inline">
								<input type="text" name="CZ" id="CZ" value="" readonly
									autocomplete="off" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label" style="width: 145px;">办公地址</label>
						<div class="layui-input-inline">
							<input type="text" name="BGDZ" id="BGDZ" value=""
								autocomplete="off" class="layui-input" readonly
								style="width: 548px">
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label" style="width: 145px;">法人姓名</label>
							<div class="layui-input-inline">
								<input type="text" name="FRXM" id="FRXM" value=""
									autocomplete="off" class="layui-input" readonly>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label" style="width: 145px;">法人手机号</label>
							<div class="layui-input-inline">
								<input type="text" name="FRSJH" id="FRSJH" value="" readonly
									autocomplete="off" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label" style="width: 145px;">法人身份证号</label>
							<div class="layui-input-inline">
								<input type="text" name="FRSFZ" id="FRSFZ" value=""
									autocomplete="off" class="layui-input" readonly>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label" style="width: 145px;">法人座机</label>
							<div class="layui-input-inline">
								<input type="text" name="FRZJ" id="FRZJ" value="" readonly
									autocomplete="off" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<!-- <div id="frsfzz_upload" class="layui-upload-drag upload"
								style="float: left"></div>
								 -->
						<label class="layui-form-label" style="width: 145px;">法人身份证扫描件</label>
						<div class='file-iteme' id="frsfzz_item"></div>
					</div>
					<div class="layui-form-item">
					<!-- <div id="yyzz_upload" class="layui-upload-drag upload"
									style="float: left"></div> -->
						<label class="layui-form-label" style="width: 145px;">营业执照</label>
						
						<div class='file-iteme' id="yyzz_item"></div>
					</div>

				</form>
			</div>
		</div>
	</div>

	<script type="text/html" id="temp_reload">
        <div class="redo" style="display:none">
		</div>
	</script>
	<script src="statics/layui/layui.js"></script>
	<script src="statics/js/concisejs.js"></script>
	<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
	<script>
		layui
				.use(
						[ "jquery", "upload", "form", "layer", "element" ],
						function() {
							var form = layui.form, element = layui.element, layer = layui.layer, upload = layui.upload;
							element.init();
							upload.render();
							/*渲染得到值*/
							$
									.ajax({
										type : "POST",
										url : "dj/findInfo",
										success : function(data) {
											if (data != null) {
												$.each(data[0], function(n, v) {
													$('#' + n + '').html(v);
													$('#' + n + '').val(v);
												});
												var sfzsmj = data[0].SFZSMJ
														.split(',');

												if (sfzsmj.length >= 1) {
													for (var i = 0; i < sfzsmj.length; i++) {
														$("#sfzsmj_item")
																.append(
																		'<div class="layui-input-inline" style="width: 170px; height: 100px"><div style="display:inline-block;margin-right: 10px;"> <a	 href="'+sfzsmj[i]+'"	target="_blank"><img  width="170px" height="100px" src="'+sfzsmj[i]+'" name="sfzsmj_upload" alt="" style="position: relative;" class=""> <span class="info" style="position: absolute; z-index: 10; top: 77px; left: 10px;"> 	</span></a></div></div>')
													}
												}
												var frsfzz = data[0].FRSFZZ
														.split(',');
												if (frsfzz.length >= 1) {
													for (var i = 0; i < frsfzz.length; i++) {
														$("#frsfzz_item")
																.append(
																								'<div class="layui-input-inline" style="width: 170px; height: 100px"><div style="display:inline-block;margin-right: 10px;"><a	 href="'+frsfzz[i]+'"	target="_blank"><img  width="170px" height="100px" src="'+frsfzz[i]+'" name="sfzsmj_upload" alt="" style="position: relative;" class=""> <span class="info" style="position: absolute; z-index: 10;top: 77px; left: 10px;">  	</span></a></div></div>')
													}
												}
												var yyzz = data[0].YYZZ
												.split(',');
												if (yyzz.length >= 1) {
													for (var i = 0; i < yyzz.length; i++) {
														$("#yyzz_item")
																.append(
																		'<div class="layui-input-inline" style="width: 170px; height: 100px"><div style="display:inline-block;margin-right: 10px;"><a	 href="'+yyzz[i]+'"	target="_blank"><img  width="170px" height="100px" src="'+yyzz[i]+'" name="sfzsmj_upload" alt="" style="position: relative;" class=""> <span class="info" style="position: absolute; z-index: 10;top: 77px; left: 10px;"> 	</span></a></div></div>')
													}
												}
										
												// 加载图片预览
												if (data[0].SFZSMJ != undefined) {

													/* 	previewPic('#sfzsmj_upload',
															data[0].SFZSMJ);
													previewPic('#yyzz_upload',
															data[0].YYZZ);
													previewPic('#frsfzz_upload',
															data[0].FRSFZZ); */
												}

											}
										},
										error : function(jqXHR) {
											aler("发生错误：" + jqXHR.status);
										}
									});

							var previewPic = function(selector, src) {
								$(selector).html($('#temp_reload').html()).css(
										{
											'background' : 'url(' + src
													+ ') no-repeat 50%',
											'height' : '73px',
											'width' : '270px'
										}).mouseenter(function() {
									$(selector + ' .redo').show();
								}).mouseleave(function() {
									$(selector + ' .redo').hide();
								});
							}

							/*展位图纸预览图*/
							upload
									.render({
										elem : '#zwtzBtn',
										url : 'uploadPic',
										multiple : true,
										before : function(obj) {
											//预读本地文件示例，不支持ie8
											obj.preview(function(index, file,
													result) {
												$("#zwtzBtn").removeAttr(
														"style");
											});
										},
										done : function(res) {
											var imgData = res.data.src
											$('#zwtz').val(imgData);
											$('#zwtzBtn')
													.before(
															"<div class='file-iteme' style='width: 92px;height: 92px;display:inline-block;margin-right: 10px;'><img src='"+ res.data.src +"' id='"+res.name+"' alt=''  style='margin-bottom: 5px;position:relative;' class='layui-upload-img uploader-list'>  <span class='info' style='position:absolute;z-index:10;display:none'><a href='"+res.data.src+"' target='_blank'><image src='statics/login/prew.png'></image></a></span><span class='info' style='position:absolute;z-index:10;display:none' onclick='del(this)'><image src='statics/login/del.png'></image></span></div>");
										}
									});
							/* 监听提交 */
							form.on('submit(component-form-demo1)',
									function(data) {
										var selected = cj
												.getCookie('selected_expo_id');
										$("#zhxxGuid").val(selected)
										var formList = $('.layui-form-pane')
												.serialize()
										$.ajax({
											type : "POST",
											url : "bg/submitBgxx",
											data : formList,
											success : function(data) {
												if (data.success) {
													layer.alert(data.msg);
													history.go(0)
												} else {
													layer.alert(data.msg);
												}
											},
											error : function(jqXHR) {
												aler("发生错误：" + jqXHR.status);
											}
										});

										return false;
									});

						});
	</script>

</body>
</html>
