<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
        + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="statics/layui/css/layui.css" media="all">
<link rel="stylesheet" href="statics/css/common.css" media="all">
<style type="text/css">
body {
    font-size: 14px;
}

a {
    color: #0000EE;
}

.table_border td {
    border: 1px #666 solid;
}

.table_border {
    border-bottom: 1px #666 solid;
    border-left: 1px #666 solid;
    border-color: #666;
}

.table_border11 {
    border-bottom: 0px #666 solid;
    border-left: 0px #666 solid;
    border-right: 0px #666 solid;
    border-top: 0px #666 solid;
    border-bottom: 0px #666 solid;
    border-color: #666;
}

.table_border11 td {
    border-left: 0px #666 solid;
    border-right: 0px #666 solid;
    border-top: 0px #666 solid;
    border-bottom: 0px #666 solid;
    border-color: #666;
}
.layui-form-label{
	width: 110px;
}
</style>
</head>
<body>
	<div id="myContent">
		<div class="piclist" id="plist" style="margin-top: 20px;">
			<input type="hidden" id="ZT"/>
<!-- 			<span style="margin-left: 50px;" id="mc"></span> -->
			<label id="mc" class="layui-form-label" style="margin-left: 25px;">审核意见：</label>
            <!-- <div id="img"></div> -->
		</div>
		<form class="layui-form" action=""
style="margin-top: 10px; width: 950px;" onsubmit="return false;">
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
</div>
<hr>
<div class="layui-fluid">
    <label class="layui-form-label">审核记录：</label>
</div>
<div >
    <div class="layui-btn-group">



        <div class="layui-fluid">
            <table id="tableElem" class="layui-table">

            </table>
        </div>
    </div>
</div>


</body>
<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
<script src="statics/layui/layui.js?t=1"></script>
<script src="statics/js/concisejs.js?t=1"></script>
<script>
	var guid = cj.queryString("guid");
    var zhxxguid = cj.queryString("zhxxguid");
    var shguid = cj.queryString("shguid");
    var shmc = cj.queryString("shmc");
    var dwbh = cj.queryString("dwbh");
//获取图片路径以及审核项
layui.use(['form', 'layer', 'table'], function () {
    var form = layui.form, layer = layui.layer, table = layui.table;
    $.ajax({
        type: "POST",
        url: "gzry/GetimgByGuid?zhxxguid=" + zhxxguid + "&shmc="+shmc+"&shguid="+shguid+"&time="+ new Date().getMilliseconds(),
        cache: false,
        dataType: "json",
        success: function (data) {
            if (data != null) {
            	$("#mc").html(data.mc+":");
            	if(data.lx){//展位图纸
            		if(data.ZTJG.trim()=="室内单层"||data.ZTJG.trim()=="室外简易结构"){//不变
            			var sfzsmj = data.tp.split(',');
                    	if (sfzsmj.length >= 1) {
        					for (var i = 0; i < sfzsmj.length-1; i++) {
        						$("#mc").after('<div class="layui-input-inline" style="width: 170px; height: 100px;margin-right: 10px;"><div style="display:inline-block;"><a	 href="'+sfzsmj[i]+'"	target="_blank"> <img  width="170px" height="100px" src="'+sfzsmj[i]+'" name="sfzsmj_upload" alt="" style="position: relative;" class="">  </a></div></div>');
        					}
        				}            			            			
            		}else{
            			var zwtz = data.tp.split(',');//展位图纸
                    	if (zwtz.length >= 1) {
                    		$("#mc").after('<div id="zwtz" style="margin-bottom:8px"></div>');
                    		var a="";
        					for (var i = 0; i < zwtz.length-1; i++) {        			
        							a+='<div class="layui-input-inline" style="width: 170px; height: 100px;margin-right: 10px;"><div style="display:inline-block;"><a	 href="'+zwtz[i]+'"	target="_blank"><img  width="170px" height="100px" src="'+zwtz[i]+'" name="sfzsmj_upload" alt="" style="position: relative;" class="">   </a></div></div>';       							        					       						
        					}
        					$("#zwtz").html(a);
        				}                    	
            			
                    	var zwjgt = data.ZWJGT.split(',');//展位结构图
                    	if (zwjgt.length >= 1) {
                    		$("#zwtz").after('<label id="mc2" class="layui-form-label" style="margin-left: 25px;margin-top:10px">展位细部结构图:</label><div id="zwjgt" style="margin-bottom:8px"></div>');
                    		var b="";
        					for (var i = 0; i < zwjgt.length-1; i++) {       					
        							b+='<div class="layui-input-inline" style="width: 170px; height: 100px;margin-right: 10px;"><div style="display:inline-block;"><a	 href="'+zwjgt[i]+'"	target="_blank"><img  width="170px" height="100px" src="'+zwjgt[i]+'" name="sfzsmj_upload" alt="" style="position: relative;" class=""> </a>	</span></div></div>';	        				        						
        					}
        					$("#zwjgt").html(b);
        				}
                    	                    	
                    	var gcszzzs = data.GCSZZZS.split(',');//工程师资质证书
                    	if (gcszzzs.length >= 1) {
                    		$("#zwjgt").after('<label id="mc3" class="layui-form-label" style="margin-left: 25px;margin-top:10px">工程师资质证书:</label><div id="gcszzzs" ></div>');
        					var c="";
                    		for (var i = 0; i < gcszzzs.length-1; i++) {        					
        							c+='<div class="layui-input-inline" style="width: 170px; height: 100px;margin-right: 10px;"><div style="display:inline-block;"><a	 href="'+gcszzzs[i]+'"	target="_blank"> <img  width="170px" height="100px" src="'+gcszzzs[i]+'" name="sfzsmj_upload" alt="" style="position: relative;" class="">  </a>	</span></div></div>';        					        						
        					}
                    		$("#gcszzzs").html(c);                    		
        				}                    	                    	
                    	$("#plist").after('<label  class="layui-form-label" style="margin-left: 25px;margin-top:10px;margin-bottom:15px;width:200px">设计院全称:'+data.SJY+'</label><label id="mc" class="layui-form-label" style="margin-left: 25px;margin-top:10px;width:150px">办公电话:'+data.BGDH+'</label><label id="mc" class="layui-form-label" style="margin-left: 25px;margin-top:10px;width:150px">出图工程师:'+data.CTSJS+'</label><label id="mc" class="layui-form-label" style="margin-left: 25px;margin-top:10px;width:150px">手机号:'+data.GCSSJH+'</label>');           			
            		}            		           		
            	}else{
            		var sfzsmj = data.tp.split(',');
                	if (sfzsmj.length >= 1) {
    					for (var i = 0; i < sfzsmj.length-1; i++) {
    						$("#mc").after('<div class="layui-input-inline" style="width: 170px; height: 100px"><div style="display:inline-block;margin-right: 10px;"><a	 href="'+sfzsmj[i]+'"	target="_blank"> <img  width="170px" height="100px" src="'+sfzsmj[i]+'" name="sfzsmj_upload" alt="" style="position: relative;" class=""></a></span></div></div>')
    					}
    				}            		
            	}            	             	                 	
            }
        }
    });
    
    table.render({
        id: 'shjl',
        elem: '#tableElem',
        width: '700',

        url: 'gzry/getAduitRecord?shdxbh=' + shguid+'&shmc='+shmc,
        skin: 'line',
        even: true,
        loading: false,
        cellMinWidth: 130,
        cols: [[
                {
                    field: 'SHYJ',
                    title: '审核意见'
                },
                {
                    field: 'SHRY',
                    title: '审核人员'
                },
                {
                    field: 'SHSJ',
                    title: '日期',
                    sort: true

                }]],
        text: {
            none: '无'
        }
    });

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
                    url: "gzry/updStateByGuid?time="+ new Date().getMilliseconds(),
                    data: {
                    	zhxxguid: zhxxguid,
                    	shguid: shguid,
                    	shmc: shmc,
                    	audit : auditing,
                    	suggest : $("#SHYJ").val(),
                    	dwbh: dwbh
                    },
                    cache: false,
                    dataType: "json",
                    success: function (data) {
                        if (data === 1) {
                            layer.alert("审核成功", function () {
                                var index = parent.layer
                                        .getFrameIndex(window.name);//关闭iframe页面
                                parent.layer.close(index);
                                parent.layui.table.reload('demo');
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
function djst(d) {
    var img = new Image();
    img.src = $('#' + d + '').val();
    var height = img.height + 50; // 原图片大小
    var width = img.width; //原图片大小
    var imgHtml = "<img src='" + $('#' + d + '').val()
            + "' width='200px' height='200px'/>";
    //         var imgHtml = "<img src='statics/admin/images/login/login_line.jpg' width='200px' height='200px'/>";  

    parent.layer.open({
        type: 1,
        shade: 0.8,
        offset: 'auto',
        area: [500 + 'px', 550 + 'px'], // area: [width + 'px',height+'px']  //原图显示
        shadeClose: true,
        scrollbar: false,
        title: "图片预览", //不显示标题  
        content: imgHtml, //捕获的元素，注意：最好该指定的元素要存放在body最外层，否则可能被其它的相对元素所影响  

    });

}
</script>
</html>
