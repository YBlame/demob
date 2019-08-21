$(document).ready(function() {
						//对查询条件的加载
						var guid = $("#guid").val();
				        var typeDj = "false";
						$.ajax({
							url : "doc/queryCondition",//请求的url地址
							dataType : "json", //返回格式为json
							async : false,//请求是否异步，默认为异步，这也是ajax重要特性
							data : {
								guid : guid,
								typeDj:typeDj
							}, //参数值
							type : "POST", //请求方式
							success : function(con) {
								//请求成功时处理
								var divFrame = "";//外层div
								var inputTitle = "";//文本框标题
								var inputValue = "";//文本框
								var inputKey = "";//文本框对应
								var inputType = "";//数据类型
								var inputHidden = "";//隐藏域
								var input = "";//文本框最终定格
								var select = "";//select标签
								var strs = new Array();//创建数组
								var option = "";//选项
								var selectTitle = "";
								for (var i = 0; i < con.length; i++) {
									//根据单选，多选，下拉获取到初始值并且赋值给当前查询条件
									if (con[i].formtypes == 'radio'
											|| con[i].formtypes == 'select'
											|| con[i].formtypes == 'checkbox') {
										var selectValues = con[i].initval;
										selectValues = selectValues
												+ "";
										strs = selectValues.split(","); //字符分割 ;
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
										//inputValue的值会被存到一个隐藏的input标签里，标签name为所有文本框的名字和数据类型
										input += "&nbsp;&nbsp;&nbsp;&nbsp;<div class='layui-input-inline'><input type='number' id='keywords' name='"+con[i].zdm+"' placeholder='请输入"+con[i].zdmc+"' style='width:"+con[i].width+"px;' class='layui-input'></div>";
									}
									if (con[i].formtypes == 'text'
											|| con[i].formtypes == 'textarea') {
										//inputValue的值会被存到一个隐藏的input标签里，标签name为所有文本框的名字和数据类型
										input += "&nbsp;&nbsp;&nbsp;&nbsp;<div class='layui-input-inline'><input type='text' id='keywords' name='"+con[i].zdm+"' placeholder='请输入"+con[i].zdmc+"' style='width:"+con[i].width+"px;' class='layui-input'></div>";
									}
									if (con[i].formtypes == 'date') {

									}
								}
								inputKey = inputKey.substr(0,
										inputKey.length - 1); //截取关键词
								var br = "<br>";
								if (!input) {
									br = ""//拼接到标签
								}
								divFrame = "" + br
										+ "<div class='inputFrame'>"
										+ input + "</div>" + br + ""//拼接到标签
								$("#demoTable").prepend(divFrame);
								var frame = $(".inputFrame").html();
								if (frame == null || frame.length == 0) {

								} else {
									document.getElementById("button").style.display = 'block';
								}
							}
						});
					});
	layui.config({
		version : '1554901097999'
	});//为了更新 js 缓存，可忽略
	layui.use(
					[ 'laydate', 'laypage', 'layer', 'table', 'carousel',
							'upload', 'element', 'util','form', 'tree', 'slider' ],
					function() {
						var form = layui.form;
						var laydate = layui.laydate //日期
						, laypage = layui.laypage //分页
						, tree = layui.tree
						, layer = layui.layer //弹层
						, tree = layui.tree, util = layui.util, table = layui.table //表格
						, carousel = layui.carousel //轮播
						, upload = layui.upload //上传
						, element = layui.element //元素操作
						, slider = layui.slider //滑块
						, index = layer.load(1)
						//监听Tab切换
						element.on('tab(demo)', function(data) {
							layer.tips('切换了 ' + data.index + '：'
									+ this.innerHTML, this, {
								tips : 1
							});
						});
						$(document)
								.ready(
										function() {
											var guid = $("#guid").val();
											//获取表头并且获取数据
											var num = 1;
											$.ajax({
												url : "doc/findDoc",//请求的url地址
												dataType : "json", //返回格式为json
												async : false,//请求是否异步，默认为异步，这也是ajax重要特性
												data : {
													guid : guid,
													num : num
												}, //参数值
												type : "POST", //请求方式
												success : function(data) {
													var doclist = data;
													var cols = [];
													//遍历表头数据, 添加到数组中
													for (var k = 0; k < doclist.length; k++) {
														var zdm = doclist[k].zdm;
														var zdmc = doclist[k].zdmc;
														var width = doclist[k].width;
														var t = {
															field : zdm,
															title : zdmc,
															width : width,
															sort : true
														};
														cols.push(t);
													}
													var id = {
														field : 'guid',
														title : 'guid',
														hide : true
													}
													cols.push(id);
													var bar = {
														fixed : 'right',
														title : '操作',
														width : 200,
														align : 'center',
														toolbar : '#barDemo'
													}
													cols.push(bar);

													// 然后开始渲染表格
												table.render({
													elem : '#demo',
													height : 420, //描述
													url : 'doc/findDocTable?guid='
															+ guid
															+ "&num="
															+ num//数据接口
													,
													title : '记录表',
													page : {
														layout : [
																'prev',
																'page',
																'next',
																'skip',
																'count' ] //自定义分页布局
														,
														first : false //不显示首页
														,
														last : false
													//不显示尾页
													}, //开启分页
													limit : 7,
													limits : [
															3,
															5,
															10,
															20,
															50 ],
													done : function(
															res,
															curr,
															count) {
														this.where = {};
														layer
																.close(index) //加载完数据
													}
													/* ,toolbar : '#toolbarDemo' //开启工具栏，此处显示默认图标，可以自定义模型，详见文档 */
													,
													cols : [ cols ]
												});
										}
									});
								})
						//监听头工具栏事件
						table.on('toolbar(test)',
										function(obj) {
											var checkStatus = table
													.checkStatus(obj.config.id), data = checkStatus.data; //获取选中的数据
											switch (obj.event) {
											case 'add':
												var guidBmodel = $(
														"#guidBmodel").val();
												if (guidBmodel == null
														|| guidBmodel == "null"
														|| guidBmodel == undefined
														|| guidBmodel == "") {
													var guid = $("#guid").val();
													window.location.href = "doc/toAddDataJsp?guid="
															+ guid;
												} else {
													window.location.href = "doc/toAddDataJsp?guid="
															+ guidBmodel;
												}

												break;
											case 'delete':
												window.history.back(-1);
												break;
											}
											;
										});

						//监听行工具事件
						table.on('tool(test)',
										function(obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
											var data = obj.data //获得当前行数据
											, layEvent = obj.event; //获得 lay-event 对应的值
											
											if (layEvent === 'detail') {
												var guid = data['guid'];
												openDetail(guid);
											} else if (layEvent === 'edit') {
												$("#ruleDiv").hide();//显示菜单栏
												$("#menuDiv").hide();//显示菜单栏
												$("#test12").html("");
												tree.render();  //更新渲染
												var roleName = data['roleName'];//获取角色名称
												$("#roleName").val(roleName);
												var guid = data['guid'];
												$("#menuDiv").show();//显示菜单栏
												setTimeout(function(index){
													var btnVal=document.getElementById("checkedAll");
													btnVal.value="选中全部";
													$("#menu").html("菜单管理："+roleName);
													$("#roleMenuGuid").val(guid)
													var dataResult = "";
													var zhxxGuid = cj.getCookie('selected_expo_id'); 
													$.ajax({
												        type:"POST",
												        url:"rule/findTreeList",
														data:{
															"roleMenuGuid" : guid,
															"zhxxGuid"	: zhxxGuid
														},
														async:false,
												        success:function(data){
															dataResult = data
													 	}
													});
												  	var ruleTree = tree.render({
														elem : '#test12',
														data : dataResult,
														showCheckbox : true, //是否显示复选框
														id : 'demoId1',
														check:'checkbox',
														click : function(obj) {
															var title = obj.data.title;  //获取当前点击的节点数据
															var guidMenu = obj.data.guid;//当前菜单的guid
															var guidRole =data['guid'];//当前对应角色的guid
															var children =obj.data.children;//判断是否为最后一级
															var roleName = data['roleName'];//获取角色名称
															if (JSON.stringify(children)=="[]") {
																var btnVal=document.getElementById("checkedAll");
																btnVal.value="选中全部";
																var checkedData = tree.getChecked('demoId1'); //获取选中节点的数据
															    $("#checkedData").val(JSON.stringify(checkedData));
																$("#rule").html("权限规则："+title+"("+roleName+")");//赋值标题
																$("#ruleDiv").show();//显示菜单栏
																$("#guidRole").val(guidRole);
																$("#guidMenu").val(guidMenu);
																//获取全部权限操作--对应表中操作
																$.ajax({
																	type:"POST",
															        url:"rule/findRuleList",
																	data: {
																		"guidRole" : guidRole,
																		"guidMenu" :guidMenu
																	},
															        success:function(data){
																 	   $("input[name=rule]").prop("checked", false);//先清空上一次选中的
																	   var dataRule = data ;
																	   var strs= new Array(); //定义一数组 
																	   strs=dataRule.split(","); //字符分割 
																	   for (i=0;i<strs.length ;i++ ) 
																	   { 	
																		   $("#"+strs[i]).prop("checked", true);
																	   } 
																	   form.render('checkbox');
															        }
																});
																   

															}else{
																$("#ruleDiv").hide();//隐藏菜单栏
															}
														}
													});
												}, 300);
											}
						});
						//按钮事件
						util.event('lay-event',{
							getCheck : function(othis) {
								var json = tree.getChecked('demoId1'); //获取选中节点的数据
								var checkedData = tree.getChecked('demoId1'); //获取选中节点的数据
								if(checkedData.length == 0) {
						            layer.msg("至少勾选一个菜单点！", {time: 1000});
						            return;
						        }else{
						        	var menuGuids = "";
							        for(var i in checkedData) {
							        	if (checkedData[i].children!="") {
							        		for(var j in checkedData[i].children) {
								            	if (checkedData[i].children[j].children!="") {
								            		for(var k in checkedData[i].children[j].children) {
								            			menuGuids+=checkedData[i].children[j].children[k].guid+",";//保存最后子节点id
									                }			
												}else{
													menuGuids+=checkedData[i].children[j].guid+",";//保存最后子节点id	
												}
								            }
										}else{
											menuGuids+=checkedData[i].guid+",";//保存最后子节点id	
										}
							        }
									var roleMenuGuid=$("#roleMenuGuid").val();
									var zhxxGuid = cj.getCookie('selected_expo_id');
									$.ajax({
										type:"POST",
								        url:"rule/inOrUpMenu",
										data: {
											"roleMenuGuid" : roleMenuGuid,//
											"menuGuid" :menuGuids,//菜单编号
											"jsons" :  JSON.stringify(json),
											"zhxxGuid" : zhxxGuid
										},
										async:false,
								        success:function(data){
											if (data=="editAdd") {
												layer.msg("修改成功...", {time: 1000});
											}else if(data=="editError") {
												layer.msg("修改异常...请重试...", {time: 1000});
											}else{
												layer.msg("修改异常...", {time: 1000});
											}
								        }
									});
						        }
							},
							checkedAll : function() {//根据按钮value值进行判断，如果为选中全部菜单进ajax
								var btnVal=document.getElementById("checkedAll");
								if(btnVal.value=="选中全部")
							    {
									$.ajax({
										type:"POST",
								        url:"rule/findAllMenu",
								        success:function(data){
									 		var ids = data;
									 		var strs= new Array(); //定义一数组 
									 		strs=ids.split(","); //字符分割 
											for (var i = 0; i < strs.length; i++) {
												var id = Number(strs[i]);
												tree.setChecked('demoId1', id); //勾选指定节点
											}
									 		btnVal.value="并赋予全部权限";
								        }
									});
							    }
							    else{
							    	var guid = $("#roleMenuGuid").val();
							    	var roleName =$("#roleName").val();
							    	var jsons = tree.getChecked('demoId1'); //获取选中节点的数据
 							    	$.ajax({
										type:"POST",
								        url:"rule/addAllRule",
										data :{
											"roleGuid" : guid,
											"jsons" : JSON.stringify(jsons)
										},
								        success:function(data){
									 		if (data=="finish") {
												layer.msg("已为\'"+roleName+"\'赋予全部权限", {time: 1000});
											}else{
												layer.msg("权限赋予失败", {time: 1000});
											}
								        }
									});
							    }
							    
								
							}
							,
							reload : function() {
								var btnVal=document.getElementById("checkedAll");
								btnVal.value="选中全部";
								//重载实例
								tree.reload('demoId1',
								{
								});
								},
							selectAll:function(){//右侧全选
								 $(".parent").prop("checked", true);
								 form.render('checkbox');
							}
							,notSelectAll:function(){//右侧全不选
								 $(".parent").prop("checked", false);
								 form.render('checkbox');
							}
						});
						// 打开查看按钮
						function openDetail(guid) {
							window.location = "bzdk_Index.jsp?guid=" + guid;
						}
						//表格重载
						var active = {
							reload : function() {
								var demoReload = $('#keywords').val();
								var keyName = $("#keywords").attr("name")
								var guid = $("#guid").val();
								var index = layer.msg("查询中,请稍等...", {
									icon : 16,
									time : false,
									shade : 0
								})

								var postData = $("#vform").serialize();
								var tmpDic = {};
								for ( var i in postData.split("&")) {
									var row = postData.split("&")[i];
									tmpDic[row.split("=")[0]] = decodeURIComponent(row
											.split("=")[1]);
								}
								postData = decodeURIComponent(postData, true);
								setTimeout(function() {
									table.reload('demo', {
										where : {
											postData : postData
										},
										page : {
											curr : 1
										}
									});
									layer.close(index)
								}, 300)
							}
						};
						//单击条件查询按钮
						$('#demoTable #reload_btn').on('click', function() {
							var type = $(this).data('type');
							active[type] ? active[type].call(this) : '';
						});
					});
		function submitRule(){//提交当前菜单中的权限
			var id_array=new Array();  
		    $('input[name="rule"]:checked').each(function(){  
				id_array.push($(this).val());//向数组中添加元素  
			});  
		    
			var chapterstr = id_array.join(',');//将数组元素连接起来以构建一个字符串
			var guidRole =$("#guidRole").val();
			var guidMenu = $("#guidMenu").val();
			var checkedData = $("#checkedData").val();
			var zhxxGuid = cj.getCookie('selected_expo_id'); 
			alert(zhxxGuid)
			$.ajax({
				type:"POST",
		        url:"rule/inOrUpRule",//修改或者添加权限
				data: {
					"guidRole" : guidRole,
					"guidMenu" :guidMenu,
					"chapterstr" :chapterstr,
					"zhxxGuid" : zhxxGuid
				},
		        success:function(data){
					if (data=="editAdd") {
						layer.msg("修改成功...", {time: 1000});
					}else if(data=="editError") {
						layer.msg("修改异常...请重试...", {time: 1000});
					}else{
						layer.msg("修改异常...", {time: 1000});
					}
		        }
			});
		}