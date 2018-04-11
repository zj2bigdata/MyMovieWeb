<%@page pageEncoding="utf-8" %>
<!DOCTYPE HTML>
<html style="width: 100%;height: 100%">
	<head>
		<title>电影详情</title>
		<meta charset="utf-8"/>
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
				//加载根据ID查找的所有信息
				$.ajax({
					url:"/SSMA_MOVIE/queryMoviesById/${param.movie_Id}",
					type:"post",
					success:function(data){
					document.getElementById("movie_Name").innerText=data[0].movie_Name;
					document.title=data[0].movie_Name;
					document.getElementById("movie_Price").innerText=data[0].play_Price;
					document.getElementById("movie_Date").innerText=data[0].movie_Date.substring(0,16);
					document.getElementById("movie_Long").innerText=data[0].movie_Long;
					document.getElementById("movie_Director").innerText=data[0].movie_Director;
					document.getElementById("movie_Actor").innerText=data[0].movie_Actor;
					document.getElementById("movie_Info").innerText=data[0].movie_Info;
					document.getElementById("movie_Photo").setAttribute("src","/SSMA_MOVIE/images/"+data[0].movie_Photo);
					document.getElementById("buy").href="/SSMA_MOVIE/main/seat.jsp?movie_Id="+data[0].movie_Id;
					}
				});
			})
			
			function changePlayer(movie_name){
				document.getElementById('myVideo').play(); // 播放
				document.getElementById("gray").style.display="block";
			}
			
			function closeChange(){
				document.getElementById('myVideo').pause(); // 暂停
				document.getElementById("gray").style.display="none";
			}
		</script>
	</head>
	<body style="width: 100%;height: 100%">
		<div id="gray" style="display:none;background: #9f9f9f; width: 100%;height: 160%; position: absolute; z-index: 100;opacity: 0.95;" onclick="closeChange()">
			<video  id="myVideo" controls="controls" src="/SSMA_MOVIE/mp4/xiyouji.mp4" id="video" width="1000px" height="600" style="position: absolute;top:30%;left: 50%; z-index: 999;margin-left: -500px;margin-top: -300px;"></video>
		</div>
		<div class="header">
			 <div class="headertop_desc">
				<div class="wrap">
						<div class="account_desc">
							<ul>
								<li><a href="register.jsp" id="register">注册</a></li>
								<li><a  href="login.jsp" id="login">登录</a></li>
								<li><a href="aboutMe.jsp">个人中心</a></li>
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
							<img src="/SSMA_MOVIE/images/preview.jpg" alt=""  id="movie_Photo"/>
					  </div>
					<div class="desc span_3_of_2">
						<h2 id="movie_Name"></h2>
						<p>一场权利之争在人类与国王、国王与诸神之间展开。</p>					
						<div class="price">
							<p>价格: <span id="movie_Price"></span>元</p>
						</div>
						<div class="available">
							<ul>
							  <li><span>上映日期:&nbsp; </span ><span id="movie_Date"></span></li>
							  <li><span>片长:&nbsp;</span><span id="movie_Long"></span></li>
							  <li><span>导演:&nbsp;</span><span id="movie_Director" ></span></li>
							  <li><span>主演:&nbsp;</span><span id="movie_Actor" ></span></li>
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
				   <p id="movie_Info"></p>
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
							<li><a href="/SSMA_MOVIE/main/login.jsp">注册与登陆</a></li>
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

