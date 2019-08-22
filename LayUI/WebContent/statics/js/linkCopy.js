function linkCopy(guid) {
	// 获取导航
	var protocol = document.location.protocol;
	var host = window.location.host;
	var link = protocol + '//' + host + '/LayUI/login?guid=' + guid;
	$("#copyhref").val(link);
	var e = document.getElementById("copyhref");// 对象是contents
	e.select(); // 选择对象
	var boo = document.execCommand("Copy", "false", null); // 执行浏览器复制命令
	$("#copymsg").remove();
	if (boo) {
		layer.msg("复制成功");
		//$("#share-link-skip").after("<lable style='color:red;position:absolute;font-size:12px;' id='copymsg'>复制成功</lable>");
	} else {
		layer.msg("复制失败");
		//$("#share-link-skip").after("<lable style='color:red;position:absolute;font-size:12px;' id='copymsg'>复制失败</lable>");
	}
	setTimeout(' $("#copymsg").remove();', 2000);
}

