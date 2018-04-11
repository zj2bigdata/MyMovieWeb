<%@ page pageEncoding="utf-8"%>
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
      				  $("#btn").click(function(){
      				   	var qx=[];
			            $.each($('input:checkbox:checked'),function(){
			                    qx.push($(this).val());
			           	 });
			           	 var qxs=qx.join("|");
			           	var flag=false;
      					var param={};
    					param. admin_Name=$("#admin_Name").val();
    					param.admin_Pwd=$("#admin_Pwd").val();
    					param.admin_Privilege=qxs;
	      					$.ajax({
	      						url:"find.admin",
	      						type:"post",
	      						success:function(data){
	      							var json_admins=$.parseJSON(data);
	      							for(var i=0;i<json_admins.length;i++){
	      								if(json_admins[i].admin_Name==$("#admin_Name").val()){
	      									flag=true;
	      									break;
	      								}
	      							}
	      							if(!flag){
	      								addData(param);
	      							}else{
	      								if(confirm("抱歉,该管理员已存在!")){
	      									location.reload();
	      								}
	      							}
	      						},
	      						error:function(){
	      							if(confirm("服务器连接失败!请检查网络~")){
	      								location=" ";
	      							}
	      						}
	      					});
		       		 });
      		})
      		
      		function addData(param){
      			console.log(param.admin_Privilege);
      				$.ajax({
		      					url:"add.admin",
		      					type:"post",
		      					data:param,
		      					success: function(data){
		      						alert($.parseJSON(data).result?"新增成功!":"新增失败!")
		      							location.href="adminJsp/adminShow.jsp"; 
		      					},
		      					error:	function(){
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
  			<legend>管理员添加</legend>
  			<p>管理账号:<input type="text" id="admin_Name"></p>
  			<p>管理密码:<input type="text" id="admin_Pwd"></p>
  			<p>权&nbsp;&nbsp;限:&nbsp;影片管理:<input type="checkbox" value="1" />场次管理:<input type="checkbox" value="2" />
  			用户管理:<input type="checkbox" value="3"/>票务管理:<input type="checkbox" value="4"/>
  			管理员管理:<input type="checkbox" value="5"/></p>
  			<p><button id="btn"  class="btn">提交</button></p>
  			<a href="adminJsp/adminShow.jsp"><button id="btn1" class="btn">返回</button></a>
  		</fieldset>
  </body>
</html>
