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
<style>
.layui-fluid {
    padding: 15px;
}

</style>
</head>
<body>
<div class="layui-fluid">
        <form method="post" class="layui-form">
       
            <div class="layui-form-item" >
                <label class="layui-form-label " name="">旧密码</label>
                <div class="layui-input-inline">
                    <input type="password" name="oldPwd" lay-verify="required" autocomplete="off" placeholder="" class="layui-input" />
                </div>
            </div>
     <div class="layui-form-item" >
                <label class="layui-form-label " name="">新密码</label>
                <div class="layui-input-inline">
                    <input type="password" name="MM" lay-verify="required" autocomplete="off" placeholder="" class="layui-input" />
                </div>
            </div>
        <div class="layui-form-item" >
                <label class="layui-form-label " name="">新密码确认</label>
                <div class="layui-input-inline">
                    <input type="password" name="newPwd" lay-verify="required" autocomplete="off" placeholder="" class="layui-input" />
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit="" lay-filter="edit" >提交</button>
                </div>
            </div>
        </form>
    </div>
	<script src="statics/layui/layui.js"></script>
	<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
	<script src="statics/js/concisejs.js"></script>
	<script>
	  layui.use(['table', 'form'], function () {
	        var form = layui.form;
	        common = layui.common;
	        form.on('submit(edit)', function (d) {
	        	if($.trim(d.field.MM)!==$.trim(d.field.newPwd))
	        		{
	        		layer.alert('两次新密码不一致');
	        		}
	        	else if ($.trim(d.field.oldPwd)==$.trim(d.field.newPwd))
	        		{
	        		layer.alert('旧密码与新密码不能相同');
	        		}
	        	else
	        		{
	        		 $.post('isPwdCorrect?tick=' + new Date().getTime(),d.field, function (data) {
		                    if (data.success) 
		                    {
		                    	 layer.alert(data.msg,function(){
		                    		 var index = parent.layer.getFrameIndex(window.name);
	                                 parent.layer.close(index);
		                    	 });
		                    	
		                   
		                    } else {
		                        layer.alert(data.msg);
		                    }
		                });
	        		}
	            return false;
	        });
	  });
	</script>
</body>
</html>
