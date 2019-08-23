<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <style>
    </style>
    <head>
        <meta charset="utf-8">
        <title>我要报馆</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
        <link rel="stylesheet" href="statics/layui/css/layui.css" media="all">
        <link rel="stylesheet" href="statics/layui/admin.css" media="all">
        <link rel="stylesheet" href="statics/css/index.css" media="all">
        <style type="text/css">
        
               #detailTbody tr:hover {
			        background: #fff;
			    }
			
			    .layui-form-label {
			        width: 110px;
			    }
			
			/*     .uploader-list {
			        margin-left: -15px;
			    } */
			
			    .uploader-list .info {
			        position: relative;
			        margin-top: -25px;
			        background-color: black;
			        color: white;
			        filter: alpha(Opacity=80);
			        -moz-opacity: 0.5;
			        opacity: 0.5;
			        width: 100px;
			        height: 25px;
			        text-align: center;
			        display: none;
			    }
			
			    .uploader-list .handle {
			        position: relative;
			        background-color: #ff6a00;
			        color: white;
			        filter: alpha(Opacity=80);
			        -moz-opacity: 0.5;
			        width: 100px;
			        text-align: right;
			        height: 18px;
			        margin-bottom: -18px;
			        display: none;
			    }
			
			    .uploader-list .handle span {
			        margin-right: 5px;
			    }
			
			    .uploader-list .handle span:hover {
			        cursor: pointer;
			    }
			
			    .uploader-list .file-iteme {
			        margin: 12px 0 0 15px;
			        padding: 1px;
			        float: left;
			    }
		</style>
    </head>
<body>

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-header">开票信息</div>
        <div class="layui-card-body" style="padding: 15px;">
            <form class="layui-form layui-form-pane" action="" lay-filter="component-form-group">
             <%--    <input type="text" id="zhxxGuid" name="zhxxGuid" style="display: none"/>
               	<input type="text" id="DJSBH" name="DJSBH" style="display: none" value="${ sessionScope.guid}"/> --%>
               
                <fieldset class="layui-elem-field layui-field-title">
                    <legend>开票信息</legend>
                </fieldset>
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 125px;"><font color=red>*</font>发票类型</label>
                    <div class="layui-input-block">                        
                        <input type="radio" id="ztjg" name="KPLX" lay-filter="ztjg" value="增值税专用发票" title="增值税专用发票" checked="checked"> 
                        <input type="radio" id="ztjg" name="KPLX" lay-filter="ztjg" value="增值税普通发票" title="增值税普通发票">                       
                    </div>
                </div>
                
                <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">开票金额</label>
                            <div class="layui-input-block">
                                <input type="text" name="KPJE" placeholder="请输入开票金额"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">发票抬头</label>
                            <div class="layui-input-block">
                                <input type="text" name="FPTT" placeholder="请输入发票抬头"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                
                 <div id='snsc' >                                                          
                    <div class="layui-form-item">
                        <div class="layui-upload">
                            <blockquote class="layui-elem-quote layui-quote-nm"
                                        style="margin-top: 10px;">
                                <font color=red>*</font>一般纳税人证明：
                                <div class="layui-upload-list" id="ctgcszzzsDiv">
                                 <input id='gcszzzs' name='NSRZM' style='display: none' lay-reqtext="一般纳税人证明不能为空" />
                                    <button type="button" class="layui-btn" style="display:block;margin:0 auto"
                                            id="gcszzzsBtn">一般纳税人证明
                                    </button>
                                </div>
                            </blockquote>
                        </div>
                        <p class="details-component-line-margin"
								style="margin-bottom: 0px;">注意：请上传一般纳税人证明，单个图片不超过1M，支持JPG格式。
						</p>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">纳税人识别号</label>
                            <div class="layui-input-block">
                                <input type="text" name="NSRSBH" placeholder="纳税人识别号"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">开户行</label>
                            <div class="layui-input-block">
                                <input type="text" name="KHH"  placeholder="开户行"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">账号</label>
                            <div class="layui-input-block">
                                <input type="text" name="ZH" placeholder="请输入账号"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">地址</label>
                            <div class="layui-input-block">
                                <input type="text" name="DZ"  placeholder="请输入地址"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">电话</label>
                            <div class="layui-input-block">
                                <input type="text" name="DH" placeholder="请输入电话"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>                      
                    </div>
                </div>                                                              
                
                <fieldset class="layui-elem-field layui-field-title" style="margin-top:25px">
                    <legend>发票邮寄信息</legend>
                </fieldset>               
                <div class="layui-form-item">
                    <label class="layui-form-label"><font color=red>*</font>收件地址</label>
                    <div class="layui-input-block">
                        <input type="text" name="SJDZ" lay-verify="required" placeholder="请输入收件地址" style="width: 300px" lay-reqtext="收件地址不能为空" 
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label"><font color=red>*</font>收件人</label>
                        <div class="layui-input-block">
                            <input type="text" name="SJR" lay-verify="required" placeholder="请输入收件人" lay-reqtext="收件人不能为空" 
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label"><font color=red>*</font>手机</label>
                        <div class="layui-input-block">
                            <input type="text" name="SJ" lay-verify="required|phone|number" placeholder="请输入手机" lay-reqtext="收件人手机不能为空" 
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
                                               
                               

                <div class="layui-form-item layui-layout-admin">
                    <div class="layui-input-block">
                        <div class="layui-footer" style="left: 0;">
                            <button class="layui-btn" lay-submit="" lay-filter="component-form-demo1">保存</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>


<script src="statics/layui/layui.js"></script>
<script src="statics/js/concisejs.js"></script>
<script type="text/javascript" src="statics/js/jquery-1.8.0.js"></script>
<script src="statics/js/doc.js"></script>
<script>
    layui.use(["jquery", "upload", "form", "layer", "element"], function () {
        var form = layui.form,
            element = layui.element,
            layer = layui.layer,
            upload = layui.upload;
        element.init();
        upload.render();
        var selectImg = function(d){
       		upload.render({
                elem: '#'+d+'Btn'
                ,url: 'uploadPic'
                ,multiple: true
                ,size: 1024 //限制文件大小，单位 KB
                ,before: function(obj){
                    //预读本地文件示例，不支持ie8
                    obj.preview(function(index, file, result){
                        $("#"+d+"Btn").removeAttr("style");
                    });
                }
                ,done: function(res){
            		var imgData = res.data.src
            		var dData = $("#"+d+"").val();
            		dData +=imgData+","
            		$("#"+d+"").val(dData);
           	  		$('#'+d+'Btn').before("<div class='file-iteme' style='width: 92px;height: 92px;display:inline-block;margin-right: 10px;'><img src='"+ res.data.src +"' id='"+res.name+"' alt=''  style='margin-bottom: 5px;position:relative;' class='layui-upload-img uploader-list'>  <span class='info' style='position:absolute;z-index:10;display:none'><a href='"+res.data.src+"' target='_blank'><image src='statics/login/prew.png'></image></a></span><span class='info' style='position:absolute;z-index:10;display:none' onclick='del(this)'><image src='statics/login/del.png'></image></span></div>");

                }
            });
        }
        
        var zhxx = cj.getCookie('selected_expo_id');
        var bmDes = "bgxx_des_" + zhxx;
        var bm = "bgxx_" + zhxx;
      
   		


        /*纳税人证明*/
        upload.render({
            elem: '#gcszzzsBtn'
            , url: 'uploadPic'
            , multiple: true
            ,size: 1024 //限制文件大小，单位 KB
            , before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $("#gcszzzsBtn").removeAttr("style");
                });
            }
            , done: function (res) {
            	var imgData = res.data.src
        		var gcszzzsData = $('#gcszzzs').val();
        		gcszzzsData +=imgData+","
            	$("#gcszzzs").val(gcszzzsData);
           	  		$('#gcszzzsBtn').before("<div class='file-iteme' style='width: 92px;height: 92px;display:inline-block;margin-right: 10px;'><img src='"+ res.data.src +"' id='"+res.name+"' alt=''  style='margin-bottom: 5px;position:relative;' class='layui-upload-img uploader-list'>  <span class='info' style='position:absolute;z-index:10;display:none'><a href='"+res.data.src+"' target='_blank'><image src='statics/login/prew.png'></image></a></span><span class='info' style='position:absolute;z-index:10;display:none' onclick='del(this)'><image src='statics/login/del.png'></image></span></div>");

            }
        });
        /*监听单选框切换表单*/
        form.on("radio(ztjg)", function (data) {
            var ztjg = data.value;
            switch (ztjg) {
                case "增值税专用发票":
                    $("#snsc").show();
                    break;
                case "增值税普通发票":
                	  $("#zwtz").attr("lay-verify","required");
                      $("#zwjgt").attr("lay-verify","required");
                      $("#snsc").hide();                  	
                    break;          
            }
           form.render();
        });
        
        /* 监听提交 */
        form.on('submit(component-form-demo1)', function (data) {
        	var selected = cj.getCookie('selected_expo_id');
        	$("#zhxxGuid").val(selected);
        	var formList = $('.layui-form-pane').serialize()
        	$.ajax({
       		        type:"POST",
       		        url:"bg/submitBgxx",
       		      	data: formList,
       		        success:function(data){
       		           if(data.success){
       						window.location.href = "DJ/FYHZ.jsp"
       		             /*  layer.alert(data.msg,function() {
       			var index = layer.open({
                    type: 2,
                    content: 'DJ/FYHZ.jsp',
                    title: '费用汇总',
                });
                layer.full(index); 
                });*/
       		           }else{
       					  layer.alert(data.msg);
       		           }
       		        },
       		        error:function(jqXHR){
       		           aler("发生错误："+ jqXHR.status);
       		        }
        		});

            return false;
        });        
		

    });
</script>
</body>
</html>
