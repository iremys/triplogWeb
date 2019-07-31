<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">

	<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>

	<title>Mysite</title>
</head>
<body>
	<div id="container">
		
	
		
		<div id="content">
			<div id="c_box">
				<div id="guestbook">
					<h2>방명록</h2>

					<div>
						<table>
							<tr>
								<td>이름</td>
								<td><input type="text" name="name"></td>
								<td>비밀번호</td>
								<td><input type="password" name="password"></td>
							</tr>
							<tr>
								<td colspan=4><textarea name="content" cols="75" rows="8"></textarea></td>
							</tr>
							<tr>
								<td colspan=4 align=right><input id="btnAdd" type="button" VALUE=" 확인 "></td>
							</tr>
						</table>
					</div>
					<br>
					
					<div id="guestbookList">
					
					
					</div>



				</div>
				<!-- /guestbook -->
			</div>
			<!-- /c_box -->
		</div>
		<!-- /content -->

	
	</div><!-- /container -->



</body>



<script type="text/javascript">

//페이지가 준비될때
$(document).ready(function() {

});	


//저장버튼을 클릭했을때
$("#btnAdd").on("click", function() {
	event.preventDefault();
	
	aaa ={
  		name:"aaa"
  	}
	
	var str = '{"accuracy":0.0,"cardPrice":0.0,"cardUnitName":"화폐선택 ▼","cardUnitNo":1,"cateName":"카테고리선택 ▼","cateNo":2,"city":"null","country":"null","inoutNo":44,"inoutType":"OUT","lat":37.6536525,"lon":126.7909734,"mMethod":"CASH","mPrice":0.0,"mUnitName":"화폐선택 ▼","mUnitNo":1,"memo":"","pMethod":"null","pPrice":0.0,"pUnitNo":0,"sync":"-1","title":"","tripNo":2,"useDate":"2019-07-16 23:18"}'

	
	$.ajax({
		url : "http://192.168.0.51:8088/triplog/api/insertInout",		
		type : "post",
		contentType : "application/json",
		data : str,
		/* dataType : "json", */
		success : function(result) {
		
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	}); 
              
	
	
});


/* 삭제팝업창 띄우기*/ 
$("#guestbookList").on("click", ".btnDelModal", function() {
	var no = $(this).data("delno");
	
	$("#modalNo").val(no);
    $("#delPop").modal();
    
});



/* 삭제 */
$("#btnDel").on("click", function() {
	event.preventDefault();
	var no = $("#modalNo").val();
   	var password = $("#modalPassword").val();
   	
	
	$.ajax({
		url : "${pageContext.request.contextPath }/api/gb/delete",	
		type : "post",
		/* contentType : "application/json", */
		data :{no: no, password: password},
		dataType : "json",
		success : function(count) {
			if(count > 0){
				$("#div"+no).remove();
			}
			$("#delPop").modal("hide")
			$("#modalPassword").val("");
			$("#modalNo").val("");	
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	});
	
});


//스크롤이 화면 제일 아래에 왔을때
$(window).scroll(function() {
    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
    	fetchList();
    }
});

	


/* 게시물을 10개 가져와 화면에 출력합니다. */
function fetchList() {

	$.ajax({
		url : "${pageContext.request.contextPath }/api/gb/list",
		type : "post",
		/* contentType : "application/json", */
		data : {lastNo: lastNo},
		dataType : "json",
		success : function(guestbookList) {
			console.log(guestbookList);
			for(var i=0; i<guestbookList.length; i++){
				render(guestbookList[i], "down");
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	});

}	


/* 게시물을 화면에 표현합니다. */
function render(guestbookVo, updown) {
	
	var str = "";
	str += "<div id='div"+guestbookVo.no+"'>";
	str += "	<table>";
	str += "		<tr>";
	str += "			<td>[" + guestbookVo.no + "]</td>";
	str += "			<td>" + guestbookVo.name + "</td>";
	str += "			<td>" + guestbookVo.regDate + "</td>";
	str += "			<td><input class='btnDelModal' type='button' value='삭제' data-delno='" + guestbookVo.no + "' ></td>";
	str += "		</tr>";
	str += "		<tr>";
	str += "			<td colspan=4>"+ guestbookVo.content.replace(/\n/gi,'<br>') + "</td>";
	str += "		</tr>";
	str += "	</table>";
	str += "	<br>";
	str += "</div>";
		

	if(updown == "up"){
		$("#guestbookList").prepend(str); 
	}else if(updown == "down"){
		$("#guestbookList").append(str); 
		lastNo = guestbookVo.no;  //마지막번호 업데이트
	}else{
		console.log("updown 오류")
	}
}	
	
	
</script>


</html>

