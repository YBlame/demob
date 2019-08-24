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
        <div class="layui-card-header">新增报馆</div>
        <div class="layui-card-body" style="padding: 15px;">
            <form class="layui-form layui-form-pane" action="" lay-filter="component-form-group">
                <input type="text" id="zhxxGuid" name="zhxxGuid" style="display: none"/>
               	<input type="text" id="DJSBH" name="DJSBH" style="display: none" value="${ sessionScope.guid}"/>
                <fieldset class="layui-elem-field layui-field-title">
                    <legend>展位信息</legend>
                </fieldset>
                <div class="layui-form-item">
			          <div class="layui-inline">
				           <label class="layui-form-label"><font color=red>*</font>展馆号</label>
				           <div class="layui-input-block">
				             <select  lay-filter="ZGH" name="ZGH" placeholder="请选择展馆号" lay-verify="required" value="" lay-reqtext="展馆号不能为空" >
				              
				             </select>
				         	</div>
			          </div>
			          <div class="layui-inline">
				           <label class="layui-form-label"><font color=red>*</font>展位号</label>
				           <div class="layui-input-block">
				             <select  lay-filter="ZWH" name="ZWH" placeholder="请选择展位号" lay-verify="required" value="" lay-reqtext="展位号不能为空" >
				              
				             </select>
				         	</div>
			          </div>
		          </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"><font color=red>*</font>参展公司</label>
                    <div class="layui-input-block">
                        <input type="text" name="CZQYGSQC" lay-verify="required" placeholder="请输入参展公司" style="width: 250px" lay-reqtext="参展公司不能为空" 
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label"><font color=red>*</font>现场负责人</label>
                        <div class="layui-input-block">
                            <input type="text" name="CZSZSXCFZR" lay-verify="required" placeholder="请输入现场负责人" lay-reqtext="现场负责人不能为空" 
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label"><font color=red>*</font>手机号</label>
                        <div class="layui-input-block">
                            <input type="text" name="CZSSJ" lay-verify="required|phone|number" placeholder="请输入手机号" lay-reqtext="负责人手机号不能为空" 
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>


                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 40px">
                    <legend>搭建商信息</legend>
                </fieldset>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label"><font color=red>*</font>安全负责人</label>
                        <div class="layui-input-block">
                            <input type="text" name="DJSXCAQFZR" lay-verify="required" placeholder="请输入安全负责人" lay-reqtext="安全负责人不能为空" 
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label"><font color=red>*</font>手机号</label>
                        <div class="layui-input-block">
                            <input type="text" name="DJSSJ" lay-verify="required|phone|number" placeholder="请输入手机号" lay-reqtext="安全负责人手机号不能为空" 
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 40px">
                    <legend>文件</legend>
                </fieldset>
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 125px;"><font color=red>*</font>展台结构类型</label>
                    <div class="layui-input-block">
                        <input type="radio" id="ztjg" name="ztjg" lay-filter="ztjg" value="室内单层" title="室内单层"
                               checked="checked">
                        <input type="radio" id="ztjg" name="ztjg" lay-filter="ztjg" value="室内双层" title="室内双层">
                        <input type="radio" id="ztjg" name="ztjg" lay-filter="ztjg" value="室外钢木结构" title="室外钢木结构">
                        <input type="radio" id="ztjg" name="ztjg" lay-filter="ztjg" value="室外简易结构"
                               title="室外简易结构(如: 纯桁架结构等)">
                    </div>
                </div>
                <div id='sndc'>
                    <div class="layui-form-item">
                    <p class="details-component-line-margin"
								style="margin-bottom: 0px;font-size: 12px;">注意：请上传展位图纸，单个图片不超过1M。
						</p>
                        <div class="layui-upload">
                            <blockquote class="layui-elem-quote layui-quote-nm"
                                        style="margin-top: 10px;">
                               <font color=red>*</font> 展位图纸预览图：
                                <div class="layui-upload-list" id="zwtzDiv">
                                <input id='zwtz' name='zwtz' style='display: none' lay-verify="required" lay-reqtext="展位图纸不能为空"  />
                                    <button type="button" class="layui-btn" style="display:block;margin:0 auto"
                                            id="zwtzBtn">展位图纸
                                    </button>
                                </div>
                            </blockquote>
                        </div>
                         
                    </div>
                </div>
                <div id='snsc' style="display: none">
                    <div class="layui-form-item">
                    <p class="details-component-line-margin"
								style="margin-bottom: 0px;font-size: 12px;">注意：请上传展位结构图及审核报告，单个图片不超过1M，支持JPG格式。
						</p>
                        <div class="layui-upload">
                            <blockquote class="layui-elem-quote layui-quote-nm"
                                        style="margin-top: 10px;">
                                <font color=red>*</font>展位结构图及审核报告：
                                <div class="layui-upload-list" id="xbjgtjshbgDiv">
                                 <input id='zwjgt' name='zwjgt' style='display: none' lay-reqtext="展位细部结构图及审核报告不能为空"/>
                                    <button type="button" class="layui-btn" style="display:block;margin:0 auto"
                                            id="zwjgtBtn">展位结构图及审核报告
                                    </button>
                                </div>
                            </blockquote>
                        </div>
                         
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">设计院全称</label>
                            <div class="layui-input-block">
                                <input type="text" name="SJY" placeholder="请输入设计院全称"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">办公电话</label>
                            <div class="layui-input-block">
                                <input type="text" name="BGDH" placeholder="请输入办公电话"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">出图工程师</label>
                            <div class="layui-input-block">
                                <input type="text" name="CTSJS" placeholder="请输入出图工程师"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">手机号</label>
                            <div class="layui-input-block">
                                <input type="text" name="GCSSJH"  placeholder="请输入手机号"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                     <p class="details-component-line-margin"
								style="margin-bottom: 0px;font-size: 12px;">注意：请上传工程师资质证书，单个图片不超过1M。
						</p>
                        <div class="layui-upload">
                            <blockquote class="layui-elem-quote layui-quote-nm"
                                        style="margin-top: 10px;">
                                <font color=red>*</font>出图工程师资质证书：
                                <div class="layui-upload-list" id="ctgcszzzsDiv">
                                 <input id='gcszzzs' name='gcszzzs' style='display: none' lay-reqtext="出图工程师资质证不能为空" />
                                    <button type="button" class="layui-btn" style="display:block;margin:0 auto"
                                            id="gcszzzsBtn">工程师资质证书
                                    </button>
                                </div>
                            </blockquote>
                        </div>
                       
                    </div>
                </div>

                <div class="layui-form-item layui-layout-admin">
                    <div class="layui-input-block">
                        <div class="layui-footer" style="left: 0;">
                            <button class="layui-btn" lay-submit="" lay-filter="component-form-demo1">下一步</button>
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
        $.ajaxSetup (
       		 {
       		 async: false
       		 });
        $.post("bg/returnZdmList", {
            bmDes: bmDes,
            bm: bm
        }, function (result) {
            if (result != null) {
                var zdm = "";
                for (var i = 0; i < result.length; i++) {
               	 var fromInput = "";
                    switch (result[i].formtypes) {
                    case "pic":
                    	var isform = '';
                    	if(result[i].isform=='1'){
                    		isform = "lay-verify=\"required\"  lay-reqtext=\""+ result[i].zdmc +"不能为空\"";
                    	}
                        fromInput += "<div class=\"layui-form-item\"><p class=\"details-component-line-margin\" style=\"margin-bottom: 0px;font-size: 12px;\">注意："+result[i].beizhu+"</p> <div class=\"layui-upload\"> <blockquote class=\"layui-elem-quote layui-quote-nm\" style=\"margin-top: 10px;\"><font color=red>*</font>" + result[i].zdmc + "： <div class=\"layui-upload-list\" id=\"div\"><input id='"+ result[i].zdm +"' name='"+ result[i].zdm +"' style='display: none' "+isform+"  /><button type=\"button\" class=\"layui-btn append\" style=\"display:block;margin:0 auto\" lay-filter=\""+ result[i].zdm +"\" id=\"" + result[i].zdm + "Btn\"> " + result[i].zdmc + "</button></div> </blockquote> </div></div>";
                        break;
                    }
                    $(".layui-layout-admin").before(fromInput);
                    selectImg(result[i].zdm)
                }
            }
    });
   		
        
        //多图片上传
        /*展位图纸预览图*/
        upload.render({
            elem: '#zwtzBtn'
            , url: 'uploadPic'
            , multiple: true
            ,size: 1024 //限制文件大小，单位 KB
            , before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $("#zwtzBtn").removeAttr("style");
                });
            }
            , done: function (res) {
            	var imgData = res.data.src
            	var zwtzData = $('#zwtz').val();
            	zwtzData +=imgData+","
            	$("#zwtz").val(zwtzData);
          	  	$('#zwtzBtn').before("<div class='file-iteme' style='width: 92px;height: 92px;display:inline-block;margin-right: 10px;'><img src='"+ res.data.src +"' id='"+res.name+"' alt=''  style='margin-bottom: 5px;position:relative;' class='layui-upload-img uploader-list'>  <span class='info' style='position:absolute;z-index:10;display:none'><a href='"+res.data.src+"' target='_blank'><image src='statics/login/prew.png'></image></a></span><span class='info' style='position:absolute;z-index:10;display:none' onclick='del(this)'><image src='statics/login/del.png'></image></span></div>");
            }
        });

        /*展位细部结构图及审核报告*/
        upload.render({
            elem: '#zwjgtBtn'
            , url: 'uploadPic'
            , multiple: true
            ,size: 1024 //限制文件大小，单位 KB
            , before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $("#zwjgtBtn").removeAttr("style");
                });
            }
            , done: function (res) {
            		var imgData = res.data.src
            		var zwjgtData = $('#zwjgt').val();
            		zwjgtData +=imgData+","
                	$("#zwjgt").val(zwjgtData);
            	  $('#zwjgtBtn').before("<div class='file-iteme' style='width: 92px;height: 92px;display:inline-block;margin-right: 10px;'><img src='"+ res.data.src +"' id='"+res.name+"' alt=''  style='margin-bottom: 5px;position:relative;' class='layui-upload-img uploader-list'>  <span class='info' style='position:absolute;z-index:10;display:none'><a href='"+res.data.src+"' target='_blank'><image src='statics/login/prew.png'></image></a></span><span class='info' style='position:absolute;z-index:10;display:none' onclick='del(this)'><image src='statics/login/del.png'></image></span></div>");
					
            }
        });
        /*出图工程师资质证书*/
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
                case "室内单层":
                    $("#sndc").show();
                    $("#snsc").hide();
                    $("#zwtz").attr("lay-verify","");
                    $("#zwjgt").attr("lay-verify","");
                    break;
                case "室内双层":
                	  $("#zwtz").attr("lay-verify","required");
                      $("#zwjgt").attr("lay-verify","required");
                    $("#snsc").show();
                  
                    break;
                case "室外钢木结构":
                	$("#zwtz").attr("lay-verify","required");
                    $("#zwjgt").attr("lay-verify","required");
                    $("#snsc").show();
                    break;
                case "室外简易结构":
                    $("#sndc").show();
                    $("#snsc").hide();
                    $("#zwtz").attr("lay-verify","");
                    $("#zwjgt").attr("lay-verify","");
                    $("#snsc input").val("");
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
        
    
      //获取展位信息
		var zhguid = cj.getCookie('selected_expo_id');
		$.ajax({
		    type: 'GET',
		    url: 'dj/findZgh',
		    cache: false,
		    data: { "zhguid": zhguid },
		    dataType: 'JSON',
		    success: function (d) {
		    	var city='<option value="" >请选择展馆号</option>';
		        var zgName = "";
		        var zgVal = "";                
		        for (var i = 0; i < d.length; i++) {
		        	zgName = d[i].GH;
		        	zgVal = d[i].id;
		            city += '<option value="' + zgName + '">' + zgName + '</option>';
				}
		        $("[name='ZGH']").html(city); 
		        form.render('select');
		    }
		});
		
		form.on('select(ZGH)', function(data){
			findZwh(data.value);  
		});
		
		var findZwh=function(zgh){
			$.ajax({
		        type: 'GET',
		        url: 'dj/findZwh',
		        cache: false,
		        data: { "ghbh": zgh },
		        dataType: 'JSON',
		        success: function (d) {
		        	var city='<option value="" >请选择展位号</option>';
		            var zgName = "";
		            var zgVal = "";                
		            for (var i = 0; i < d.length; i++) {
		            	zgName = d[i].ZWH;
		            	zgVal = d[i].GHBH;
		                city += '<option value="' + zgName + '">' + zgName + '</option>';
					}
		            $("[name='ZWH']").html(city); 
		            form.render('select');
		        }
		    });        	        	
		}
    });
</script>
</body>
</html>
