<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://kit.fontawesome.com/7c9e4a6a06.js" crossorigin="abuttonnonymous"></script>
    <link rel="stylesheet" href="/resources/css/adminPlaceUpdate.css">
    <title>WITH</title>
</head>
<%@ include file="../header.jsp"%>
<%@ include file="../adminSidebar.jsp"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(document).ready(function(){
	// 이미지 변경시 텍스트 이미지 텍스트 변경
	$(".place_img1").on("change", function(){
		var str = $(".place_img1").val().toString();
		var name = str.split("\\")[2];
		$("#img_name1").val(name);
	});
	$(".place_img2").on("change", function(){
		var str = $(".place_img2").val().toString();
		var name = str.split("\\")[2];
		$("#img_name2").val(name); 
	});
	$(".place_img3").on("change", function(){
		var str = $(".place_img3").val().toString();
		var name = str.split("\\")[2];
		$("#img_name3").val(name); 
	});
	// 취소
	$(".cancle").on("click", function(){
		location.href = "../admin/adminPlaceList";
	});
	// 우편번호 찾기
	$("#find_zipcode").on("click", function(){
		new daum.Postcode({
			oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	           	document.getElementById("place_zipcode").value = data.zonecode;
	           	document.getElementById("place_adr1").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("place_adr2").focus();
	        }
    	}).open();
	});
	// 등록
	$("#addLocation").on("click", function(){
		if($("#place_name").val()==""){
			alert("상호명을 입력해주세요.");
			$("#place_name").focus();
			return false;
		}
		if($("#place_detail").val()==""){
			alert("상세설명을 입력해주세요.");
			$("#place_detail").focus();
			return false;
		}
		if($("#place_zipcode").val()==""){
			alert("우편번호를 입력해주세요.");
			$("#place_zipcode").focus();
			return false;
		}
		if($("#place_adr1").val()==""){
			alert("주소를 입력해주세요.");
			$("#place_adr1").focus();
			return false;
		}
		if($("#place_adr2").val()==""){
			alert("상세주소를 입력해주세요.");
			$("#place_adr2").focus();
			return false;
		}
		if($("#place_phone").val()==""){
			alert("전화번호를 입력해주세요.");
			$("#place_phone").focus();
			return false;
		}
		if($("#place_menu").val()==""){
			alert("추천메뉴를 입력해주세요.");
			$("#place_menu").focus();
			return false;
		}
		if($("#place_bhours").val()==""){
			alert("영업시간을 입력해주세요.");
			$("#place_runtime").focus();
			return false;
		}
		if($("#place_dayoff").val()==""){
			alert("휴무일을 입력해주세요.");
			$("#place_breaktime").focus();
			return false;
		}
		// 임시로 주석 처리
		/* if($(".place_img1").val()=="" || $(".place_img2").val()=="" || $(".place_img3").val()==""){
			alert("이미지를 입력해주세요.");
			return false;
		} */
		
		// 이미지를 일단 배열로 등록
		// $(".place_img").val()=$(".place_img1").val()+","+$(".place_img2").val()+","+$(".place_img3").val();
		
		$("#placeUpdateForm").submit();
	})
})
</script>
<body>
 <section>
   <form action="/admin/adminPlaceUpdate" method="post" id="placeUpdateForm" enctype="multipart/form-data">
     <div class="admininfo">
         <div class="write">
             <h1 style="text-align: center; margin: 30px 0 30px 0;">장소 수정</h1>
             <input type="hidden" name="PLACE_NO" value="${placeinfo.PLACE_NO}" />
                 <div class="container goods_add">
                     <div class="goods_content">
                         <div class="goodsbox">
                             <label class="form-label">상호명</label>
                             <input type="text" class="form-control" id="place_name" name="place_name" value="${placeinfo.place_name}">
                         </div>
                         <div class="goodsbox">
                             <label class="form-label">상세설명</label>
                             <input type="text" class="form-control" id="place_detail" name="place_detail" value="${placeinfo.place_detail}">
                         </div>
                         <div class="goodsbox">
                             <label class="form-label">카테고리</label>
                             <div class="inputRadio">
                                 <div class="form-radio">
                                     <input class="form-radio-input" type="radio" value=0 id="cate1" name="place_type"
                                         checked>
                                     <label class="form-radio-label" for="cate1"
                                         style="margin-right: 10px;">맛집</label>
                                 </div>
                                 <div class="form-radio">
                                     <input class="form-radio-input" type="radio" value=1 id="cate2" name="place_type">
                                     <label class="form-check-label" for="cate2"
                                         style="margin-right: 10px;">카페</label>
                                 </div>
                             </div>
                         </div>

                         <div class="goodsbox">
                             <label class="form-label">우편번호</label>

                             <div class="input-group">
                                 <input type="text" class="form-control" id="place_zipcode" name="place_zipcode" value="${placeinfo.place_zipcode}">
                             </div>
                             <input type=button class=find-zip-btn id="find_zipcode" value="주소검색" />

                         </div>
                         
                          <div class="goodsbox">
                             <label class="form-label">주소</label>

                             <div class="input-group">
                                 <input type="text" class="form-control" id="place_adr1" name="place_adr1" value="${placeinfo.place_adr1}">
                             </div>

                         </div>
                         
                          <div class="goodsbox">
                             <label class="form-label">상세주소</label>

                             <div class="input-group">
                                 <input type="text" class="form-control" id="place_adr2" name="place_adr2" value="${placeinfo.place_adr2}">
                             </div>

                         </div>

                         <div class="goodsbox">
                             <label class="form-label">전화번호</label>

                             <input type="text" class="form-control" id="place_phone" name="place_phone" value="${placeinfo.place_phone}">

                         </div>

                         <div class="goodsbox">
                             <label class="form-label">추천메뉴</label>

                             <input type="text" class="form-control" id="place_menu" name="place_menu" value="${placeinfo.place_menu}">

                         </div>

                         <div class="goodsbox">
                             <label class="form-label">영업시간</label>

                             <input type="text" class="form-control" id="place_bhours" name="place_bhours" value="${placeinfo.place_bhours}">

                         </div>

                         <div class="goodsbox">
                             <label class="form-label">휴무일</label>

                             <div class="input-group">
                                 <input type="text" class="form-control" id="place_dayoff" name="place_dayoff" value="${placeinfo.place_dayoff}">
                             </div>

                         </div>

                         <div class="goodsbox">
                             <label class="form-label">메인 이미지</label>
                             <div class="input-img">
                                 <input type="text" class="upload-name" id="img_name1" name="place_img1" value="${placeinfo.place_img1}" readonly>
                                 <label for="upload-file1">파일선택</label>
                                 <input type="file" id="upload-file1" name="upload1" class="place_img1" required>
                             </div>
                         </div>

                         <div class="goodsbox">

                             <label class="form-label">상세 이미지</label>
                             <div class="input-img">
                                 <input type="text" class="upload-name" id="img_name2" name="place_img2" value="${placeinfo.place_img2}" readonly>
                                 <label for="upload-file2">파일선택</label>
                                 <input type="file" id="upload-file2" name="upload2" class="place_img2" required>
                             </div>
                         </div>
                         
                         <div class="goodsbox">

                             <label class="form-label">상세 이미지2</label>
                             <div class="input-img">
                                 <input type="text" class="upload-name" id="img_name3" name="place_img3" value="${placeinfo.place_img3}" readonly>
                                 <label for="upload-file3">파일선택</label>
                                 <input type="file" id="upload-file3" name="upload3" class="place_img3" required>
                             </div>
                         </div>
                     </div>
                 </div>
           
             <div class="btnarea" style="margin-top: 5%;">
                 <input type="submit" id="addLocation" value="등록" />
                 <button style="border: 2px solid black;" class="cancle">취소</button>
             </div>
         </div>
     </div>
   </form>
 </section>
</body>
<footer>

</footer>

</html>