///搭建商注册
function DJSXX() {
	var boo = validate();
	if (boo) {
		var formData = $("#form1").serialize();
		// 获取导航
		$.ajax({
			type : "POST",
			url : "regBuilder?time=" + new Date().getMilliseconds(),
			data : formData,
			cache : false,
			dataType : "json",
			success : function(data) {
				if (data===1) {
					alert("提交已成功，请等待管理员审核。");
					window.location.href = "login";
				} else {
			alert("添加失败");
				}
			}
		});
	}
}

function validate() {
	var boo = true;
	var v = "";
	var msg = "";
	var vid = "";

	$(".ti").each(function() {
		v = $(this).val();
		vid = $(this).attr("id");
		if (v == "" || v == null) {

			boo = false;
			msg = "请填写" + $(this).attr("clabel");

			$("#" + vid + "T").show();
			$(this).focus();
			return false;
		} else {
			$("#" + vid + "T").hide();
		}
	});
	if (!boo) {
		return false;
	}
	$(".span11").each(function() {

		v = $(this).val();
		vid = $(this).attr("id");
		if (v == "" || v == null) {

			boo = false;
			msg = "请填写" + $(this).attr("clabel");

			$("#" + vid + "T").show();
			$(this).focus();
			return false;
		} else {
			$("#" + vid + "T").hide();
		}
	});

	if (boo) {
		var phone = $.trim($("#SJ").val());
		var reg = new RegExp(/^0?1[3|4|5|7|8][0-9]\d{8}$/);
		if (!reg.test(phone)) {
			boo = false;
			msg = "请输入正确的手机号";
			$("#SJT").show();
			$("#SJ").focus();
		} else {
			$("#SJT").hide();
		}
	}
	if (boo) {
		var phone = $.trim($("#EMAIL").val());
		var reg = new RegExp(
				/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/);
		if (!reg.test(phone)) {
			boo = false;
			msg = "邮箱格式不正确";
			$("#EMAILT").show();
			$("#EMAIL").focus();
		} else {
			$("#EMAILT").hide();
		}
	}
	return boo;
}

$(function() {
	$("#LXR").focus(function() {
		$("#LXRT").show();
	});
	$("#LXR").blur(function() {
		$("#LXRT").hide();
	});
	$("#DWMC").focus(function() {
		$("#DWMCT").show();
	});
	$("#DWMC").blur(function() {
		$("#DWMCT").hide();
	});
	$("#EMAIL").focus(function() {
		$("#EMAILT").show();
	});
	$("#EMAIL").blur(function() {
		$("#EMAILT").hide();
	});
	$("#SJ").focus(function() {
		$("#SJT").show();
	});
	$("#SJ").blur(function() {
		$("#SJT").hide();
	});
	$("#DWDZ").focus(function() {
		$("#DWDZT").show();
	});
	$("#DWDZ").blur(function() {
		$("#DWDZT").hide();
	});

});

function getXY() {
	layui.use([ 'laypage', 'layer' ], function() {
		var layer = layui.layer // 弹层
		layer.open({
			type : 2,
			title : '用户注册协议',
			shadeClose : true,
			shade : false,
			maxmin : true, // 开启最大化最小化按钮
			area : [ '893px', '600px' ],
			content : 'DJ/DJ_XieYi.jsp'
		});
	});
}
