<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
		<head>
		<title>注册页面</title>
		<meta charset="utf-8" />
		<link href="/SSMA_MOVIE/css/style.css" rel="stylesheet" type="text/css" media="all"/>
		<script type="text/javascript" src="/SSMA_MOVIE/js/jquery-1.9.0.min.js"></script> 
		<script type="text/javascript" src="/SSMA_MOVIE/js/move-top.js"></script>
		<script type="text/javascript" src="/SSMA_MOVIE/js/easing.js"></script>
		<script type="text/javascript">
				function DropDown(el) {
					this.dd = el;
					this.initEvents();
				}
				DropDown.prototype = {
					initEvents : function() {
						var obj = this;
	
						obj.dd.on('click', function(event){
							$(this).toggleClass('active');
							event.stopPropagation();
						});	
					}
				}
	
				$(function() {
	
					var dd = new DropDown( $('#dd') );
	
					$(document).click(function() {
						$('.wrapper-dropdown-2').removeClass('active');
					});
	
				});
	    </script>
	    <script>
	    	$(function(){
	    		//1.验证邮箱
	    		var testEmail=false;
	    		$("input[name='member_Email']").bind('input propertychange', function() {
	    			testEmail=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test($(this).val());
	    			if(testEmail){
	    				$("#email").css("display","none");
	    			}else{
	    				$("#email").css("display","inline-block");
	    			}
	    			showBtn(testEmail,testName,testPhone,testPwd,testPwd2,testAgree);
	    		});
	    		//2.验证账户
	    		var testName=false;
	    		$("input[name='member_Name']").bind('input propertychange', function() {
	    			 var regex = new RegExp("^([\u4E00-\uFA29]|[\uE7C7-\uE7F3]|[a-zA-Z0-9_]){1,10}$"); 
 					 testName = regex.test($(this).val());
 					 if(testName){
	    				$("#name").css("display","none");
	    			}else{
	    				$("#name").css("display","inline-block");
	    			}
	    			showBtn(testEmail,testName,testPhone,testPwd,testPwd2,testAgree);
	    		});
	    		//3.验证电话
	    		var testPhone=false;
	    		$("input[name='member_Phone']").bind('input propertychange', function() {
 					 testPhone = /^1\d{10}$/.test($(this).val());
 					 if(testPhone){
	    				$("#phone").css("display","none");
	    			}else{
	    				$("#phone").css("display","inline-block");
	    			}
 					 showBtn(testEmail,testName,testPhone,testPwd,testPwd2,testAgree);
	    		});
	    		//4.验证密码
	    		var testPwd=false;
	    		$("input[name='member_Pwd']").bind('input propertychange', function() {
 					 testPwd =/^(\w){6,15}$/.test($(this).val());
 					 if(testPwd){
	    				$("#pwd").css("display","none");
	    			}else{
	    				$("#pwd").css("display","inline-block");
	    			}
	    			showBtn(testEmail,testName,testPhone,testPwd,testPwd2,testAgree);
	    		});
	    		//5.确认密码
	    		var testPwd2=false;
	    		$("input[name='pwd2']").bind('input propertychange', function() {
 					testPwd2=$(this).val()==$("input[name='member_Pwd']").val();
 					 if(testPwd2){
	    				$("#pwd2").css("display","none");
	    			}else{
	    				$("#pwd2").css("display","inline-block");
	    			}
	    			showBtn(testEmail,testName,testPhone,testPwd,testPwd2,testAgree);
	    		});
	    		//6.验证阅读协议同时所有验证通过显示注册按钮
	    		var testAgree=false;
	    		$("input[type='checkbox']").change(function(){
	    			testAgree=$(this).is(':checked');
	 				 showBtn(testEmail,testName,testPhone,testPwd,testPwd2,testAgree);
	    		});
	    		//7.点击注册按钮验证邮箱 ,如果验证邮箱不重复,则插入数据到数据库
	    		$("#btn").click(function(){
	    			var testEmail2=true;
	    			$.ajax({
	    				url:"/SSMA_MOVIE/queryEmails",
	    				success:function(data){
	    					for(var i=0;i<data.length;i++){
	    						if(data[i]==$("input[name='member_Email']").val()){
	    							testEmail2=false;
	    						}
	    					}
	    					if(testEmail2){
	    					//9.插入新用户到数据库
	    						var member={};
	    						member.member_Email=$("input[name='member_Email']").val();
	    						member.member_Pwd=$("input[name='member_Pwd']").val();
	    						member.member_Name=$("input[name='member_Name']").val();
	    						member.member_Phone=$("input[name='member_Phone']").val();
	    						member.member_Gender=$('input[name="gender"]:checked ').val();
	    						member.member_Money="5";
	    						member.member_Photo="无";
				    			$.ajax({
				    					url:"/SSMA_MOVIE/insertSingleMember",
				    					type:"post",
				    					data:member,
				    					success:function(data){
				    						if($.parseJSON(data).result&&confirm("注册成功!")){
				    							location.href="login.jsp";
				    						}
				    					}
				    			});
				    		}else{
				    			alert("抱歉,该邮箱已经注册!");
				    			$("input[name='member_Email']").val(" ");
				    		}
	    				}
	    			});
	    		}); 	
	   		})
	   		function showBtn(testEmail,testName,testPhone,testPwd,testPwd2,testAgree){
	   			   	if(testEmail&&testName&&testPhone&&testPwd&&testPwd2&&testAgree){
	    				$("#btn").css("display","block");
		    		}else{
		    			$("#btn").css("display","none");
		    		}
	   		}
	    </script>
		</head>
		<body>
			<div class="header">
				 <div class="headertop_desc">
					<div class="wrap">
							<div class="account_desc">
								<ul>
									<li><a href="#">登录</a></li>
									<li><a href="/movie/main/index.jsp">主页</a></li>
								</ul>
							</div>
						<div class="clear"></div>
					</div>
			  	</div>
		  	  		<div class="wrap">
						<div class="header_top">
							<div class="logo">
								<a href="/SSMA_MOVIE/main/index.jsp"><img src="/SSMA_MOVIE/images/logo.png" alt="" /></a>
							</div>
								<div class="header_top_right">
								 
								 <div class="clear"></div>
							</div>	
					   <div class="clear"></div>
		  		    </div>     				
		   		</div>
		   	</div>
		 <div class="main">
		 	<div class="wrap">
		     <div class="content">
		     	<div class="content_top">
		    		<div class="back-links">
		    		<h2 style="color:red;">注册</h2>
		    	    </div>
		    		<div class="clear"></div>
		    	</div>
		    	<div class="section group">
						<div class="col span_2_of_3">
						  <div class="contact-form">
							    	<div>
								    	<span><label>电子邮箱</label></span>
								    	<span><input name="member_Email" type="text" class="textbox" ></span>
								    	<span id="email" style="display:inline-block;color: red;">请注意邮箱格式!</span>
								    </div>
								    <div>
								    	<span><label>账户</label></span>
								    	<span><input name="member_Name" type="text" class="textbox" ></span>
								    	<span id="name" style="display:inline-block;color: red;">账户只能为1-10位中文或者英文组合!</span>
								    </div>
								    <div>
								    	<span><label>性别</label></span>
								    	<span>男:<input name="gender" type="radio" class="textbox" value="男" checked="checked"></span>
								    	<span>女:<input name="gender" type="radio" class="textbox" value="女"></span>
								    </div>
								     <div>
								    	<span><label>电话</label></span>
								    	<span><input name="member_Phone" type="text" class="textbox" ></span>
								    	<span id="phone" style="display:inline-block;color: red;">电话只能为11位数字(大陆)!</span>
								    </div>
								    <div>
								     	<span><label>创建登录密码</label></span>
								    	<span><input type="password" class="textbox" name="member_Pwd" placeholder="3-15位字母数字组合"></span>
								    	<span id="pwd" style="display:inline-block;color: red;">密码只能为6-15位英文,字母,下划线组合!</span>
								    </div>
								    <div>
								    	<span><label>确认登录密码</label></span>
								    	<span><input type="password" class="textbox" placeholder="3-15位字母数字组合" name="pwd2"></span>
								    	<span id="pwd2" style="display:inline-block;color: red;">两次输入密码不同!</span>
								    </div>
								     <div>
								    	<span><label>验证码:</label></span>
								    	<span></span>
								    </div>
								    <div>
								    	我看过并同意<a href="#"><strong style="color: #3399FF;">&lt;&lt;网站协议&gt;&gt;<input type="checkbox" ></strong></a>
								    </div>
								   <div id="btn" style="display:none;">
								   		<span><input type="submit" value="立即注册"  class="mybutton" ></span>
								  </div>
						  </div>
		  				</div>
						   </div>
						 </div>
					  </div>		
		         </div> 

		   <div class="footer">
		   	  <div class="wrap">	
			     <div class="section group">
						<div class="col_1_of_4 span_1_of_4">
								<h4>新手上路</h4>
								<ul>
								<li><a href="/movie/main/login.jsp">注册与登陆</a></li>
								<li><a href="#">快速购票</a></li>
								<li><a href="#">找到想看的电影</a></li>
								</ul>
							</div>
						<div class="col_1_of_4 span_1_of_4">
							<h4>购票指南</h4>
								<ul>
								<li><a href="#">购票选座说明</a></li>
								<li><a href="#">支付相关说明</a></li>
								<li><a href="#">如何取票</a></li>
								</ul>
						</div>
						<div class="col_1_of_4 span_1_of_4">
							<h4>在线帮助</h4>
								<ul>
									<li><a href="contact.html">旧网站用户登录说明</a></li>
									<li><a href="index.html">影城信息查询</a></li>
									<li><a href="#">联系我们</a></li>
								</ul>
						</div>
						<div class="col_1_of_4 span_1_of_4">
							<h4>客服热线</h4>
								<ul>
									<li><span>6666-666-66</span></li>
									<li><span>6666-666-66</span></li>
								</ul>
								<div class="social-icons">
									<h4>加入我们</h4>
							   		  <ul>
									      <li><a href="#" target="_blank"><img src="/SSMA_MOVIE/images/facebook.png" alt="" /></a></li>
									      <li><a href="#" target="_blank"><img src="/SSMA_MOVIE/images/twitter.png" alt="" /></a></li>
									      <li><a href="#" target="_blank"><img src="/SSMA_MOVIE/images/skype.png" alt="" /> </a></li>
									      <li><a href="#" target="_blank"> <img src="/SSMA_MOVIE/images/linkedin.png" alt="" /></a></li>
								     </ul>
		   	 					</div>
						</div>
					</div>
					 <div class="copy_right">
						<p><a target="_blank" href="#">&copy; 2014©2018 Moive 欢迎 意见反馈 京ICP证030173号  京公网安备11000002000001号 </a></p>
				   </div>			
		        </div>
		    </div>
		</body>
</html>

