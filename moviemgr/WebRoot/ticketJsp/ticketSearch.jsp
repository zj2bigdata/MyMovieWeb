<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>票务管理</title>
    <link rel="stylesheet" type="text/css" href="/moviemgr/style/btn.css">

    <script type="text/javascript" src="/moviemgr/js/jquery.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#btn").click(function(){
				var ticket_Id=$("#TICKET_ID").val();
				var pra={};
				pra.ticket_Id=ticket_Id;
				$.ajax({
					url:"/moviemgr/findBt.ticket",
					type:"post",
					data: pra,
					success: function(data){
											showData(data);
			      						},
			      	error:	function(){
			      							alert("查询失败!");
			      	}
				});
			});
			
			function showData(data){
			var ticket =$.parseJSON(data);
				$("#TICKET_DATE").val(ticket.ticket_Date);
				$("#TICKET_PRICE").val(ticket.ticket_Price);
				$("#MEMBER_NAME").val(ticket.member_Name);
				$("#MEMBER_EMAIL").val(ticket.member_Email);
				$("#MOVIE_NAME").val(ticket.movie_Name);
				$("#PLAY_TIME").val(ticket.play_Time);
				$("#TICKET_SEAT").val(ticket.ticket_Seat);
				$("#TICKET_FLAG").val(ticket.ticket_Flag);
			}
			
		})
	</script>
  </head>
  
  <body>
  <div class="div1"><img src="/moviemgr/images/login_logo.jpg"/></div>
    <fieldset style="color:#9f9f9f;">
    	<legend>票务管理</legend>
    	<p>订票号:<input type="text" id="TICKET_ID"/></p><button id="btn" class="btn">搜索</button>
    	<a href="adminJsp/adminManager.jsp"><button id="btn1" class="btn">返回</button></a>
		<table border="1">
			<tr><td>订票时间</td><td><input type="text" id="TICKET_DATE" readonly="readonly"/></td><td>实际票价</td><td><input type="text" id="TICKET_PRICE" readonly="readonly"/></td></tr>
			<tr><td>用户姓名</td><td><input type="text" id="MEMBER_NAME" readonly="readonly"/></td><td>用户邮箱</td><td><input type="text" id="MEMBER_EMAIL" readonly="readonly"/></td></tr>
			<tr><td>影片名称</td><td><input type="text" id="MOVIE_NAME" readonly="readonly"/></td><td>场次时间</td><td><input type="text" id="PLAY_TIME" readonly="readonly"/></td></tr>
			<tr><td>已订票</td><td><input type="text" id="TICKET_SEAT" readonly="readonly"/></td><td>已退票</td><td><input type="text" id="TICKET_FLAG" readonly="readonly"/></td></tr>
		</table>
    </fieldset>
  </body>
</html>
