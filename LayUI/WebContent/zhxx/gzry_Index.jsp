<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>慧展软件管理后台</title>
<meta ZHMC="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta ZHMC="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="statics/layui/css/layui.css" media="all">
</head>
<body>
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
   <div class="layui-logo">慧展</div>
	   <ul class="layui-nav layui-layout-left" lay-filter="top_expo_nav" id="top_expo_nav">
	      <li class="layui-nav-item" id ="zhxx">
	      </li>
	    </ul>
		<ul class="layui-nav layui-layout-right">
		      <li class="layui-nav-item">
		        <a href="javascript:;">
		        	<%String user = request.getSession().getAttribute("user").toString();%>  
					<%String role = request.getSession().getAttribute("role").toString();%>  
					
					<%=user %>,<%=role %>  
		        </a>
		      </li>
		      <li class="layui-nav-item"><a href="javascript:userOut();" target="_parent">退出</a></li>
  		</ul>
	</div>
  
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree site-demo-nav" lay-filter="test" id="leftMenu">
       			<li class="layui-nav-item layui-nav-itemed" id="indexJSP">
					<a class="" href="javascript:toSyrgl();">搭建商信息</a>
				</li>
				
				<li class="layui-nav-item layui-nav-itemed" id="bgxxJSP">
					<a class="" href="javascript:toSyrglbgxx();">报馆信息</a>
				</li>
				
				
				
		</ul>

    </div>
  </div>
	<div class="layui-body">
    <!-- 内容主体区域 -->
    	<div style="width: 99%; height: 100%">
    		<iframe src="DJ/index.jsp" frameborder="0" id="demoAdmin"
		style="width: 99%; height: 99%"></iframe>
	
		</div>
 	 </div>
	<div class="layui-footer" style="text-align:  center;">
			<!-- 底部固定区域 -->
			© - 慧展软件
	</div>
</div>
	<script src="statics/layui/layui.js"></script>
	<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
	<script src="statics/js/concisejs.js"></script>
	<script type="text/javascript">
	var reloadExpo;
	var readyLeft;
	layui.use(['element', 'layer', 'form', 'laytpl'], function () {
	    var element = layui.element,
	        layer = layui.layer,
	        form = layui.form,
	        laytpl = layui.laytpl;
	    	reloadExpo = function(){
	    	 $.post("zhxx/findAllZhxx", 
    		    function(data) {
	    		 if (data.length==0) {
	                 layer.alert('请先添加一个展会');
	                 html = '<a href="javascript:toAddZhxx();" >添加展会</a>';
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
	                            if (data[k].guid === selected) html = '<a href="javascript:;" id="g_expo" data-id="' + data[k].guid + '" data-value="'+data[k].ZHMC+'">' + data[k].ZHMC + '</a>';
	                            else other += '<dd><a href="javascript:;" id="g_expo" data-id="' + data[k].guid + '" data-value="'+data[k].ZHMC+'">' + data[k].ZHMC + '</a></dd>';
	                        }

	                        if (data.length > 1) html += other;

	                        $('#top_expo_nav li').html(html);
	                        element.render('nav', 'top_expo_nav');

	                    } else {
	                        html = '<a href="javascript:;" id="g_expo" data-id="' + data[0].guid + '" data-value="'+data[0].ZHMC+'">' + data[0].ZHMC + '</a>';
	                        if (data.length > 1) {
	                            other = '<dl class="layui-nav-child">';
	                            for (var i = 1; i < data.length; i++) {
	                                other += '<dd><a href="javascript:;" id="g_expo" data-id="' + data[i].guid + '" data-value="'+data[i].ZHMC+'">' + data[i].ZHMC + '</a></dd>';
	                            }
	                            other += '</dl>';
	                            html += other;
	                        }
	                        $('#top_expo_nav li').html(html);
	                        cj.setCookie('selected_expo_id', data[0].guid, 365);
	                        cj.setCookie('selected_expo_zdmc',data[0].ZDMC,365)
	                        element.render('nav', 'top_expo_nav');
	                    }
	                }  else { // 无展会，提示添加测试
	                    cj.removeCookie('selected_expo_id');
	                    cj.removeCookie('selected_expo_zdmc');
	                    html = '<a href="javascript:toAddZhxx();">添加展会</a>';
	                    $('#top_expo_nav li').html(html);
	                    element.render('nav', 'top_expo_nav');
	                }
	    	 });	
	    }
	    	
    	readyLeft = function(){
			var html="";
			var zhxxGuid  = cj.getCookie('selected_expo_id');
	    		$.post("gzry/findParentMenu",{
	    				zhxxGuid : zhxxGuid
	    			},function(data) {
	    				for (var i = 0; i < data.length; i++) {
	    					var guid =  data[i].guid;
	    					if (guid!= undefined ) {
	    						html+="<li class='layui-nav-item layui-nav-itemed'>";
								var bmc = data[i].bmc;
								var bm = data[i].bm;
								if (bmc!= undefined) {
									if (bm=="JBXX") {
										html+="";
									}else if(bm=="BGXX"){
										var guid="efb2383bbeda41aba50bd1fdea49a418";
										html+="";
									}else{
										if(bm=="RYBDB"){
											html+="<a href='javascript:toRybdb(\""+zhxxGuid+"\",\""+data[i].bmc+"\",\""+data[i].bm+"\");' data-url=''>"+data[i].name+"</a>";
										}else{
											html+="<a href='javascript:toList(\""+zhxxGuid+"\",\""+data[i].bmc+"\",\""+data[i].bm+"\");' data-url=''>"+data[i].name+"</a>";
										}
									}
								}else{
									html+="<a class='' href='javascript:;'>"+data[i].name+"</a>";
								}
								var parentMenu = data[i].id;
								$.ajax({
									    url:"gzry/findSonMenu",//请求的url地址
									    dataType:"json",   //返回格式为json
									 	async : false,//请求是否异步，默认为异步，这也是ajax重要特性
									    data:{parentMenu : parentMenu,zhxxGuid :zhxxGuid},    //参数值
									    type:"POST",   //请求方式
									    success:function(con){
											if (con.length!=0) {
												html+="<dl class='layui-nav-child' id='model'>";
												for (var a = 0; a < con.length; a++) {//展会编号,表名称，表名
													if(bm=="rybdb"){
														html+="<dd><a href='javascript:toRybdb(\""+zhxxGuid+"\",\""+con[a].bmc+"\",\""+con[a].bm+"\");' data-url=''>"+con[a].name+"</a></dd>";
													}else{
														html+="<dd><a href='javascript:toList(\""+zhxxGuid+"\",\""+con[a].bmc+"\",\""+con[a].bm+"\");' data-url=''>"+con[a].name+"</a></dd>";
													}
												}
												html+="</dl>"
											}
										}
								});
								html+="</li>"
							}
						}
	    				$("#bgxxJSP").after(html);
	    				element.init();
	    	    	 });	
	    }
    	readyLeft();
	    reloadExpo()
		// 展会切换监听
	    element.on('nav(top_expo_nav)', function (elem) {
	    	if (elem.data('action') === 'add') {
	            layer.alert('点击左侧「展会基本信息」进行添加');
	            return;
	        }
	    	var selected = cj.getCookie('selected_expo_id');
	        var elemId = elem.data('id');
	        var elemVal = elem.data('value');
	        if (selected === elemId) return;
	        layer.confirm('切换展会需要刷新页面，请先保存当前操作', {
	            btn: ['切换', '不切换']
	        }, function () {
	        	cj.setCookie('selected_expo_id', elemId, 365);
	        	cj.setCookie('selected_expo_zdmc', elemVal, 365);
	            location.reload();
	            $("#demoAdmin").attr("src", "findZhxx");
	        });
	    });
	});
	//去列表页
	function toList(zhxx,bmc,bm){
		var typeDj = "true";
		$("#demoAdmin").attr("src", "doc_Index.jsp?zhxx="+ zhxx+"&bmc="+bmc+"&bm="+bm+"&typeDj="+typeDj);
	}
	function toRybdb(zhxx,bmc,bm){
		var typeDj = "true";
		$("#demoAdmin").attr("src", "zhxx/gzry/rybdb_Index.jsp?zhxx="+ zhxx+"&bmc="+bmc+"&bm="+bm+"&typeDj="+typeDj);
	}
	
	function toSyrgl(){
		 var guid="00c99009ec2d4cb883acc9ae24f73b6e";
		 var bmc="搭建商审核";
		 $("#demoAdmin").attr("src", "zhxx/userList.jsp?guid="+guid+"&bmc="+bmc);
	}
	
	function toSyrglbgxx(){
		 var bmc="报馆信息审核";
		 var selected = cj.getCookie('selected_expo_id');
		 $("#demoAdmin").attr("src", "zhxx/bgxxList.jsp?zhxxGuid="+selected);
	}
	
	function toBgxx(){
		$("#demoAdmin").attr("src", "DJ/BGXX.jsp");
	}
	
	//去添加页
	function toForm(bm,bmc){
		var zhxxGuid  = cj.getCookie('selected_expo_id');
		var bmDj = bm;
		var typeDj = "true";
		var zhxxDj = zhxxGuid;
		var bmcDj = bmc;
		var jbxx = "jbxx";
		$("#demoAdmin").attr("src", "doc/toAddDataJsp?bmDj="+bmDj+"&jbxx="+jbxx+"&typeDj="+typeDj+"&zhxxDj="+zhxxDj+"&bmcDj="+bmcDj);
	}
	function userOut(){//退出
		layer.confirm('确定退出吗？', function(
				index) {
				top.location.href = "userOut";
				layer.close(index);
		});
	}
	</script>
</body>
</html>