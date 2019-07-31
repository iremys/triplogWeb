<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<title>부트스트랩 101 템플릿</title>

<!-- CSS -->
<link href="${pageContext.request.contextPath }/assets/bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/assets/css/triplog.css" rel="stylesheet">

<!-- JS-->
<script src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
<script src="${pageContext.request.contextPath }/assets/bootstrap/js/bootstrap.js"></script>


<!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
<!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->


</head>
<body>
	<header>
		<a href="${pageContext.request.contextPath }"><h1>TripLog</h1></a>
	</header>

	<div id="wapper">


		<nav>
			<h2>여행리스트</h2>
			<ul>

				<c:forEach items="${tripList}" var="tirpVo">
					<a href="${pageContext.request.contextPath }?tripNo=${tirpVo.tripNo }">
						<li>
							<div class="tripTitle">${tirpVo.tripTitle}</div>
							<div class="tripDate">${tirpVo.startDate} ~ ${tirpVo.endDate}</div>
						</li>
					</a>
				</c:forEach>

			</ul>
		</nav>

		<section>
			<h2>가계부 리스트
				<a href="${pageContext.request.contextPath }?tripNo=${crtTripNo}" class="btn btn-sm btn-primary pull-right">리스트로보기</a>
			</h2>

			<div id="map"></div>
			
			
		</section>
		
		<div id="detailBox">
			<h2>상세</h2>
			
			<div id=detail>
			
				
			</div>
		</div>
	</div>

<script 
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBmbB4EjgIh8N0zQAmRmIMdMMc-z4f7JQY&callback=initMap" async defer>
</script>


<script>
var map;
var marker=[];


function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
		center : {
			lat : 37.448465,
			lng : 126.450322
		},
		zoom : 12
	});
	

	//좌표 리스트
	var tripNo = "${crtTripNo}";
	console.log(tripNo);
	$.ajax({
		url : "${pageContext.request.contextPath }/api/inoutList",		
		type : "post",
		/* contentType : "application/json", */
		data : {tripNo: tripNo},
		dataType : "json",
		async: false,
		success : function(inoutList) {
			console.log(inoutList);
			if(inoutList.length > 0){
				for (i = 0; i < inoutList.length; i++) {  
					marker[i] = new google.maps.Marker({
					    inoutNo: inoutList[i].inoutNo,
					    position: new google.maps.LatLng(inoutList[i].lat, inoutList[i].lon),
					    map: map
				    });
					
					/* marker.addListener('click', function() {
					    console.log(marker.inoutNo);
					}); */
					
				    markerListener(marker[i]);  
					
				}
				
				//마커그린후 위치
				//마지막 마커
				map.setCenter(new google.maps.LatLng(inoutList[0].lat, inoutList[0].lon));
			}						
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	}); 
	
	 

}


//마커 클리시 세부항목, 이미지 보여준다.
function markerListener(thisMarker){      
	  google.maps.event.addListener(thisMarker, 'click', function(){ 
		  //i번째 마커 클릭했을 때 실행할 내용들... 
		  console.log(thisMarker.inoutNo);
		  $.ajax({
				url : "${pageContext.request.contextPath }/api/inout",		
				type : "post",
				/* contentType : "application/json", */
				data : {inoutNo: thisMarker.inoutNo},
				dataType : "json",
				/*async: false, */
				success : function(inoutVo) {
					console.log(inoutVo);
					detail(inoutVo)//
				},
				error : function(XHR, status, error) {
					console.error(status + " : " + error);
				}
			}); 
	  });
}



function detail(inoutVo){

	var str ="";
	str += "  ";
	str += " <table class='table table-striped table-bordered table-hover table-condensed'> ";
	str += " 	<colgroup> ";
	str += " 		<col width='15%'> ";
	str += " 		<col width=''> ";
	str += " 		<col width='15%'> ";
	str += " 		<col width='8%'> ";
			
	str += " 		<col width='15%'> ";
	str += " 		<col width=''> ";
	str += " 		<col width='15%'> ";
	str += " 		<col width='8%'> ";
	str += " 	</colgroup> ";
	str += " 	<tr> ";
	str += " 		<th>날짜</th> ";
	str += " 		<td colspan='3'>"+inoutVo.useDate+"</td> ";

	str += " 		<th>구분</th> ";
	str += " 		<td colspan='3'>"+inoutVo.inoutType+"</td> ";
	str += " 	</tr> ";
	str += " 	<tr> ";
	str += " 		<th>제목</th> ";
	str += " 		<td colspan='7'>"+inoutVo.title+"</td> ";
	str += " 	</tr> ";
	str += " 	<tr> ";
	str += " 		<th>-금액</th> ";
	str += " 		<td>- "+inoutVo.mPrice+"</td> ";
	str += "		<td>"+inoutVo.mUnitName+"</td> ";
	str += "		<td>"+inoutVo.mMethod+"</td> ";
	str += "		<th>+금액</th> ";
	str += " 		<td>"+inoutVo.pPrice+"</td> ";
	str += "		<td>"+inoutVo.pUnitName+"</td> ";
	str += "		<td>"+inoutVo.pMethod+"</td> ";
	str += "	</tr>		 ";
	str += " 	<tr> ";
	str += " 		<th>카테고리</th> ";
	str += " 		<td colspan='3'>"+inoutVo.cateName+"</td> ";

	str += " 		<th>동기날짜</th> ";
	str += " 		<td colspan='3'>"+inoutVo.regDate+"</td> ";
	str += " 	</tr> ";
	str += "	<tr> ";
	str += "		<th>위치</th> ";
	str += "		<td colspan='7'>위도: "+inoutVo.lat+"<br>경도 :"+inoutVo.lon+"</td> ";
	str += "	</tr> ";
	str += "	<tr > ";
	str += "		<th>사진</th> ";
	str += "		<td colspan='7' > ";
	str += "			<div class='imgOut'> ";
	
	for(var i=0; i<inoutVo.fileList.length; i++){
		str += "			<div><img class='imgBox' src='${pageContext.request.contextPath}"+inoutVo.fileList[i].webFilePath+"'></div> ";
	}
	
	str += "			</div> ";
	str += "		</td> ";
	str += "	</tr> ";
	str += "</table> ";
	
	$("#detail").html(str);
}






</script>


</body>
</html>