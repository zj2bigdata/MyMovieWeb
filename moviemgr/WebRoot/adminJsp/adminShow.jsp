<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>管理员明细</title>
		  <link type="text/css" rel="stylesheet" href="/moviemgr/style/table.css" />
		  <link rel="stylesheet" type="text/css" href="/moviemgr/style/btn.css">
		  <style type="text/css">
			    a{
					text-decoration: none;
				}
		    	a:LINK{ color:#D6D6D6;}
		    	a:VISITED{ color:#CDAA7D;}
		    	a:HOVER{ color:#CAE1FF;}
		    	a:ACTIVE{ color:#8B8B83;}
		  </style>
		  <script type="text/javascript" src="/moviemgr/js/jquery.min.js"></script>
		<script type="text/javascript">
			$(function(){
				
				$.ajax({
							url : "/moviemgr/find.admin",
							type : "post",
							success : function(data){
								showData(data);
							},
							error : function(){
								if(confirm("服务器连接失败!请检查网络~")){
	      								location="adminManager.jsp";
	      							}
							}
						});
				
			})	
			
			function showData(admins){
				var json_admins=JSON.parse(admins);
				var html=[ ];
				html.push('<table class="gridtable">');
				html.push('<tr><th>管理编号</th><th>管理账号</th><th>管理密码</th><th>管理权限</th><th>修改</th><th>删除</th></tr>')
				for(var i=0;i<json_admins.length;i++){
					html.push('<tr>'+'<td>'+json_admins[i].admin_Id+'</td>');
					html.push('<td>'+json_admins[i].admin_Name+'</td>');
					html.push('<td>'+json_admins[i].admin_Pwd+'</td>');
					html.push('<td>'+json_admins[i].admin_Privilege+'</td>');
					html.push('<td><a href="adminUpdate.jsp?admin_Id='+json_admins[i].admin_Id+'">修改</a></td>');
					html.push('<td><a href="javascript:void(0)" onclick="sel('+json_admins[i].admin_Id+')">删除</a></td></tr>');
				}
				html.push('</table>');
				var js=html.join(' ');
				document.getElementById("idv").innerHTML=js;
			}
			function sel(admin_Id){
					if(confirm("确认?")){
						var admin={};
						admin.admin_Id=admin_Id;
						$.ajax({
								url:"/moviemgr/delete.admin",
								type:"post",
								data:admin,
								success:function(data){
										alert($.parseJSON(data).result?"删除成功!":"删除失败!")
				      					location.reload();
								},
								error:function(){
										if(confirm("服务器连接失败!请检查网络~")){
	      										location=" ";
	      									}
								}
						});					
					}	
			}
		</script>
	</head>
	<body>
	 		<div class="div1"><img src="/moviemgr/images/login_logo.jpg"/></div>
			<a href="adminAdd.jsp"><button id="btn" class="btn">增加</button></a>
			<a href="adminManager.jsp"><button id="btn1" class="btn">返回</button></a>
         	<div id="idv"></div>
	</body>
</html>