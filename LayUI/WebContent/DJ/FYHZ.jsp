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
				</div>
				<div class="layui-row">
					<div class="layui-form" lay-filter="freshform">
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
									<th><input type="checkbox" name="checksAll" lay-skin="primary" lay-filter="allChoose" class="checks"></th>
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
									<td colspan="2"><select name="XMMC_DATA" class="proNameSel" lay-filter="projectNameSel">

									</select></td>
									<td colspan="2"><select name="XMDES_DATA" class="proDescSel" lay-filter="projectDescSel">

									</select></td>
									<td colspan="1"><input type="text" name="DJ0" class="layui-input " readonly="readonly"></td>
									<td><input type="text" name="SL0" class="layui-input binputs"></td>
									<td><input type="text" name="XJ0" class="layui-input XJ_value" readonly="readonly"></td>
								</tr>

								<tr class="addlists">
									<td></td>
									<td colspan="2">小计</td>
									<td colspan=4></td>
									<td><input type="text" name="XJ" class="layui-input" readonly="readonly"></td>
								</tr>

								<tr>
									<td rowspan="2"></td>
									<td rowspan="2" colspan="2">其他</td>
									<td colspan="2">施工押金</td>
									<td colspan="2">
									<select name="SGYJ_DATA" class="SGYJ" lay-filter="sgyjFilter">

									</select>
									</td>
									<td><input type="text" name="" class="layui-input" readonly="readonly"></td>
								</tr>

								<tr>
									<td colspan="2">滞纳金</td>
									<td colspan="2"></td>
									<td><input type="text" name="" class="layui-input" readonly="readonly"></td>
								</tr>
								<tr >
									<td></td>
									<td colspan="2">费用总计</td>
									<td colspan=4></td>
									<td><input type="text" name="ZJ" class="layui-input" readonly="readonly"></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
	</div>
			</div>
			<script src="statics/layui/layui.js"></script>
			<script src="statics/js/concisejs.js"></script>
			<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
			<script>
			layui.use(['form', 'laydate', 'layer', 'table'], function () {
                        var form = layui.form, laydate = layui.laydate, laypage = layui.laypage, layer = layui.layer, table = layui.table;
                        var iNums = "";
                        var asyncBool = "";
                        function getRandomNum() {
                            return parseInt(Math.random() * 50);
                        }
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
                                        xmID = d[i].ID;
                                        xmmc += '<option value="' + xmName + '" id="' + xmID + '">' + xmName + '</option>';
                                    }
                                    if (isadd) {
                                        $("[name='XMMC_DATA_" + iNums + "']").html(xmmc);
                                    } else {
                                        $("[name='XMMC_DATA']").html(xmmc);
                                    }

                                    form.render();
                                }
                            });
                        };
                        //加载项目描述
                        var xmms_select = function (isadd, elemId) {
                            var xmmc = "";
                            if (isadd) {
                                xmmc = $("[name=XMMC_DATA_" + elemId + "] option:selected").val();
                            } else {
                                xmmc = $("[name=XMMC_DATA] option:selected").val();

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
                                        xmms += '<option value="' + msName + '" id="' + msID + '">' + msName + ',' + fy + '</option>';
                                    }
                                    if (isadd) {
                                        $("[name='XMDES_DATA_" + elemId + "']").html(xmms);
                                    } else {
                                        $("[name='XMDES_DATA']").html(xmms);
                                    }
                                    form.render();
                                }
                            });
                        };
                        xmmc_select(false);
                        //项目名称监听事件
                        form.on('select(projectNameSel)',
                                function () {
                                    $("[name=DJ0]").val("");
                                    xmms_select(false);
                                });
                        //新增项目名称监听事件
                        form.on('select(addNameSel)',
                                function (index) {
                                    var elemId = index.elem.id.split('_')[1];
                                    $("[name=DJ_" + elemId + "]").val("");
                                    xmms_select(true, elemId);
                                });
                        //项目描述监听事件
                        form.on('select(projectDescSel)', function (index) {
                            var sums = 0;
                            var dj = parseInt(index.elem.innerText.split(',')[1]);
                            $('[name=DJ0]').val(dj);

                            if ($('[name=SL0]').val() != '') {
                                var sl = Number($('[name=SL0]').val());
                                var xj = dj * sl;

                                $("[name=XJ0]").val(xj);

                                $(".XJ_value").each(function () {
                                    var cid = $(this).attr("name");

                                    sums += Number($("[name='" + cid + "']").val());
                                });
                                $("[name=XJ]").val(sums);//小计
                            }
                        });
                        //新增项目描述监听事件
                        form.on('select(addDescSel)',
                                        function (index) {
                                            var sums = 0;
                                            var elemId = index.elem.id.split('_')[1];
                                            var dj = parseInt(index.elem.innerText.split(',')[1]);

                                            $('[name=DJ_' + elemId + ']').val(dj);

                                            if ($('[name=SL_' + elemId + ']').val() != '') {
                                                var sl = Number($('[name=SL_' + elemId + ']').val());
                                                var xj = dj * sl;

                                                $("[name=XJ_" + elemId + "]").val(xj);

                                                $(".XJ_value").each(function () {
                                                    var cid = $(this).attr("name");

                                                    sums += Number($("[name='" + cid + "']").val());
                                                });
                                                $("[name=XJ]").val(sums);//总金额
                                            }
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
                                var jes = "";
                                jes = Number($("[name=XJ_" + num + "]").val());
                                var xj = Number($("[name=XJ]").val()) - jes;
                                $("[name=XJ]").val(xj);//总金额
                                $("tr[id=" + cheched_ids + "]").remove();
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
                                    + '<select id="MCID_' + iNums + '" name="XMMC_DATA_' + iNums + '" class="proName" lay-filter="addNameSel">\n'
                                    +'</select>\n'
                                    + '</td>\n'
                                    + '<td colspan="2">\n'
                                    + '<select id="DESID_' + iNums + '" name="XMDES_DATA_' + iNums + '" class="proDesc" lay-filter="addDescSel">\n'
                                    +' </select>\n'
                                    + '</td>\n'
                                    + '<td colspan="1">\n'
                                    + '<input type="text" name="DJ_' + iNums + '" class="layui-input" readonly="readonly">\n'
                                    + '</td>\n'
                                    + '<td>\n'
                                    + '<input type="text" name="SL_' + iNums + '" class="layui-input binputs">\n'
                                    + '</td>\n'
                                    + '<td>\n'
                                    + '<input type="text" name="XJ_' + iNums + '" class="layui-input XJ_value" readonly="readonly">\n'
                                    + '</td>\n'
                                    + '</tr>';

                            $('.addlists').before(strs1);
                            return true;
                        }
                        //数量获得焦点
                        $(".binputs").die("keyup").live("keyup", function () {
                            var cid = $(this).attr("name");
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
                                var dj = Number($("[name=DJ" + va + "]").val());
                                var sl = Number($("[name=SL" + va + "]").val());
                                sum = dj * sl;
                                $("[name=XJ" + va + "]").val(sum);
                            }

                            $(".XJ_value").each(function () {
                                var cid = $(this).attr("name");

                                sums += Number($("[name='" + cid + "']").val());
                            });
                            $("[name=XJ]").val(sums);//总金额
                        });
                    });
			</script>
</body>
</html>
