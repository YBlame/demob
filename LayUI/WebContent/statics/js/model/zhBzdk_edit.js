//layui初始化
//配置选项（select/checkbox/radio）
layui.use('form',function() {
var form = layui.form;
form.render();
form.on('select(formtypes)',
		function(e) {
			var val = e.value;
			$(e).parent().find('.option').remove();
			if (val == "radio" || val == "checkbox"
					|| val == "select") {
				var initVal = $("#initVal").val();
				var strs = new Array(); // 定义一数组
				strs = initVal.split(","); // 字符分割
				var option = '<div class="option">';
				for (a = 0; a < strs.length; a++) {
					option += '<div class="option-item"><span class="option-input-wrap"><input type="text" class="option-input-option" value="'
							+ strs[a]
							+ '"  placeholder="选项名"/></span>';
					option += '<span class="option-sign-wrap" onclick="DelOption(this)">×</span></div>';
				}
				option += '<div class="add_option" onclick="AddOption(this)"><div class="add_option_sign">+</div><div class="add_option_words">添加选项</div></div>';
				option += '<div><a class="save_button" href="javascript:save_button()">保存操作</a></div>';

				option += '<div style="clear:both"></div></div>';
				var formtypes = document
						.getElementById("formtypesOption");
				formtypes.innerHTML = option;
			} else if (val === 'pic'
					|| val == 'file') {
				var html = "";
				html += "<input type='radio' name='exam' value='审核' title='审核' checked>";
				html += "<input type='radio' name='exam' value='不审核' title='不审核' >";
				var pic = document.getElementById("pic");
				pic.innerHTML = html;
				
				
				form.render();
			} else {
				$('.option').remove();
				$("#initVal").val("0");
			}
		});
	});
// 窗体加载事件
$(document).ready(function() {
	var val = document.getElementById("formtypesStr").value;
	$("#formtypes").val(val);
	if (val === 'pic' || val == 'file') {
		var formZdm = $("#zdm").val();
		var zdmZt = $("#zdmZT").val();
		var html = "";
		html += "<input type='radio' name='exam' value='审核' title='审核'>";
		html += "<input type='radio' name='exam' value='不审核' title='不审核'>";
		var pic = document.getElementById("pic");
		pic.innerHTML = html;
		if(zdmZt!=""){
				$("[name=exam][value=审核]").prop("checked", true);
		}else{
			$("[name=exam][value=不审核]").prop("checked", true);
		}
			
	}
	var flag = "<%=request.getParameter('flag')%>";
	if (flag == -404) {
		layui.use("layer", function() {
			var layer = layui.layer; // layer初始化
			layer.msg('数据字段已存在..');
		})
	}

})
// 返回
function toBack() {
	window.history.back(-1);
}