layui.use(['layer','element'], function () {
    var $ = layui.jquery
    , layer = layui.layer //弹层
        , element = layui.element;    
    
});
function toIndexSystem(){//去开发人员的系统表
	$("#demoAdmin").attr("src", "bmodel_Index.jsp")
}
function toIndexAdmin(){//去系统中栏目列表
	$("#demoAdmin").attr("src", "smodel_Index.jsp")
}

function findZhxx(){//添加展会
	$("#demoAdmin").attr("src", "findZhxx")
}
function findZcglry(){//开发人员管理
	var guid="1199221444f345a7bc770f8dc2ba9ed5";
	var bmc="使用人";
	$("#demoAdmin").attr("src", "syrzc/SYRZC.jsp?guid="+guid+"&bmc="+bmc);
}

function userOut(){//退出
	layer.confirm('确定退出吗？', function(
			index) {
			top.location.href = "userOut";
			layer.close(index);
	});
}

      