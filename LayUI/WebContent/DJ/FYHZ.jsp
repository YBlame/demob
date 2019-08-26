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
			<div class="layui-card-header">费用汇总</div>
			<div class="layui-card-body" style="padding: 15px;">
				<div class="layui-row">
					<div class="layui-btn-group">
						<button type="button" class="layui-btn layui-btn-sm add-btn" data-type="addRow" title="添加">
							<i class="layui-icon layui-icon-add-1"></i> 添加
						</button>
					</div>
					<div class="layui-btn-group">
						<a class="layui-btn layui-btn-sm layui-btn-danger btn-del" lay-event="del"><i class="layui-icon layui-icon-delete"></i>移除</a>
					</div>
				<blockquote class="layui-elem-quote" style="display: inline-block; float: right;">展馆号：<p id="zgh" style="display: inline-block;"></p>&nbsp;&nbsp;&nbsp;展位号：<p style="display: inline-block;" id="zwh"></p></blockquote>
				</div>
				<div class="layui-row">
				
					<input id="bgGuid" name="bgGuid" style="display: none" value="<%=request.getParameter("bgGuid")%>">
					<form class="layui-form fyhzForm" id="vform" lay-filter="fyhzform">
						<table class="layui-table" lay-filter="test" id="test_table">
							<colgroup>
								<col width="100">
								<col width="200">
								<col width="200">
								<col width="200">
								<col width="200">
								<col width="200">
								<col width="200">
							</colgroup>
							<thead>
								<tr>
									<th><input type="checkbox"  lay-skin="primary" lay-filter="allChoose" class="checks"></th>
									<th colspan="2">项目名称</th>
									<th colspan="2">项目描述</th>
									<th>单价（元）</th>
									<th>数量</th>
									<th>金额（元）</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td></td>
									<td colspan="2"><select id="XMMC_DATA" name="xm[0].XMMC_DATA" class="proName" lay-filter="projectNameSel">	

									</select></td>
									<td colspan="2"><select name="xm[0].XMDES_DATA" id="XMDES_DATA" class="proDescSel" lay-filter="projectDescSel">

									</select></td>
									<td colspan="1"><input type="text" name="xm[0].DJ" id="DJ0" class="layui-input " readonly="readonly"></td>
									<td><input type="text" name="xm[0].SL" id="SL0" class="layui-input binputs"></td>
									<td><input type="text" name="xm[0].HXJ" id="XJ0" class="layui-input XJ_value" readonly="readonly"></td>
								</tr>

								<tr class="addlists">
									<td></td>
									<td colspan="2">小计</td>
									<td colspan=4></td>
									<td><input type="text" name="XJ" id="XJ" class="layui-input" readonly="readonly"></td>
								</tr>

								<tr>
									<td rowspan="2"></td>
									<td rowspan="2" colspan="2">其他</td>
									<td colspan="2">施工押金</td>
									<td colspan="2">
									<select name="SGYJ_DATA" class="SGYJ" lay-filter="sgyjFilter">

									</select>
									</td>
									<td><input type="text" name="SGYJJE" class="layui-input" readonly="readonly"></td>
								</tr>

								<tr>
									<td colspan="2">滞纳金</td>
									<td colspan="2" id="ZNJMS"></td><input type="text" id="znjzt" style="display:none;" >
									<td><input type="text" name="ZNJ" class="layui-input" readonly="readonly"></td>
								</tr>
								<tr >
									<td></td>
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
						<button type="button" class="layui-btn layui-btn-normal" lay-submit=""  style="float:right;" lay-filter="fyhz_submit_btn">提交</button>
					</f>
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
                        
                        var zgh = cj.getCookie('bgxx_zgh');
                        var zwh = cj.getCookie('bgxx_zwh');
                        $("#zgh").html(zgh);
                        $("#zwh").html(zwh);
                        
                        var selected = cj.getCookie('selected_expo_id');
                    	var zgh = cj.getCookie('bgxx_zgh');
                    	var zwh = cj.getCookie('bgxx_zwh');
                    	$("[name=zhxx]").val(selected);
                    	$("[name=zgh]").val(zgh);
                    	$("[name=zwh]").val(zwh);
                        //加载项目名称
                        var xmmc_select = function (isadd) {
                            asyncBool = isadd === true ? false : true;
               	             $.ajax({
                                type: 'GET',
                                url: 'dj/GetFybzMc',
                                cache: false,
                                async: asyncBool,
                                dataType: 'JSON',
                                success: function (d) {
                                    var xmmc = '<option value="" >请选择</option>';
                                    var xmName = "";
                                    var xmID = "";
                                    for (var i = 0; i < d.length; i++) {
                                        xmName = d[i].XMMC;
                                        if(xmName=="滞纳金"){//主场填写的截至日期和当前日期相比较
                                        	var xmMS = d[i].XMMS;
                                        	var xmRQ = d[i].RQ;
                                        	xmRQ = xmRQ.substring(0,xmRQ.length-2);
                                        	$("#ZNJMS").html(xmMS);
                                        	var flag = getNowFormatDate(xmRQ);
                                        	if(flag){
                                        		$("#znjzt").val("true");
                                        	}else{
                                        		$("#znjzt").val("false");
                                        		$("[name=ZNJ]").val("0");
                                        	}
                                        	
                                        }else{
                                        	 xmID = d[i].ID;
                                             xmmc += '<option value="' + xmName + '" id="' + xmID + '">' + xmName + '</option>';
                                        }
                                       
                                    }
                                    if (isadd) {
                                        $("[id='XMMC_DATA_" + iNums + "']").html(xmmc);
                                    } else {
                                        $("[id='XMMC_DATA']").html(xmmc);
                                    }

                                    form.render();
                                }
                            });
                        };
                        //加载项目描述
                        var xmms_select = function (isadd, elemId) {
                            var xmmc = "";
                            if (isadd) {
                                xmmc = $("[id=XMMC_DATA_" + elemId + "] option:selected").val();
                            } else {
                                xmmc = $("[id=XMMC_DATA] option:selected").val();

                            }
                            $.ajax({
                                type: 'GET',
                                url: 'dj/GetXmDesByName',
                                data: { "xmmc": xmmc },
                                cache: false,
                                dataType: 'JSON',
                                success: function (d) {
                                    var xmms = '<option value="" >请选择</option>';

                                    for (var i = 0; i < d.length; i++) {
                                        var msName = d[i].XMMS;
                                        var msID = d[i].ID;
                                        var fy = d[i].FY;
                                        xmms += '<option value="' + msName+","+fy + '" id="' + msID + '">' + msName + ',' + fy + '</option>';
                                    }
                                    if (isadd) {
                                        $("[id='XMDES_DATA_" + elemId + "']").html(xmms);
                                    } else {
                                        $("[id='XMDES_DATA']").html(xmms);
                                    }
                                    form.render();
                                }
                            });
                        };
                        
                        //项目施工押金
                        var sgyj_select = function (isadd, elemId) {
                            var xmmc = "";
                            if (isadd) {
                                xmmc = $("[name=SGYJ_DATA_" + elemId + "] option:selected").val();
                            } else {
                                xmmc = $("[name=SGYJ_DATA] option:selected").val();

                            }
                            $.ajax({
                                type: 'GET',
                                url: 'dj/GetFybzSgyj',
                                data: { },
                                cache: false,
                                dataType: 'JSON',
                                success: function (d) {
                                	var sgmc= '<option value="" >请选择</option>' ;

                                    for (var i = 0; i < d.length; i++) {
                                       	var sgName = d[i].XMMC;
                                        var sgID = d[i].id;
                                        var sgFY = d[i].fy;
                                        var sgMS = d[i].XMMS;
                                        sgmc += '<option value="' + sgFY + '" id="' + sgID + '">' + sgMS + '</option>';
                                    }
                                    if (isadd) {
                                        $("[name='SGYJ_DATA_" + iNums + "']").html(sgmc);
                                    } else {
                                        $("[name='SGYJ_DATA']").html(sgmc);
                                    }
                                    form.render("select");
                                }
                            });
                        };
                        xmmc_select(false);
                        sgyj_select(false);
                        //项目名称监听事件
                        form.on('select(projectNameSel)',
                                function () {
                                    $("[id=DJ0]").val("");
                                    xmms_select(false);
                                });
                        //新增项目名称监听事件
                        form.on('select(addNameSel)',
                                function (index) {
                                    var elemId = index.elem.id.split('_')[2];
                                    $("[id=DJ_" + elemId + "]").val("");
                                    xmms_select(true, elemId);
                                });
                        //项目描述监听事件
                        form.on('select(projectDescSel)', function (index) {
                            var sums = 0;
                            var dj = index.value;
                            var strs= new Array(); //定义一数组 
                            strs=dj.split(","); //字符分割 
                            $('[id=DJ0]').val(strs[1]);

                            if ($('[id=SL0]').val() != '') {
                                var sl = Number($('[id=SL0]').val());
                                var xj = strs[1] * sl;

                                $("[id=XJ0]").val(xj);

                                $(".XJ_value").each(function () {
                                    var cid = $(this).attr("id");

                                    sums += Number($("[id='" + cid + "']").val());
                                });
                                $("[name=XJ]").val(sums);//小计
                                
                            }
                        });
                        //新增项目描述监听事件
                        form.on('select(addDescSel)',
                                        function (index) {
                                            var sums = 0;
                                            var elemId = index.elem.id.split('_')[2];
                                            var dj = index.value;
                                            var strs= new Array(); //定义一数组 
                                            strs=dj.split(","); //字符分割 
                                            $('[id=DJ_' + elemId + ']').val(strs[1]);
                                            if ($('[id=SL_' + elemId + ']').val() != '') {
                                                var sl = Number($('[id=SL_' + elemId + ']').val());
                                                var xj = strs[1] * sl;

                                                $("[id=XJ_" + elemId + "]").val(xj);

                                                $(".XJ_value").each(function () {
                                                    var cid = $(this).attr("id");

                                                    sums += Number($("[id='" + cid + "']").val());
                                                });
                                                $("[name=XJ]").val(sums);//总金额
                                                var sgyj = Number($('[name=SGYJJE]').val());
                    							var znj;
                    							var znjzt = $("#znjzt").val()
                    							if(znjzt=="true"){
                    								znj= xj / 2;
                    								Number(znj);
                    							}
                    							$('[name=ZNJ]').val(znj)
                    							var zj = xj+sgyj+znj
                                                $("[name=ZJ]").val(zj);//小计
                                                
                                                
                                            }
                                        });
                        
                      //施工押金监听事件
                        form.on('select(sgyjFilter)', function (index) {
                            var sums = 0;
                           var dj  = index.value;
                            $('[name=SGYJJE]').val(dj);
                                var xj = Number($('[name=XJ]').val());
								var sgyj = Number($('[name=SGYJJE]').val());
								var zj = xj+sgyj
                                $("[name=ZJ]").val(zj);//小计
                            
                        });
                        //新增一行
                        $('.add-btn').click(function () {
                            if (addstrs1()) {
                                xmmc_select(true);
                            }
                        });
                        //删除一行
                        $('body').on("click", ".btn-del", function (d) {
                            if ($("input[name='checks']:checked").length == 0) {
                                layer.alert('请选择要删除的行');
                            } $("input[name='checks']:checked").each(function (n, v) {
                                if (n.id == 'check1') {
                                    layer.alert('至少保留一行');
                                    return false;
                                }
                                var cheched_ids = $(this).parents("tr").attr('id');
                                var num = cheched_ids.substring("3", cheched_ids.lenth);
                                var xj = Number($("[name=XJ]").val()) - Number($("[id=XJ_" + num + "]").val());
                                $("[name=XJ]").val(xj);//总金额
    							var sgyj = Number($('[name=SGYJJE]').val());
    							var znj ="";
    							var znjzt = $("#znjzt").val()
    							if(znjzt=="true"){
    								znj= xj / 2;
    								Number(znj);
    							}
    							$('[name=ZNJ]').val(znj)
    							var zj = xj+sgyj+znj
                                $("[name=ZJ]").val(zj);//小计
                                $("tr[id=" + cheched_ids + "]").remove();
                                indexCount--;
                            });
                        });
                        //新增一行方法
                        function addstrs1() {
                            iNums = getRandomNum();
                            let
                            strs1;
                            strs1 = '<tr id="row' + iNums + '" class="">\n'
                                    + '	<td>\n'
                                    + '	<input type="checkbox" name="checks" cnum="' + iNums + '" lay-skin="primary" lay-filter="allChoose" class="checks">\n'
                                    + ' </td>\n'
                                    + '<td colspan="2">\n'
                                    + '<select id="XMMC_DATA_' + iNums + '" name="xm[' + indexCount +'].XMMC_DATA" class="proName" lay-filter="addNameSel">\n'
                                    +'</select>\n'
                                    + '</td>\n'
                                    + '<td colspan="2">\n'
                                    + '<select id="XMDES_DATA_' + iNums + '" name="xm[' + indexCount +'].XMDES_DATA" class="proDesc" lay-filter="addDescSel">\n'
                                    +' </select>\n'
                                    + '</td>\n'
                                    + '<td colspan="1">\n'
                                    + '<input type="text" id="DJ_' + iNums + '" name="xm[' + indexCount +'].DJ" class="layui-input" readonly="readonly">\n'
                                    + '</td>\n'
                                    + '<td>\n'
                                    + '<input type="text" id="SL_' + iNums + '" name="xm[' + indexCount +'].SL" class="layui-input binputs">\n'
                                    + '</td>\n'
                                    + '<td>\n'
                                    + '<input type="text" id="XJ_' + iNums + '" name="xm[' + indexCount +'].HXJ" class="layui-input XJ_value" readonly="readonly">\n'
                                    + '</td>\n'
                                    + '</tr>';

                            $('.addlists').before(strs1);
                            indexCount++;
                            return true;
                        }
                        //数量获得焦点
                        $(".binputs").die("keyup").live("keyup", function () {
                            var cid = $(this).attr("id");
                            var va = cid.substring("2", cid.lenth);
                            var re = /^(-)?\d+$/;

                            var boo = true;
                            if ($(this).val() !== "") {
                                if (!re.test($(this).val())) {
                                    layer.alert("请输入数字整数");
                                    $(this).val("");
                                    boo = false;
                                    return false;
                                }
                            }
                            if (boo) {
                                var sum = 0;
                                var sums = 0;
                                var dj = Number($("[id=DJ" + va + "]").val());
                                var sl = Number($("[id=SL" + va + "]").val());
                                sum = dj * sl;
                                $("[id=XJ" + va + "]").val(sum);
                            }

                            $(".XJ_value").each(function () {
                                var cid = $(this).attr("id");
                                sums += Number($("[id='" + cid + "']").val());
                            });
                            $("[id=XJ]").val(sums);//小计
                            
                            var xj = Number($('[id=XJ]').val());
							var sgyj = Number($('[name=SGYJJE]').val());
							var znj ="";
							var znjzt = $("#znjzt").val()
							if(znjzt=="true"){
								znj= xj / 2;
								Number(znj);
							}
							$('[name=ZNJ]').val(znj)
							var zj = xj+sgyj+znj
                            $("[name=ZJ]").val(zj);//小计
                        });
                        
                        /* 监听提交 */
                        form.on('submit(fyhz_submit_btn)', function (data) {
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
