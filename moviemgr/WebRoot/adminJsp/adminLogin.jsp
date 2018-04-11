<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>管理员登录页面</title>
	<link rel="stylesheet" type="text/css" href="/moviemgr/style/btn.css">
    <script type="text/javascript" src="/moviemgr/js/jquery.min.js"></script>
    <script type="text/javascript">
    	$(function(){
    	 	var img = document.getElementById("img");
			refreshCode(img);
    		$("#btn").click(function(){
    			$.ajax({
    				url : "/moviemgr/test.admin",
							type : "post",
							success : function(data){
								var json_test=$.parseJSON(data);
								if(json_test.captcha==$("#ck").val()){
									check();
								}else{
									confirm("验证码错误!");
								}
							},
							error : function(){
									if(confirm("服务器连接失败!请检查网络~")){
	      								location=" ";
	      							}
							}
    			});
    		});
    		
    		
    	})
    	function refreshCode(img)
    		{
    			var t = (new Date()).getTime();
				var code = "/moviemgr/captcha?k=" + t;
				img.src = code;
    		}
    		function check(){
    			$.ajax({
    				url : "/moviemgr/find.admin",
    				type:"post",
    				success: function(data){
    							var json=$.parseJSON(data);
								var flag=false;
								var qx="";
								for(var i=0;i<json.length;i++){
									if($("#admin_Name").val()==json[i].admin_Name&&$("#admin_Pwd").val()==json[i].admin_Pwd){
										flag=true;
										qx=json[i].admin_Id;
									}
								}
								if(flag){
									var user={};
									user.flag=flag;
									user.qx=qx;
									toFilter(user);					
								}else{
									if(confirm("密码或账号错误!请重新登录")){
										location.reload();
									}else{
										location.href=" ";
									}
								}
    				},
    				error:function(){
    					if(confirm("服务器连接失败!请检查网络~")){
	      								location=" ";
	      							}
    				}
    			});
    		}
    			function toFilter(user){
    			$.ajax({
    				url: "/moviemgr/filter.admin",
    				type:"post",
    				data:user,
    				success:function(data){
    					var json=$.parseJSON(data);
    					if(json.setHs){
    						location.href="adminJsp/adminManager.jsp";
    					}
    				},
    				error:function(){
    					if(confirm("抱歉暂未连接到服务器,请检查网络!")){
    						location.href=" ";
    					}
    				}
    			});
    		}
    </script>
  </head>
  <body>
  		<div class="div1"><img src="/moviemgr/images/login_logo.jpg"/></div>
  		<div class="div2">
  			<fieldset>
  				<legend>管理员登录界面</legend>
  					<p>用户名:&nbsp;<input type="text" id="admin_Name"/></p>
    				<p>密&nbsp;&nbsp;&nbsp;码:&nbsp;<input type="password" id="admin_Pwd"/></p>
    				<p>验证码:&nbsp;<input type="text" id="ck"/>
    						<img id="img" title="点击刷新" width="54px" height="21px" style="vertical-align:middle; cursor:pointer;" onclick="refreshCode(this)"/>
    				</p>
    				<p><button id="btn" style="border-radius: 15px" class="btn">登录</button></p>
  			</fieldset>
  		</div>
  		
  </body>
</html>
