<%@ page pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
      <link rel="stylesheet" type="text/css" href="/moviemgr/style/btn.css">
		<title>文件上传和下载</title>
	</head>
	
	<body>
		<div class="div1"><img src="/moviemgr/images/login_logo.jpg"/></div>
		<!-- 固定写法:method="post" enctype="multipart/form-data" -->
		<form action="/moviemgr/saveImg.movie" method="post" enctype="multipart/form-data">
			<fieldset>
				<legend>海报需要单独上传</legend>
					<!-- 固定写法:type="file" name="自定义" -->
				<input type="file" name="file"/>
				<input type="submit" value="上传"/>
			</fieldset>
		</form>
	</body>
</html>