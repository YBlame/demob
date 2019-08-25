<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
	<link rel="stylesheet" href="statics/layui/css/layui.css" media="all">
    <script src="statics/layui/layui.js"></script>
    <script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
	<script src="statics/js/concisejs.js"></script>
	<style type="text/css">
		.layui-tab-card {
	    margin-top: 61px;
	    border-width: 1px;
	    border-style: solid;
	    border-radius: 2px;
	    box-shadow: 0 2px 5px 0 rgba(0,0,0,.1);
	}
	
	</style>
</head>
<body style="padding:10px">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;" id="title">
				<legend>我的报馆</legend>
			</fieldset>
	<div>
		<a href="DJ/BGXX.jsp" class="layui-btn layui-btn-normal newsAdd_btn" style="float: right;">+新增报馆</a>
	</div>
    <div class="layui-tab layui-tab-card" lay-filter="tabInfo" id="bgxxInfo">
        <ul class="layui-tab-title">
            <li class="layui-this" lay-id="JJ">拒绝</li>
            <li lay-id="WTJ">未提交</li>
            <li lay-id="DSH">待审核</li>
            <li lay-id="TG">通过</li>
        </ul>
        <div class="layui-tab-content" >
            <div class="layui-tab-item layui-show">
                <div class="layui-tab layui-tab-brief layadmin-latestData" lay-filter="JJ">
								<div class="layui-card-body">
									<table id="Table1" lay-filter="Table1"></table>

								</div>
							</div>
            </div>
            <div class="layui-tab-item">
                <div class="layui-tab layui-tab-brief layadmin-latestData" lay-filter="WTJ">
								<div class="layui-card-body">
									<table id="Table2"  lay-filter="Table2"></table>

								</div>
							</div>
            </div>
            <div class="layui-tab-item">
                <div class="layui-tab layui-tab-brief layadmin-latestData"  lay-filter="DSH">
								<div class="layui-card-body">
									<table id="Table3" lay-filter="Table3"></table>

								</div>
							</div>
            </div>
            <div class="layui-tab-item">
                <div class="layui-tab layui-tab-brief layadmin-latestData" lay-filter="TG">
								<div class="layui-card-body">
									<table id="Table4" lay-filter="Table4"></table>

								</div>
							</div>
            </div>
            <div class="layui-tab-item">
                <div class="layui-tab layui-tab-brief layadmin-latestData">
								<div class="layui-card-body">
									<table id="Table4" lay-filter="test"></table>

								</div>
							</div>
            </div>
        </div>
    </div>
    <script>
        layui.use([ 'laydate', 'laypage', 'layer', 'table','upload', 'element'], function () {
            var element = layui.element;
            var table = layui.table,
            cols = [{type:'checkbox', fixed: 'left'}
				           ,{field:'ZGH', title: '展馆号',sort: true}
				           ,{field:'ZWH',  title: '展位号', sort: true}
				           ,{field:'CZQYGSQC',  title: '参展商'}
				           ,{field:'RQ', title: '日期', width: '30%', minWidth: 100,sort: true} //minWidth：局部定义当前单元格的最小宽度，layui 2.2.1 新增				        
				       ];
          	//对查询条件的加载
    		var guid = "";
    		var zhxx = cj.getCookie('selected_expo_id');

    		var bm = "BGXX";
    		var bmc = "报馆信息";
    		var typeDj = "true";					
    		var guid = "";
    		//获取表头并且获取数据
    		var num = 1;                       
			// 然后开始渲染表格
            var type= "拒绝"
            
            
  			table.render({
  				elem: '#Table1',
  				height: 420, //描述
  				url: 'bg/findBgTable?type='+type+"&bm="+bm//数据接口
  				,
  				title: '记录表',
  				page :true,
  				done: function (res, curr, count) {
  				    this.where = {};
  				},
  				toolbar: true ,//开启工具栏，此处显示默认图标，可以自定义模型，详见文档
  				defaultToolbar: ['filter', 'exports'],
  				cols: [cols]
  			});
            table.render();
	         element.on('tab(tabInfo)', function(data){
	            	var zt = $(this).attr('lay-id');
	            	switch(zt){
	        		case "JJ":
	        			type="拒绝"
	        			table.render({
	          				elem: '#Table1',
	          				height: 420, //描述
	          				url: 'bg/findBgTable?type='+type//数据接口
	          				,
	          				title: '记录表',
	          				page: {
	          				    layout: ['prev', 'page', 'next','skip', 'count'], //自定义分页布局
	          				    first: false, //不显示首页
	          				    last: false
	          				    //不显示尾页
	          				}, //开启分页
	          				limit: 7,
	          				limits: [3, 5, 10, 20, 50],
	          				done: function (res, curr, count) {
	          				    this.where = {};
	          				},
	          				toolbar: true ,//开启工具栏，此处显示默认图标，可以自定义模型，详见文档
	          				defaultToolbar: ['filter', 'exports'],
	          				cols: [cols]
	          			});
	        			table.render();
	        			break;
	        			
	        		case "WTJ":
	        			type="未提交"
	        				table.render({
	        					elem: '#Table2',
	        					height: 420, //描述
	        					url: 'bg/findBgTable?type='+type//数据接口
	        					,
	        					title: '记录表',
	        					page: {
	        					    layout: ['prev', 'page', 'next','skip', 'count'], //自定义分页布局
	        					    first: false, //不显示首页
	        					    last: false
	        					    //不显示尾页
	        					}, //开启分页
	        					limit: 7,
	        					limits: [3, 5, 10, 20, 50],
	        					done: function (res, curr, count) {
	        					    this.where = {};
	        					},
	        					toolbar: true ,//开启工具栏，此处显示默认图标，可以自定义模型，详见文档
	        					defaultToolbar: ['filter', 'exports'],
	        					cols: [cols]
	        				});
	        			table.render();
	        			break;
	        		case "DSH":
	        			type="待审核"
	        				table.render({
	        					elem: '#Table3',
	        					height: 420, //描述
	        					url: 'bg/findBgTable?type='+type//数据接口
	        					,
	        					title: '记录表',
	        					page: {
	        					    layout: ['prev', 'page', 'next','skip', 'count'], //自定义分页布局
	        					    first: false, //不显示首页
	        					    last: false
	        					    //不显示尾页
	        					}, //开启分页
	        					limit: 7,
	        					limits: [3, 5, 10, 20, 50],
	        					done: function (res, curr, count) {
	        					    this.where = {};
	        					},
	        					toolbar: true ,//开启工具栏，此处显示默认图标，可以自定义模型，详见文档
	        					defaultToolbar: ['filter', 'exports'],
	        					cols: [cols]
	        				});
	        			table.render();
	        			break;
	        		case "TG":
	        			type="通过"
	        				table.render({
	        					elem: '#Table4',
	        					height: 420, //描述
	        					url: 'bg/findBgTable?type='+type//数据接口
	        					,
	        					title: '记录表',
	        					page: {
	        					    layout: ['prev', 'page', 'next','skip', 'count'], //自定义分页布局
	        					    first: false, //不显示首页
	        					    last: false
	        					    //不显示尾页
	        					}, //开启分页
	        					limit: 7,
	        					limits: [3, 5, 10, 20, 50],
	        					done: function (res, curr, count) {
	        					    this.where = {};
	        					},
	        					toolbar: true ,//开启工具栏，此处显示默认图标，可以自定义模型，详见文档
	        					defaultToolbar: ['filter', 'exports'],
	        					cols: [cols]
	        				});
	        			table.render();
	        			break;
	        	}
            });
	  //监听行单击事件（单击事件为：rowDouble）
	  table.on('row(Table1)', function(obj){
	    	var data = obj.data;		
	    	var guid = data['guid'];
		    window.location.href = "DJ/BGXX_EDIT.jsp?bgGuid="+guid;
	  });
	  
	  table.on('row(Table2)', function(obj){
		    var data = obj.data;				   
		    var guid = data['guid'];
		    window.location.href = "DJ/BGXX_EDIT.jsp?bgGuid="+guid;
		    
		  });
	  
	  table.on('row(Table3)', function(obj){
		    var data = obj.data;
		    var guid = data['guid'];
		    window.location.href = "DJ/BGXX_SHOW.jsp?bgGuid="+guid;
		  });
	  
	  table.on('row(Table4)', function(obj){
		    var data = obj.data;
		    var guid = data['guid'];
		    window.location.href = "DJ/BGXX_SHOW.jsp?bgGuid="+guid;
		  });
          
        });
</script> 
    
  
</body>
</html>
