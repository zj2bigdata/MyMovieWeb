<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>用户明细</title>
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
				console.log(1);
				$.ajax({
							url : "/moviemgr/find.member",
							type : "post",
							success : function(data){
								console.log(data);
								showData(data);
								
							},
							error : function(){
	      								if(confirm("服务器连接失败!请检查网络~")){
     											location=" ";
     										}
							}
						});
				
			})	
			
			function showData(members){
				var json_members=JSON.parse(members);
				var html=[ ];
				html.push('<table class="gridtable">');
				html.push('<tr><th>用户ID</th><th>用户邮箱</th><th>用户密码</th><th>用户姓名</th><th>用户电话</th><th>用户金额</th><th>用户性别</th><th>用户头像地址</th><th>修改</th><th>删除</th></tr>')
				for(var i=0;i<json_members.length;i++){
					html.push('<tr>'+'<td>'+json_members[i].member_Id+'</td>');
					html.push('<td>'+json_members[i].member_Email+'</td>');
					html.push('<td>'+json_members[i].member_Pwd+'</td>');
					html.push('<td>'+json_members[i].member_Name+'</td>');
					html.push('<td>'+json_members[i].member_Phone+'</td>');
					html.push('<td>'+json_members[i].member_Money+'</td>');
					html.push('<td>'+json_members[i].member_Gender+'</td>');
					html.push('<td>'+json_members[i].member_Photo+'</td>');
					html.push('<td><a href="memberUpdate.jsp?member_Id='+json_members[i].member_Id+'">修改</a></td>');
					html.push('<td><a href="javascript:void(0)" onclick="sel('+json_members[i].member_Id+')">删除</a></td></tr>');
				}
				html.push('</table>');
				var js=html.join(' ');
				document.getElementById("idv").innerHTML=js;
			}
			function sel(admin_Id){
					if(confirm("确认?")){
						var member={};
						member.member_Id=member_Id;
						$.ajax({
								url:"/moviemgr/delete.member",
								type:"post",
								data:member,
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
			<a href="memberAdd.jsp"><button id="btn" class="btn">增加</button></a>
			<a href="../adminJsp/adminManager.jsp"><button id="btn" class="btn">返回</button></a>
         	<div id="idv"></div>
	</body>
</html>