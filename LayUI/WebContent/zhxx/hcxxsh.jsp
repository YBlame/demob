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
	<div class="layui-fluid">
</div>
<div >
    <div class="layui-btn-group">
        <div class="layui-fluid">
            <table id="tableElem" class="layui-table">
            </table>
        </div>
    </div>
</div>
		<hr>
		<form class="layui-form" action=""
style="margin-top: 15px; width: 950px;" onsubmit="return false;">
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




</body>
<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
<script src="statics/layui/layui.js?t=1"></script>
<script src="statics/js/concisejs.js?t=1"></script>
<script>
	var dataguid = cj.queryString("dataGuid");
    var zhxxguid = cj.queryString("zhxxguid");
    var dwbh = cj.queryString("dwbh");
    /* var shguid = cj.queryString("shguid");
    var shmc = cj.queryString("shmc"); */
//获取图片路径以及审核项
layui.use(['form', 'layer', 'table'], function () {
    var form = layui.form, layer = layui.layer, table = layui.table;
   
    var guid =dataguid;
    var zhxx =zhxxguid;
    var bm = "hcxx";
    var bmc ="";
    var typeDj = true;
	$.ajax({
		    url:"djpublic/queryCondition",//请求的url地址
		    dataType:"json",   //返回格式为json
		 	async : false,//请求是否异步，默认为异步，这也是ajax重要特性
		    data:{guid : guid,zhxxDj : zhxx,bmDj:bm,typeDj:typeDj,bmcDj:bmc},    //参数值
		    type:"POST",   //请求方式
		    success:function(con){}
	});
    
    //动态加载表格 加载施工人员信息表

	//获取表头并且获取数据
		var num =1;
		$.ajax({
		    url:" gzry/findsgryDoc",//请求的url地址
		    dataType:"json",   //返回格式为json
		    async : false,//请求是否异步，默认为异步，这也是ajax重要特性
		    data:{guid:zhxx,num:num},    //参数值
		    type:"POST",   //请求方式
		    success:function(data){
                   var doclist = data;
				var cols = [];				
				//遍历表头数据, 添加到数组中
                   for (var k = 0; k < doclist.length; k++) {
                       var zdm = doclist[k].zdm;
                       var zdmc = doclist[k].zdmc;
                       var width = doclist[k].width;
					var t ={
                            field: zdm,
                            title: zdmc,                       
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
                   // 然后开始渲染表格
                   table.render({
                   	elem : '#tableElem',
					height : 300,		//描述
					url : 'gzry/findsgryDocTable?guid='+guid+"&num="+num//数据接口
					,
					title : '记录表',
					done:function (res, curr, count) {
						this.where={};
	                   // layer.close(index) //加载完数据
	                }
					,
					cols : [cols]
	               
				}); 
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
                    url: "gzry/updhcStateByGuid?time="+ new Date().getMilliseconds(),
                    data: {
                    	zhxxguid: zhxxguid,                    
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
