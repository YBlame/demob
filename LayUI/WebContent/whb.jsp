<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">


<title>新增-图片</title>


<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
  <link rel="stylesheet" href="statics/layui/css/layui.css" media="all">




</head>

<body>
	 <form class="layui-form" action="<%=basePath%>paibianshenpi/shangbaosave.do" name="Form" id="Form"  method= "post">
	<input type="hidden" name="PAIBIANSHENPI_ID" id="PAIBIANSHENPI_ID" value="${pd.PAIBIANSHENPI_ID}"/>
    <div id="zhongxin" style="padding-top: 13px;">
       <div class="layui-form-item">
          <div class="layui-inline">
            <label class="layui-form-label">申请人：</label>
            <div class="layui-input-inline">
              <input type="text" name="NAME" id="NAME"  class="layui-input" placeholder="请输入姓名">
            </div>
          </div>
       
              </div>
  
              <div class="layui-tab-content">
                <div class="layui-tab-item layui-show ">
                <div class="layui-form-item layui-form-text">
                   <textarea name="NEIRONG" id="NEIRONG" placeholder="请输入内容" class="layui-textarea"></textarea>
                </div>
              <div class="layui-upload">
                <button type="button" class="layui-btn" id="duotu">多图片上传</button> 
                <blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;">预览图：<div class="layui-upload-list" id="demo2"></div>
                </blockquote>
              </div>
              <div class="layui-form-item">			
				<div><button type="button" class="layui-btn" lay-submit=""  id="testListAction" style="display:none;">上传图片</button></div>
		        <div style="margin-top:10px;"><button type="button" class="layui-btn" lay-submit="" lay-filter="tijiao">提交数据</button></div>
		      </div>
             </div>
           </div>
        </div>				
</form>	
  <script src="statics/layui/layui.js"></script>  
<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
<script>
 
var fileshu=0;
layui.use(['form','upload'], function(){
  var $ = layui.jquery
  ,upload = layui.upload
  ,form = layui.form;
 //多图片上传
  upload.render({
    elem: '#duotu'
    ,url: '<%=basePath%>paibianshenpi/shangchuan'
    ,multiple: true
    ,auto: false //选择文件后不自动上传
    ,bindAction: '#testListAction' //指向一个按钮触发上传
      ,choose: function(obj){
    //将每次选择的文件追加到文件队列
    var files = obj.pushFile();
     this.data={PAIBIANSHENPI_ID: $("#PAIBIANSHENPI_ID").val()};
    //预读本地文件，如果是多文件，则会遍历。(不支持ie8/9)
    obj.preview(function(index, file, result){
        fileshu=1;
       $("#testListAction").css('display','block');
       $('#demo2').append('<img src="'+ result +'" alt="'+ file.name +'" style="width:50px;height:50px;padding-left:10px;padding-top:10px;">')
       
    });
    }
    ,done: function(res){
      //上传完毕
      fileshu=2;
      $("#testListAction").css('display','none');
      //alert("res1:"+res.result1);
     
    }
  });
//监听提交
   form.on('submit(tijiao)', function(data){
    if($("#NAME").val()==""){
	    layer.tips('请输入姓名', '#NAME');
	    return false;
	}
	if(fileshu == 1){
		layer.msg("请先上传附件！");
		return false;
	}else{
		$.ajax({
			type:"post",
			url:"shangbaosave",
			data: data.field,
			dataType: "json",
			error:function(){
				layer.msg("修改过程中出错！");
			},
			success:function(data){
				if(data.result=="success"){
					layer.msg("上报数据成功！");
					setTimeout("self.location='<%=basePath%>qiantai/paibianshenpi'",2000);
				}else {
					layer.msg("修改出错！");
				}
			}
		})
	}
    return false;
  });
});
</script>
</body>
</html>

