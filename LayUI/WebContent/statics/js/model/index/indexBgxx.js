function bgxxList(){
	layui.use(['element', 'layer', 'form', 'laytpl'], function () {
	    var element = layui.element,
	        layer = layui.layer,
	        form = layui.form,
	        laytpl = layui.laytpl;
	    	table = layui.table, //表格
	    	carousel = layui.carousel,
	    	device = layui.device();
			// 对查询条件的加载
			var guid = "";
			var zhxx = cj.getCookie('selected_expo_id');
		
			var bm = "BGXX";
			var bmc = "报馆信息";
			var typeDj = "true";
			$.ajax({url : "doc/queryCondition",// 请求的url地址
				dataType : "json", // 返回格式为json
				async : false,// 请求是否异步，默认为异步，这也是ajax重要特性
				data : {
					guid : guid,
					zhxxDj : zhxx,
					bmDj : bm,
					typeDj : typeDj,
					bmcDj : bmc
				}, // 参数值
				type : "POST", // 请求方式
				success : function(con) {
					// 请求成功时处理
					var divFrame = "";// 外层div
					var inputTitle = "";// 文本框标题
					var inputValue = "";// 文本框
					var inputKey = "";// 文本框对应
					var inputType = "";// 数据类型
					var inputHidden = "";// 隐藏域
					var input = "";// 文本框最终定格
					var select = "";// select标签
					var strs = new Array();// 创建数组
					var option = "";// 选项
					var selectTitle = "";
		
					for (var i = 0; i < con.length; i++) {
						// 根据单选，多选，下拉获取到初始值并且赋值给当前查询条件
						if (con[i].formtypes == 'radio'
								|| con[i].formtypes == 'select'
								|| con[i].formtypes == 'checkbox') {
							var selectValues = con[i].initval;
							selectValues = selectValues
									+ "";
							strs = selectValues.split(","); // 字符分割 ;
							option += "<option value='请选择'>请选择"
									+ con[i].zdmc
									+ "</option>"
							for (a = 0; a < strs.length; a++) {
								selectTitle = con[i].zdmc;
								option += "<option value='"
										+ strs[a].replace(
												"|$|", ",")
										+ "'>"
										+ strs[a].replace(
												"|$|", ",")
										+ "</option> ";
							}
							input += "&nbsp;&nbsp;&nbsp;&nbsp;<div class='layui-input-inline' style='width:"+con[i].width+"px;'><select name='"+con[i].zdm+"'  id='"+con[i].zdm+"' >"
									+ option
									+ "</select></div>";
							option = "";
						}
						if (con[i].formtypes == 'number') {
							// inputValue的值会被存到一个隐藏的input标签里，标签name为所有文本框的名字和数据类型
							input += "&nbsp;&nbsp;&nbsp;&nbsp;<div class='layui-input-inline'><input type='number' id='keywords' name='"+con[i].zdm+"' placeholder='请输入"+con[i].zdmc+"' style='width:"+con[i].width+"px;' class='layui-input'></div>";
						}
						if (con[i].formtypes == 'text'
								|| con[i].formtypes == 'textarea') {
							// inputValue的值会被存到一个隐藏的input标签里，标签name为所有文本框的名字和数据类型
							input += "&nbsp;&nbsp;&nbsp;&nbsp;<div class='layui-input-inline'><input type='text' id='keywords' name='"+con[i].zdm+"' placeholder='请输入"+con[i].zdmc+"' style='width:"+con[i].width+"px;' class='layui-input'></div>";
						}
						if (con[i].formtypes == 'date') {
		
						}
					}
					inputKey = inputKey.substr(0,
							inputKey.length - 1); // 截取关键词
					var br = "<br>";
					if (!input) {
						br = ""// 拼接到标签
					}
					divFrame = "" + br
							+ "<div class='inputFrame'>"
							+ input + "</div>" + br + ""// 拼接到标签
					$("#demoTable").prepend(divFrame);
					var frame = $(".inputFrame").html();
					if (frame == null || frame.length == 0) {
		
					} else {
		
						document.getElementById("button").style.display = 'block';
					}
				}
			});
			$.ajax({
				type : "POST",
				url : "dj/findBgxxLen",
				data : {
					"zhxxGuid" : zhxx,
					"bm":bm,
					"bmc":bmc
				},
				success : function(data) {
					if(data!='exist'){
						$('#bgxxTable').hide();
						$("#bgxxDiv").append("<a href=\"DJ/BGXX.jsp\" class=\"layui-btn layui-btn-normal newsAdd_btn\">+新增报馆</a>")
					}else{
					var guid = "";
					// 获取表头并且获取数据
					var num = 1;
					$.ajax({
						url : "doc/findDoc",// 请求的url地址
						dataType : "json", // 返回格式为json
						async : false,// 请求是否异步，默认为异步，这也是ajax重要特性
						data : {
							guid : guid,
							num : num
						}, // 参数值
						type : "POST", // 请求方式
						success : function(data) {
							var doclist = data;
							var cols = [];
							var types = {
								type : 'checkbox',
								fixed : 'left'
							}
							cols.push(types);
							// 遍历表头数据, 添加到数组中
							for (var k = 0; k < doclist.length; k++) {
								var zdm = doclist[k].zdm;
								var zdmc = doclist[k].zdmc;
								var width = doclist[k].width;
								var t;
								// 不显示还有'_ZT'的列
								if (zdm.indexOf('_ZT') == -1
										&& zdm != "ZWJGT" && zdm != "SJY"
										&& zdm != "BGDH" && zdm != "CTSJS"
										&& zdm != "GCSSJH"
										&& zdm != "GCSZZZS") {
									// 添加固定列以及设置宽度
									if (zdm == "ZGH" || zdm == "ZWH") {
										t = {
											field : zdm,
											title : zdmc,
											width : width,
											sort : true,
											fixed : 'left',
											width : 80
										};
									}
		
									else if (zdm == "CZQYGSQC") {
										t = {
											field : zdm,
											title : zdmc,
											width : width,
											sort : true,
											fixed : 'left',
		
											width : 160
										};
									} else {
										t = {
											field : zdm,
											title : zdmc,
											width : width,
											sort : true,
										};
		
									}
									cols.push(t);
								}
							}
							var id = {
								field : 'guid',
								title : 'guid',
								hide : true
							}
							cols.push(id);
							/*
							 * var bar = { title : '操作', width : 140, fixed : 'right',
							 * align : 'center', sort : true, toolbar : '#barDemo' }
							 * cols.push(bar);
							 */
							// 然后开始渲染表格
							table.render({
								elem : '#demo',
								height : 420, // 描述
								url : 'bg/findBgTable?guid=' + guid
										+ "&num=" + num// 数据接口
								,
								title : '记录表',
								defaultToolbar: ['exports'],
								page :true,
								done : function(res, curr, count) {
									this.where = {};
								},
								toolbar : '#toolbarDemo' // 开启工具栏，此处显示默认图标，可以自定义模型，详见文档
								,
								cols : [ cols ]
							});
						}
		
					});
				}
			}
		});
			
	});
}