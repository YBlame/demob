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
<meta ZHMC="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta ZHMC="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="statics/layui/css/layui.css" media="all">
<link rel="stylesheet" href="statics/layui/css/admin.css" media="all">
<link rel="stylesheet" href="statics/css/index.css" media="all">
</head>
<body>
	<div class="layui-fluid">
		<div class="layui-row layui-col-space15">
			<div class="layui-col-md8">
				<div class="layui-row layui-col-space15">
					<div class="layui-col-md12">
						<div class="layui-card">
							<div class="layui-card-header">工具栏</div>
							<div class="layui-card-body">
								<div class="layadmin-shortcut">
									<div carousel-item>
										<ul class="layui-row layui-col-space10">
											<li class="layui-col-xs3"><a href="javascript:toBgxx();" lay-href=""> <i class="layui-icon layui-icon-home" style="height: 146px; line-height: 146px; font-size: 60px;"></i> <cite>我要报馆</cite>
											</a></li>
											<li class="layui-col-xs3"><a lay-href="home/homepage2.html"> <i class="layui-icon layui-icon-util" style="height: 146px; line-height: 146px; font-size: 60px;"></i> <cite>施工人员</cite>
											</a></li>
											<li class="layui-col-xs3"><a lay-href="component/layer/list.html"> <i class="layui-icon layui-icon-notice" style="height: 146px; line-height: 146px; font-size: 60px;"></i> <cite>通知</cite>
											</a></li>
											<li class="layui-col-xs3"><a layadmin-event="im"> <i class="layui-icon layui-icon-form" style="height: 146px; line-height: 146px; font-size: 60px;"></i> <cite>付款通知单</cite>
											</a></li>
											<li class="layui-col-xs3"><a lay-href="user/user/list.html"> <i class="layui-icon layui-icon-rmb" style="height: 146px; line-height: 146px; font-size: 60px;"></i> <cite>汇款水单和发票</cite>
											</a></li>
											<li class="layui-col-xs3"><a lay-href="user/user/list.html"> <i class="layui-icon layui-icon-close-fill" style="height: 146px; line-height: 146px; font-size: 60px;"></i> <cite>违规记录</cite>
											</a></li>
											<li class="layui-col-xs3"><a lay-href="user/user/list.html"> <i class="layui-icon layui-icon-username" style="height: 146px; line-height: 146px; font-size: 60px;"></i> <cite>我的资料</cite>
											</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
			<div class="layui-col-md4">
				<div class="layui-card">
					<div class="layui-card-header">
						<i class="layui-icon layui-icon-notice" style="height: 16px; width: 16px; line-height: 16px; float: left; margin-left: 25px; position: inherit;"></i>
					</div>
					<div class="layui-card-body layui-text" style="height: 350px;">
						<ul class="layui-timeline">
							<li class="layui-timeline-item">
								<div class="layui-timeline-content layui-text">
									<h3 class="layui-timeline-title" id='RQ'></h3>
									<p id="NR"></p>
								</div>
							</li>
						</ul>
					</div>
				</div>

			</div>
		</div>
		<div class="layui-row layui-col-space15">
			<div class="layui-col-md12">
				<div class="layui-row layui-col-space15">
					<div class="layui-col-md12">
						<div class="layui-card">
							<div class="layui-tab layui-tab-brief layadmin-latestData">
								<div class="layui-card-body" id="bgxxDiv">
									<table id="demo" lay-filter="test" id="bgxxTable"></table>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/html" id="toolbarDemo">
		 <button type="button" class="layui-btn layui-btn-normal"  lay-event="detail">新增</button>
    <button type="button" class="layui-btn layui-btn-danger">删除</button>
        <div class="layui-btn-container" style="float: right;">
            <i class="layui-icon layui-icon-ok-circle" style="font-size: 15px; color: #AFF42C;">
                <span style="color: black">审核通过</span>
            </i>
            <i class="layui-icon layui-icon-radio" style="font-size: 15px; color: #c2c2c2">
                <span style="color: black">审核中</span>
            </i>
            <i class="layui-icon layui-icon-close-fill" style="font-size: 15px; color: red;">
                <span style="color: black">审核未通过</span>
            </i>
        </div>
    </script>

<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
<script src="statics/layui/layui.js?t=1"></script>
<script src="statics/js/concisejs.js?t=1"></script>

<script type="text/javascript">
	layui.use([ 'laydate', 'laypage', 'layer', 'table', 'carousel',
							'upload', 'element', 'slider' ],
					function() {
						var table = layui.table, //表格
						carousel = layui.carousel, device = layui.device();

						
				});
</script>

</html>