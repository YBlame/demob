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
               <table class="layui-table" lay-filter="test" id="test_table">
                    <colgroup>
                        <col width="100">
                        <col width="200">
                        <col width="200">
                        <col width="200">
                        <col width="200">
                        <col width="200">
                    </colgroup>
                        <thead>
                        <tr>
                         <th>  <input type="checkbox" name="checks" lay-skin="primary" lay-filter="allChoose" class="checks"></th>
                            <th>项目名称</th>
                            <th>项目描述</th>
                            <th>单价（元）</th>
                            <th>数量</th>
                            <th>金额（元）</th>
                        </tr>
                        </thead>
                        <tbody >
                        <tr >
                        <td>  <input type="checkbox" name="checks" lay-skin="primary" lay-filter="allChoose" class="checks"></td>
                            <td>
                                 <select name="XMMC_DATA" class="proNameSel" lay-filter="projectNameSel">
                                  
                                </select>
                            </td>
                            <td>
                               <select name="XMDES_DATA" class="proDescSel" lay-filter="projectDescSel">
                                   
                                </select>
                            </td>
                            <td>
                                <input type="text" name="FY" class="layui-input" readonly="readonly">
                            </td>
                            <td>
                                <input type="text" name="" class="layui-input">
                            </td>
                            <td>
                                   <input type="text" name="" class="layui-input" readonly="readonly">
                            </td>
                        </tr>
                        <tr class="addlists">
               
                         <td></td>
                          <td>施工管理费</td>
                           <td>按展位实际面积计算</td>
                            <td> <input type="text" name="" class="layui-input" readonly="readonly"></td>
                             <td> <input type="text" name="" class="layui-input" ></td>      
                             <td> <input type="text" name="" class="layui-input" readonly="readonly"></td>   
                        </tr>
                        <tr>
               
                         <td></td>
                          <td>施工证</td>
                           <td>一人一证</td>
                            <td> <input type="text" name="" class="layui-input" readonly="readonly"></td>
                             <td> <input type="text" name="" class="layui-input" ></td>      
                             <td> <input type="text" name="" class="layui-input" readonly="readonly"></td>   
                        </tr>
                        <tr>
               
                         <td></td>
                          <td>车证</td>
                           <td>辆/限2小时，超过时间按照50元/小时收取延时费。（未退回将扣除全部车证押金）</td>
                            <td> <input type="text" name="" class="layui-input" readonly="readonly"></td>
                             <td> <input type="text" name="" class="layui-input" ></td>      
                             <td> <input type="text" name="" class="layui-input" readonly="readonly"></td>   
                        </tr>
                        <tr>
               
                         <td></td>
                          <td>安全员袖章</td>
                           <td>  100㎡以下（含），1名安全员;
  101-500㎡（含），2名安全员;
  500㎡以上（含），3名安全员;
备注：安全员展会期间必须在展位，负责展位安全，监督施工人员安全作业，配合主场管理。</td>
                            <td> <input type="text" name="" class="layui-input" readonly="readonly"></td>
                             <td> <input type="text" name="" class="layui-input" ></td>      
                             <td> <input type="text" name="" class="layui-input" readonly="readonly"></td>   
                        </tr>
                        
                     <tr >
                     <td> </td>
                     <td>合计</td>
                     <td colspan=3></td>
                       <td>    <input type="text" name="" class="layui-input"></td>
                     </tr>
                     <tr >
                     <td> </td>
                     <td>滞纳金</td>
                     <td colspan=3></td>
                       <td>    <input type="text" name="" class="layui-input"></td>
                     </tr>
                       <tr >
                     <td> </td>
                     <td>施工押金</td>
                     <td colspan=3>
                       <input type="text" name="" class="layui-input">
                     </td>
                       <td>    <input type="text" name="" class="layui-input"></td>
                       
                     </tr>
                     <tr >
                     <td></td>
                     <td >费用总计</td>
                     <td  rowspan="2" >
                       <input type="text" name="" class="layui-input">
                        <input type="text" name="" class="layui-input">
                         
                     </td>
                        <td  rowspan="2" colspan=2>
             
                         <input type="text" name="" class="layui-input">
 <input type="text" name="" class="layui-input">
                  </td >
                 
                  <td>
                       <input type="text" name="" class="layui-input">
                     </td>
                     </tr>
                        </tbody>
                </table>
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
                        /* case "text"://文本类型
                            fromInput += "<div class=\"layui-form-item\"> <label class=\"layui-form-label\">" + result[i].zdmc + "</label> <div class=\"layui-input-block\"> <input type=\"text\" name=\"" + result[i].zdm + "\" lay-verify=\"required\" placeholder=\"请输入" + result[i].zdmc + "\" autocomplete=\"off\" class=\"layui-input\"> </div></div>";
                            break;
                        case "number"://文本类型
                            fromInput += "<div class=\"layui-form-item\"> <label class=\"layui-form-label\">" + result[i].zdmc + "</label> <div class=\"layui-input-block\"> <input type=\"number\" name=\"" + result[i].zdm + "\" lay-verify=\"required\" placeholder=\"请输入" + result[i].zdmc + "\" autocomplete=\"off\" class=\"layui-input\"> </div></div>";
                            break;
                        case "textarea"://文本域
                            fromInput += "<div class=\"layui-form-item layui-form-text\"> <label class=\"layui-form-label\">" + result[i].zdmc + "</label> <div class=\"layui-input-block\"> <textarea name=\"text\"  name=\"" + result[i].zdm + "\"  placeholder=\"请输入" + result[i].zdmc + "\" class=\"layui-textarea\"></textarea> </div> </div>"
                            break; */
                       /*  case "date":
                            fromInput += "< div class=\"layui-inline\"> <label class=\"layui-form-label\">" + result[i].zdmc + "</label> <div class=\"layui-input-inline\"> <input type=\"text\" name=\"" + result[i].zdm + "\" id=\"date\" lay-verify=\"date\" placeholder=\"yyyy-MM-dd\" autocomplete=\"off\" class=\"layui-input date\"> </div> </div>";
                            break;
                        case "datetime":
                            fromInput += "<div class=\"layui-inline\"> <label class=\"layui-form-label\">" + result[i].zdmc + "</label> <div class=\"layui-input-inline\"> <input type=\"text\" name=\"" + result[i].zdm + "\" id=\"date\" lay-verify=\"date\" placeholder=\"yyyy-MM-dd\" autocomplete=\"off\" class=\"layui-input date\"> </div> </div>";
                            break; */
                    case "pic":
                    	var isform = '';
                    	if(result[i].isform=='1'){
                    		isform = "lay-verify=\"required\"  lay-reqtext=\""+ result[i].zdmc +"不能为空\"";
                    	}
                        fromInput += "<div class=\"layui-form-item\"> <div class=\"layui-upload\"> <blockquote class=\"layui-elem-quote layui-quote-nm\" style=\"margin-top: 10px;\"><font color=red>*</font>" + result[i].zdmc + "： <div class=\"layui-upload-list\" id=\"div\"><input id='"+ result[i].zdm +"' name='"+ result[i].zdm +"' style='display: none' "+isform+"  /><button type=\"button\" class=\"layui-btn append\" style=\"display:block;margin:0 auto\" lay-filter=\""+ result[i].zdm +"\" id=\"" + result[i].zdm + "Btn\"> " + result[i].zdmc + "</button></div> </blockquote> </div><p class=\"details-component-line-margin\" style=\"margin-bottom: 0px;\">注意："+result[i].beizhu+"</p> </div>";
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
