<%@page pageEncoding="utf-8" %>
<!DOCTYPE HTML>
<html style="width: 100%;height: 100%">
	<head>
		<title  id="title">电影详情</title>
		<meta charset="utf-8"/>
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
	      	          document.getElementById("register").innerText="已注册"; 
				      document.getElementById("register").href='javascript:void(0)';
				      }
				$.ajax({
					url: "/movie/findById.movie",
					type:"post",
					data:"movie_id=${param.movie_id}",
					success:function(data){
						var movie=$.parseJSON(data);
						document.getElementById("movie_name").innerText=movie.movie_name;
						document.getElementById("title").innerText=movie.movie_name;
						document.getElementById("movie_date").innerText=movie.movie_date;
						document.getElementById("movie_long").innerText=movie.movie_long;
						document.getElementById("movie_director").innerText=movie.movie_director;
						document.getElementById("movie_actor").innerText=movie.movie_actor;
						document.getElementById("movie_info").innerText=movie.movie_info;
						document.getElementById("movie_photo").setAttribute("src",movie.movie_photo);
						document.getElementById("movie_price").innerText=${param.movie_price};
						name=movie.movie_name;
						if(name=="前任3(再见前任)"){
							document.getElementById("video").src="/movie/mp4/qianren3.mp4";
						}
						date=movie.movie_date.substring(10, 19);
						document.getElementById("buy").href="/movie/main/seat.jsp?movie_name="+name+"&movie_price="+${param.movie_price}+"&date="+date;
					},
					error:function(){
									if(confirm("抱歉,与服务器失去连接...")){
			   						location.href="index.jsp";
			   					}
					}
				});
				
				   <!--加载购票车-->
					      $.ajax({
			   				url:"/movie/findTickets.ticket",
			   				type:"post",
			   				data:"email=${param.email}",
			   				success:function(data){
			   					var json_tickets=$.parseJSON(data);
			   					var op=[];
			   					op.push("<li>取票ID--电影名--播放时间--座位号--票价</li>");
			   					for(var i=0;i<json_tickets.length;i++){
			   						op.push("<li>"+json_tickets[i].ticket_id+"--"+json_tickets[i].movie_name+
			   						"--"+json_tickets[i].play_time.substring(0,16)+"--"+json_tickets[i].ticket_seat+
			   						"--"+json_tickets[i].ticket_price+"--<a href='/movie/deleteTicket.ticket?ticket_id="
			   						+json_tickets[i].ticket_id+"&email=${param.email}'>×</a></li>");
			   					}
			   					document.getElementById("car").innerHTML=op.join("</br>");
			   				},
			   				error:function(){
			   				}
			   			}); 
				//加载用户头像
			   			$.ajax({
			   				url:"/movie/loadPhoto.movie",
			   				type:"post",
			   				data:"email=${param.email}",
			   				success:function(data){
			   					document.getElementById("photo").setAttribute("src",data);
			   				},
			   				error:function(){
			   				
			   				}
			   			
			   			});
				
			})
			
			function changePlayer(movie_name){
				document.getElementById("gray").style.display="block";
			}
			
			function closeChange(){
				document.getElementById("gray").style.display="none";
			}
		</script>
	</head>
	<body style="width: 100%;height: 100%">
		<div id="gray" style="display:none;background: #9f9f9f; width: 100%;height: 160%; position: absolute; z-index: 100;opacity: 0.95;" onclick="closeChange()">
			<video  controls="controls" src="/movie/mp4/xiyouji.mp4" id="video" width="1000px" height="600" style="position: absolute;top:30%;left: 50%; z-index: 999;margin-left: -500px;margin-top: -300px;"></video>
		</div>
		<div class="header">
			 <div class="headertop_desc">
				<div class="wrap">
						<div class="account_desc">
							<ul>
								<li><a href="/movie/main/register.jsp" id="register">注册</a></li>
								<li><a  href="/movie/main/login.jsp" id="login">登录</a></li>
								<li><a href="/movie/main/aboutMe.jsp?email=${param.email }">个人中心</a></li>
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
							 <div class="cart">
						  	   <div id="dd" class="wrapper-dropdown-2">我的电影票
						  	   	<ul class="dropdown" id="car" style="z-index: 100;">
										<li>你还没有购票哦^_^!</li>
								</ul></div>
						  </div>
								
							 <div class="clear"></div>
						</div>
				 <div class="clear"></div>
	  		    </div>     				
	   		</div>
	   <div class="main">
	   	 <div class="wrap">
	   	 	<div class="content_top">
	    		<div class="back-links">
	    			<h3></h3>
	    	    </div>
	    		<div class="clear"></div>
	    	</div>
	   	 	<div class="section group">
					<div class="cont-desc span_1_of_2">
					  <div class="product-details">				
						<div class="grid images_3_of_2">
							<img src="/movie/images/preview.jpg" alt=""  id="movie_photo"/>
					  </div>
					<div class="desc span_3_of_2">
						<h2 id="movie_name">诸神之战</h2>
						<p>一场权利之争在人类与国王、国王与诸神之间展开。</p>					
						<div class="price">
							<p>价格: <span id="movie_price">5.6$</span>元</p>
						</div>
						<div class="available">
							<ul>
							  <li><span>上映日期:&nbsp; </span > <span id="movie_date"></span></li>
							  <li><span>片长:&nbsp;</span> <span id="movie_long"></span></li>
							  <li><span>导演:&nbsp;</span> <span id="movie_director" ></span></li>
							  <li><span>主演:&nbsp;</span><span id="movie_actor" ></span></li>
						    </ul>
						</div>
					<div class="share-desc">
						
						<div class="button"><span><a href="#" id="buy" style="margin-left: 10px;">购买</a></span></div>
						<div class="button"><span><a href="javascript:void(0)"  onclick="changePlayer()">预告片</a></span></div>					
						<div class="clear"></div>
					</div>
				</div>
				<div class="clear"></div>
			  </div>
			<div class="product_desc">	
				 <h2>Details :</h2>
				   <p id="movie_info">一场权利之争在人类与国王、国王与诸神之间展开。然而仅仅诸神之间的战争就足以摧毁整个人类世界。生为神明，却被当做人类抚养的珀尔修斯（萨姆·沃辛顿饰演），眼睁睁地看着从地狱而来的冥王《诸神之战》截图《诸神之战》截图(17张)哈迪斯（拉尔夫·费因斯饰演）夺走亲人的性命，却无能为力。失去亲人后的珀尔修斯一无所有，自告奋勇去完成一项危险的任务，在哈迪斯获得宙斯（连姆·尼森饰演）的力量之前打败他，否则整个人类世界都会变成地狱。珀尔修斯带领着一群勇士，踏上了这段前往冥界禁地的危险征途。其中有经验丰富的战士卓拉古（马兹·米克尔森饰演），正是他鼓励叛逆的珀尔修斯善用自己身上的神力。一路上珀尔修斯要斩妖除魔，还要面对各种可怕的猛兽。他只有正视自己神族出身的事实才能取得胜利，改变天意并创造自己的命运。</p>
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
								<li><a href="#">旧网站用户登录说明</a></li>
								<li><a href="#">影城信息查询</a></li>
								<li><a href="#">联系我们</a></li>
							</ul>
					</div>
					<div class="col_1_of_4 span_1_of_4">
						<h4>客服热线</h4>
							<ul>
								<li><span>6666-666-66</span></li>
								<li><span>6666-6666-66</span></li>
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

