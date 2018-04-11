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
		<link href="/movie/css/style.css" rel="stylesheet" type="text/css" media="all"/>
		<script type="text/javascript" src="/movie/js/jquery-1.9.0.min.js"></script> 
		<script type="text/javascript" src="/movie/js/move-top.js"></script>
		<script type="text/javascript" src="/movie/js/easing.js"></script>
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
	    			document.getElementById("email").onblur=function(){
	    			var email=this.value;
	    			var pattern= /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;  
					var strEmail=pattern.test(email); 
	    			$.ajax({
	    				url:"/movie/login.movie",
	    				type:"post",
	    				data: "member_email="+email,
	    				success:function(data){
	    					if(data==1&&strEmail){
	    						document.getElementById("ti").style.display="none";
	    							document.getElementById("agree").onchange=function(){
							    			if(this.checked){
							    				document.getElementById("btn").style.display="block";
							    			}else{
							    				document.getElementById("btn").style.display="none";
							    			}
							    		}
	    						
	    					}else{
   							    		document.getElementById("ti").style.display="inline-block";
	    								document.getElementById("btn").style.display="none";
	    					}
	    				}
	    			})	
	    		}
	    	})
	    	
	    
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
								<a href="/movie/main/index.html"><img src="/movie/images/logo.png" alt="" /></a>
							</div>
								<div class="header_top_right">
								  <div class="cart">
								  	   <span>购票车</span><div id="dd" class="wrapper-dropdown-2"> (empty)
								  	   	<ul class="dropdown">
												<li>你还没有购票哦^_^!</li>
										</ul></div>
								  </div>
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
						  <form action="/movie/register.movie" method="post">
							    	<div>
								    	<span><label>电子邮箱</label></span>
								    	<span><input name="member_email" type="text" class="textbox"  id="email"></span>
								    	<span id="ti" style="display:none;">该邮箱已经被注册或者格式有误!</span>
								    </div>
								    <div>
								    	<span><label>姓名</label></span>
								    	<span><input name="member_name" type="text" class="textbox" ></span>
								    </div>
								    <div>
								    	<span><label>性别</label></span>
								    	<span>男:<input name="gender" type="radio" class="textbox" value="男"></span>
								    	<span>女:<input name="gender" type="radio" class="textbox" value="女"></span>
								    </div>
								     <div>
								    	<span><label>电话</label></span>
								    	<span><input name="member_phone" type="text" class="textbox" ></span>
								    </div>
								    <div>
								     	<span><label>创建登录密码</label></span>
								    	<span><input type="password" class="textbox" name="member_pwd" placeholder="3-15位字母数字组合"></span>
								    </div>
								    <div>
								    	<span><label>确认登录密码</label></span>
								    	<span><input type="password" class="textbox" placeholder="3-15位字母数字组合"></span>
								    </div>
								     <div>
								    	<span><label>验证码:</label></span>
								    	<span></span>
								    </div>
								    <div>
								    	我看过并同意<a href="#"><strong style="color: #3399FF;">&lt;&lt;网站协议&gt;&gt;<input type="checkbox" id="agree" ></strong></a>
								    </div>
								   <div id="btn" style="display:none;">
								   		<span><input type="submit" value="立即注册"  class="mybutton" ></span>
								  </div>
						</form>
							
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
									      <li><a href="#" target="_blank"><img src="/movie/images/facebook.png" alt="" /></a></li>
									      <li><a href="#" target="_blank"><img src="/movie/images/twitter.png" alt="" /></a></li>
									      <li><a href="#" target="_blank"><img src="/movie/images/skype.png" alt="" /> </a></li>
									      <li><a href="#" target="_blank"> <img src="/movie/images/linkedin.png" alt="" /></a></li>
								     </ul>
		   	 					</div>
						</div>
					</div>
					 <div class="copy_right">
						<p><a target="_blank" href="#">&copy; 2014©2018 Moive 欢迎 意见反馈 京ICP证030173号  京公网安备11000002000001号 </a></p>
				   </div>			
		        </div>
		    </div>
		    <script type="text/javascript">
				$(document).ready(function() {			
					$().UItoTop({ easingType: 'easeOutQuart' });
					
				});
			</script>
		    <a href="#" id="toTop"><span id="toTopHover"> </span></a>
		</body>
</html>

