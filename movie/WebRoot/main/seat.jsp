<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>${param.movie_name }</title>
<style type="text/css">
body{
	background:url("/movie/images/seatBg.jpg");
	background-size:100%;
}

.demo{width:700px; margin:40px auto 0 auto; min-height:450px;}
@media screen and (max-width: 360px) {.demo {width:340px}}
.front{width: 300px;margin: 5px 32px 45px 32px;background-color: #f0f0f0;	color: #666;text-align: center;padding: 3px;border-radius: 5px;}
.booking-details {float: right;position: relative;width:200px;height: 450px; }
.booking-details h3 {margin: 5px 5px 0 0;font-size: 16px;}
.booking-details p{line-height:26px; font-size:16px; color:#999}
.booking-details p span{color:#666}
div.seatCharts-cell {color: #182C4E;height: 25px;width: 25px;line-height: 25px;margin: 3px;float: left;text-align: center;outline: none;font-size: 13px;}
div.seatCharts-seat {color: #fff;cursor: pointer;-webkit-border-radius: 5px;-moz-border-radius: 5px;border-radius: 5px;}
div.seatCharts-row {height: 35px;}
div.seatCharts-seat.available {background-color: #B9DEA0;}
div.seatCharts-seat.focused {background-color: #76B474;border: none;}
div.seatCharts-seat.selected {background-color: #E6CAC4;}
div.seatCharts-seat.unavailable {background-color: #472B34;cursor: not-allowed;}
div.seatCharts-container {border-right: 1px dotted #adadad;width: 400px;padding: 20px;float: left;}
div.seatCharts-legend {padding-left: 0px;position: absolute;bottom: 470px;}
ul.seatCharts-legendList {padding-left: 0px;}
.seatCharts-legendItem{float:left; width:90px;margin-top: 10px;line-height: 2;}
span.seatCharts-legendDescription {margin-left: 5px;line-height: 30px;}
.checkout-button {display: block;width:80px; height:24px; line-height:20px;margin: 10px auto;border:1px solid #999;font-size: 14px; cursor:pointer}
#selected-seats {max-height: 150px;overflow-y: auto;overflow-x: none;width: 200px;}
#selected-seats li{float:left; width:72px; height:26px; line-height:26px; border:1px solid #d3d3d3; background:#f7f7f7; margin:6px; font-size:14px; font-weight:bold; text-align:center}
li{
	list-style: none;
}
</style>
<script type="text/javascript" src="/movie/js/jquery.min.js"></script>
<script type="text/javascript" src="/movie/js/jquery.seat-charts.min.js"></script>
<script type="text/javascript">
	$(function(){
		$.ajax({
			url:"/movie/findTime.ticket",
			type:"post",
			data:"movie_name=${param.movie_name }",
			success:function(data){
				var p=$.parseJSON(data);
				for(var i=0;i<p.length;i++){
					var date=p[i].play_time.substring(0,16);
					if(!${empty sessionScope.play_id }&&"${sessionScope.play_id }"==p[i].play_id){
						$("#select_id").append("<option selected='selected' value="+(p[i].play_id)+" >"+date+"</option>");
					}else{
						$("#select_id").append("<option value="+(p[i].play_id)+" >"+date+"</option>");
					}	
				}
			},
		});
		$.ajax({
			url:"/movie/login.movie",
			type:"post",
			data:"member_email=${sessionScope.email }",
			success:function(data){
				var member=$.parseJSON(data);
				$("input[name='myMoney']").val(member.member_money);
			},
		});
	})
	
</script>
</head>
<body>
<div id="header">
   <div id="logo"><a href="/movie/main/index.jsp?email=${sessionScope.email }"><img src="/movie/images/logo.png"/></a></div>
   
</div>

<div id="main">
   <div class="demo">
   		<div id="seat-map">
			<div class="front">屏幕</div>					
		</div>
		<div class="booking-details">
			
			<p>影片：<span>${param.movie_name }</span></p>
			<p>时间：<span><select id="select_id">
								<option value="-1">无</option>
							 </select></span></p>
			<p>票价：<span>${param.movie_price }元/张</span></p>
			<p>座位：</p>
			<ul id="selected-seats"></ul>
			<p>票数：<span id="counter">0</span></p>
			
			<p>总计：<b>￥<span id="total">0</span>我的钱包:<input type="text" name="myMoney" readonly="readonly"/></b></p>
			
			<button class="checkout-button">确定购买</button>	
			<div id="legend" style="margin-top: 100px;"></div>
		</div>
		
		<div style="clear:both"></div>
   </div>
	
  <br/>
  <p></p>	
</div>

<script type="text/javascript">
var price = ${param.movie_price}; //票价
$(document).ready(function() {


	var $cart = $('#selected-seats'), //座位区
	$counter = $('#counter'), //票数
	$total = $('#total'); //总计金额
	var seats=[ ];
	var money="";
	var sc = $('#seat-map').seatCharts({
		map: [  //座位图
			'aaaaaaaaaa',
            'aaaaaaaaaa',
            '__________',
            'aaaaaaaa__',
            'aaaaaaaaaa',
			'aaaaaaaaaa',
			'aaaaaaaaaa',
			'aaaaaaaaaa',
			'aaaaaaaaaa',
            'aa__aa__aa'
		],
		naming : {
			top : false,
			getLabel : function (character, row, column) {
				return column;
			}
		},
		legend : { //定义图例
			node : $('#legend'),
			items : [
				[ 'a', 'available',   '可选座' ],
				[ 'a', 'unavailable', '已售出']
			]					
		},
		click: function () { //点击事件
			if (this.status() == 'available') { //可选座
				$('<li>'+(this.settings.row+1)+'排'+this.settings.label+'座</li>')
					.attr('id', 'cart-item-'+this.settings.id)
					.data('seatId', this.settings.id)
					.appendTo($cart);
					seats.push((this.settings.row+1)+"_"+this.settings.label);

				$counter.text(sc.find('selected').length+1);
				$total.text(recalculateTotal(sc)+price);
				money=$total.text();
				return 'selected';
			} else if (this.status() == 'selected') { //已选中
					//更新数量
					$counter.text(sc.find('selected').length-1);
					//更新总计
					$total.text(recalculateTotal(sc)-price);
						
					//删除已预订座位
					$('#cart-item-'+this.settings.id).remove();
					//可选座
					return 'available';
			} else if (this.status() == 'unavailable') { //已售出
				return 'unavailable';
			} else {
				return this.style();
			}
		}
	});
	//已售出的座位
	$("#select_id").change(function(){
			$.ajax({
					url:"/movie/findSeats.ticket",
					type:"post",
					data:"id="+$("#select_id").val(),
					success:function(data){
						location.reload();
					},
			});
		});
		var flag="${empty sessionScope.seats}";
		if(flag!=true){
				sc.get(${sessionScope.seats}).status('unavailable');
		}else{
			sc.get([]).status('unavailable');
		}
	//获取并发送数据
	$(".checkout-button").click(function(){
		if($("#select_id").val()==-1){
			confirm("请选择场次时间!")
			location.reload();
		}else{
			for(var i=0;i<seats.length;i++){
		var seat={};
		seat.seats=seats[i];
		seat.money=money;
		seat.email="${sessionScope.email}";
		seat.ticket_code=$('#select_id option:selected').text().substring(8,10);
		seat.movie_name="${param.movie_name }";
		seat.movie_price="${param.movie_price }";
		seat.member_id="${sessionScope.id }";
		seat.play_id=$("#select_id").val();
		if(($("input[name='myMoney']").val()-seat.movie_price)>=0){
					$.ajax({
								url:"/movie/buyMovie.ticket",
								type:"post",
								data:seat,
								success:function(){	
										lessMoney(seat.movie_price*seats.length);
								},
								error:function(){
									if(confirm("服务器异常!")){
										location.href="";
									}
								}
					});
		}else{
			if(confirm("您账户余额不够!")){
				location.reload();
			}
		}
		
		}
		}
	});
	
});

//扣除用户的金额
function lessMoney(movie_price){
	var count=$("input[name='myMoney']").val()-movie_price;
	var id="${sessionScope.id }";
	$.ajax({
		url:"/movie/lessMoney.ticket",
		type:"post",
		data:"id="+id+"&count="+count,
	});
	
	$.ajax({
					url:"/movie/findSeats.ticket",
					type:"post",
					data:"id="+$("#select_id").val(),
					success:function(data){
						if(confirm("购买完成!")){
							location.reload();
						}
					},
			});

}
//计算总金额
function recalculateTotal(sc) {
	var total = 0;
	sc.find('selected').each(function () {
		total += price;
	});
			
	return total;
}
</script>
</body>
</html>
