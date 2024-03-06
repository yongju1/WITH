<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/7c9e4a6a06.js" crossorigin="anonymous"></script>
    <title>WITH</title>
</head>
<%@ include file="./header.jsp"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=378312520ec4b7c39fcff4eb6a8a7310&libraries=services,clusterer,drawing"></script>
<body>
<div id="map" style="width:100%; height:100%;"></div>
<c:forEach var="i" begin="0" end="${placeList.size()-1}">
   <div id="place_address${i}" data-address="${placeList[i].place_adr1}"></div>
   <div id="place_name${i}" data-placename="${placeList[i].place_name}"></div>
   <div id="place_no${i}" data-placeno="${placeList[i].PLACE_NO}"></div>
</c:forEach>
</body>
<script>
    $(document).ready(function(){
       var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
       mapOption = {
           center: new kakao.maps.LatLng(37.569918, 126.986015), // 지도의 중심좌표
           level: 1 // 지도의 확대 레벨
       };
       // 지도를 생성합니다
       var map = new kakao.maps.Map(mapContainer, mapOption);
       
       var geocoder = new kakao.maps.services.Geocoder();
       
       var no = new Array();
       var name = new Array();
       var addrlist = new Array();
       for (var y=0;y<parseInt("${cnt}");y++){
          
          var t = $("#place_name"+y.toString()).data("placename");
          
          no[y] = $("#place_no"+y).data("placeno");
          name[y] = $("#place_name"+y.toString()).data("placename");
          addrlist[y] = $("#place_address"+y.toString()).data("address");
          console.log(name[y]);
          console.log(addrlist[y]);
          console.log(no[y]);
       }
       
       addrlist.forEach(function(addrlist, index){
            geocoder.addressSearch(addrlist, function(result, status) {
               // 정상적으로 검색이 완료됐으면
                if (status === kakao.maps.services.Status.OK) {
                  var pos = new kakao.maps.LatLng(result[0].y, result[0].x);
                   var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
                   var imageSize = new kakao.maps.Size(24, 35);
                   // 마커 이미지를 생성합니다    
                   var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
                   // 마커를 생성합니다
                   var marker = new kakao.maps.Marker({
                       map: map, // 마커를 표시할 지도
                       position: pos,
                       image : markerImage // 마커 이미지
                   });
                   
                   // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                   //map.setCenter(pos);
                   var content = '<div style="width:150px;text-align:center;padding:6px 0;" class="info">'+name[index]+'</div>';
                   // 인포윈도우로 장소에 대한 설명을 표시합니다
                   var infowindow = new kakao.maps.InfoWindow({
                       content: content
                   });
                   infowindow.open(map, marker);
                   
                // 마커에 클릭이벤트를 등록합니다
                   kakao.maps.event.addListener(marker, 'click', function() {
                         // 마커 위에 인포윈도우를 표시합니다
                	   location.href='http://localhost:8080/place/?place_no='+no[index];
                   });
                   
                   /* $(".info").on("click", function(){
           			location.href="http://localhost:8080/place/?place_no="+no[index];
           			}) */
               }
           });
       });
    });
</script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap');
body{
    font-family: 'Gowun Dodum', sans-serif;
}
</style>