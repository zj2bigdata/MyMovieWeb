<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>管理员管理界面</title>
    <link rel="stylesheet" type="text/css" href="/moviemgr/style/btn.css">
    <script type="text/javascript" src="/moviemgr/js/jquery.min.js"></script>
    <style type="text/css">
		a{
			text-decoration: none;
		}
    	a:LINK{ color:#D6D6D6;}
    	a:VISITED{ color:#CDAA7D;}
    	a:HOVER{ color:#CAE1FF;}
    	a:ACTIVE{ color:#8B8B83;}
    	
    	div.div2{
    		font-size: 30px;
    	}
    </style>
    <script type="text/javascript">
    	$(function(){
			var pra={};
    		pra.admin_Id=${sessionScope.qx};
    			$.ajax({
    				url:"toUpdate.admin",
    				type:"post",
    				data:pra,
    				success:function(data){
    					var ad=$.parseJSON(data);
    					var arr=ad.admin_Privilege.split('|');
    					for(var i=0;i<arr.length;i++){
    						$("#uls li").eq(arr[i]-1).attr({style:"display: "});
    					}
    				},
    				error:function(){}
    			});
    			$("#btn").click(function(){
    				$.ajax({
    					url:"layout.admin",
    					type:"get",
    					success:function(){
    						location.href=" ";
    					},
    					error:function(){
    							if(confirm("服务器连接失败!请检查网络~")){
	      								location=" ";
	      							}
    					}
    				});
    			
    			});
    	
    	})
    </script>
  </head>
  
  <body>
	  <div class="div1"><img src="/moviemgr/images/login_logo.jpg"/></div>
	  <div class="div2"> 
		  <fieldset>
		  	<legend>后台管理操作</legend>
		  		<ul id="uls">
					  <li style="display:none"><a href="movieJsp/movieShow.jsp">影片管理</a></li>
					   <li style="display:none"><a href="playJsp/playShow.jsp">场次管理</a></li>
					   <li style="display:none"><a href="memberJsp/memberShow.jsp">用户管理</a></li>
					   <li style="display:none"><a href="ticketJsp/ticketSearch.jsp">票务管理</a></li>
					   <li style="display:none"><a href="adminJsp/adminShow.jsp">管理员管理</a></li>
					   <li><button id="btn" class="btn">退出</button></li>
		   		</ul>
		  </fieldset>
	   </div>
  </body>
</html>
