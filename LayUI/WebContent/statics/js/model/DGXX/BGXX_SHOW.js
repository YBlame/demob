function findBgxxInfo(){
	var zhxx = cj.getCookie('selected_expo_id');
	var bgGuid = $("#bgGuid").val();
	$.ajax({
		type: "POST",
		url: "bg/findBgxxInfo",
		data: {
			"bgGuid": bgGuid,
			"zhxxGuid": zhxx
		},
		success: function (data) {
			if (data != null) {
				shzt = data[0].ZT;
				$.each(data[0], function (n, v) {
					$('#' + n + '').html(v);
					$('#' + n + '').val(v);
					if (n === 'ZGH') {
						$("option[value=" + v + "]").attr("selected", true);
						form.render('select');
						findZwh(v);
					}
					if (n == 'ZWH') {
						$("option[value=" + v + "]").attr("selected", true);
					}
					if (n == 'ZTJG') {
						$('[name=ztjg][value=' + v + ']').prop("checked", true);
						if (v.trim() == '室外钢木结构' || v.trim() == "室内双层") {
							$("#zwtz").attr("lay-verify", "required");
							$("#zwtz").attr("lay-verify", "required");
							$("#snsc").show();
						}
					}
					
					
					
					
					if (n.indexOf("_ZT")!=-1) {
						if (v == '通过') {
							var btn = n.substring(0,n.length-3);
							btn = btn.toLocaleLowerCase();
							$("#"+btn+"Btn").hide();
							$("#"+btn+"Btn").prevAll().removeClass("file-iteme")
						}else{
							if(btn="ZWTZ"){
								$("#zwtzBtn").prevAll().attr("class","file-iteme")
								$("#zwjgtBtn").prevAll().attr("class","file-iteme")
								$("#gcszzzsBtn").prevAll().attr("class","file-iteme")
								
							}
						}
					}
					if (v.indexOf("/kh/")!=-1) {
						if (v != "") {
							v = v.substring(0,v.length-1);
							var picture = v.split(',');
							var btn = n.toLowerCase();
							if (picture.length >= 1) {
								for (var i = 0; i < picture.length; i++) {
									$("#"+ btn+ "Btn").before("<div class='file-iteme' style='width: 92px;height: 92px;display:inline-block;margin-right: 10px;'><img src='" + picture[i] + "' id='' alt=''  style='margin-bottom: 5px;position:relative;' class='layui-upload-img uploader-list'>  <span class='info' style='position:absolute;z-index:10;display:none'><a href='" + picture[i] + "' target='_blank'><image src='statics/login/prew.png'></image></a></span></div>")
								}
							}
							$("#"+ btn+ "Btn").removeAttr("style");
						}
					}

					form.render();
				});
			}
		}
	});
}


