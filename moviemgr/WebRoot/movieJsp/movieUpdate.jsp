<%@ page pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'shopAdd.jsp' starting page</title>
    <link rel="stylesheet" type="text/css" href="/moviemgr/style/btn.css">
      <script type="text/javascript" src="/moviemgr/js/jquery.min.js"></script>
      <script type="text/javascript">
      		$(function(){
      			$.ajax({
      				url:"/moviemgr/findById.movie",
      				type:"post",
      				data:"movie_Id=${param.movie_Id}",
      				success:function(data){
      					var movie=$.parseJSON(data);
      					$("input[name='movie_name']").val(movie.movie_Name);
      					$("input[name='movie_Director']").val(movie.movie_Director);
      					$("input[name='movie_Actor']").val(movie.movie_Actor);
      					$("input[name='movie_Language']").each(function(){
								   if($(this).val()==movie.movie_Language)
								{
									$(this).attr("checked",true);
								}
						});
      					$("input[name='movie_Long']").val(movie.movie_Long);
      					$("input[name='movie_Edition']").each(function(){
								   if($(this).val()==movie.movie_Edition)
								{
									$(this).attr("checked",true);
								}
						});
						$("#info").val(movie.movie_Info); 
      					
      				},
      				error:function(){
      				}
      			});
 
      			<!--提交新影片-->
      			$("#btn").click(function(){
      				var para={};
      				para.movie_Id=${param.movie_Id};
      				para.movie_name=$("input[name='movie_name']").val();
      				para.movie_Director=$("input[name='movie_Director']").val();
      				para.movie_Actor=$("input[name='movie_Actor']").val();
      				para.movie_Language=$("input[name='movie_Language']").val();
      				para.movie_Kind=$('#sel option:selected') .val();
      				para. movie_Long=$("input[name='movie_Long']").val();
      				para.movie_Edition=$("input[name='movie_Edition']").val();
      				para.movie_Info=$("textarea[name='movie_Info']").val();
      				var arr=$("input[name='file']").val().split( "\\" );
      				para.movie_photo="/movie/images/"+arr[arr.length-1];
      				para.movie_Date=$("textarea[name='movie_Date']").val();
      				$.ajax({
      					url:"/moviemgr/updateMovie.movie",
      					type:"post",
      					data:para,
      					success:function(){
      						location.href="/moviemgr/movieJsp/saveImg.jsp";
      					},
      					error:function(){
      						alert("影片更新失败!");
      					}
      				});
      			});
      		
      		})
      </script>
  </head>
  
  <body>
  		<div class="div1"><img src="/moviemgr/images/login_logo.jpg"/></div>

  		<div style="position: absolute;left: 8px;top:300px;">
	  		<fieldset style="width: 964px">
	  			<legend>新电影添加</legend>
	  			<p>片名:<input type="text"  name="movie_name" ></p>
	  			<p>导演:<input type="text" name="movie_Director" ></p>
	  			<p>演员:<input type="text" name="movie_Actor" ></p>
	  			<p>电影语言:中文:<input type="radio" name="movie_Language"  value="1">
	  								  英文:<input type="radio" name="movie_Language"  value="2"></p>
	  			<p>电影类型:<select id="sel">
	  										<option value="1">喜剧片<option/>
	  										<option value="2">动作片<option/>
	  										<option value="3">科幻片<option/>
	  								  </select></p>
	  			<!-- 固定写法:method="post" enctype="multipart/form-data" -->
				<form action="/moviemgr/saveImg.movie" method="post" enctype="multipart/form-data" >
					<!-- 固定写法:type="file" name="自定义" -->
					上传图片:<input type="file" name="file"/>
				</form>
	  			<p>片长:<input type="text" name="movie_Long"></p>
	  			<p>版本:MAX<input type="radio" name="movie_Edition" value="1">
	  							3D<input type="radio" name="movie_Edition" value="2">
	  							普通<input type="radio" name="movie_Edition" value="3">
	  			</p>
	  			<p>电影信息:<textarea rows="" cols="50" name="movie_Info" id="info"></textarea></p>
	  			<p>上映时间:<input type="text" name="movie_Date" value="2018-01-20 12:04:33"></p>
	  			<p><button id="btn"  class="btn">提交</button></p>
	  			<a href="movieJsp/movieShow.jsp"><button id="btn1" class="btn">返回</button></a>
	  		</fieldset>
  		</div>
  </body>
</html>
