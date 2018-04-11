<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
		<head>
		<title>个人中心</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
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
		    <script type="text/javascript">
		    	$(function(){
		    		//1.读取cookie,如果登录则改变个人信息
			    	var fcookie=${empty cookie.email.value};
			    	var pwd2="";
			    	if(!fcookie){
			    		//1.动态显示个人信息
			    		$.ajax({
			    			url:"/SSMA_MOVIE/querySingleMemberByEmail",
			    			type:"post",
			    			data:"member_Email=${cookie.email.value}",
			    			success:function(data){
			    				pwd2=data.member_Pwd;
			    				$("input[name='id']").val(data.member_Id);
			    				$("input[name='email']").val(data.member_Email);
			    				$("input[name='mima']").val(data.member_Pwd);
			    				$("input[name='name']").val(data.member_Name);
			    				$("input:radio[name='gender'][value='" + data.member_Gender + "']").prop("checked", "checked");
			    				$("input[name='phone']").val(data.member_Phone);
			    				$("input[name='money']").val(data.member_Money);
			    			}
			    		});
			    		//2.点击修改则改变不可编辑状态
			    		$("#btn1").click(function(){
			    			var ins=$("input");
			    			for(var i=1;i<ins.length-1;i++){
			    				ins[i].removeAttribute("readonly");
			    			}
			    			$("#btn2").css("display","inline-block");
			    			//3.给确认按钮添加点击事件从而修改用户信息
			    			$("#btn2").click(function(){
			    				var testEmail=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test($("input[name='email']").val());
		    					var regex = new RegExp("^([\u4E00-\uFA29]|[\uE7C7-\uE7F3]|[a-zA-Z0-9_]){1,10}$"); 
		 						var testName = regex.test($("input[name='name']").val());
		 						var testPhone=/^1\d{10}$/.test($("input[name='phone']").val());
		 						var testPwd=/^(\w){6,15}$/.test($("input[name='mima']").val());
			    				if(testEmail&&testName&&testPhone&&testPwd){
			    					var member={};
			    					member.member_Id=$("input[name='id']").val();
			    					member.member_Email=$("input[name='email']").val();
			    					member.member_Name=$("input[name='name']").val();
			    					member.member_Phone=$("input[name='phone']").val();
			    					member.member_Pwd=$("input[name='mima']").val();
			    					member.member_Gender=$('input[name="gender"]:checked').val();
			    					$.ajax({
			    						url:"/SSMA_MOVIE/updateSingleMember",
			    						type:"post",
			    						data:member,
			    						success:function(data){
			    							if($.parseJSON(data).result){
			    								var email2="${cookie.email.value}";
			    								if(email2==$("input[name='email']").val()&&pwd2==$("input[name='mima']").val()){
				    								if(confirm("您的个人信息已经修改!")){
				    										location.reload();
				    									}
			    								}else{
			    									if(confirm("您的邮箱或者密码已经修改!请重新登录使其重置!")){
				    										location.href="login.jsp";
				    									}
			    								}
			    							}
			    						}
			    					});
			    				}else{
			    					alert("请注意修改内容的格式!");
			    				}
			    			});
			    		});
			    	}else{
			    		if(confirm("请先登录!")){
			    			location.href="login.jsp";
			    		}
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
									<li><a href="index.jsp">主页</a></li>
								</ul>
							</div>
						<div class="clear"></div>
					</div>
			  	</div>
		  	  		<div class="wrap">
						<div class="header_top">
							<div class="logo">
								<a href="index.jsp"><img src="/SSMA_MOVIE/images/logo.png" alt="" /></a>
							</div>
								<div class="header_top_right">
								  <div class="cart">
								  	   <div id="dd" class="wrapper-dropdown-2">我的电影票
								  	   	<ul class="dropdown" id="car">
												<li>你还没有购票哦^_^!</li>
										</ul></div>
								  </div>
									  <div class="search_box">
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
		    		<p>欢迎回来, ${cookie.email.value }!</p>
		    	    </div>
		    		<div class="clear"></div>
		    	</div>
		    	<div class="section group">
						<div class="col span_2_of_3">
						  <div class="contact-form">
						  	<h2>个人中心</h2>
						  	 <div>
						    	<span><label>用户ID</label></span>
						    	<span><input name="id" type="text" class="textbox"  readonly="readonly"></span>
						    </div>
							<div>
						    	<span><label>头像</label></span>
						    	<img alt="" src="" id="photo" width="40px" height="40px">
						    	<!-- 固定写法:method="post" enctype="multipart/form-data" -->
								<form action="/SSMA_MOVIE/saveMemberPhoto?email=${cookie.email.value}" method="post" enctype="multipart/form-data">
									<!-- 固定写法:type="file" name="自定义" -->
									<input type="file" name="file"/>
									<input type="submit" value="上传"/>
								</form>
						    </div>
						    <div>
						    	<span><label>邮箱</label></span>
						    	<span><input name="email" type="text" class="textbox" readonly="readonly"></span>
						    	<span id="email" style="display:inline-block;color: blue;">正确邮箱格式分为:名称（英文字母,数字,下划线组成）,@邮箱符号,后缀!</span>
						    </div>
						     <div id="mima">
						    	<span><label>密码</label></span>
						    	<span><input name="mima" type="password" class="textbox" readonly="readonly"></span>
						   		<span id="pwd" style="display:inline-block;color: blue;">密码只能为6-15位英文,字母,下划线组合!</span>
						    </div>
						    <div>
						     	<span><label>姓名</label></span>
						    	<span><input name="name" type="text" class="textbox" readonly="readonly"></span>
						    	<span id="name" style="display:inline-block;color: blue;">账户只能为1-10位中文或者英文组合!</span>
						    </div>
						     <div>
						     	<span><label>姓别</label></span>
						    	<span>男:<input name="gender" type="radio" class="textbox" value="男" checked="checked"></span>
						    	<span>女:<input name="gender" type="radio" class="textbox" value="女"></span>
						    </div>
						    <div>
						     	<span><label>电话</label></span>
						    	<span><input name="phone" type="text" class="textbox" readonly="readonly"></span>
						    	<span id="phone" style="display:inline-block;color: blue;">电话只能为11位数字(大陆)!</span>
						    </div>
						    <div>
						    	<span><label>余额</label></span>
						    	<span><input name="money" type="text" class="textbox" readonly="readonly"></span>
						    </div>
						     <div>
						    	<span>
						    		<button id="btn1" style="background-color:#FC7D01;width: 60px;height: 30px;border-radius: 10px;">修改</button>
						    		<button id="btn2" style="margin-left:100px;background-color:#FC7D01;width: 60px;height: 30px;border-radius: 10px;display:none">确认</button>
						    	</span>
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
								<li><a href="register.jsp">注册与登陆</a></li>
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
									<li><a href="#">旧网站用户登录说明</a></li>
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
		    <script type="text/javascript">
				$(document).ready(function() {			
					$().UItoTop({ easingType: 'easeOutQuart' });
					
				});
			</script>
		    <a href="#" id="toTop"><span id="toTopHover"> </span></a>
		</body>
</html>

