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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="statics/layui/css/layui.css" media="all">
<style type="text/css">
body {
	font-size: 14px;
}

a {
	color: #0000EE;
}

.table_border td {
	border: 1px #666 solid;
}

.table_border {
	border-bottom: 1px #666 solid;
	border-left: 1px #666 solid;
	border-color: #666;
}

.table_border11 {
	border-bottom: 0px #666 solid;
	border-left: 0px #666 solid;
	border-right: 0px #666 solid;
	border-top: 0px #666 solid;
	border-bottom: 0px #666 solid;
	border-color: #666;
}

.table_border11 td {
	border-left: 0px #666 solid;
	border-right: 0px #666 solid;
	border-top: 0px #666 solid;
	border-bottom: 0px #666 solid;
	border-color: #666;
}
</style>
</head>
<body>
	<div id="myContent">
		<div class="piclist" id="plist">
			<input type="hidden" id="ZT"></input>
			<table width="830" border="0" align="center" cellpadding="0"
				cellspacing="0" bgcolor="#FAFAFA"
				style="border-left: 1px #000 solid; border-right: 1px #000 solid; border-bottom: 1px #000 solid; text-align: center; margin-top: 10px">
				<tr>
					<td width="861" height="55" align="center" bgcolor="#009688"
						style="font-size: 24px; color: #fff;">填报人信息</td>
					<td width="39" align="center" bgcolor="#009688"
						style="font-size: 44px; color: #fff;"></td>
				</tr>
				<tr>
					<td colspan="2" style="padding: 35px;">
						<table width="820" border="0" align="center" cellpadding="0"
							cellspacing="0" class="table_border">
							<tr>
								<td height="40" colspan="4" align="center">填报人基本信息</td>
								<td height="40" colspan="2" align="center">单位基本信息</td>
								<td height="40" colspan="2" align="center">资质信息</td>
							</tr>
							<tr>
								<td width="89" height="40" align="right">姓名&nbsp;</td>
								<td height="40" colspan="3"><span id="NAME"></span></td>
								<td width="78" height="40" align="right">中文名称&nbsp;</td>
								<td width="213" height="40"><span id="GSMC"></span></td>
								<td width="99" height="40" align="right">营业执照&nbsp;</td>
								<td width="94" height="40" align="center"><a
									href="javascript:;" onclick="djst('YYZZ')">查看</a> <input
									type="hidden" id="YYZZ" value=""></input></td>
							</tr>
							<tr>
								<td height="40" align="right">职务&nbsp;</td>
								<td height="40" colspan="3"><span id="ZW"></span></td>
								<td height="40" align="right">邮寄地址&nbsp;</td>
								<td height="40"><span id="YJDZ"></span></td>
								<td height="40" align="right">&nbsp;</td>
								<td height="40" align="center"><a href="javascript:;"
									onclick="djst('SWDJZ')"></a>
									<input
									type="hidden" id="SWDJZ" value=""></input>
									</td>
									
							</tr>
							<tr>
								<td height="40" align="right">手机&nbsp;</td>
								<td height="40" colspan="3"><span id="SJ"></span></td>
								<td height="40" align="right">办公地址&nbsp;</td>
								<td height="40"><span id="BGDZ"></span></td>
								<td height="40" align="right">&nbsp;</td>
								<td height="40" align="center"><a href="javascript:;"
									onclick="djst('ZZJGDM')"></a>
									<input
									type="hidden" id="ZZJGDM" value=""></input>
									</td>
							</tr>
							<tr>
								<td height="40" align="right">微信&nbsp;</td>
								<td height="40" colspan="3"><span id="WXH"></span></td>
								<td height="40" align="right">传真&nbsp;</td>
								<td height="40"><span id="CZ"></span></td>
								<td height="40" align="right">&nbsp;</td>
								<td height="40" align="center"><a href="javascript:;"
									onclick="djst('XGZZ')"></a>
										<input
									type="hidden" id="XGZZ" value=""></input>
									</td>
							</tr>
							<tr>
								<td height="40" align="right">邮箱&nbsp;</td>
								<td height="40" colspan="3"><span id="EMAIL"></span></td>
								<td height="40" align="right">&nbsp;</td>
								<td height="40"></td>
								<td height="40" align="right">&nbsp;</td>
								<td height="40" colspan="3"></td>
							</tr>
							<tr>
								<td height="40" align="right">身份证号码&nbsp;</td>
								<td height="40" colspan="3"><span id="SFZH"></span>&nbsp;&nbsp;&nbsp;<a
									href="javascript:;" onclick="djst('SFZSMJ')">查看</a>
									<input
									type="hidden" id="SFZSMJ" value=""></input>
									</td>
								<td height="40" align="right"></td>
								<td height="40">&nbsp;</td>
								<td height="40">&nbsp;</td>
								<td height="40">&nbsp;</td>
							</tr>
							<tr>
								<td height="40" colspan="8">&nbsp;&nbsp;&nbsp;公司法人信息</td>
							</tr>
							<tr>
								<td height="40" align="right">姓名&nbsp;</td>
								<td width="84" height="40"><span id="FRXM"></span></td>
								<td width="52" align="right">座机&nbsp;</td>
								<td width="111"><span id="FRZJ"></span></td>
								<td height="40" align="right">手机&nbsp;</td>
								<td height="40" colspan="3">
									<table width="100%" border="0" cellspacing="0" cellpadding="0"
										class="table_border11">
										<tr>
											<td width="33%" height="40"><span id="FRSJH"></span></td>
											<td width="22%" height="40" align="right"
												style="border-left: 1px solid #666; border-right: 1px solid #666">身份证号码&nbsp;</td>
											<td width="45%" height="40"><span id="FRSFZ"></span>&nbsp;&nbsp;&nbsp;<a
												href="javascript:;" onclick="djst('FRSFZZ')">查看</a>
												<input
									type="hidden" id="FRSFZZ" value=""></input>
												</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
			</table>

		</div>
		<form class="layui-form" action=""
			style="margin-top: 10px; width: 950px;" onsubmit="return false;">
			<div class="layui-form-item ">
				<label class="layui-form-label" style="margin-left: 25px;">审核意见：</label>
				<div class="layui-input-inline" style="width: 803px">
					<textarea name="desc" placeholder="请输入内容（合格可不填）"
						class="layui-textarea " id="SHYJ"></textarea>

				</div>
			</div>
			<div class="layui-row" style="text-align: center">
				<div class="layui-btn-group">
					<button class="layui-btn" lay-submit
						data-type="pass">合 格</button>

					<button class="layui-btn layui-btn-danger" data-type="NoPass">不合格</button>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block"></div>
			</div>
		</form>
	</div>
	<hr>
	<div class="layui-fluid">
		<label class="layui-form-label">审核记录：</label>
	</div>
	<div >
		<div class="layui-btn-group">



			<div class="layui-fluid">
				<table id="tableElem" class="layui-table">

				</table>
			</div>
		</div>
	</div>


</body>
<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
<script src="statics/layui/layui.js?t=1"></script>
<script src="statics/js/concisejs.js?t=1"></script>
<script>
	var guid = cj.queryString("guid");
	layui.use([ 'form', 'layer', 'table' ], function() {
		var form = layui.form, layer = layui.layer, table = layui.table;
		$.ajax({
			type : "POST",
			url : "doc/GetUserByGuid?guid=" + guid + "&time="
					+ new Date().getMilliseconds(),
			cache : false,
			dataType : "json",
			success : function(data) {
				if (data != null) {
					$.each(data[0], function(n, v) {
						$('#' + n + '').html(v);
						$('#' + n + '').val(v);
					});
				}
			}
		});
		table.render({
			id : 'shjl',
			elem : '#tableElem',
			width : '700',

			url : 'doc/getAduitRecord?guid=' + guid,
			skin : 'line',
			even : true,
			loading : false,
			cellMinWidth : 130,
			cols : [ [
					{
						field : 'SHYJ',
						title : '审核意见'
					},
					{
						field : 'SHR',
						title : '审核人员'
					},
					{
						field : 'SHRQ',
						title : '日期',
						sort : true
						
					} ] ],
			text : {
				none : '无'
			}
		});

		var active = {
			pass : function() {
				//修改guid的状态 通过
				if ($("#ZT").val() === '通过') {
					layer.alert('该人员已通过审核');
				} else {
					audit("pass");
				}
			},
			NoPass : function() {
			
					if ($('#SHYJ').val() != '') {
						//修改guid的状态未通过、审核意见
						audit("NoPass")
					} else {
						document.getElementById("SHYJ").setAttribute(
								"lay-verify", "required");
						layer.alert('审核意见不能为空');
					}
			},
		}

		var audit = function(auditing) {
			$
					.ajax({
						type : "POST",
						url : "doc/updStateByGuid?time="
								+ new Date().getMilliseconds(),
						data : {
							guid : guid,
							audit : auditing,
							suggest : $("#SHYJ").val()
						},
						cache : false,
						dataType : "json",
						success : function(data) {
							if (data === 1) {
								layer.alert("审核成功", function() {
									var index = parent.layer
											.getFrameIndex(window.name);//关闭iframe页面
									parent.layer.close(index);
									parent.layui.table.reload('demo');
								});

							} else {
								layer.alert("审核失败");
							}
						}
					});
		}
		$('.layui-row .layui-btn').on('click', function() {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});

	});
	function djst(d) {
		var img = new Image();
		img.src = $('#' + d + '').val();
		var height = img.height + 50; // 原图片大小
		var width = img.width; //原图片大小
		var imgHtml="";
		if($("#"+d+"").val())
			{
			var pics=$("#"+d+"").val().split(',');
	
			for(var i=0;i<pics.length;i++)
				{
				var picture=pics[i];
				if(picture!='')
					{
					 imgHtml += "<a href='"+picture+"' target='_blank'><img src='" + picture
						+ "' width='200px' height='200px' style='margin-right:5px' /></a>";
					}
				
				}
			}
		
	
		//         var imgHtml = "<img src='statics/admin/images/login/login_line.jpg' width='200px' height='200px'/>";  

	var index=	parent.layer.open({
			type : 1,
			shade : 0.8,
			offset : 'auto',
			//area : [ 500 + 'px', 550 + 'px' ], // area: [width + 'px',height+'px']  //原图显示
			shadeClose : true,
			scrollbar : false,
			title : "图片预览", //不显示标题  
			content :"<div class='file-iteme'>"+ imgHtml+"</div>", //捕获的元素，注意：最好该指定的元素要存放在body最外层，否则可能被其它的相对元素所影响  

		});
		  parent.layer.full(index);

	}
</script>
</html>
