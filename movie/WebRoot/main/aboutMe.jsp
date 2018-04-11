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
		    <script type="text/javascript">
		    	$(function(){
		    		var flag = "${empty param.email}";  
					if(flag!="true"){  
					     document.getElementById("login").innerText='${param.email}'; 
					       document.getElementById("login").href='#'; 
					       var inps=document.getElementsByTagName("input");
					       $.ajax({
        					url:"/movie/login.movie",
        					type: "post",
        					data:"member_email=${param.email}",
        					success:function(data){
        						var json_member=$.parseJSON(data);
        						document.getElementsByName("id")[0].value=json_member.member_id;
        						document.getElementsByName("name")[0].value=json_member.member_name;
        						$("input:radio[name='gender'][value='" + json_member.member_gender + "']").prop("checked", "checked");
        						document.getElementsByName("money")[0].value=json_member.member_money;
        						document.getElementsByName("mima")[0].value=json_member.member_pwd;
        						document.getElementsByName("phone")[0].value=json_member.member_phone;
        						document.getElementById("photo").setAttribute("src",json_member.member_photo);
        					},
        					error:function(){
        					if(confirm("服务器异常!")){
        								location.href="/movie/main/index.jsp";
        							}
        						
        					}
        				});
        				for(var i=0;i<inps.length;i++){
        					inps[i].setAttribute("readonly",true);
        				}
        				//加载购票车
       				   $.ajax({
			   				url:"/movie//findTickets.ticket",
			   				type:"post",
			   				data:"email=${param.email}",
			   				success:function(data){
			   					var json_tickets=$.parseJSON(data);
			   					var op=[];
			   					op.push("<li>取票ID--电影名--播放时间--座位号--票价</li>");
			   					for(var i=0;i<json_tickets.length;i++){
			   						op.push("<li>"+json_tickets[i].ticket_id+"--"+json_tickets[i].movie_name+"--"+json_tickets[i].play_time.substring(0,16)+"--"+json_tickets[i].ticket_seat+"--"+json_tickets[i].ticket_price+"</li>");
			   					}
			   					document.getElementById("car").innerHTML=op.join("</br>");
			   				},
			   				error:function(){
			   				}
			   			}); 
        				
        				document.getElementById("btn1").onclick=function(){
        					for(var i=3;i<inps.length-1;i++){
        						inps[i].removeAttribute("readonly");
        					}
        					document.getElementById("btn2").style.display="inline-block";
        				}
        				
        				//修改用户信息
        				document.getElementById("btn2").onclick=function(){
        					var m={};
        					m.member_id=$("input[name='id']").val();
        					m.member_email=$("input[name='email']").val();
        					m.member_pwd=$("input[name='mima']").val();
        					var regExp=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{3,15}$/;
					        if(!regExp.test($("input[name='mima']").val())){
						        alert("密码格式错误!必须为3-15位字母数字组合!");
					        return false;
    						}
        					m.member_name=$("input[name='name']").val();
        					m.member_gender=$('input[name="gender"]:checked').val();
        					m.member_phone=$("input[name='phone']").val();
        					$.ajax({
        						url:"/movie/updateMember.movie",
        						type:"post",
        						data:m,
        						success:function(){
        							if(confirm("修改成功!请重新登录!")){
        								location.href="/movie/main/login.jsp";
        							}
        						},
        						error:function(){
        								if(confirm("服务器异常!")){
        								location.href=" ";
        							}
        						}
        					});
        				}
        				
					};  
		    	})
		    	
		    </script>
		</head>
		<body>
			<div class="header">
				 <div class="headertop_desc">
					<div class="wrap">
							<div class="account_desc">
								<ul>
									<li><a href="/movie/main/login.jsp" id="login">登录</a></li>
									<li><a href="/movie/main/index.jsp?email=${param.email }&flag=true">主页</a></li>
								</ul>
							</div>
						<div class="clear"></div>
					</div>
			  	</div>
		  	  		<div class="wrap">
						<div class="header_top">
							<div class="logo">
								<a href="/movie/main/index.jsp?email=${param.email}"><img src="/movie/images/logo.png" alt="" /></a>
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
		    		<p>欢迎回来, ${param.email }!</p>
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
								<form action="/movie/upload?email=${param.email}" method="post" enctype="multipart/form-data">
									<!-- 固定写法:type="file" name="自定义" -->
									<input type="file" name="file"/>
									<input type="submit" value="上传"/>
								</form>
						    </div>
						    <div>
						    	<span><label>邮箱</label></span>
						    	<span><input name="email" type="text" class="textbox" value="${param.email }" ></span>
						    </div>
						     <div id="mima">
						    	<span><label>密码</label></span>
						    	<span><input name="mima" type="password" class="textbox"></span>
						    </div>
						    <div>
						     	<span><label>姓名</label></span>
						    	<span><input name="name" type="text" class="textbox"></span>
						    </div>
						     <div>
						     	<span><label>姓别</label></span>
						    	<span>男:<input name="gender" type="radio" class="textbox" value="男"></span>
						    	<span>女:<input name="gender" type="radio" class="textbox" value="女"></span>
						    </div>
						    <div>
						     	<span><label>电话</label></span>
						    	<span><input name="phone" type="text" class="textbox"></span>
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

