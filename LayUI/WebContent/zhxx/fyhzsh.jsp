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
<title>费用汇总</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<link rel="stylesheet" href="statics/layui/css/layui.css" media="all">

</head>
<body>
	<div class="layui-fluid">
		<div class="layui-card">
			<div class="layui-card-header">费用汇总审核</div>
			<div class="layui-card-body" style="padding: 15px;">
				<div class="layui-row">							
				<blockquote class="layui-elem-quote" style="display: inline-block; float: right;">展馆号：<p id="zgh" style="display: inline-block;"></p>&nbsp;&nbsp;&nbsp;展位号：<p style="display: inline-block;" id="zwh"></p></blockquote>
				</div>
				<div class="layui-row">
				
					<input id="bgGuid" name="bgGuid" style="display: none" value="<%=request.getParameter("bgGuid")%>">
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
							<tbody >

								<tr class="addlists">
									<td colspan="2">小计</td>
									<td colspan=4></td>
									<td><input type="text" name="XJ" id="XJ" class="layui-input" readonly="readonly"></td>
								</tr>

								<tr>
									<td rowspan="2" colspan="2">其他</td>
									<td colspan="2">施工押金</td>
									<td colspan="2">
									<input type="text" name="SGYJ_DATA" id="SGYJ_DATA" class="layui-input" readonly="readonly">
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
								<hr>
						<form class="layui-form" action="" style="margin-top: 15px; width: 950px;" onsubmit="return false;">
							<div class="layui-form-item ">
								<label class="layui-form-label" style="margin-left: 25px;">审核意见：</label>
								<div class="layui-input-inline" style="width: 750px">
									<textarea name="desc" placeholder="请输入内容（合格可不填）"
										class="layui-textarea " id="SHYJ"></textarea>

								</div>
							</div>
							<div class="layui-row" style="text-align: center">
								<div class="layui-btn-group">
									<button class="layui-btn layui-btn-normal" lay-submit
										data-type="pass">合 格</button>

									<button class="layui-btn layui-btn-danger" data-type="NoPass">不合格</button>
								</div>
							</div>
							<div class="layui-form-item">
								<div class="layui-input-block"></div>
							</div>
						</form>
					</form>
				</div>
			</div>
	</div>
			</div>
			<script src="statics/layui/layui.js"></script>
			<script src="statics/js/concisejs.js"></script>
			<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
			<script>
			var indexCount = 1;
			layui.use(['form', 'laydate', 'layer', 'table'], function () {
                        var form = layui.form, laydate = layui.laydate, laypage = layui.laypage, layer = layui.layer, table = layui.table;
                        var iNums = "";
                        var asyncBool = "";
                        function getRandomNum() {
                            return parseInt(Math.random() * 50);
                        }
                        
                        var zgh = cj.queryString("zgh");
                        var zwh = cj.queryString("zwh"); 
                        var dwbh = cj.queryString("dwbh");
                        
                        
                      /*   var zgh = cj.getCookie('bgxx_zgh');
                        var zwh = cj.getCookie('bgxx_zwh'); */
                        $("#zgh").html(zgh);
                        $("#zwh").html(zwh);
                        findFYXXINFO(zgh,zwh)
                        var selected = cj.getCookie('selected_expo_id');                   	
                    	$("[name=zhxx]").val(selected);
                    	$("[name=zgh]").val(zgh);
                    	$("[name=zwh]").val(zwh);
                        
                    	function findFYXXINFO(v,ve){
                			var zgh =v;
                			var zwh = ve;
                			var zhxx = cj.getCookie('selected_expo_id');
                			$.ajax({
                			        type:"POST",
                			        url:"bg/findFyxxInfo",
                			      	data: {"zgh":zgh,"zwh":zwh,"zhxx":zhxx,"dwbh":dwbh},
                			        success:function(data){
                						var fy = data.fyList;
                						var tr = "";
                						for (var i = 0; i < fy.length; i++) {
                							 var strs= new Array(); //定义一数组 
                							 strs=fy[i].XMDES_DATA.split(","); //字符分割 
                							 tr += "<tr>";
                							 tr += "<td colspan=\"2\"><input type=\"text\" value='"+fy[i].XMMC_DATA+"' lay-verify=\"required\"  readonly=\"readonly\" class=\"layui-input\">";
                							 tr += "<td colspan=\"2\"><input type=\"text\" value='"+strs[0]+"' lay-verify=\"required\"  readonly=\"readonly\" class=\"layui-input\">";
                							 tr += "<td colspan=\"1\"><input type=\"text\" value='"+fy[i].DJ+"' lay-verify=\"required\"  readonly=\"readonly\" class=\"layui-input\">";
                							 tr += "<td><input type=\"text\" value='"+fy[i].SL+"' class=\"layui-input\"  readonly=\"readonly\"></td>"
                							 tr += "<td><input type=\"text\" value='"+fy[i].HXJ+"' class=\"layui-input\" readonly=\"readonly\"></td>"
                							 tr += "</tr>";
                						}
                						$(".addlists").before(tr);
                						var xm = data.xmList;	
                						for (var i = 0; i < xm.length; i++) {
                							$("[name=SGYJJE]").val(xm[i].SGYJ);
                							$("[name=XJ]").val(xm[i].XJ);
                							$("[name=ZNJ]").val(xm[i].ZNJ);
                							$("[name=ZJ]").val(xm[i].ZJ);
                							$("[name=SGYJ_DATA]").val(xm[i].SGYJ_DATA)
                						}
                						
                			        },
                			        error:function(jqXHR){
                			           alert("发生错误："+ jqXHR.status);
                			        }
                		    });

                		}
                        
                        /* 监听提交 */
                  /*       form.on('submit(fyhz_submit_btn)', function (data) {
                        	var fy =$("form").serialize();
                        	$.ajax({
                       		        type:"POST",
                       		        url:"bg/submitFyhz",
                       		      	data: fy,
		                            dataType:"json",
                       		        success:function(data){
                       					var bgGuid = $("#bgGuid").val();
                       		           if(data.success){
                       						layer.alert(data.msg);
                       						window.location.href = "DJ/BGXX_SHOW.jsp?bgGuid="+bgGuid
                       		           }else{
                       					  layer.alert(data.msg);
                       		           }
                       		        },
                       		        error:function(jqXHR){
                       		           alert("发生错误："+ jqXHR.status);
                       		        }
                        		});

                            return false;
                        }); */
                        //审核
                        var active = {
                                pass: function () {
                                    //修改guid的状态 通过
                                    if ($("#ZT").val() === '通过') {
                                        layer.alert('该人员已通过审核');
                                    } else {
                                        audit("pass");
                                    }
                                },
                                NoPass: function () {
                                    if ($("#ZT").val() === '通过') {
                                        layer.alert('该人员已通过审核');
                                    } else {
                                        if ($('#SHYJ').val() != '') {
                                            //修改guid的状态未通过、审核意见
                                            audit("NoPass")
                                        } else {
                                            document.getElementById("SHYJ").setAttribute(
                                                    "lay-verify", "required");
                                            layer.alert('审核意见不能为空');
                                        }
                                    }
                                },
                            }

                            var audit = function (auditing) {
                                $.ajax({
                                            type: "POST",
                                            url: "gzry/updfyStateByGuid?time="+ new Date().getMilliseconds(),
                                            data: {
                                            	zhxxguid: selected,                    
                                            	audit : auditing,
                                            	suggest : $("#SHYJ").val(),
                                            	dwbh:dwbh,
                                            },
                                            cache: false,
                                            dataType: "json",
                                            success: function (data) {
                                                if (data === 1) {
                                                    layer.alert("审核成功", function () {
                                                        var index = parent.layer.getFrameIndex(window.name);//关闭iframe页面
                                                        
                                                        parent.layui.table.reload('demo');
                                                        parent.layer.close(index);
                                                       
                                                    });

                                                } else {
                                                    layer.alert("审核失败");
                                                }
                                            }
                                        });
                            }
                            $('.layui-row .layui-btn').on('click', function () {
                                var type = $(this).data('type');
                                active[type] ? active[type].call(this) : '';
                            });
                        
                    });

			//获取当前时间，格式YYYY-MM-DD
			function getNow(s) {
					return s < 10 ? '0' +s: s;
			}
			function getNowFormatDate(xmRQ) {//获取当前时间，传入数据库时间比较
				var myDate = new Date();             
				var year=myDate.getFullYear();        //获取当前年
				var month=myDate.getMonth()+1;   //获取当前月
				var date=myDate.getDate();            //获取当前日
				var h=myDate.getHours();              //获取当前小时数(0-23)
				var m=myDate.getMinutes();          //获取当前分钟数(0-59)
				var s=myDate.getSeconds();
				var now=year+'-'+getNow(month)+"-"+getNow(date)+" "+getNow(h)+':'+getNow(m)+":"+getNow(s);
			
				var startTime=xmRQ;//数据库时间
				var start=new Date(startTime.replace("-", "/").replace("-", "/"));
				var endTime=now;//当前时间
				var end=new Date(endTime.replace("-", "/").replace("-", "/"));
				if(end<start){
				 	return false;
				}
				return true;
			}
			</script>
</body>
</html>
