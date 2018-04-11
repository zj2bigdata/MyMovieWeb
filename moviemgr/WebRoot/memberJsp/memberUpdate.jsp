<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'memberUpdate.jsp' starting page</title>
     <link rel="stylesheet" type="text/css" href="/moviemgr/style/btn.css">
     <script type="text/javascript" src="/moviemgr/js/jquery.min.js"></script>
    <script>
    		$(function(){
	    			$("#btn").click(function(){
	    				var para={};
	    				para.member_Id=${param.member_Id};
	   					para.member_Email=$("#member_Email").val();
	   					para.member_Pwd=$("#member_Pwd").val();
	 					para.member_Name=$("#member_Name").val();
	 					para.member_Phone=$("#member_Phone").val();
	 					para.member_Money=$("#member_Money").val();
	 					para.member_Gender=$("#member_Gender").val();
	 					para.member_Photo=$("#member_Photo").val();
	    				$.ajax({
			      					url:"update.member",
			      					type:"post",
			      					data:para,
			      					success: function(data){
											alert($.parseJSON(data).result?"修改成功!":"修改失败!")
			      							location.href="memberJsp/memberShow.jsp";
			      						},
			      					error:	function(){
			      								if(confirm("服务器连接失败!请检查网络~")){
	      											location=" ";
	      										}
			      						}
			      				});	
	    			
	    		});	
    		})
    		window.onload=function(){
    				var pr={};
	    			pr.member_Id=${param.member_Id};
    			$.ajax({
			      					url:"toUpdate.member",
			      					type:"post",
			      					data:pr,
			      					success: function(data){
			      						var json=$.parseJSON(data);
			      						$("#member_Id").val(json.member_Id);
			      						$("#member_Email").val(json.member_Email);
			      						$("#member_Pwd").val(json.member_Pwd);
			      						$("#member_Name").val(json.member_Name);
			      						$("#member_Phone").val(json.member_Phone);
			      						$("#member_Money").val(json.member_Money);
			      						$("#member_Gender").val(json.member_Gender);
			      						$("#member_Photo").val(json.member_Photo);
			      						},
			      					error:function(){
			      								if(confirm("服务器连接失败!请检查网络~")){
	      											location=" ";
	      									}
			      						}
			      				});
    		}
    </script>
  </head>
  
  <body>
  		<div class="div1"><img src="/moviemgr/images/login_logo.jpg"/></div>
  		<fieldset>
  			<legend>用户修改</legend>
   			<p>用户ID:<input type="text" id="member_Id"></p>
	    	<p>用户邮箱:<input type="text" id="member_Email"></p>
	  		<p>用户密码:<input type="text" id="member_Pwd"></p>
	  		<p>用户姓名:<input type="text" id="member_Name"></p>
	  		<p>用户电话:<input type="text" id="member_Phone"></p>
	  		<p>用户金额:<input type="text" id="member_Money"></p>
	  		<p>用户性别:<input type="text" id="member_Gender"></p>
	  		<p>用户头像地址:<input type="text" id="member_Photo"></p>
	  		<p><button id="btn" class="btn">提交</button>
	  		<a href="memberJsp/memberShow.jsp"><button id="btn" class="btn">返回</button></a>
	  		</p>
   		</fieldset>
  </body>
</html>
