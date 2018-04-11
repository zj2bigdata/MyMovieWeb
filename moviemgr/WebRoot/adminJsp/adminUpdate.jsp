<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'shopUpdate.jsp' starting page</title>
    <link rel="stylesheet" type="text/css" href="/moviemgr/style/btn.css">
    <script type="text/javascript" src="/moviemgr/js/jquery.min.js"></script>
    <script>
    		$(function(){
	    		var pra={};
	    		pra.admin_Id=${param.admin_Id};
	    			$.ajax({
	    				url:"toUpdate.admin",
	    				type:"post",
	    				data:pra,
	    				success:function(data){
	    					var ad=$.parseJSON(data);
	    					var arr=ad.admin_Privilege.split('|');
	    					for(var i=0;i<arr.length;i++){
	    						$('input[type="checkbox"]').eq(arr[i]-1).prop('checked','true');
	    					}
	    				},
	    				error:function(){}
	    			});
	    			$("#btn").click(function(){
	    			 	var qx=[];
			            $.each($('input:checkbox:checked'),function(){
			                    qx.push($(this).val());
			           	 });
			           	 var qxs=qx.join("|");
	    				var para={};
	    				para.admin_Id=${param.admin_Id};
	   					para.admin_Name=$("#admin_Name").val();
	   					para.admin_Pwd=$("#admin_Pwd").val();
	 					para.admin_Privilege=qxs;
	    				$.ajax({
			      					url:"update.admin",
			      					type:"post",
			      					data:para,
			      					success: function(data){
											alert($.parseJSON(data).result?"修改成功!":"修改失败!")
			      							location.href="adminJsp/adminShow.jsp";
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
	    			pr.admin_Id=${param.admin_Id};
	    			console.log(pr);
    			$.ajax({
			      					url:"toUpdate.admin",
			      					type:"post",
			      					data:pr,
			      					success: function(data){
			      						var json=$.parseJSON(data);
			      						console.log(data);
			      						$("#admin_Id").val(json.admin_Id);
			      						$("#admin_Name").val(json.admin_Name);
			      						$("#admin_Pwd").val(json.admin_Pwd);
			      						$("#admin_Privilege").val(json.admin_Privilege);
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
   			<legend>管理员修改</legend>
   			<p>管理编号:<input type="text" id=admin_Id  readonly="readonly" ></p>
  			<p>管理账户:<input type="text" id="admin_Name" ></p>
  			<p>管理密码:<input type="text" id="admin_Pwd" ></p>
  			<p>权&nbsp;&nbsp;限:&nbsp;影片管理:<input type="checkbox" value="1" />场次管理:<input type="checkbox" value="2" />
  			用户管理:<input type="checkbox" value="3"/>票务管理:<input type="checkbox" value="4"/>
  			管理员管理:<input type="checkbox" value="5"/></p>
  			<p><button id="btn" class="btn">提交</button>
  			<a href="adminJsp/adminShow.jsp"><button id="btn1" class="btn">返回</button></a>
  			</p>
  			
   		</fieldset>
  </body>
</html>
