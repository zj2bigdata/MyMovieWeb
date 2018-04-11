<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'shopAdd.jsp' starting page</title>
    <link rel="stylesheet" type="text/css" href="/moviemgr/style/btn.css">
      <script type="text/javascript" src="/moviemgr/js/jquery.min.js"></script>
      <script type="text/javascript">
      		$(function(){
      		//加载影片名
      			$.ajax({
      				url:"/moviemgr/find.movie",
      				type:"post",
      				success:function(data){
      					var movies=$.parseJSON(data);
      					for(var i=0;i<movies.length;i++){
      						$("#sel").append("<option value='"+movies[i].movie_Id+"'>"+movies[i].movie_Name+"</option>");
      					}
      				}
      			});
  			})
      </script>
  </head>
  
  <body>
  		<div class="div1"><img src="/moviemgr/images/login_logo.jpg"/></div>
  		<div style="position: absolute;left: 8px;top:300px;">
  		<form action="/moviemgr/addPlay.play" method="post">
	  		<fieldset style="width: 964px">
	  			<legend>场次管理</legend>
	  			<p>选择影片:<select id="sel" name="play_Movie">
	  								  </select></p>
	  			<p>添加场次:<input type="text" name="play_Time" value="2018-01-20 12:04:33"></p>
	  			<p>票价:<input type="text" name="play_Price" >元</p>
	  			<p><input type="submit" value="提交"/></p>
	  		</fieldset>
	  	</form>
	  	<a href="playJsp/playShow.jsp"><button id="btn1" class="btn">返回</button></a>
  		</div>
  </body>
</html>

