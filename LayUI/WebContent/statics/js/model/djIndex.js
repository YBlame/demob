var reloadExpo;
	var readyLeft;
	var selected;
	layui.use(['element', 'layer', 'form', 'laytpl'], function () {
	    var element = layui.element,
	        layer = layui.layer,
	        form = layui.form,
	        laytpl = layui.laytpl;
	    	table = layui.table, //表格
	    	carousel = layui.carousel,
	    	device = layui.device();
	    	reloadExpo = function(){
	    	 $.post("zhxx/findDjsZhxx", 
    		    function(data) {
	    		 if (data.length==0) {
	                 layer.alert('请先添加一个展会');
	                 html = '<a href="javascript:toAddZhxx();" >添加展会</a>';
	                 $('#top_expo_nav li').html(html);
	                 return;
	             }
	    		 var expoSelect='<form class="layui-form"><div class="layui-form-item" ><select name="expoList" ></select></div></form>';
	    		
	    		 $('#top_expo_nav li').html('');
	                if (data.length > 0) { // 有展会，渲染数据
	                	var expo="";
	                	 selected = cj.getCookie('selected_expo_id');
	                	  var ids = [];
		                    for (var j = 0; j < data.length; j++) {
		                        ids.push(data[j].guid);
		                    }
		                    var html;
		                    var other;
		                    var loadExpo=function(){
				            	   var str ='<option value="">请选择展会</option>';
				                	 for (var i = 0; i < data.length; i++) {
				                		  str += '<option id="'+data[i].guid+'" value="' + data[i].guid + '">' + data[i].ZHMC + '</option>) ';
				                	 }
				                	 $("[name=expoList]").html(str);
				    	    		 form.render('select');
				               }; 
		                    var winloadExpo=function(){ layer.open({
		    	                 title: '选择展会',
		    	                 content:expoSelect ,
		    	                 closeBtn: 0, //不显示关闭按钮
		    	                 area: ['300px', '370px'],
		    	                 btn: '确定',
		    	                 yes: function (index, layero) {
		    	                  selected=$('[name=expoList]').val();
		    	                    if(selected!="")
		    	                    	{
		    	                    	cj.setCookie('selected_expo_id',selected);
		    	                    	 other = '<dl class="layui-nav-child">';
		    		                        for (var k = 0; k < data.length; k++) {
		    		                            if (data[k].guid === selected) html = '<a href="javascript:;" id="g_expo" data-id="' + data[k].guid + '">' + data[k].ZHMC + '</a>';
		    		                            else other += '<dd><a href="javascript:;" id="g_expo" data-id="' + data[k].guid + '" >' + data[k].ZHMC + '</a></dd>';
		    		                        }

		    		                        if (data.length > 1) html += other;

		    		                        $('#top_expo_nav li').html(html);
		    		                        element.render('nav', 'top_expo_nav');
		    		                        readyLeft();//对左侧栏进行渲染
		    		                        xxtz();//消息
		    		                        layer.close(index);
		    	                    	}
		    	                    else
		    	                    	{
		    	                    	layer.alert('请选择一个展会',{closeBtn: 0},function(){
		    	                    		winloadExpo();
		    	                    		loadExpo();
		    	                    	});
		    	                    	}
		    	                 }
		    	             });
		                    }
		                    if(selected=="")
		                    	{
		                    	winloadExpo();
		                    	loadExpo();
	                	}
	                    if (selected !== '' && $.inArray(selected, ids) !== -1) {
	                        other = '<dl class="layui-nav-child">';
	                        for (var k = 0; k < data.length; k++) {
	                            if (data[k].guid === selected) html = '<a href="javascript:;" id="g_expo" data-id="' + data[k].guid + '">' + data[k].ZHMC + '</a>';
	                            else other += '<dd><a href="javascript:;" id="g_expo" data-id="' + data[k].guid + '" >' + data[k].ZHMC + '</a></dd>';
	                        }

	                        if (data.length > 1) html += other;

	                        $('#top_expo_nav li').html(html);
	                        element.render('nav', 'top_expo_nav');

	                    } 
	                /*    else {
	                        html = '<a href="javascript:;" id="g_expo" data-id="' + data[0].guid + '">' + data[0].ZHMC + '</a>';
	                        if (data.length > 1) {
	                            other = '<dl class="layui-nav-child">';
	                            for (var i = 1; i < data.length; i++) {
	                                other += '<dd><a href="javascript:;" id="g_expo" data-id="' + data[i].guid + '" >' + data[i].ZHMC + '</a></dd>';
	                            }
	                            other += '</dl>';
	                            html += other;
	                        }
	                        $('#top_expo_nav li').html(html);
	                        cj.setCookie('selected_expo_id', data[0].guid, 365);
	                        element.render('nav', 'top_expo_nav');
	                    }*/
	                }  else { // 无展会，提示添加测试
	                    cj.removeCookie('selected_expo_id');
	                    html = '<a href="javascript:toAddZhxx();">添加展会</a>';
	                    $('#top_expo_nav li').html(html);
	                    element.render('nav', 'top_expo_nav');
	                }
	    	 });	
	    }
		readyLeft = function(){
			var html="";
			var zhxxGuid  = cj.getCookie('selected_expo_id');
	    		$.post("dj/findParentMenu",{
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
									}else if(bm=="SGRYBX"){
										html+="<a href='javascript:toSgrybx(\""+zhxxGuid+"\",\""+data[i].bmc+"\",\""+data[i].bm+"\");' data-url=''>"+data[i].name+"</a>";
									}else{
										html+="<a href='javascript:toList(\""+zhxxGuid+"\",\""+data[i].bmc+"\",\""+data[i].bm+"\");' data-url=''>"+data[i].name+"</a>";
									}
								}else{
									html+="<a class='' href='javascript:;'>"+data[i].name+"</a>";
								}
								var parentMenu = data[i].id;
								$.ajax({
									    url:"dj/findSonMenu",//请求的url地址
									    dataType:"json",   //返回格式为json
									 	async : false,//请求是否异步，默认为异步，这也是ajax重要特性
									    data:{parentMenu : parentMenu,zhxxGuid:zhxxGuid},    //参数值
									    type:"POST",   //请求方式
									    success:function(con){
											if (con.length!=0) {
												html+="<dl class='layui-nav-child' id='model'>";
												for (var a = 0; a < con.length; a++) {//展会编号,表名称，表名
													html+="<dd><a href='javascript:toList(\""+zhxxGuid+"\",\""+con[a].bmc+"\",\""+con[a].bm+"\");' data-url=''>"+con[a].name+"</a></dd>";
												}
												html+="</dl>"
											}
										}
								});
								html+="</li>"
							}
						}
	    				$("#leftMenu").append(html);
	    				 element.init();
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
	function toSgrybx(zhxx,bmc,bm){
		var typeDj = "true";
		$("#demoAdmin").attr("src", "djpublic/toBdxx?zhxx="+ zhxx+"&bmc="+bmc+"&bm="+bm+"&typeDj="+typeDj);
	}
	//去列表页
	function toList(zhxx,bmc,bm){
		var typeDj = "true";
		$("#demoAdmin").attr("src", "DJ/public/public_Index.jsp?zhxx="+ zhxx+"&bmc="+bmc+"&bm="+bm+"&typeDj="+typeDj);
	}
	function toIndex(){
		$("#demoAdmin").attr("src", "DJ/index.jsp");
	}
	function toBgxx(){
		$("#demoAdmin").attr("src", "DJ/BGXX_LIST.jsp");
	}
	
	//去查看基本信息
	function toUserInfo(){
		$("#demoAdmin").attr("src", "DJ/JBXX_Info.jsp");
	}
	function userOut(){//退出
		layer.confirm('确定退出吗？', function(
				index) {
				top.location.href = "userOut";
				layer.close(index);
		});
	}