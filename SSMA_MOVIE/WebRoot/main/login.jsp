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
        <link rel="stylesheet" href="/SSMA_MOVIE/css/reset.css">
        <link rel="stylesheet" href="/SSMA_MOVIE/css/supersized.css">
        <link rel="stylesheet" href="/SSMA_MOVIE/css/style2.css">

        <script src="/SSMA_MOVIE/js/jquery.min.js"></script>
        <script src="/SSMA_MOVIE/js/supersized.3.2.7.min.js"></script>
        <script src="/SSMA_MOVIE/js/supersized-init.js"></script>
        <script src="/SSMA_MOVIE/js/scripts.js"></script>

        <script type="text/javascript">
        	$(function(){
        		//1.验证邮箱
	    		var testEmail=false;
	    		$("input[name='member_Email']").bind('input propertychange', function() {
	    			testEmail=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test($(this).val());
	    		});
	    		//4.验证密码
	    		var testPwd=false;
	    		$("input[name='member_Pwd']").bind('input propertychange', function() {
 					 testPwd =/^(\w){6,15}$/.test($(this).val());
	    		});
	    		//3.点击按钮验证所有条件
	    		$("#btn").click(function(){
	    			var login=$("input[type='checkbox']").is(':checked');
	    			if(testEmail&&testPwd){
	    				$.ajax({
	    					url:"/SSMA_MOVIE/querySingleMemberByEmail?member_Email="+$("input[name='member_Email']").val(),
	    					success:function(data){
	    						if(data.member_Pwd==$("input[name='member_Pwd']").val()){
	    							//4.如果勾选免密登录则存储邮箱到cookie保存10分钟
	    							saveMember(data.member_Email,login);
		    						if(confirm("登陆成功!")){
		    							location.href="index.jsp";
		    						}
	    						}else{
	    							alert("账号或者密码有误!")
	    						}
	    					}
	    				});
	    			}else{
	    				alert("账号或者密码格式有误!")
	    			}
	    		});
        	})
      
        	function saveMember(member_Email,flag){
        		$.ajax({
        			url:"/SSMA_MOVIE/saveMember?member_Email="+member_Email+"&flag="+flag,
        		});
        	}
        </script>
    </head>
    <body>
        <div class="page-container">
            <h1>My Movie Login,Welcome!</h1>
                <p>邮箱:<input type="text" name="member_Email" class="username" placeholder="Email"></p>
                <p>密码:<input type="password" name="member_Pwd" class="password" placeholder="Password"></p>
                <p>记住账号:&nbsp;&nbsp;&nbsp;<input type="checkbox" id="checkbox-id"  style="width: 24px;height: 15px;"></p>
               	<p><button id="btn">登录</button></p>
                <div class="error"><span>+</span></div>
        </div>
    </body>
</html>


