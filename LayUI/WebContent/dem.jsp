<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>layui</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="statics/layui/css/layui.css" media="all">
<style>
.layui-upload .mark_button {
	position: absolute;
	right: 15px;
}

.upload-img {
	position: relative;
	display: inline-block;
	width: 300px;
	height: 200px;
	margin: 0 10px 10px 0;
	transition: box-shadow .25s;
	border-radius: 4px;
	box-shadow: 0px 10px 10px -5px rgba(0, 0, 0, 0.5);
	transition: 0.25s;
	-webkit-transition: 0.25s;
	margin-top: 15px;
}

.layui-upload-img {
	width: 300px;
	height: 200px;
	border-radius: 4px;
}

.upload-img:hover {
	cursor: pointer;
	box-shadow: 0 0 4px rgba(0, 0, 0, 1);
	transform: scale(1.2);
	-webkit-transform: scale(1.05);
}

.upload-img input {
	position: absolute;
	left: 0px;
	top: 0px;
}

.upload-img button {
	position: absolute;
	right: 0px;
	top: 0px;
	border-radius: 6px;
}
</style>
<!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>

<body>

	<select id='ulList' class='ulList' style='position: absolute; overflow: auto; float: left; z-index: 99;'>
		<option onclick='getValue({"FZR":"刘媛媛","FZRDWBH":10},".","刘媛媛,10","FZR")'><div type='text' readonly='readOnly' name='FZRDWBH' class='kwli'>刘媛媛,10</div>
		</option>
		<option onclick='getValue({"FZR":"桑三","FZRDWBH":17},".","桑三,17","FZR")'><div type='text' readonly='readOnly' name='FZRDWBH' class='kwli'>桑三,17</div>
		</option>
		<option onclick='getValue({"FZR":"刘晓飞","FZRDWBH":18},".","刘晓飞,18","FZR")'><div type='text' readonly='readOnly' name='FZRDWBH' class='kwli'>刘晓飞,18</div>
		</option>
	</select>

	<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
	<script src="statics/layui/layui.js?t=1"></script>

	<script id="img_template" type="text/html">
        <div class="upload-img" filename="{{ d.index }}">
            <input type="checkbox" name="" lay-skin="primary">
            <img src="{{  d.result }}" alt="{{ d.name }}" class="layui-upload-img">
        </div>
    </script>


	<script>
		layui
				.use(
						[ 'upload', 'laytpl', 'form' ],
						function() {
							var $ = layui.jquery, upload = layui.upload, laytpl = layui.laytpl, form = layui.form;

							//批量删除 单击事件
							$('#dele_imgs')
									.click(
											function() {
												$('input:checked')
														.each(
																function(index,
																		value) {
																	var filename = $(
																			this)
																			.parent()
																			.attr(
																					"filename");
																	delete imgFiles[filename];
																	$(this)
																			.parent()
																			.remove()
																});
											});

							var imgFiles;

							//多图片上传
							var uploadInst = upload
									.render({
										elem : '#sele_imgs' //开始
										,
										acceptMime : 'image/*',
										url : '/upload/',
										auto : false,
										bindAction : '#upload_imgs',
										multiple : true,
										size : 1024 * 12,
										choose : function(obj) { //选择图片后事件
											var files = this.files = obj
													.pushFile(); //将每次选择的文件追加到文件队列
											imgFiles = files;

											$('#upload_imgs').prop('disabled',
													false);

											//预读本地文件示例，不支持ie8
											obj
													.preview(function(index,
															file, result) {
														var data = {
															index : index,
															name : file.name,
															result : result
														};

														//将预览html 追加
														laytpl(
																img_template.innerHTML)
																.render(
																		data,
																		function(
																				html) {
																			$(
																					'#imgs')
																					.append(
																							html);
																		});

														//绑定单击事件
														$(
																'#imgs div:last-child>img')
																.click(
																		function() {
																			var isChecked = $(
																					this)
																					.siblings(
																							"input")
																					.prop(
																							"checked");
																			$(
																					this)
																					.siblings(
																							"input")
																					.prop(
																							"checked",
																							!isChecked);
																			return false;
																		});

													});
										},
										before : function(obj) { //上传前回函数
											layer.load(); //上传loading
										},
										done : function(res, index, upload) { //上传完毕后事件

											layer.closeAll('loading'); //关闭loading
											//上传完毕

											$('#imgs').html("");//清空操作

											top.layer.msg("上传成功！");

											return delete imgFiles[index]; //删除文件队列已经上传成功的文件

										},
										error : function(index, upload) {

											layer.closeAll('loading'); //关闭loading

											top.layer.msg("上传失败！");

										}
									});

						});
	</script>

</body>

</html>