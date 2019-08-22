$(document).ready(function() {
	//对查询条件的加载
    var guid =$("#guid").val();
    var zhxx = $("#zhxx").val();
    var bm = $("#bm").val();
    var bmc = $("#bmc").val();
    var typeDj = $("#typeDj").val();
	$.ajax({
		    url:"doc/queryCondition",//请求的url地址
		    dataType:"json",   //返回格式为json
		 	async : false,//请求是否异步，默认为异步，这也是ajax重要特性
		    data:{guid : guid,zhxxDj : zhxx,bmDj:bm,typeDj:typeDj,bmcDj:bmc},    //参数值
		    type:"POST",   //请求方式
		    success:function(con){
		        //请求成功时处理
				var divFrame="";//外层div
				var inputTitle="";//文本框标题
				var inputValue="";//文本框
				var inputKey="";//文本框对应
				var inputType="";//数据类型
				var inputHidden="";//隐藏域
				var input ="";//文本框最终定格
				var select = "";//select标签
				var strs =new Array();//创建数组
				var option="";//选项
				var selectTitle="";
				
				for (var i = 0; i < con.length; i++) {
					//根据单选，多选，下拉获取到初始值并且赋值给当前查询条件
					if (con[i].formtypes=='radio'||con[i].formtypes=='select'||con[i].formtypes=='checkbox') {
						var selectValues=con[i].initval;
						selectValues=selectValues+"";
						strs=selectValues.split(","); //字符分割 ;
						option +="<option value='请选择'>请选择"+con[i].zdmc+"</option>"
						for (a=0;a<strs.length ;a++ ) 
				    	{ 	
							selectTitle=con[i].zdmc;
				    		option += "<option value='"+strs[a].replace("|$|",",")+"'>"+strs[a].replace("|$|",",")+"</option> ";
				    	}
						input+="&nbsp;&nbsp;&nbsp;&nbsp;<div class='layui-input-inline' style='width:"+con[i].width+"px;'><select name='"+con[i].zdm+"'  id='"+con[i].zdm+"' >"+option+"</select></div>";
						option="";
					}
					if (con[i].formtypes=='number') {
						//inputValue的值会被存到一个隐藏的input标签里，标签name为所有文本框的名字和数据类型
						input+="&nbsp;&nbsp;&nbsp;&nbsp;<div class='layui-input-inline'><input type='number' id='keywords' name='"+con[i].zdm+"' placeholder='请输入"+con[i].zdmc+"' style='width:"+con[i].width+"px;' class='layui-input'></div>";
					}
					if (con[i].formtypes=='text'||con[i].formtypes=='textarea') {
						//inputValue的值会被存到一个隐藏的input标签里，标签name为所有文本框的名字和数据类型
						input+="&nbsp;&nbsp;&nbsp;&nbsp;<div class='layui-input-inline'><input type='text' id='keywords' name='"+con[i].zdm+"' placeholder='请输入"+con[i].zdmc+"' style='width:"+con[i].width+"px;' class='layui-input'></div>";
					}
					if (con[i].formtypes=='date') {
						
					}
				}
				inputKey = inputKey.substr(0, inputKey.length - 1); //截取关键词
				var br = "<br>";
				if(!input){
					br=""//拼接到标签
				}
				divFrame=""+br+"<div class='inputFrame' style='float:left;'>"+input+"</div>"+br+""//拼接到标签
				$("#button").before(divFrame); 
				var frame = $(".inputFrame").html();
				if (frame==null ||frame.length == 0) {
					
				}else{
					
					document.getElementById("button").style.display='block';
				}											    
			}
		});
			});
				layui.config({
					version : '1554901097999' //为了更新 js 缓存，可忽略
				});
				layui.use([ 'laydate', 'laypage', 'layer', 'table',
							'carousel', 'upload', 'element',
							'slider' ],function() {
									var form = layui.form;
									var laydate = layui.laydate //日期
									, laypage = layui.laypage //分页
									, layer = layui.layer //弹层
									, table = layui.table //表格
									, carousel = layui.carousel //轮播
									, upload = layui.upload //上传
									, element = layui.element //元素操作
									, slider = layui.slider //滑块
									, index  = layer.load(1)
									//监听Tab切换
									element.on('tab(demo)', function(data) {
										layer.tips('切换了 ' + data.index + '：'
												+ this.innerHTML, this, {
											tips : 1
										});
									});
									$(document).ready(function() {
										var guid =$("#guid").val();
										//获取表头并且获取数据
											var num =1;
											$.ajax({
											    url:"doc/findDoc",//请求的url地址
											    dataType:"json",   //返回格式为json
											    async : false,//请求是否异步，默认为异步，这也是ajax重要特性
											    data:{guid:guid,num:num},    //参数值
											    type:"POST",   //请求方式
											    success:function(data){
								                    var doclist = data;
													var cols = [];
													var types ={
															type : 'checkbox',
															fixed : 'left'
													}
													cols.push(types);
													//遍历表头数据, 添加到数组中
								                    for (var k = 0; k < doclist.length; k++) {
								                        var zdm = doclist[k].zdm;
								                        var zdmc = doclist[k].zdmc;
								                        var width = doclist[k].width;
														var t ={
									                            field: zdm,
									                            title: zdmc,
									                            width : width,
									                            sort: true,
									                            
									                        };
								                        cols.push(t);
								                    }
								                    var id={
								                    		field: 'guid',
															title : 'guid',
															hide : true
								                        }
								                    cols.push(id);
								                    var bar={
															title : '操作',
															width:180,
															fixed: 'right',
															align:'center',
															sort: true,
															toolbar : '#barDemo'
								                        }
								                    cols.push(bar);
								                    // 然后开始渲染表格
								                    table.render({
								                    	elem : '#demo',
														height : 420,		//描述
														url : 'doc/findDocTable?guid='+guid+"&num="+num//数据接口
														,
														title : '记录表',
														page:true,
														done:function (res, curr, count) {
															this.where={};
										                    layer.close(index) //加载完数据
										                }
														,toolbar : '#toolbarDemo' //开启工具栏，此处显示默认图标，可以自定义模型，详见文档
														,
														cols : [cols]
										               
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
															var guidBmodel = $("#guidBmodel").val();
															if (guidBmodel==null||guidBmodel=="null"||guidBmodel==undefined||guidBmodel=="") {
																var guid = $("#guid").val();
																var bmc = $("#bmc").val();
																window.location.href = "doc/toAddDataJsp?guid="+guid+"&bmc="+bmc;
															}else{
																window.location.href = "doc/toAddDataJsp?guid="+guidBmodel+"&bmc="+bmc;
															}
															
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
											                                            window.location.reload();
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

									//监听行工具事件
									table.on('tool(test)', function(obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
										var data = obj.data //获得当前行数据
										, layEvent = obj.event; //获得 lay-event 对应的值
										if (layEvent === 'detail') {
											var guid = data['guid'];
											openDetail(guid);
										} else if (layEvent === 'del') {
											layer.confirm('真的删除该行么', function(index) {
												var guid = data['guid'];
												var guidBmodel = $("#guid").val();
												layer.close(index);
												$.post("doc/deleteDoc", {
													guid : guid,
													guidBmodel :guidBmodel
												}, function(result) {
													if (result=="delFinish") {
														layer.msg("删除成功...");
														obj.del();
													}else{
														layer.msg("删除成功...");
													}
												});
											});
										} else if (layEvent === 'edit') {
											var guid = data['guid'];//拿到一行数据中的guid
											var guidBmodel = $("#guidBmodel").val();
											if (guidBmodel==null||guidBmodel=="null"||guidBmodel==undefined||guidBmodel=="") {
												var guidB =$("#guid").val();//拿到模型表中的guid
												window.location.href = "doc/toUpdateDoc?guid="+guid+"&guidBmodel="+guidB;
											}else{
												window.location.href = "doc/toUpdateDoc?guid="+guid+"&guidBmodel="+guidBmodel;
											}
											//方便显示表单
										}else if (layEvent === 'audit') {
										       var guid = data['guid'];

										      }
									});
									// 打开查看按钮
									function openDetail(guid) {
										window.location = "bzdk_Index.jsp?guid="
												+ guid;
									}
									//表格重载
									var active = {
								            reload: function(){
								               	var demoReload = $('#keywords').val();
								            	var keyName = $("#keywords").attr("name")
								            	var guid =$("#guid").val();
								            	var index = layer.msg("查询中,请稍等...",{icon:16,time:false,shade:0})
								            	
								            	var postData = $("#vform").serialize();
											    var tmpDic={};
											    for(var i in postData.split("&")){
											        var row=postData.split("&")[i];
											        tmpDic[row.split("=")[0]]=decodeURIComponent(row.split("=")[1]);
											    }
											    postData = decodeURIComponent(postData,true);
								                setTimeout(function(){
								                	table.reload('demo',{
									                    where: {
									                    	postData : postData
									                    },page:{
									                    	  curr:1
									                    }
									                });
								                	layer.close(index)
								                },300)
								            }
								        };
									//单击条件查询按钮
									$('#demoTable #reload_btn').on('click', function(){
										var type = $(this).data('type');
							            active[type] ? active[type].call(this) : '';
							        });
								});