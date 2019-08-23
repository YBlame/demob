//右侧消息通知
function xxtz(){
	layui.use(['element', 'layer', 'form', 'laytpl'], function () {
	    var element = layui.element,
	        layer = layui.layer,
	        form = layui.form,
	        laytpl = layui.laytpl;
	    	table = layui.table, //表格
	    	carousel = layui.carousel,
	    	device = layui.device();
			var zhxxGuid = cj.getCookie('selected_expo_id');
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
	});
}