<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
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
<title>报馆信息</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<link rel="stylesheet" href="statics/layui/css/layui.css" media="all">
<link rel="stylesheet" href="statics/layui/admin.css" media="all">
<style type="text/css">
span{
cursor:pointer;
}
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
			<div class="layui-card-header">报馆详情信息</div>
			<div class="layui-card-body" style="padding: 15px;">
				<form class="layui-form layui-form-pane" action="" lay-filter="component-form-group">
				<input id="djsshdx" name="djsshdx" style="display: none" >
					<input id="bgGuid" name="bgGuid" style="display: none" value="<%=request.getParameter("bgGuid")%>">
					<input type="text" id="zhxxGuid" name="zhxxGuid" style="display: none" />
					<fieldset class="layui-elem-field layui-field-title">
						<legend>展位信息</legend>
					</fieldset>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">
								<font color=red>*</font>展馆号
							</label>
							<div class="layui-input-inline">
								<select disabled="disabled" lay-filter="ZGH" name="ZGH" placeholder="请选择展馆号"  s lay-verify="required" value=""
									lay-reqtext="展馆号不能为空">

								</select>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">
								<font color=red>*</font>展位号
							</label>
							<div class="layui-input-inline" style="width:182px">
								<select lay-filter="ZWH" name="ZWH" disabled="disabled" placeholder="请选择展位号" lay-verify="required" value=""
									lay-reqtext="展位号不能为空">

								</select>
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">
							<font color=red>*</font>参展公司
						</label>
						<div class="layui-input-inline" style="width: 504px">
							<input type="text" id="CZQYGSQC" name="CZQYGSQC" lay-verify="required" placeholder="请输入参展公司"
								lay-reqtext="参展公司不能为空"  disabled="disabled" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">
								<font color=red>*</font>现场负责人
							</label>
							<div class="layui-input-inline">
								<input type="text" id="CZSZSXCFZR" name="CZSZSXCFZR" lay-verify="required"
									placeholder="请输入现场负责人" disabled="disabled" lay-reqtext="现场负责人不能为空" autocomplete="off"
									class="layui-input">
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">
								<font color=red>*</font>手机号
							</label>
							<div class="layui-input-block">
								<input type="text" id="CZSSJ" name="CZSSJ" lay-verify="required|phone|number"
									placeholder="请输入手机号" disabled="disabled" lay-reqtext="负责人手机号不能为空" autocomplete="off"
									class="layui-input">
							</div>
						</div>
					</div>


					<fieldset class="layui-elem-field layui-field-title" style="margin-top: 40px">
						<legend>搭建商信息</legend>
					</fieldset>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">
								<font color=red>*</font>安全负责人
							</label>
							<div class="layui-input-block">
								<input type="text" id="DJSXCAQFZR" name="DJSXCAQFZR" lay-verify="required"
									placeholder="请输入安全负责人" disabled="disabled" lay-reqtext="安全负责人不能为空" autocomplete="off"
									class="layui-input">
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">
								<font color=red>*</font>手机号
							</label>
							<div class="layui-input-block">
								<input type="text" id="DJSSJ" name="DJSSJ" lay-verify="required|phone|number"
									placeholder="请输入手机号" disabled="disabled" lay-reqtext="安全负责人手机号不能为空" autocomplete="off"
									class="layui-input">
							</div>
						</div>
					</div>
					<fieldset class="layui-elem-field layui-field-title" style="margin-top: 40px">
						<legend>文件</legend>
					</fieldset>
					<div class="layui-form-item">
						<label class="layui-form-label" style="width: 125px;">
							<font color=red>*</font>展台结构类型
						</label>
						<div class="layui-input-block">
							<input type="radio" id="ztjg" name="ztjg" lay-filter="ztjg" value="室内单层" title="室内单层">
							<input type="radio" id="ztjg" name="ztjg" lay-filter="ztjg" value="室内双层" title="室内双层">
							<input type="radio" id="ztjg" name="ztjg" lay-filter="ztjg" value="室外钢木结构" title="室外钢木结构">
							<input type="radio" id="ztjg" name="ztjg" lay-filter="ztjg" value="室外简易结构"
								title="室外简易结构(如: 纯桁架结构等)">
						</div>
					</div>
					<div id='sndc'>
						<div class="layui-form-item">
							<div class="layui-upload">
								<blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;">
									<font color=red>*</font> 展位图纸预览图：
									<div class="layui-upload-list" id="zwtzDiv">
										<input id='ZWTZ' name='zwtz' style='display: none' lay-verify="required"
											lay-reqtext="展位图纸不能为空" />
											
											<input type="hidden" id="zwtzBtn"/>
											
									</div>
								</blockquote>
							</div>
						</div>
					</div>
					<div id='snsc' style="display: none">
						<div class="layui-form-item">
							<div class="layui-upload">
								<blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;">
									<font color=red>*</font>展位细部结构图及审核报告： 
									<div class="layui-upload-list" id="xbjgtjshbgDiv">
										<input id='ZWJGT' name='zwjgt' style='display: none'
											lay-reqtext="展位细部结构图及审核报告不能为空" />
											<input type="hidden" id="zwjgtBtn"/>
									</div>
								</blockquote>
							</div>
						</div>
						<div class="layui-form-item">
							<div class="layui-inline">
								<label class="layui-form-label">设计院全称</label>
								<div class="layui-input-block">
									<input type="text" id="SJY" name="SJY" placeholder="请输入设计院全称" autocomplete="off"
										class="layui-input">
								</div>
							</div>
							<div class="layui-inline">
								<label class="layui-form-label">办公电话</label>
								<div class="layui-input-block">
									<input type="text" id="BGDH" name="BGDH" placeholder="请输入办公电话" autocomplete="off"
										class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-form-item">
							<div class="layui-inline">
								<label class="layui-form-label">出图工程师</label>
								<div class="layui-input-block">
									<input type="text" id="CTSJS" name="CTSJS" placeholder="请输入出图工程师" autocomplete="off"
										class="layui-input">
								</div>
							</div>
							<div class="layui-inline">
								<label class="layui-form-label">手机号</label>
								<div class="layui-input-block">
									<input type="text" id="GCSSJH" name="GCSSJH" placeholder="请输入手机号" autocomplete="off"
										class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-form-item">
							<div class="layui-upload">
								<blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;">
									<font color=red>*</font>出图工程师资质证书：
									<div class="layui-upload-list" id="ctgcszzzsDiv">
										<input id='GCSZZZS' name='gcszzzs' style='display: none'
											lay-reqtext="出图工程师资质证不能为空" />
											<input type="hidden" id="gcszzzsBtn"/>
									</div>
								</blockquote>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="layui-fluid">
		<div class="layui-card">
			<div class="layui-card-header">报馆详情信息</div>
			<div class="layui-card-body" style="padding: 15px;">
				<div class="layui-row">
					<form class="layui-form fyhzForm" id="vform" lay-filter="fyhzform">
						<table class="layui-table" lay-filter="test" id="test_table">
							<colgroup>
								<col width="200">
								<col width="200">
								<col width="200">
								<col width="200">
								<col width="200">
								<col width="200">
							</colgroup>
							<thead>
								<tr>
									<th colspan="2">项目名称</th>
									<th colspan="2">项目描述</th>
									<th>单价（元）</th>
									<th>数量</th>
									<th>金额（元）</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td colspan="2"><span style="text-align: center;">401-600㎡（含600㎡）</span>

									</select></td>
									<td colspan="2"><span style="text-align: center;">401-600㎡（含600㎡）</span>

									</select></td>
									<td colspan="1"><input type="text" name="xm[0].DJ" id="DJ0" class="layui-input " readonly="readonly"></td>
									<td><input type="text" name="xm[0].SL" id="SL0" class="layui-input binputs"></td>
									<td><input type="text" name="xm[0].HXJ" id="XJ0" class="layui-input XJ_value" readonly="readonly"></td>
								</tr>

								<tr class="addlists">
									<td colspan="2">小计</td>
									<td colspan=4></td>
									<td><input type="text" name="XJ" id="XJ" class="layui-input" readonly="readonly"></td>
								</tr>

								<tr>
									<td rowspan="2" colspan="2">其他</td>
									<td colspan="2">施工押金</td>
									<td colspan="2">
									<span style="text-align: center;">401-600㎡（含600㎡）</span>
									</td>
									<td><input type="text" name="SGYJJE" class="layui-input" readonly="readonly"></td>
								</tr>

								<tr>
									<td colspan="2">滞纳金</td>
									<td colspan="2" id="ZNJMS"></td><input type="text" id="znjzt" style="display:none;" >
									<td><input type="text" name="ZNJ" class="layui-input" readonly="readonly"></td>
								</tr>
								<tr >
									<td colspan="2">费用总计</td>
									<td colspan=4></td>
									<td><input type="text" name="ZJ" class="layui-input" readonly="readonly">
										<input type="text" name="zhxx" style="display:none;" >
										<input type="text" name="zgh" style="display:none;" >
										<input type="text" name="zwh" style="display:none;" >	
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script src="statics/layui/layui.js"></script>
	<script src="statics/js/concisejs.js"></script>
	<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
	<!-- <script src="statics/js/model/DGXX/BGXX_SHOW.js"></script> -->
	<script>
		layui.use(["jquery", "upload", "form", "layer", "element"],
			function () {
				var form = layui.form, element = layui.element, layer = layui.layer, upload = layui.upload;
				element.init();
				upload.render();
				var bgGuid = $("#bgGuid").val();
				var zhxx = cj.getCookie('selected_expo_id');
				var shzt;
				
				$.ajax({
					type: "POST",
					url: "bg/findBgxxInfo",
					data: {
						"bgGuid": bgGuid,
						"zhxxGuid": zhxx
					},
					success: function (data) {
						if (data != null) {
							shzt = data[0].ZT;
							$.each(data[0], function (n, v) {
								$('#' + n + '').html(v);
								$('#' + n + '').val(v);
								if (n === 'ZGH') {
									$("option[value=" + v + "]").attr("selected", true);
									form.render('select');
									findZwh(v);
									
								}
								if (n == 'ZWH') {
									$("option[value=" + v + "]").attr("selected", true);
									var zgh = $("[name=ZGH]").val();
									findFYXXINFO(zgh,v);
								}
								if (n == 'ZTJG') {
									$('[name=ztjg][value=' + v + ']').prop("checked", true);
									if (v.trim() == '室外钢木结构' || v.trim() == "室内双层") {
										$("#zwtz").attr("lay-verify", "required");
										$("#zwtz").attr("lay-verify", "required");
										$("#snsc").show();
									}
								}
								
								
								
								
								if (n.indexOf("_ZT")!=-1) {
									if (v == '通过') {
										var btn = n.substring(0,n.length-3);
										btn = btn.toLocaleLowerCase();
										$("#"+btn+"Btn").hide();
										$("#"+btn+"Btn").prevAll().removeClass("file-iteme")
									}else{
										if(btn="ZWTZ"){
											$("#zwtzBtn").show();
											$("#zwjgtBtn").show();
											$("#gcszzzsBtn").show();
											$("#zwtzBtn").prevAll().attr("class","file-iteme")
											$("#zwjgtBtn").prevAll().attr("class","file-iteme")
											$("#gcszzzsBtn").prevAll().attr("class","file-iteme")
											
										}
									}
								}
								if (v.indexOf("/kh/")!=-1) {
									if (v != "") {
										v = v.substring(0,v.length-1);
										var picture = v.split(',');
										var btn = n.toLowerCase();
										if (picture.length >= 1) {
											for (var i = 0; i < picture.length; i++) {
												$("#"+ btn+ "Btn").before("<div class='file-iteme' style='width: 92px;height: 92px;display:inline-block;margin-right: 10px;'><img src='" + picture[i] + "' id='' alt=''  style='margin-bottom: 5px;position:relative;' class='layui-upload-img uploader-list'>  <span class='info' style='position:absolute;z-index:10;display:none'><a href='" + picture[i] + "' target='_blank'><image src='statics/login/prew.png'></image></a></span><span class='info' style='position:absolute;z-index:10;display:none' onclick='del(this)'><image src='statics/login/del.png'></image></span></div>")
											}
										}
										$("#"+ btn+ "Btn").removeAttr("style");
									}
								}
								
								form.render();
							});
							/* var radio = data[0].ZTJG; 
							$("input[name='ztjg'][value=室外钢木结构]").attr("checked",true); */

							if (shzt == '拒绝') {
								$.ajax({
									type: "POST",
									url: "bg/GetShjlByGuid",
									data: {
										"bgGuid": bgGuid
									},
									success: function (result) {
										if (result.length > 0) {
											for (var i = 0; i < result.length; i++) {
												var shdx = $("#djsshdx").val();
												shdx +=result[i].SHXM+",";
												$("#"+result[i].SHXM+"").parent().before("<span style=\"font-size: 19px; float: right; color: red;\">"+ result[i].SHYJ +"</span>");
											}
										}
									}
								});
							}


						}
					}
				});


				
				var selectImg = function(d){
		       		upload.render({
		                elem: '#'+d+'Btn'
		                ,url: 'uploadPic'
		                ,multiple: true
		                ,size: 1024 //限制文件大小，单位 KB
		                ,before: function(obj){
		                    //预读本地文件示例，不支持ie8
		                    obj.preview(function(index, file, result){
		                        $("#"+d+"Btn").removeAttr("style");
		                    });
		                }
		                ,done: function(res){
		            		var imgData = res.data.src
		            		var dData = $("#"+d+"").val();
		            		dData +=imgData+","
		            		$("#"+d+"").val(dData);
		           	  		$('#'+d+'Btn').before("<div class='file-iteme' style='width: 92px;height: 92px;display:inline-block;margin-right: 10px;'><img src='"+ res.data.src +"' id='"+res.name+"' alt=''  style='margin-bottom: 5px;position:relative;' class='layui-upload-img uploader-list'>  <span class='info' style='position:absolute;z-index:10;display:none'><a href='"+res.data.src+"' target='_blank'><image src='statics/login/prew.png'></image></a></span></div>");

		                }
		            });
		        }

			var zhxx = cj.getCookie('selected_expo_id');
			var bmDes = "bgxx_des_" + zhxx;
			var bm = "bgxx_" + zhxx;
			$.ajaxSetup({
				async: false
			});
			$.post(
				"bg/returnZdmList",
				{
					bmDes: bmDes,
					bm: bm
				},
				function (result) {
					if (result != null) {
						var zdm = "";
						for (var i = 0; i < result.length; i++) {
							var fromInput = "";
							switch (result[i].formtypes) {
								case "text"://文本类型
									fromInput += "<div class=\"layui-form-item\"> <label class=\"layui-form-label\">"
										+ result[i].zdmc
										+ "</label> <div class=\"layui-input-block\"> <input type=\"text\" name=\"" + result[i].zdm + "\" lay-verify=\"required\" placeholder=\"请输入" + result[i].zdmc + "\" autocomplete=\"off\" class=\"layui-input\"> </div></div>";
									break;
								case "number"://文本类型
									fromInput += "<div class=\"layui-form-item\"> <label class=\"layui-form-label\">"
										+ result[i].zdmc
										+ "</label> <div class=\"layui-input-block\"> <input type=\"number\" name=\"" + result[i].zdm + "\" lay-verify=\"required\" placeholder=\"请输入" + result[i].zdmc + "\" autocomplete=\"off\" class=\"layui-input\"> </div></div>";
									break;
								case "textarea"://文本域
									fromInput += "<div class=\"layui-form-item layui-form-text\"> <label class=\"layui-form-label\">"
										+ result[i].zdmc
										+ "</label> <div class=\"layui-input-block\"> <textarea name=\"text\"  name=\"" + result[i].zdm + "\"  placeholder=\"请输入" + result[i].zdmc + "\" class=\"layui-textarea\"></textarea> </div> </div>"
									break;
								case "pic":
									fromInput += "<div class=\"layui-form-item\"> <div class=\"layui-upload\"> <blockquote class=\"layui-elem-quote layui-quote-nm\" style=\"margin-top: 10px;\"><font color=red>*</font>"
										+ result[i].zdmc
										+ "： <div class=\"layui-upload-list\" id=\"div\"><input id='" + result[i].zdm + "' name='" + result[i].zdm + "' style='display: none' lay-verify=\"required\"  lay-reqtext=\"" + result[i].zdmc + "不能为空\" /><button type=\"button\" class=\"layui-btn append\" style=\"display:block;margin:0 auto\" lay-filter=\"" + result[i].zdm + "\" id=\"" + result[i].zdm + "Btn\"> "
										+ result[i].zdmc
										+ "</button></div> </blockquote> </div> </div>";
									break;
								case "date":
									fromInput += "<div class=\"layui-inline\"> <label class=\"layui-form-label\">"
										+ result[i].zdmc
										+ "</label> <div class=\"layui-input-inline\"> <input type=\"text\" name=\"" + result[i].zdm + "\" id=\"date\" lay-verify=\"date\" placeholder=\"yyyy-MM-dd\" autocomplete=\"off\" class=\"layui-input date\"> </div> </div>";
									break;
								case "datetime":
									fromInput += "<div class=\"layui-inline\"> <label class=\"layui-form-label\">"
										+ result[i].zdmc
										+ "</label> <div class=\"layui-input-inline\"> <input type=\"text\" name=\"" + result[i].zdm + "\" id=\"date\" lay-verify=\"date\" placeholder=\"yyyy-MM-dd\" autocomplete=\"off\" class=\"layui-input date\"> </div> </div>";
									break;
							}
							$(".layui-layout-admin").before(fromInput);
							selectImg(result[i].zdm)
						}
					}
				});
			//获取展位信息
			var zhguid = cj.getCookie('selected_expo_id');
			$
				.ajax({
					type: 'GET',
					url: 'dj/findZgh',
					cache: false,
					data: {
						"zhguid": zhguid
					},
					dataType: 'JSON',
					success: function (d) {
						var city = '<option value="" >请选择展馆号</option>';
						var zgName = "";
						var zgVal = "";
						for (var i = 0; i < d.length; i++) {
							zgName = d[i].GH;
							zgVal = d[i].id;
							city += '<option name="' + zgName + '" value="' + zgName + '">'
								+ zgName + '</option>';
						}
						$("[name='ZGH']").html(city);
						form.render('select');
					}
				});

			form.on('select(ZGH)', function (data) {
				findZwh(data.value);
			});

			var findZwh = function (zgh) {
				$.ajax({
						type: 'GET',
						url: 'dj/findZwh',
						cache: false,
						data: {
							"ghbh": zgh
						},
						dataType: 'JSON',
						success: function (d) {
							var city = '<option value="" >请选择展位号</option>';
							var zgName = "";
							var zgVal = "";
							for (var i = 0; i < d.length; i++) {
								zgName = d[i].ZWH;
								zgVal = d[i].GHBH;
								city += '<option name="' + zgName + '" value="' + zgName + '">'
									+ zgName
									+ '</option>';
							}
							$("[name='ZWH']").html(city);
							form.render('select');
							
						}
					});
			}

			});
		
		function findFYXXINFO(v,ve){
			var zgh =v;
			var zwh = ve;
			var zhxx = cj.getCookie('selected_expo_id');
			$.ajax({
			        type:"POST",
			        url:"bg/findFyxxInfo",
			      	data: {"zgh":zgh,"zwh":zwh,"zhxx":zhxx},
			        success:function(data){
			           if(data.success){
			       			
							
							window.location.href = "DJ/FYHZ.jsp"
			            
			           }else{
						  layer.alert(data.msg);
			           }
			        },
			        error:function(jqXHR){
			           alert("发生错误："+ jqXHR.status);
			        }
		    });

		}
	</script>
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
						.css("left", left + 24).show();
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

	</script>
</body>

</html>
</html>
