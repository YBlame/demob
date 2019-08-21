$(document).on("mouseenter mouseleave", ".file-iteme", function(event) {
			if (event.type === "mouseenter") {
				//鼠标悬浮			
				var top=$(this).offset().top;
				var left=$(this).offset().left;
				$(this).children().first().next().css("top",top-23).css("left",left+10).show();
				$(this).children().first().next().next().css("top",top-23).css("left",left+40).show();
				$(this).css("background-color","rgba(0,0,0,0.5)");
				$(this).children().first().css("opacity","0.5"); 		
			}
			if (event.type === "mouseleave") {
				//鼠标离开
				$(this).children().first().next().hide();
				$(this).children().first().next().next().hide();
			$(this).css("background-color",""); 
			$(this).children().first().css("opacity","1"); 
			}
		});
		
function del(event){
	var img  = $(event).parent().find("img").attr("src");//拿到删除的图片路径
	var input = $(event).parent().parent().find("input").attr("id");//拿到全局input
	var btn = $(event).parent().parent().find("button").attr("id");
	var inputVal  = $("#"+input+"").val();
	var imgDel = img+",",
	inputVal = inputVal.replace(imgDel, '');
	$("#"+input+"").val(inputVal)
	inputVal =$("#"+input+"").val();
	if(inputVal == "" || inputVal == null || inputVal == undefined){
		$("#"+btn+"").css({margin:"auto",display:"block"}) 
	}
	$(event).parent().remove();		
	
}