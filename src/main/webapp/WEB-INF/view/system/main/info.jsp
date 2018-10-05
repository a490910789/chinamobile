<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>登录</title>
<link rel="stylesheet" href="${ctx }/resources/css/pintuer.css">
<link rel="stylesheet" href="${ctx }/resources/css/admin.css">
<script src="${ctx }/resources/zTree/js/jquery-1.4.4.min.js"></script>
<script src="js/pintuer.js"></script>
</head>
<body>
	<div class="bg"></div>
	<div class="container">
		<div class="line bouncein">
			<div class="xs6 xm4 xs3-move xm4-move">
				<div style="height:150px;"></div>
				<div class="media media-y margin-big-bottom"></div>
				<form action="index.html" method="post">
					<div class="panel loginbox">
						<div class="text-center margin-big padding-big-top">
							<h1>欢迎使用中国移动计费系统</h1>
						</div>
						<div class="panel-body"
							style="padding:30px; padding-bottom:10px; padding-top:10px;">
							您好：${operator.name }<br /> 登陆时间:<span id="msg"></span>
							<script>
						       var now=new Date();
								//1.获取年
								var year = now.getFullYear();
								//2.获取月(0-11的数字，0代表1月，1代表2月....11代表12月)
								var month = now.getMonth() + 1;
								//3.获取日
								var day = now.getDate();

								//4.获取小时
								var hour = now.getHours();
								//5.获取分钟
								var minute = now.getMinutes();
								//6.获取秒数
								var seconds = now.getSeconds();
								$("#msg").html(year+"年"+month+"月"+day+"日"+hour+":"+minute+":"+seconds);
							</script>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>