<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주소목록</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<style>
#darken-background {
	position: absolute;
	top: 0px;
	left: 0px;
	right: 0px;
	height: 100%;
	width: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: 1000;
	overflow-y: scroll;
	display: none;
}

#lightbox {
	width: 700px;
	margin: 20px auto;
	padding: 15px;
	border: 1px solid #333333;
	border-radius: 5px;
	background: white;
	box-shadow: 0px 5px 5px rgba(34, 25, 25, 0.4);
	text-align: center;
}
</style>
</head>
<body>
	<h1>[주소목록]</h1>
	
	<table border=1 width=700>
		<tr>
			<td width=100>이름</td>
			<td width=100><input type="text" id="txtName"></td>
		</tr>
		<tr>
			<td width=100>전화번호</td>
			<td width=100><input type="text" id="txtTel"></td>
		</tr>
		<tr>
			<td width=150>주소</td>
			<td width=100><input type="text" id="txtAddress"></td>
		</tr>
	</table>
	<br>
	<button id="btnInsert">입력</button>
	<br>
	<br> 전체 데이터:
	<span id="total"></span>건
	<table border=1 width=700 id="tbl"></table>
	<script id="temp" type="text/x-handlebars-template">
	<tr>
		<td>제목</td>
		<td>이름</td>
		<td>주소</td>
		<td>전화번호</td>
		<td>삭제</td>
		<td>수정</td>
	</tr>
	{{#each list}}
	<tr class="row">
		<td>{{id}}</td>
		<td>{{name}}</td>
		<td>{{address}}</td>
		<td>{{tel}}</td>
		<td><button class="delete" bid="{{id}}">삭제</button></td>
		<td><button class="update" bid="{{id}}">수정</button></td>
	</tr>
	{{/each}}
	</script>
	<button id="btnPre">◀</button>
	<button id="btnNext">▶</button>

	<!-- 라이트박스 -->

	<div id="darken-background">
		<div id="lightbox">
		<input type="text" id="edtId">
			<table border=1 width=700>
		<tr>
			<td width=100>이름</td>
			<td width=100><input type="text" id="bxtName"></td>
		</tr>
		<tr>
			<td width=100>전화번호</td>
			<td width=100><input type="text" id="bxtTel"></td>
		</tr>
		<tr>
			<td width=150>주소</td>
			<td width=100><input type="text" id="bxtAddress"></td>
		</tr>
	</table>
			<button id="btnUpdate">저장</button>
			 <button id="btnClose">닫기</button>
			 <!--  <a id="btnClose" href="#">닫기</a>-->
		</div>
	</div>


</body>
<script>
	
	var start = 0;
	var total = 0;
	getList();
	function getList() {
		$.ajax({
			type : "get",
			url : "list.json",
			data : {
				"start" : start
			},
			dataType : "json",
			success : function(data) {
				var temp = Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
				total = data.total;
				$("#total").html(total);
			}
		});
	}

	$("#btnNext").on("click", function() {
		if (start + 10 < total) {
			start = start + 10;
			getList();
		}

	});
	$("#btnPre").on("click", function() {
		if (start > 1) {
			start = start - 10;
			getList();
		}

	});
	$("#btnInsert").on("click", function() {
		var name = $("#txtName").val();
		var tel = $("#txtTel").val();
		var address = $("#txtAddress").val();
		//alert(name + "-"+ tel + "-"+address + "-");

		$.ajax({
			type : "post",
			url : "insert",
			data : {
				"name" : name,
				"tel" : tel,
				"address" : address
			},
			success : function() {
				
					alert("입력되었습니다.");
					start = 0;
					getList();
			
			},
			error:function(){
				alert("입력에 실패하셨습니다.");
			}
		});
		

	});

	$("#tbl").on("click", ".row .delete", function() {
		if (confirm("삭제하시겠습니까?")) {
			var id = $(this).attr("bid");
			//alert(id);
			$.ajax({
				type : "post",
				url : "delete",
				data : {"id" : id},
				success : function() {
					alert("삭제되었습니다.");
					getList();
				},
				error:function(){
					alert("삭제 실 패 !!!!!!!.");
				}
			});
			
		}
	});
	
	
	$("#tbl").on("click",".row .update", function(){
		$("#darken-background").show();
		var id=$(this).attr("bid");
		$("#edtId").val(id);
		$.ajax({
			type:"get",
			url:"read.json",
			data:{"id":id},
			success:function(data){
				$("#bxtName").val(data.name);
				$("#bxtTel").val(data.tel);
				$("#bxtAddress").val(data.address);
			}
		});
	});
	
	$("#btnUpdate").on("click", function(){
		if(!confirm("수정하시겠습니까?")){return;}
		var id=$("#edtId").val();
		var name=$("#bxtName").val();
		var tel=$("#bxtTel").val();
		var address=$("#bxtAddress").val();
		//alert(id +"_"+ name+"-"+ tel+"-"+ address);
		
		$.ajax({
			type:"post",
			url:"update",
			data:{"id":id,"name":name,"tel":tel,"address":address},
			success:function(){
				alert("수정되었습니다.");
				$("#darken-background").hide();
				getList();
			},
			error:function(){
				alert("입력에 실패하셨습니다.");
			}
		});
		
	});
	
	/*
	$("#tbl").on("click",".row", function(){
		var id = $(this).attr("bid");
		alert(id);
	});
	*/
	
	$("#btnClose").on("click", function(){
		$("#darken-background").hide();
	});
	
	
	
</script>
</html>