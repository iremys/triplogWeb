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
							<div class="tripDate">${tirpVo.startDate}~ ${tirpVo.endDate}</div>
					</li>
					</a>
				</c:forEach>

			</ul>
		</nav>

		<section>

			<h2>
				가계부 리스트 <a href="${pageContext.request.contextPath }/map?tripNo=${crtTripNo}" class="btn btn-sm btn-primary pull-right">지도로보기</a>
			</h2>



			<table class="table table-striped table-bordered table-hover table-condensed">
				<colgroup>
					<col width="5%">
					<col width="10%">
					<col width="5%">

					<col width="10%">
					<col width="10%">
					<col width="5%">

					<col width="10%">
					<col width="10%">
					<col width="5%">


					<col width="">
					<col width="10%">
				</colgroup>

				<thead>
					<tr>
						<th>번호</th>
						<th>날짜</th>
						<th>구분</th>


						<th colspan="3">-금액</th>

						<th colspan="3">+금액</th>
						<th>카테고리</th>
						<th>동기날짜</th>
					</tr>
				</thead>

				<tbody>

					<c:forEach items="${pMap.inoutList}" var="inoutVo">
						<tr class="btnInoutNo mouse" data-inoutno='${inoutVo.inoutNo}'>
							<td rowspan="2">${inoutVo.inoutNo}</td>
							<td>${inoutVo.useDate}</td>
							<td><c:if test="${inoutVo.inoutType=='IN'}">입금</c:if> <c:if test="${inoutVo.inoutType=='OUT'}">지출</c:if> <c:if test="${inoutVo.inoutType=='CHANGE'}">환전</c:if> <c:if test="${inoutVo.inoutType=='WITHROW'}">인출</c:if></td>


							<td>${inoutVo.mPrice} <c:if test="${inoutVo.mMethod=='BANK'}">
									<br>
								 	${inoutVo.cardPrice}
								 	</c:if>
							</td>
							<td>${inoutVo.mUnitName}(${inoutVo.mUnitNo}) <c:if test="${inoutVo.mMethod=='BANK'}">
									<br>
								 	${inoutVo.cardUnitName}(${inoutVo.cardUnitNo}) 
									</c:if>
							</td>
							<td>${inoutVo.mMethod}</td>


							<td>${inoutVo.pPrice}</td>
							<td>${inoutVo.pUnitName}(${inoutVo.pUnitNo})</td>
							<td>${inoutVo.pMethod}</td>

							<td>${inoutVo.cateName}(${inoutVo.cateNo})</td>
							<td>${inoutVo.regDate}</td>
						</tr>
						<tr>
							<td colspan="5">${inoutVo.title}(${inoutVo.inoutNo})</td>
							<td colspan="5">위도: ${inoutVo.lat} &nbsp;&nbsp;&nbsp;&nbsp; 경도: ${inoutVo.lon} <%-- <div class="debug">
									 ${inoutVo}
								</div> --%>
							</td>
						</tr>
					</c:forEach>
				</tbody>

			</table>

			<div class="text-center">
				<ul class="pagination pagination-lg" >
					<c:if test="${pMap.prev == true}">
						<li><a href="${pageContext.request.contextPath }/?tripNo=${crtTripNo}&crtPage=${pMap.startPageBtnNo-1}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
					</c:if>
					
					<c:forEach begin="${pMap.startPageBtnNo }" end="${pMap.endPageBtnNo }" step="1" var="page">
						<c:choose>
							<c:when test="${crtPage eq page }">
								<li class="active"><a href="${pageContext.request.contextPath }/?tripNo=${crtTripNo}&crtPage=${page}">${page }</a></li>
							</c:when>
					
							<c:otherwise>
								<li><a href="${pageContext.request.contextPath }/?tripNo=${crtTripNo}&crtPage=${page}">${page }</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<c:if test="${pMap.next == true}">
						<li><a href="${pageContext.request.contextPath }/?tripNo=${crtTripNo}&crtPage=${pMap.endPageBtnNo+1}" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
					</c:if>
				</ul>
			</div>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
		</section>

		<div id="detailBox">
			<h2>상세</h2>

			<div id=detail>
				<table class='table table-striped table-bordered table-hover table-condensed'>
					<tr>
						<td>
							<div>
								<div id='smap'></div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class='memo'>
								<!-- 메모영역 -->
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class='imgOut2'>
								<!-- 이미지영역 -->
							</div>
						</td>
					</tr>
				</table>

			</div>
		</div>


	</div>

</body>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBmbB4EjgIh8N0zQAmRmIMdMMc-z4f7JQY&callback=initMap" async defer>
	
</script>


<script>
	var map;
	var marker = [];

	function initMap() {
		map = new google.maps.Map(document.getElementById('smap'), {
			center : {
				lat : -34.397,
				lng : 150.644
			},
			zoom : 8
		});

		//좌표 리스트
		var tripNo = "${crtTripNo}";
		$.ajax({
			url : "${pageContext.request.contextPath }/api/inoutList",
			type : "post",
			/* contentType : "application/json", */
			/* data : guestbookVo, */
			data : {
				tripNo : tripNo
			},
			dataType : "json",
			async : false,
			success : function(inoutList) {
				console.log(inoutList);
				if (inoutList.length > 0) {
					for (i = 0; i < inoutList.length; i++) {
						marker[i] = new google.maps.Marker({
							inoutNo : inoutList[i].inoutNo,
							position : new google.maps.LatLng(inoutList[i].lat,
									inoutList[i].lon),
							map : map
						});

						/* marker.addListener('click', function() {
						    console.log(marker.inoutNo);
						}); */

					}

					//마커그린후 위치
					//마지막 마커
					map.setCenter(new google.maps.LatLng(inoutList[0].lat,
							inoutList[0].lon));
				}
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});

	}

	$(".btnInoutNo").on("click", function() {

		var inoutNo = $(this).data("inoutno");
		console.log(inoutNo);

		$.ajax({
			url : "${pageContext.request.contextPath }/api/inout",
			type : "post",
			/* contentType : "application/json", */
			data : {
				inoutNo : inoutNo
			},
			dataType : "json",
			/* async: false, */
			success : function(inoutVo) {
				console.log(inoutVo);
				map.setCenter(new google.maps.LatLng(inoutVo.lat, inoutVo.lon));
				map.setZoom(18);

				$(".memo").html(inoutVo.memo);

				detail(inoutVo.fileList);

			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	});
</script>






<script type="text/javascript">
	function detail(fileList) {
		var str = "";

		for (var i = 0; i < fileList.length; i++) {
			str += " <div> ";
			str += " 	<img class='imgBox' src='${pageContext.request.contextPath}"+fileList[i].webFilePath+"'> ";
			str += "</div> ";
		}
		$(".imgOut2").html(str);
	}
</script>


</html>