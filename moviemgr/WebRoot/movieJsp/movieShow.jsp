<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>电影明细</title>
		  <link type="text/css" rel="stylesheet" href="/moviemgr/style/table.css" />
		  <link rel="stylesheet" type="text/css" href="/moviemgr/style/btn.css">
		  <style type="text/css">
			    a{
					text-decoration: none;
				}
		    	a:LINK{ color:#D6D6D6;}
		    	a:VISITED{ color:#CDAA7D;}
		    	a:HOVER{ color:#CAE1FF;}
		    	a:ACTIVE{ color:#8B8B83;}
		  </style>
		  <script type="text/javascript" src="/moviemgr/js/jquery.min.js"></script>
		<script type="text/javascript">
			$(function(){
			var allCount=0;
			//获取数据总长度
			$.ajax({
							url : "/moviemgr//find.movie",
							type : "post",
							success : function(data){
								allCount=$.parseJSON(data).length;
							},
							error : function(){
								if(confirm("服务器连接失败!请检查网络~")){
	      								
	      							}
							}
						});
				var i=1;
				changeData((1+3*(i-1)),i*3);
				$("#huanye").click(function(){
					if(allCount%3!=0){
								if(i>=Math.floor(allCount/3)){
								changeData((3*i+1),allCount);
								i=1;
							}else{
								i++;
								changeData((1+3*(i-1)),i*3);
							}
					}else{
						if(i>=Math.floor(allCount/3)){
								i=0;
							}
								i++;
								changeData((1+3*(i-1)),i*3);
					}
				
				});
				$("#huanshang").click(function(){
					if(allCount%3!=0){
							if(i<=1){
								i=Math.floor(allCount/3);13
								changeData((3*i+1),allCount);
							}else{
								i--;
								changeData((1+3*(i-1)),i*3);
							}
						}else{
							if(i>=1){
								i=Math.floor(allCount/3);
							}
							changeData((1+3*(i-1)),i*3);
							i--;
						}
				});
			})	
			function changeData(s,e){
				$.ajax({
							url : "/moviemgr/selectMovies3.movie",
							type : "post",
							data:"start="+s+"&end="+e,
							success : function(data){
								showData(data);
							},
							error : function(){
								if(confirm("服务器连接失败!请检查网络~")){
	      								location="adminManager.jsp";
	      							}
							}
						});
			}
			
			function showData(movies){
				var json_movies=JSON.parse(movies);
				var html=[ ];
				document.getElementById("idv").innerHTML=" ";
				html.push('<table class="gridtable">');
				html.push('<tr><th>电影ID</th><th>电影片名</th><th>电影导演</th><th>电影演员</th><th>电影语言</th><th>电影类型</th><th>电影片长</th><th>电影版本</th><th>电影信息</th><th>上映时间</th><th>电影类型</th><th>修改</th><th>删除</th></tr>')
				for(var i=0;i<json_movies.length;i++){
					html.push('<tr>'+'<td>'+json_movies[i].movie_Id+'</td>');
					html.push('<td>'+json_movies[i].movie_Name+'</td>');
					html.push('<td>'+json_movies[i].movie_Director+'</td>');
					html.push('<td>'+json_movies[i].movie_Actor+'</td>');
					html.push('<td>'+json_movies[i].movie_Info+'</td>');
					html.push('<td>'+json_movies[i].movie_Language+'</td>');
					html.push('<td>'+json_movies[i].movie_Kind+'</td>');
					html.push('<td>'+json_movies[i].movie_Photo+'</td>');
					html.push('<td>'+json_movies[i].movie_Long+'</td>');
					html.push('<td>'+json_movies[i].movie_Date+'</td>');
					html.push('<td>'+json_movies[i].movie_Edition+'</td>');
					html.push('<td><a href="movieUpdate.jsp?movie_Id='+json_movies[i].movie_Id+'">修改</a></td>');
					html.push('<td><a href="javascript:void(0)" onclick="sel('+json_movies[i].movie_Id+')">删除</a></td></tr>');
				}
				html.push('</table>');
				var js=html.join(' ');
				document.getElementById("idv").innerHTML=js;
			}
			function sel(id){
					if(confirm("确认?")){
						$.ajax({
								url:"/moviemgr/deleteMovie.movie",
								type:"post",
								data:"id="+id,
								success:function(data){
										alert("删除成功!");
				      					location.reload();
								},
								error:function(){
										if(confirm("服务器连接失败!请检查网络~")){
	      										location=" ";
	      									}
								}
						});					
					}	
			}
		</script>
	</head>
	<body>
	 		<div class="div1"><img src="/moviemgr/images/login_logo.jpg"/></div>
			<a href="movieAdd.jsp"><button id="btn" class="btn">增加</button></a>
			<a href="/moviemgr/adminJsp/adminManager.jsp"><button id="btn1" class="btn">返回</button></a>
         	<div id="idv"></div>
         	<p><button id="huanshang" class="btn">上一页</button></p>
         	<p><button id="huanye" class="btn">下一页</button></p>
	</body>
</html>