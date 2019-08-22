var reloadExpo;
var zhxxGuid  = null;
	layui.use(['element', 'layer', 'form', 'laytpl'], function () {
	    var element = layui.element,
	        layer = layui.layer,
	        form = layui.form,
	        laytpl = layui.laytpl;
	    	reloadExpo = function(){
	    	 $.post("zhxx/findZcZhxx", 
    		    function(data) {
	    		 if (data.length==0) {
	    			 cj.removeCookie('selected_expo_id');
	                 layer.alert('请先添加一个展会');
	                 html = '<a href="javascript:toAddZhxx();">添加展会</a>';
	                 $('#top_expo_nav li').html(html);
	                 return;
	             }
	    		 $('#top_expo_nav li').html('');
	                if (data.length > 0) { // 有展会，渲染数据
	                	var selected = cj.getCookie('selected_expo_id');
	                    var ids = [];
	                    for (var j = 0; j < data.length; j++) {
	                        ids.push(data[j].guid);
	                    }
	                    var html;
	                    var other;
	                    if (selected !== '' && $.inArray(selected, ids) !== -1) {
	                        other = '<dl class="layui-nav-child">';
	                        for (var k = 0; k < data.length; k++) {
	                            if (data[k].guid === selected) html = '<a href="javascript:;" id="g_expo" data-id="' + data[k].guid + '">' + data[k].ZHMC + '</a>';
	                            else other += '<dd><a href="javascript:;" id="g_expo" data-id="' + data[k].guid + '" >' + data[k].ZHMC + '</a></dd>';
	                        }

	                        if (data.length > 1) html += other;
	                        $('#top_expo_nav li').html(html);
	                        element.render('nav', 'top_expo_nav');
	                        cj.setCookie('selected_expo_id', selected, 365);
	                        zhxxGuid = cj.getCookie("selected_expo_id")

	                    } else {
	                        html = '<a href="javascript:;" id="g_expo" data-id="' + data[0].guid + '">' + data[0].ZHMC + '</a>';
	                        if (data.length > 1) {
	                            other = '<dl class="layui-nav-child">';
	                            for (var i = 1; i < data.length; i++) {
	                                other += '<dd><a href="javascript:;" id="g_expo" data-id="' + data[i].guid + '"">' + data[i].ZHMC + '</a></dd>';
	                            }
	                            other += '</dl>';
	                            html += other;
	                        }
	                        $('#top_expo_nav li').html(html);
	                        cj.setCookie('selected_expo_id', data[0].guid, 365);
	                        zhxxGuid  = cj.getCookie('selected_expo_id');
	                        element.render('nav', 'top_expo_nav');
	                    }
	                }  else { // 无展会，提示添加测试
	                    cj.removeCookie('selected_expo_id');
	                    html = '<a href="javascript:toAddZhxx();">添加展会</a>';
	                    $('#top_expo_nav li').html(html);
	                    element.render('nav', 'top_expo_nav');
	                }
	    	 });	
	    }	
	    reloadExpo()
		// 展会切换监听
	    element.on('nav(top_expo_nav)', function (elem) {
	    	if (elem.data('action') === 'add') {
	            layer.alert('点击左侧「展会基本信息」进行添加');
	            return;
	        }
	    	var selected = cj.getCookie('selected_expo_id');
	        var elemId = elem.data('id');
	        if (selected === elemId) return;
	        layer.confirm('切换展会需要刷新页面，请先保存当前操作', {
	            btn: ['切换', '不切换']
	        }, function () {
	        	cj.setCookie('selected_expo_id', elemId, 365);
	        	
	            location.reload();
	            $("#demoAdmin").attr("src", "findZhxx");
	        });
	    });
	});

function toSystem(){//系统管理
	$("#demoAdmin").attr("src", "menu/toMenu")
}
function toRule(){//角色管理
	$("#demoAdmin").attr("src", "rule/toRuleIndex")
}

function findZhxx(){//添加展会
	$("#demoAdmin").attr("src", "findZhxx")
}
function toSyrgl(){//对一般工作人员管理
	var guid="00c99009ec2d4cb883acc9ae24f73b6e";
	var bmc="人员管理";
	$("#demoAdmin").attr("src", "zhxx/public/public_Index.jsp?guid="+guid+"&bmc="+bmc+"&zhxxGuid="+zhxxGuid);
}
function findFybz(){
	var guid="57d75cd50cf14c639da65d25ad74ee84";
	var bmc="费用标准";
	$("#demoAdmin").attr("src", "zhxx/public/public_Index.jsp?guid="+guid+"&bmc="+bmc+"&zhxxGuid=");
}

function toZggl(){//对展馆管理
	
	alert(zhxxGuid)
	var guid="f77fa37759f44b1f8f49cd6b5c7c100f";
	var bmc="展馆管理";
	$("#demoAdmin").attr("src", "zhxx/public/public_Index.jsp?guid="+guid+"&bmc="+bmc+"&zhxxGuid="+zhxxGuid);
}
function toZwgl(){//对展位管理
	var guid="171c6db9797e440abae1d787bd15792f";
	var bmc="展位管理";
	$("#demoAdmin").attr("src", "zhxx/public/public_Index.jsp?guid="+guid+"&bmc="+bmc+"&zhxxGuid="+zhxxGuid);
}
function toZhgg(){//消息通知
	var guid="1178b7245d034da1a314cffe84698c44";
	var bmc="消息通知";
	$("#demoAdmin").attr("src", "zhxx/public/public_Index.jsp?guid="+guid+"&bmc="+bmc+"&zhxxGuid="+zhxxGuid);
}

function userOut(){//退出
	layer.confirm('确定退出吗？', function(
			index) {
			cj.removeCookie('selected_expo_id');
			top.location.href = "userOut";
			layer.close(index);
	});
}

      