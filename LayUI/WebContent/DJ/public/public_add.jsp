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
<meta charset="utf-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="statics/css/exseen.css">
<link rel="stylesheet" href="statics/layui/css/layui.css" media="all">
<link rel="stylesheet" href="statics/layui/admin.css" media="all">
 <link rel="stylesheet" href="statics/css/index.css" media="all">
</head>
<body>
	<div class="layui-fluid">
		<div class="layui-card">
			<div class="layui-card-header"><%=request.getParameter("bmc")%>-新增
			<input id="bm" name="bm" style="display: none" value="<%=request.getParameter("bm")%>">
			</div>
			<div class="layui-card-body" style="padding: 15px;">
				<input id="uuid" name="uuid" style="display: none" value="<%=request.getParameter("guid")%>"> <input id="flag" name="flag" style="display: none" value="<%=request.getParameter("flag")%>"> <input id="bmcDj" name="bmcDj" style="display: none" value="<%=request.getParameter("bmcDj")%>"> <span id="isform"></span>
				<form id="layui-form" class="layui-form  layui-form-pane" action="djpublic/public_doAdd" onsubmit="return fomrSubmit(this);" method="post"></form>
			</div>
		</div>
	</div>



</body>


<script src="statics/layui/layui.js"></script>
<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
<script src="statics/js/concisejs.js"></script>
<script src="statics/js/doc.js"></script>
<script type="text/javascript">
layui.use([ 'form','laydate','layer','upload' ],function() {
	var form = layui.form, laydate = layui.laydate, layer = layui.layer;
	upload = layui.upload;
	//初始化layUI
	var form = layui.form;
	form.render();
	var flag = $("#flag").val();
	if (flag == 1) {
		layui.use("layer", function() {
			layer.msg('数据添加成功..');
		})
	} else if (flag == -404) {
		layui.use("layer", function() {
			layer.msg('数据添加异常..请重试..');
		})
	}
	
	
	upload.render();
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
       	  		$('#'+d+'Btn').before("<div class='file-iteme' style='width: 92px;height: 92px;display:inline-block;margin-right: 10px;'><img src='"+ res.data.src +"' id='"+res.name+"' alt=''  style='margin-bottom: 5px;position:relative;' class='layui-upload-img uploader-list'>  <span class='info' style='position:absolute;z-index:10;display:none'><a href='"+res.data.src+"' target='_blank'><image src='statics/login/prew.png'></image></a></span><span class='info' style='position:absolute;z-index:10;display:none' onclick='del(this)'><image src='statics/login/del.png'></image></span></div>");
       	  		$("#"+d+"").val();
            }
        });
    }
	
	
	var guid = $("#uuid").val();
	//post方法获取表单类型
	$.post("djpublic/toAddData",
			{
				guid : guid
			},
			function(result) {
				var fromInput = "";
				var isform = "";
				var isedit = ""
				var jsdm = "";
				var picZdm = "";//当是图片时，追加字段，进行渲染按钮
				for (var i = 0; i < result.length; i++) {
					if (result[i].jsdmFlag != 0) {
						jsdm = "   placeholder='请单击选择' readonly  onclick='findJSDM(\""
								+ result[i].api
								+ "\",\""
								+ result[i].guid
								+ "\",this,\""
								+ result[i].zdm
								+ "\",)' ";
					} else {
						if (result[i].zdm == 'parentMenu') {
							jsdm = "   placeholder='请单击选择' readonly onclick='findParentMenu(\""
									+ result[i].guid
									+ "\",this)' ";
						} else {
							jsdm = "";
						}
					}
					if (result[i].isedit == 1) {
						isedit = "";
					} else {
						isedit = "readonly";
					}
					if (result[i].isform == 0) {
						isform = "";
					} else {
						isform = "<font color=red>*</font>";
					}
					var input = "";
					var display = ""//用于菜单中新增菜单时，没有父级的应用场景
					switch (result[i].formtypes) {
					case "text"://文本类型
						var id = "${id}";
						var parentName = "${parentName}";
						if (result[i].zdm == "ZHBH") {
							display += "display:none;";
							var selected = cj.getCookie('selected_expo_id');
							input += "<input type='text' id='"+result[i].zdm+"' value='"+selected+"'  name='"+ result[i].zdm+"' "+jsdm+" style='"+display+"' "+isedit+"   placeholder='请输入"+ result[i].zdmc+"' autocomplete='off' class='layui-input'>";
						} else {
							display = "";
							if (result[i].zdm == 'parentMenu') {
								if (!id) {
									display += "display:none;";
									input += "<input type='text' id='"+result[i].zdm+"'  name='"+ result[i].zdm+"' "+jsdm+" style='width:"+result[i].width+"px;"+display+"' "+isedit+"   placeholder='请输入"+ result[i].zdmc+"' autocomplete='off' class='layui-input'>";
								} else {
									input += "<input type='text' id='"+result[i].zdm+"'  style='width:"+result[i].width+"px;' "+isedit+"  value='"+parentName+"'   placeholder='请输入"+ result[i].zdmc+"' autocomplete='off' class='layui-input'>";
									input += "<input type='hidden' id='hiddenInput' name='"+ result[i].zdm+"' value='"+id+"'>"
								}
							} else {
								if (result[i].zdm == 'mm') {
									input += "<input type='password' id='"+result[i].zdm+"' name='"+ result[i].zdm+"' "+jsdm+" style='width:"+result[i].width+"px;' "+isedit+"    placeholder='请输入"+ result[i].zdmc+"' autocomplete='off' class='layui-input'>";
								} else {
									input += "<input type='text' id='"+result[i].zdm+"' name='"+ result[i].zdm+"' "+jsdm+" style='width:"+result[i].width+"px;' "+isedit+"    placeholder='请输入"+ result[i].zdmc+"' autocomplete='off' class='layui-input'>";
								}
							}
						}
						fromInput += "<div class=\"layui-form-item\" style="+display+">"
								+ "<label class=\"layui-form-label\" style='width:150px;'>"
								+ isform
								+ result[i].zdmc
								+ "</label>"
								+ "<div class=\"layui-input-block\">"
								+ ""
								+ input
								+ "</div>"
								+ "<div class='layui-form-mid layui-word-aux'></div></div>";
						break;
					case "select"://下拉框类型
						var selectDisabled = "";
						var strOption = result[i].initval;
						var strs = new Array(); //定义一数组 
						var option = " ";
						strs = strOption.split(","); //字符分割 
						if (result[i].isedit == 1) {
							selectDisabled = "";
						} else {
							selectDisabled = "disabled"
						}
						for (a = 0; a < strs.length; a++) {
							option += "<option value='"+ strs[a].replace("|$|",",")+ "'>"+ strs[a].replace("|$|",",")+ "</option> ";
						}
						fromInput += "<div class='layui-form-item'>"
								+ "<label class='layui-form-label' '>"
								+ isform
								+ result[i].zdmc
								+ "</label>"
								+ "<div class=\"layui-input-block\"  style='width:"+result[i].width+"px;' >"
								+ "<select name='"+result[i].zdm+"' "+selectDisabled+" id='"+result[i].zdm+"' >"
								+ ""
								+ option
								+ ""
								+ "</select></div>"
								+ "<div class='layui-form-mid layui-word-aux'></div></div>";
						break;
					case "textarea"://文本域
						fromInput += "<div class='layui-form-item layui-form-text'><label class='layui-form-label'  style='width:150px;'>"
								+ isform
								+ result[i].zdmc
								+ "</label><div class='layui-input-block'><textarea id='"+result[i].zdm+"'  name='"+result[i].zdm+"' placeholder='请输入"+result[i].zdmc+"' "+isedit+"  style='width:"+result[i].width+"px;height:"+result[i].height+"' class='layui-textarea'></textarea></div></div>";
						break;
					case "number"://数字
						fromInput += " <div class='layui-form-item'><label class='layui-form-label'  style='width:150px;'>"
								+ isform
								+ result[i].zdmc
								+ "</label><div class='layui-input-inline'><input type='number' id='"+result[i].zdm+"'  name='"+result[i].zdm+"' "+jsdm+"  "+isedit+" style='width:"+result[i].width+"px;' placeholder='仅限输入数字' lay-verify='required|number'  min='0'  autocomplete='off' class='layui-input'></div><div class='layui-form-mid layui-word-aux'></div></div>"
						break;
					case "datetime"://时间
						if (result[i].isedit == 1) {
							fromInput += "<div class='layui-form-item'><label class='layui-form-label' style='width:150px;'>"
								+ isform
									+ result[i].zdmc
									+ "</label><div class='layui-input-inline'><input type='text' class='layui-input datetime' name='"+result[i].zdm+"' id='"+result[i].zdm+"' style='width:"+result[i].width+"px;' readonly placeholder='yyyy-MM-dd HH:mm:ss'></div></div>";

						} else {
							fromInput += "<div class='layui-form-item'><label class='layui-form-label'  style='width:150px;'>"
								+ isform
									+ result[i].zdmc
									+ "</label><div class='layui-input-inline'><input type='text' class='layui-input datetime' name='"+result[i].zdm+"' id='"+result[i].zdm+"'  readonly style='width:"+result[i].width+"px;' placeholder='yyyy-MM-dd HH:mm:ss'></div></div>";
						}
						break;
					case "date":
						if (result[i].isedit == 1) {
							fromInput += "<div class='layui-form-item'><label class='layui-form-label' style='width:150px;'>"
								+ isform
									+ result[i].zdmc
									+ "</label> <div class='layui-input-inline' > <input type='text' class='layui-input date' id='"+result[i].zdm+"'  name='"+result[i].zdm+"' style='width:"+result[i].width+"px;'  readonly placeholder='yyyy-MM-dd'> </div></div>";
						} else {
							fromInput += "<div class='layui-form-item'><label class='layui-form-label' style='width:150px;'>"
								+ isform
									+ result[i].zdmc
									+ "</label> <div class='layui-input-inline'> <input type='text' class='layui-input date' id='"+result[i].zdm+"'  name='"+result[i].zdm+"' style='width:"+result[i].width+"px;'   placeholder='yyyy-MM-dd'> </div></div>";
						}
						break;
					case "checkbox"://多选
						var strOptionC = result[i].initval;
						var strsC = new Array(); //定义一数组 
						var optionC = " ";
						strsC = strOptionC
								.split(","); //字符分割 
						for (f = 0; f < strsC.length; f++) {
							if (result[i].isedit == 1) {
								optionC += "<input type='checkbox' class='"+result[i].zdm+"' lay-skin='primary'  title='"+strsC[f]+"' value='"+strsC[f]+"'>";
							} else {
								optionC += "<input type='checkbox' class='"+result[i].zdm+"' lay-skin='primary' disabled title='"+strsC[f]+"' value='"+strsC[f]+"'>";

							}
						}
						optionC += "<input id='"+result[i].zdm+"' name='"+result[i].zdm+"' style='display: none'  >"
						fromInput += " <div class='layui-form-item'> <label class='layui-form-label' style='width:150px;'>"
							+ isform
								+ result[i].zdmc
								+ "</label><div class='layui-input-block'>"
								+ optionC
								+ "</div></div>";
						break;
					case "radio"://单选
						var strOptionR = result[i].initval;
						var strsR = new Array(); //定义一数组 
						var optionR = " ";
						strsR = strOptionR
								.split(","); //字符分割 
						for (e = 0; e < strsR.length; e++) {
							if (result[i].isedit == 1) {
								optionR += "<input type='radio' name='"+result[i].zdm+"'  value='"+strsR[e]+"' title='"+strsR[e]+"' checked>";

							} else {
								optionR += "<input type='radio' name='"+result[i].zdm+"' disabled value='"+strsR[e]+"' title='"+strsR[e]+"' checked>";
							}
						}
						fromInput += " <div class='layui-form-item'><label class='layui-form-label' style='width:150px;'>"
							+ isform
								+ result[i].zdmc
								+ "</label><div class='layui-input-block'>"
								+ optionR
								+ "</div></div>";
						break;
					case "pic":
						fromInput += "  <div class=\"layui-form-item\">"
						fromInput += "  	<div class=\"layui-upload\">"
						fromInput += "  	 <blockquote class=\"layui-elem-quote layui-quote-nm\" style=\"margin-top: 10px;\">"+isform+result[i].zdmc
						fromInput += "  	 	<div class=\"layui-upload-list\" >"
						fromInput += "  			<input id='"+result[i].zdm+"' name='"+result[i].zdm+"' style='display: none' lay-reqtext=\""+result[i].zdmc+"不能为空\" />"
						fromInput += "  			<button type=\"button\" class=\"layui-btn\" style=\"display:block;margin:0 auto\" id=\""+result[i].zdm+"Btn\">"+result[i].zdmc+" </button>"
						fromInput += "			</div>"
						fromInput += "		 </blockquote>"
						fromInput += "      </div>"
						fromInput += "      </div>"
						picZdm += result[i].zdm+",";
					}
				}
				var guid = $("#uuid").val();
				fromInput += "<input id='guid' name='guid' style='display: none' value='"+guid+"' />";
				if (guid == "73c2efa3c34f4904ae0eee4ab31dfa79") {//此处是用于菜单的新增
					fromInput += "<div class=\"layui-form-item layui-layout-admin\"><div class=\"layui-input-block\"><div class=\"layui-footer\" style=\"left: 0;\">   <button class='layui-btn' >立即提交</button><button type='button' onclick='bakcButton()'  class='layui-btn layui-btn-primary'>返回</button></div> </div></div></div>"
				} else {
					var bm = $("#bm").val();
					if(bm=="SGRYBX"){
						fromInput+="<div class=\"layui-form-item layui-layout-admin\"><div class=\"layui-input-block\"><div class=\"layui-footer\" style=\"left: 0;\">  <button class='layui-btn' lay-submit='' lay-filter='component-form-demo1'>保存</button></div> </div></div></div>";
					}else{
						fromInput += "<div class=\"layui-form-item layui-layout-admin\"><div class=\"layui-input-block\"><div class=\"layui-footer\" style=\"left: 0;\">  <button class='layui-btn' onclick='toSubmitMenu()' >保存</button><button type='button' onclick='bakcButton()'  class='layui-btn layui-btn-primary'>返回</button></div> </div></div></div>"
					}
				}
				var formtypes = document.getElementById("layui-form");
				formtypes.innerHTML = fromInput;
				
				
				
				
				var strs= new Array(); //定义一数组 
				strs=picZdm.split(","); //字符分割 
				for (i=0;i<strs.length ;i++ ) 
				{ 
					selectImg(strs[i])
				} 
				form.render();
				
				lay('.date').each(function() {
					laydate.render({
						elem : this,
						trigger : 'click',
						type : 'date',
						position : 'fixed'
					});
				});
				lay('.datetime').each(
					function() {
						laydate
								.render({
									elem : this,
									type : 'datetime',
									trigger : 'click',
									position : 'fixed'
								});
					});
				});
	
	
	/* 监听提交审核 */
	  form.on('submit(component-form-demo2)', function (data) {
		  layer.open({
           content: '确定要提交审核吗？系统将要提交全部数据，提交后将不能进行添加、修改、删除等操作！',
           btn: ['确认', '取消'],
        
           yes: function (index, layero) {
            //提交之后修改状态 重新加载框架 
            $.ajax({
                 url:"gzry/updtijiaobxStateByGuid",//请求的url地址
                 dataType:"json",   //返回格式为json                                      
                 data:{zhxxguid : cj.getCookie('selected_expo_id') },    //参数值
                 type:"POST",   //请求方式
                 success:function(con){
            	 $(".layui-upload-list button").remove();
					//$("div").removeClass("file-iteme");
						$(".layui-layout-admin").remove();
            	 layer.close(index);
             }
            });
               
           },
           //btn2和cancel方法没有用到，可以不写
           btn2: function (index, layero) {
        
           },
           cancel: function () {
           //右上角关闭回调
           }
       });
	})
	})
	//查找JSDM关联字段
	function findJSDM(api, guid, data, father) {
		hideDiv();
		var guid = guid;
		var apiVal = "";
		var father = father;
		if (api == ".") {
			apiVal = "";
		} else {
			apiVal = $("#" + api).val();
		}
		//根据zdmc，guid查找对应jsdm在后台得到对应一行数据
		$.post("doc/findJSDM",
						{
							api : api,
							apiVal : apiVal,
							zdmc : data.name,
							guid : guid
						},
						function(result) {
							if (result.length == 0) {
								layui.use("layer", function() {
									layer.msg('未找到JSDM关联字段...');
								})
							} else if (result == "error") {
								layui.use("layer", function() {
									layer.msg('未找到JSDM关联的数据库或表...');
								})
							} else if (result == "errorJSDM") {
								layui.use("layer", function() {
									layer.msg('JSDM格式有误...');
								})
							} else if (result == "nullJSDM") {
								layui.use("layer", function() {
									layer.msg('该标签为级联标签请选择父级...');
								})
							} else {
								//得到后台对应jsdm将字段传到前台
								$
										.post(
												"doc/findJSDMZdm",
												{
													zdmc : data.name,//字段名
													guid : guid
												},
												function(jsdm) {
													var jsdmVal = "";
													var fromVal = "";
													for (var i = 0; i < jsdm.length; i++) {
														jsdmVal = jsdm[0];
														fromVal = jsdm[1];
													}
													var parts = new Array();
													parts = jsdmVal.split(","); //字符分割 
													var froms = new Array();
													froms = fromVal.split(","); //字符分割 
													var trBody = "";
													var tdBody = "";
													var getValueMap = new Map();
													var mapJson = "";
													var name = "";
													var resultLength = result.length;
													var partsLen = parts.length;
													var fromsLen = froms.length;
													for (var i = 0; i < resultLength; i++) {
														tdBody = "";
														for (var a = 0; a < partsLen; a++) {
															tdBody += ""
																	+ result[i][parts[a]]
																	+ ",";
														}
														for (var b = 0; b < fromsLen; b++) {
															for (var y = 0; y < partsLen; y++) {
																name = froms[b];
																getValueMap[froms[b++]] = result[i][parts[y]];
															}
															b--;//自增值减一返回初始值
														}

														mapJson = JSON
																.stringify(getValueMap);
														tdBody = tdBody
																.slice(
																		0,
																		tdBody.length - 1)
														trBody += " <li onclick='getValue("
																+ mapJson
																+ ",\""
																+ api
																+ "\",\""
																+ tdBody
																+ "\",\""
																+ father
																+ "\")'><div type=\'text\' readonly=\'readOnly\' name=\'"+name+"\' class=\'kwli\'>"
																+ tdBody
																+ "</div></li>"
													}
													var s = "<ul id=\'ulList\' class='ulList' style='position:absolute; overflow:auto; float:left; z-index:99;'>"
															+ trBody + "</ul>";
													$(
															"input[name='"
																	+ data.name
																	+ "']")
															.after(s);
												});

							}
						});
	}
	$('html').bind('click', function(event) {
		// IE支持 event.srcElement ， FF支持 event.target    
		var evt = event.srcElement ? event.srcElement : event.target;
		if (evt.id == 'ulList')
			return; // 如果是元素本身，则返回
		else {
			$('#ulList').remove(); // 如不是则隐藏元素
		}
	});
	function bakcButton() {
		window.history.go(-1);
	}
	//JSDM关联字段的值放入目标字段中;关闭列表
	function getValue(map, api, apiVal, father) {
		//遍历map
		for ( var prop in map) {
			if (map.hasOwnProperty(prop)) {
				//如果api不等于.说明是级联的子级
				//得到api查询父级的值，添加change事件
				//当父级的值改变时，子级清空
				//api = 父级
				//prop= 子级(当存在父级的时候prop等于子级)
				var p = $("#" + father).val();
				document.getElementById("" + prop + "").value = map[prop];
				if (api == ".") {
					if (p != apiVal) {
						$("#" + prop).change();
					}
				}
				if (api != ".") {
					$("#" + api).on('change', function() {
						$("#" + prop).val("");
					});
				}
			}
		}
		hideDiv();
	}
	//关闭列表
	function hideDiv() {
		$('#ulList').remove(); // 如不是则隐藏元素
	}
	
	
	
	//提交

	function fomrSubmit(form) {
		$("input[name=file]").removeAttr("name")
		var guid = $("#uuid").val();
		var flag = false;
		$.ajax({url : "doc/toAddData",
					type : "POST",
					dataType : "json",
					async : false,
					data : {
						guid : guid
					},
					success : function(result) {
						for (var i = 0; i < result.length; i++) {
							if (result[i].isform != 0) {
								if (result[i].formtypes == "checkbox") {
									var obj = document
											.getElementsByClassName(""
													+ result[i].zdm + "");
									var check_val = [];
									for (k in obj) {
										if (obj[k].checked)
											check_val.push(obj[k].value);
									}
									$("#" + result[i].zdm + "").val(check_val);
								}
								if (result[i].formtypes == "textarea") {
									if ($("#" + result[i].zdm + "").val() != "") {
										flag = true;
									} else {
										layui.use("layer", function() {
											layer.msg(result[i].tips + ""
													+ result[i].zdmc);
										})
										$("#" + result[i].zdm + "").focus();
										flag = false;
										return false;
									}
								}
								if ($("input[name='" + result[i].zdm + "']")
										.val() != "") {
									flag = true;
								} else {
									layui.use("layer", function() {
										layer.msg(result[i].tips + ""
												+ result[i].zdmc);
									})
									$("input[name='" + result[i].zdm + "']")
											.focus();
									flag = false;
									return false;
								}

							}
						}
					}
				});
		return flag;
	}
</script>
</html>
