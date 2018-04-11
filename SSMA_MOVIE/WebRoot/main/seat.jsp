<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<title></title>
	<style type="text/css">
		*{
			margin: 0px;
			padding: 0px;
		}
		body{
			background: #F5F;
		}
		div{
			width:100%;
			height: 100px;
			position: relative; 
		}
		ul{
			width: 600px;
			height: 100px;
			position: absolute;
			left: 50%;
			margin-left:-340px;
		}
		ul li{
			list-style: none;
			width: 50px;
			height: 50px;
			background: #F7F7F7;
			float: left;
			margin-left: 10px;
			text-align: center;
			line-height: 50px;
			cursor:pointer;
		}
		div.msg{
			width: 200px;
			height: 315px;
			position: absolute;
			right: 10px;
			top: 100px;
			color: black;
			border: 1px solid blue;
			background: #F0F8FF;
		}
		div.msg p{
			margin-top: 30px;
		}
	</style>
	<script type="text/javascript" src="/SSMA_MOVIE/js/jquery.min.js"></script>
	<script type="text/javascript">
		$(function() {
			//加载用户钱包

				$.ajax({
					url:"/SSMA_MOVIE/querySingleMemberByEmail?member_Email=${cookie.email.value}",
					success:function(data){
						$("#myMoney").text(data.member_Money);
					}
				});

			var seats=[];
            //动态加载场次信息
            var prices=[];
            $.ajax({
	            url:"/SSMA_MOVIE/querySinglePlay/${param.movie_Id}",
	            success:function(data){
	            	var play=$.parseJSON(data);
	            	if(play.length<=1){
	            		$("#movie_Name").text(play[0].movie_Name);
	            		$("#play_Price").text(play[0].play_Price);
	            		prices[play[0]]=play[0].play_Price;
	            		$("#play_Time").append("<option value="+(play[0].play_Id)+" >"+play[0].play_Time+"</option>");
	            	}else{
	            		$("#movie_Name").text(play[0].movie_Name);
	            			$("#play_Price").text(play[0].play_Price);
	            		for(var i=0;i<play.length;i++){
	            			$("#play_Time").append("<option value="+(play[i].play_Id)+" >"+play[i].play_Time+"</option>");
	            			prices[play[i].play_Id]=play[i].play_Price;
	            		}
	            	}
	            }
            });
            //根据时间段改变票价和已经出售座位
            $("#play_Time").change(function(){	
           			seats=[];
           			$("#sumMoney").text(0);
           			$(document).find('li').each(function() {
           				$(this).unbind("click");
           			});
           			$(document).find('li').each(function() {
		            	var flag=true;
		                $(this).click(function() {
		                	if(flag){
		                		$(this).css("background", "#C6E2FF");
		                		 seats.push($(this).text());
		                		$("#sumMoney").text(seats.length*$("#play_Price").text());
		                	}else{
		                		$(this).css("background", "#F7F7F7");
		                		var i=$(this).text();
		                		$.each(seats,function(index,item){  
						            // index是索引值（即下标）   item是每次遍历得到的值；
						            if(item==i){
						           	        	seats.splice(index,1);							
						        	    }
							     });
		                		$("#sumMoney").text(seats.length*$("#play_Price").text());
		                	}
		                    flag=!flag;
		                });
		            });
            		//1.改变票价
            		$("#play_Price").text(prices[$("#play_Time").val()]);
            		//2.改变座位
            		$.ajax({
            			url:"/SSMA_MOVIE/querySeatsByPlayId/"+$("#play_Time").val(),
            			success:function(data){
    						if(data.length>=1){
    							for(var i=0;i<data.length;i++){
	            					$(document).find('li').eq(data[i]-1).css("background", "#C6E2FF");
	            					$(document).find('li').eq(data[i]-1).unbind("click");
            					}
    						}else{
   									 $(document).find('li').each(function() {
						                $(this).css("background", "#F7F7F7");
						            });
    						}
            			}
            		});
            });
            //确认购买==>1.保存票务信息到数据库==>2.减少用户的余额
            $("#buy").click(function(){
            	if($("#play_Time").val()==-1){
            		alert("请选择场次时间!");
            		location.reload();
            	}else{
            		//1.获取到总购买票数(seats.length),价格($("#play_Price").val()),座位号集合(seats),场次ID
					if(seats.length>3){
            			alert("每个用户最多能购买同场次3张票!")
            		}else if(seats.length<1){
            			alert("你还没有选择座位!");
            		}else{
	            		//2.查询该用户ID
	            		var fcookie=${empty cookie.email.value};
				    	if(!fcookie){
				    		var member_Id=0;
				    		var member_Money=0;
			    			$.ajax({
			    				url:"/SSMA_MOVIE/querySingleMemberByEmail?member_Email=${cookie.email.value}",
			    				success:function(data){
			    					var flag=false;
			    					member_Id=data.member_Id;
			    					member_Money=data.member_Money;
			    					//3.遍历座位并且保存票的信息到数据库
			            			for(var i=0;i<seats.length;i++){
			            				var ticket={};
			            				ticket.ticket_Play=$("#play_Time").val();
			            				ticket.ticket_Member=member_Id;
			            				ticket.ticket_Code="0208";
			            				ticket.ticket_Seat=seats[i];
			            				ticket.ticket_Price=$("#play_Price").text();
			            				ticket.ticket_Flag="00";	
			            				$.ajax({
			            					url:"/SSMA_MOVIE/insertSingleTicket",
			            					type:"post",
			            					data:ticket,
			            					success:function(data){
			            						flag=$.parseJSON(data).result;
			            					}
			            				});
			            			}
			            			//4.减少用户的账户资金
			    					var member={};
			    					member.member_Id=member_Id;
			    					member.member_Money=member_Money-$("#sumMoney").text();
			    					$.ajax({
			    						url:"/SSMA_MOVIE/updateSingleMember",
			    						type:"post",
			    						data:member,
			    						success:function(data){
			    							if($.parseJSON(data).result&&flag){
			    								if(confirm("购买成功!")){
			    									location.reload();
			    								}
			    							}
			    						}
			    					});
			    				}
			    			});
			    			
				    	}else{
				    		if(confirm("请先登录!")){
				    			location.href="login.jsp";
				    		}
				    	}
            		}
            	}
            });
        })
	</script>
</head>
<body>
	<div class="logo" >
	<a href="index.jsp"><img src="/SSMA_MOVIE/images/logo.png" alt="" /></a>
	</div>
	<div><h1 style="color:white;text-align: center;">大屏幕</h1></div>
	<div class="div1">
		<ul class="ul1">
			<li>1</li>
			<li>2</li>
			<li>3</li>
			<li>4</li>
			<li>5</li>
			<li>6</li>
			<li>7</li>
			<li>8</li>
			<li>9</li>
			<li>10</li>
		</ul>	
	</div>
	<div class="div2">
		<ul class="ul2">
			<li>11</li>
			<li>12</li>
			<li>13</li>
			<li>14</li>
			<li>15</li>
			<li>16</li>
			<li>17</li>
			<li>18</li>
			<li>19</li>
			<li>20</li>
		</ul>	
	</div>
	<div class="div3">
		<ul class="ul3">
			<li>21</li>
			<li>22</li>
			<li>23</li>
			<li>24</li>
			<li>25</li>
			<li>26</li>
			<li>27</li>
			<li>28</li>
			<li>29</li>
			<li>30</li>
		</ul>	
	</div>
	<div style="height: 40px;text-align: center;line-height: 40px;"></div>
	<div class="div3">
		<ul class="ul3">
			<li>31</li>
			<li>32</li>
			<li>33</li>
			<li>34</li>
			<li>35</li>
			<li>36</li>
			<li>37</li>
			<li>38</li>
			<li>39</li>
			<li>40</li>
		</ul>	
	</div>
	<div class="div3">
		<ul class="ul3">
			<li>41</li>
			<li>42</li>
			<li>43</li>
			<li>44</li>
			<li>45</li>
			<li>46</li>
			<li>47</li>
			<li>48</li>
			<li>49</li>
			<li>50</li>
		</ul>	
	</div>
	<div class="msg">
		<p>片名:<span id="movie_Name"></span></p>
		<p>票价:<span id="play_Price">0</span></p>
		<p>时间:<select id="play_Time" >
					<option value="-1">无</option>	
				</select></p>
		<p>总计(元):<span id="sumMoney"></span></p>
		<p>我的钱包(元):<span id="myMoney"></span></p>
		<p><button id="buy">确认购买</button></p>
	</div>
</body>
</html>