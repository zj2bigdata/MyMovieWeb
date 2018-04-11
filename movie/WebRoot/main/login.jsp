<%@ page  pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE html>
<html lang="en" class="no-js">

    <head>
        <meta charset="utf-8">
        <title>登录页面</title>
        <link rel='stylesheet' href='http://fonts.googleapis.com/css?family=PT+Sans:400,700'>
        <link rel="stylesheet" href="/movie/css/reset.css">
        <link rel="stylesheet" href="/movie/css/supersized.css">
        <link rel="stylesheet" href="/movie/css/style2.css">

        <script src="/movie/js/jquery.min.js"></script>
        <script src="/movie/js/supersized.3.2.7.min.js"></script>
        <script src="/movie/js/supersized-init.js"></script>
        <script src="/movie/js/scripts.js"></script>

        <script type="text/javascript">
        	$(function(){
        		$("#btn").click(function(){
        				if($('#checkbox-id').prop('checked')){
	        				$.ajax({
	        					url:"/movie/saveCookie.movie",
	        					type:"post",
	        					data:"email="+$("input[name='email']").val(),
	        				});
        				}
        				$.ajax({
        					url:"/movie/login.movie",
        					type: "post",
        					data:"member_email="+$("input[name='email']").val(),
        					success:function(data){
        						var json_member=$.parseJSON(data);
        						if(json_member.member_pwd==$("input[name='password']").val()){
        							saveCount(json_member.member_email,json_member.member_pwd,json_member.member_id);
        						}else{
        							if(confirm("账号或者密码错误!")){
        								location.reload();
        							}
        						}
        					},
        					error:function(){
        					if(confirm("服务器异常!")){
        								location.href="/movie/main/index.jsp";
        							}
        						
        					}
        				});
        		});
        		
        	})
        	
        	function saveCount(email,pwd,id){
        		$.ajax({
        			url:"/movie/saveCount.movie",
        			type:"post",
        			data:"email="+email+"&pwd="+pwd+"&id="+id,
        			success:function(){
        				location.href="/movie/main/index.jsp?email="+email;
        			}
        			
        		})
        	}
        </script>

    </head>

    <body>

        <div class="page-container">
            <h1>My Movie Login,Welcome!</h1>
                <p>邮箱:<input type="text" name="email" class="username" placeholder="Email"></p>
                <p>密码:<input type="password" name="password" class="password" placeholder="Password"></p>
                <p>记住账号:&nbsp;&nbsp;&nbsp;<input type="checkbox" id="checkbox-id"  style="width: 24px;height: 15px;"></p>
               	<p><button id="btn">登录</button></p>
                <div class="error"><span>+</span></div>
        </div>

     

    </body>

</html>


