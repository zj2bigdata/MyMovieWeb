<%@ page pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
<head>
		<title>主页面</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<link href="/SSMA_MOVIE/css/style.css" rel="stylesheet" type="text/css" media="all"/>
		<link href="/SSMA_MOVIE/css/slider.css" rel="stylesheet" type="text/css" media="all"/>
		<script type="text/javascript" src="/SSMA_MOVIE/js/jquery-1.9.0.min.js"></script> 
		<script type="text/javascript" src="/SSMA_MOVIE/js/move-top.js"></script>
		<script type="text/javascript" src="/SSMA_MOVIE/js/easing.js"></script>
		<script type="text/javascript" src="/SSMA_MOVIE/js/jquery.nivo.slider.js"></script>
		<!-- 特效脚本 --> 
		<script type="text/javascript">
		    $(window).load(function() {
		        $('#slider').nivoSlider();
		       })
		    </script>
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
			
			<!-- 逻辑脚本 -->   
		    <script type="text/javascript">
		    	var i=1;
			   	var j=1;
			   	var allCount=0;
		   		$(function(){
			   		//1.读取cookie,如果登录则改变导航栏状态和头像
			    	var fcookie=${empty cookie.email.value};
			    	if(!fcookie){
		    			$("#login").html('${cookie.email.value}');
		    			$("#login").attr("href","javascript:void(0)");
		    			//2.加载用户头像
		    			$.ajax({
		    				url:"/SSMA_MOVIE/querySingleMemberByEmail?member_Email=${cookie.email.value}",
		    				success:function(data){
		    					$("#photo").attr("src","/SSMA_MOVIE/images/"+data.member_Photo);
		    				}
		    			});
		    			//3.加载该用户的票务信息
		    			$.ajax({
		    				url:"/SSMA_MOVIE/queryAllTicketsForMember?email=${cookie.email.value}",
		    				success:function(data){
		    					var json_tickets=$.parseJSON(data);
			   					var op=[];
			   					op.push("<li>电影名-------播放时间-------座位号</li>");
			   					for(var i=0;i<json_tickets.length;i++){
			   						op.push("<a href='#'><li>"+json_tickets[i].movie_Name.substring(0,4)+
			   						"---"+json_tickets[i].play_Time+"---"+json_tickets[i].ticket_Seat+"</li></a>");
			   					}
			   					document.getElementById("car").innerHTML=op.join("</br>");
			   					document.getElementById("show1").innerHTML=" ";
			   					var html=[ ];
			   					for(var i=0;i<json_tickets.length;i++){
									html.push(" <div class='grid_1_of_5 images_1_of_5'>");
									html.push("<a href='#'><img  width='200' height='300' src='/SSMA_MOVIE/images/"+json_tickets[i].movie_Photo+"'></a>");
									html.push(" <h2>"+json_tickets[i].movie_Name+"</h2>");
									html.push("<div class='price-details'>");
									html.push(" <div class='price-number'>");
									html.push("<p><span class='rupees' style='color:#FC7D01'>时间"+json_tickets[i].play_Time+"</span></p>")
									html.push("</div>");
									html.push(" <div class='add-cart'>");
									html.push("<h4>座位号:"+json_tickets[i].ticket_Seat+"</h4>")
									html.push("</div>");
									html.push(" <div class='clear'><a href='#' onclick='deleteTicket("+json_tickets[i].ticket_Id+")'>退票</a></div>");
									html.push("</div>");
									html.push("</div>");
									var js=html.join(' ');
									document.getElementById("show1").innerHTML=js;
								}
		    				}
		    			});
			    	}
				})
				
				function deleteTicket(ticket_Id){
					if ( confirm("确认退票?") ){
						$.ajax({
						url:"/SSMA_MOVIE/deleteTicketById?ticket_Id="+ticket_Id+"&email=${cookie.email.value}",
						success:function(data){
							if ($.parseJSON(data).result) {
								if (confirm("退票成功!")) {
									location.reload();
								}
							} else {
								alert("服务器繁忙,请稍后再试!")
							}
						}
					});
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
							<li><a href="/SSMA_MOVIE/main/register.jsp" id="register">注册</a></li>
							<li><a href="/SSMA_MOVIE/main/login.jsp"  id="login">登录</a></li>
							<li><a href="/SSMA_MOVIE/main/aboutMe.jsp">个人中心</a></li>
							<li><a href="/SSMA_MOVIE/clearMember">退出</a></li>
						</ul>
					</div>
				<div class="clear"></div>
			</div>
	  	</div>
  	  		<div class="wrap">
				<div class="header_top">
					<div class="logo" >
						<a href="index.jsp"><img src="/SSMA_MOVIE/images/logo.png" alt="" /></a>
					</div>
						<div class="header_top_right">
						  <div class="cart">
						  	   <div id="dd" class="wrapper-dropdown-2">我的电影票
						  	   	<ul class="dropdown" id="car" style="z-index: 100;">
										<li>你还没有购票哦^_^!</li>
								</ul></div>
						  </div>
							  <div class="search_box">
					     		<a href="/SSMA_MOVIE/main/aboutMe.jsp"><img alt="" src="/SSMA_MOVIE/images/twitter.png" id="photo" width="40px" height="40px"></a>
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
    		<div class="heading">
    		<h3>我的电影票</h3>
    		</div>
    	</div>
	      <div class="section group" id="show1">
				
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
						<li><a href="/SSMA_MOVIE/main/login.jsp">注册与登陆</a></li>
						<li><a href="javascript:void(0)">快速购票</a></li>
						<li><a href="javascript:void(0)">找到想看的电影</a></li>
						</ul>
					</div>
				<div class="col_1_of_4 span_1_of_4">
					<h4>购票指南</h4>
						<ul>
						<li><a href="javascript:void(0)">购票选座说明</a></li>
						<li><a href="javascript:void(0)">支付相关说明</a></li>
						<li><a href="javascript:void(0)">如何取票</a></li>
						</ul>
				</div>
				<div class="col_1_of_4 span_1_of_4">
					<h4>在线帮助</h4>
						<ul>
							<li><a href="javascript:void(0)">旧网站用户登录说明</a></li>
							<li><a href="javascript:void(0)">影城信息查询</a></li>
							<li><a href="javascript:void(0)">联系我们</a></li>
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
							      <li><a href="javascript:void(0)" target="_blank"><img src="/SSMA_MOVIE/images/facebook.png" alt="" /></a></li>
							      <li><a href="javascript:void(0)" target="_blank"><img src="/SSMA_MOVIE/images/twitter.png" alt="" /></a></li>
							      <li><a href="javascript:void(0)" target="_blank"><img src="/SSMA_MOVIE/images/skype.png" alt="" /> </a></li>
							      <li><a href="javascript:void(0)" target="_blank"> <img src="/SSMA_MOVIE/images/linkedin.png" alt="" /></a></li>
						     </ul>
   	 					</div>
				</div>
			</div>
			 <div class="copy_right">
				<p><a target="_blank" href="#">&copy; 2014©2018 Movie 欢迎 意见反馈 京ICP证030173号  京公网安备11000002000001号 </a></p>
		   </div>			
        </div>
    </div>
     <script type="text/javascript">
		$(document).ready(function() {			
			$().UItoTop({ easingType: 'easeOutQuart' });
			
		});
	</script>
     <a href="javascript:void(0)" id="toTop"><span id="toTopHover"> </span></a>
</body>
</html>

