<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta ZHMC="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta ZHMC="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="statics/layui/css/layui.css" media="all">
<link rel="stylesheet" href="statics/layui/css/admin.css" media="all">
<link rel="stylesheet" href="statics/css/index.css" media="all">
</head>
<body>
	<div class="layui-fluid">
		<div class="layui-row layui-col-space15">
			<div class="layui-col-md8">
				<div class="layui-row layui-col-space15">
					<div class="layui-col-md12">
						<div class="layui-card">
							<div class="layui-card-header">工具栏</div>
							<div class="layui-card-body">
								<div class="layadmin-shortcut">
									<div carousel-item>
										<ul class="layui-row layui-col-space10" id="main_li">
											<li class="layui-col-xs3"><a href="javascript:;" name="WDZL"  class="bm" ><i class="layui-icon layui-icon-username" style="height: 146px; line-height: 146px; font-size: 60px;"></i> <cite>我的资料</cite>
											</a></li>
											<li class="layui-col-xs3"><a href="javascript:;"  name="BGXX" class="bm"> <i class="layui-icon layui-icon-home" style="height: 146px; line-height: 146px; font-size: 60px;"></i> <cite>我要报馆</cite>
											</a></li>
											<li class="layui-col-xs3"><a href="javascript:;" name="SGRYBX" class="bm"> <i class="layui-icon layui-icon-file" style="height: 146px; line-height: 146px; font-size: 60px;"></i> <cite>保险信息</cite>
											</a></li>
											<li class="layui-col-xs3"><a href="javascript:;" name="SGRYXX" class="bm"> <i class="layui-icon layui-icon-util" style="height: 146px; line-height: 146px; font-size: 60px;"></i> <cite>施工人员信息</cite>
											</a></li>
											<li class="layui-col-xs3"><a href="javascript:;" name="aa" class="bm"> <i class="layui-icon layui-icon-flag" style="height: 146px; line-height: 146px; font-size: 60px;"></i> <cite>货车信息</cite>
											</a></li>
											<li class="layui-col-xs3"><a href="javascript:;" name="KFPXX" class="bm"> <i class="layui-icon layui-icon-rmb" style="height: 146px; line-height: 146px; font-size: 60px;"></i> <cite>开票及退押金</cite>
											</a></li>
											<li class="layui-col-xs3"><a href="javascript:;" name="ss" class="bm"> <i class="layui-icon layui-icon-log" style="height: 146px; line-height: 146px; font-size: 60px;"></i> <cite>转账凭证</cite>
											</a></li>
											
										</ul>
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
			<div class="layui-col-md4">
				<div class="layui-card">
					<div class="layui-card-header">
						<i class="layui-icon layui-icon-notice" style="height: 16px; width: 16px; line-height: 16px; float: left; margin-left: 25px; position: inherit;"></i>
					</div>
					<div class="layui-card-body layui-text" style="height: 350px;">
						<ul class="layui-timeline">
							<li class="layui-timeline-item">
								<div class="layui-timeline-content layui-text">
									<h3 class="layui-timeline-title" id='RQ'></h3>
									<p id="NR"></p>
								</div>
							</li>
						</ul>
					</div>
				</div>

			</div>
		</div>
		<div class="layui-row layui-col-space15">
			<div class="layui-col-md12">
				<div class="layui-row layui-col-space15">
					<div class="layui-col-md12">
						<div class="layui-card">
							<div class="layui-tab layui-tab-brief layadmin-latestData">
								<div class="layui-card-body" id="bgxxDiv">
									<table id="demo" lay-filter="test" id="bgxxTable"></table>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/html" id="toolbarDemo">
		 <button type="button" class="layui-btn layui-btn-normal"  lay-event="add">新增</button>
    <button type="button" class="layui-btn layui-btn-danger" lay-event="delete">删除</button>
        <div class="layui-btn-container" style="float: right;">
            <i class="layui-icon layui-icon-ok-circle" style="font-size: 15px; color: #AFF42C;">
                <span style="color: black">审核通过</span>
            </i>
            <i class="layui-icon layui-icon-radio" style="font-size: 15px; color: #c2c2c2">
                <span style="color: black">审核中</span>
            </i>
            <i class="layui-icon layui-icon-close-fill" style="font-size: 15px; color: red;">
                <span style="color: black">审核未通过</span>
            </i>
        </div>
    </script>

<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
<script src="statics/layui/layui.js?t=1"></script>
<script src="statics/js/concisejs.js?t=1"></script>

<script type="text/javascript">
	layui.use([ 'laydate', 'laypage', 'layer', 'table', 'carousel',
							'upload', 'element', 'slider' ],
					function() {
						var table = layui.table, //表格
						carousel = layui.carousel, device = layui.device();

						var zhxxGuid = cj.getCookie('selected_expo_id');
						
					
						$.ajax({
							type : "POST",
							url : "dj/GetMenuByExpoGuid",
							data : {"zhxxGuid" : zhxxGuid},
							success : function(data) 
							{  
								 $("#main_li").find("a").each(function (i) {
						                var a = $(this).attr('name');
						                for (var j = 0; j < data.length; j++) {
						                	var li_href=$(this).attr('href');
						                	 if(data[j].bm==a)
						                    	{
						                    	$(this).removeAttr("disabled")
						                    	return;
						                    	}
						                    if (data[j].bm != a) {
						                    
						                    	$(this).attr('disabled',"true")
						                    }
						                }
						            });
								 
								 $("#main_li").find("a").each(function(i){							
									 var li_disabled=$(this).attr('disabled');
									 if(li_disabled!=undefined)
										 {
										 $(this).attr("href","javascript:toNoMsg()")
										 }
								 })
								
							}
							});
						
						$.ajax({
							type : "POST",
							url : "dj/findXxtz",
							data : {
								"zhxxGuid" : zhxxGuid
							},
							success : function(data) {
								var rq = document.getElementById("RQ");
								var nr = document.getElementById("NR");
								if (data.length > 0) {

									rq.innerHTML = data[0].RQ;

									nr.innerHTML = data[0].NR;
								} else {
									nr.innerHTML = "暂无消息";
								}
							},
							error : function(jqXHR) {
								alert("发生错误：" + jqXHR.status);
							}
						});

						//对查询条件的加载
						var guid = "";
						var zhxx = cj.getCookie('selected_expo_id');

						var bm = "BGXX";
						var bmc = "报馆信息";
						var typeDj = "true";
						$.ajax({url : "doc/queryCondition",//请求的url地址
							dataType : "json", //返回格式为json
							async : false,//请求是否异步，默认为异步，这也是ajax重要特性
							data : {
								guid : guid,
								zhxxDj : zhxx,
								bmDj : bm,
								typeDj : typeDj,
								bmcDj : bmc
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
										var types = {
											type : 'checkbox',
											fixed : 'left'
										}
										cols.push(types);
										//遍历表头数据, 添加到数组中
										for (var k = 0; k < doclist.length; k++) {
											var zdm = doclist[k].zdm;
											var zdmc = doclist[k].zdmc;
											var width = doclist[k].width;
											var t;
											//不显示还有'_ZT'的列
											if (zdm.indexOf('_ZT') == -1
													&& zdm != "ZWJGT" && zdm != "SJY"
													&& zdm != "BGDH" && zdm != "CTSJS"
													&& zdm != "GCSSJH"
													&& zdm != "GCSZZZS") {
												//添加固定列以及设置宽度
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
										/* var bar = {
											title : '操作',
											width : 140,
											fixed : 'right',
											align : 'center',
											sort : true,
											toolbar : '#barDemo'
										}
										cols.push(bar); */
										// 然后开始渲染表格
										table.render({
											elem : '#demo',
											height : 420, //描述
											url : 'bg/findBgTable?guid=' + guid
													+ "&num=" + num//数据接口
											,
											title : '记录表',
											defaultToolbar: ['exports'],
											page :true,
											done : function(res, curr, count) {
												this.where = {};
											},
											toolbar : '#toolbarDemo' //开启工具栏，此处显示默认图标，可以自定义模型，详见文档
											,
											cols : [ cols ]
										});
									}
	
								});
							}
						}
					});
						//监听头工具栏事件
						table.on('toolbar(test)',
										function(obj) {
											var checkStatus = table
													.checkStatus(obj.config.id), data = checkStatus.data; //获取选中的数据
											switch (obj.event) {
											case 'add':
												window.location.href = "DJ/BGXX.jsp";
												
												break;
											case 'delete':
												if(data.length === 0){
											          layer.msg('请选择一行');
											        } else {
											        	layer.confirm('确认删除？', function(index) {
											        		layer.msg('正在删除...', {icon: 16,shade: 0.3,time:1000});
											        		var guid ="";
											        		for (var i = 0; i < data.length; i++) {
																guid +=data[i]["guid"]+","
															}
															var guidBmodel = $("#guid").val();
															layer.close(index);
															$.post("doc/deleteDoc", {
																guid : guid,
																guidBmodel :guidBmodel
															}, function(result) {
																if (result=="delFinish") {
																	layer.msg('已删除!', {
								                                        icon: 1, time: 800, end: function () {
								                                        	table.reload('demo',{page:{curr:1}});
								                                            parent.reloadExpo();
								                                        }
								                                    });
																}else{
																	layer.msg('删除失败', {
								                                        icon: 1, time: 1000, end: function () {
								                                           
								                                        }
								                                    });
																}
															});
														});
											        }
											      break;
											}
											;
										});

				});
	function toNoMsg(){
	layer.alert('无权查看');
	}
	
</script>

</html>