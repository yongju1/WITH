<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://kit.fontawesome.com/7c9e4a6a06.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/css/main.css">
    <title>WITH</title>
</head>

<%@ include file="./header.jsp"%>

<script type="text/javascript">
    var index = 0;   //이미지에 접근하는 인덱스
    window.onload = function () {
        slideShow();
    }

    function slideShow() {
        var i;
        var x = document.getElementsByClassName("infobox2");  //infobox에 대한 dom 참조
        var y = document.getElementsByClassName("infobox3");
        var z = document.getElementsByClassName("infobox4");
        var a = document.getElementsByClassName("infobox5");
        var b = document.getElementsByClassName("infobox6");

        for (i = 0; i < x.length; i++) {
            x[i].style.display = "none";   //처음에 전부 display를 none으로 한다.
            y[i].style.display = "none";
            z[i].style.display = "none";
            a[i].style.display = "none";
            b[i].style.display = "none";
        }
        index++;
        if (index > x.length) {
            index = 1;  //인덱스가 초과되면 1로 변경
        }
        x[index - 1].style.display = "block";  //해당 인덱스는 block으로
        y[index - 1].style.display = "block";
        z[index - 1].style.display = "block";
        a[index - 1].style.display = "block";
        b[index - 1].style.display = "block";
        setTimeout(slideShow, 3000);   //함수를 4초마다 호출

    }
</script>

    <body>
    <div class="main" style="margin-top: 20px;">
        <div class="content">
        <c:choose>
        	<c:when test="${type0.size()-1 < 0 }">
        	<h2 style="margin: 200px auto">해당 장소가 없습니다.</h2>
        	</c:when>
        	<c:otherwise>
        	<c:forEach var="i" begin="0" end="${type0.size()-1}">
        		<c:choose>
	        		<c:when test="${i==0}">
		            	<div class="infobox" style="margin-left: 0;" onclick="location.href='${pageContext.request.contextPath}/place/?place_no=${type0[i].PLACE_NO}'">
		            </c:when>
		            <c:otherwise>
		            	<div class="infobox" onclick="location.href='${pageContext.request.contextPath}/place/?place_no=${type0[i].PLACE_NO}'">
		            </c:otherwise>
	            </c:choose>
	                <img src="/resources/img/${type0[i].place_img1}">
	                <div style="margin-left: 5%; margin-top: 3%;">
	                    <span style="font-size: 18px;">${type0[i].place_name}</span>
	                    <c:choose>
								<c:when test="${not empty sessionScope.user}">
									<c:choose>
										<c:when test="${bookList.contains(type0[i].PLACE_NO)}">
											<a
												href="${pageContext.request.contextPath}/bookmarkRemove?&place_no=${type0[i].PLACE_NO}"
												class="bookmarkBtn" data-place-id="${type0[i].PLACE_NO}"
												style="color: '#ff0000';">
												<i class="fa-solid fa-bookmark fa-lg" style="color: #ffffff;"></i>
											</a>
										</c:when>
										<c:otherwise>
											<a
												href="${pageContext.request.contextPath}/bookmarkAdd?&place_no=${type0[i].PLACE_NO}"
												class="bookmarkBtn" data-place-id="${type0[i].PLACE_NO}"
												style="color: '#ffffff';">
												<i class="fa-regular fa-bookmark fa-lg" style="color: #FFFFFF;"></i>
											</a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<a style="color: '#ffffff';" class="click" href="${pageContext.request.contextPath}/account/login"><i class="fa-regular fa-bookmark fa-lg" style="color: #FFFFFF;"></i></a>
								</c:otherwise>
							</c:choose>


							<div style="margin-top: 5%;">
	                        <span style="font-size: 15px;">${type0[i].place_adr1} ${type0[i].place_adr2}</span>
	                    </div>
	                </div>
	            </div>
	        </c:forEach>
	        </c:otherwise>
	        </c:choose>
            <div class="mainbox">
                <h1 style="padding-left: 30%; padding-top: 60%;">맛집 BEST</h1>
            </div>
        </div>

    </div>
    <div class="main" style="float: right;">
        <div class="content">
            <div class="mainbox" style="margin-left: 0;">
                <h1 style="padding-left: 30%; padding-top: 60%;">카페 BEST</h1>
            </div>
            <c:choose>
        	<c:when test="${type1.size()-1 < 0 }">
        	<h2 style="margin: 200px auto">해당 장소가 없습니다.</h2>
        	</c:when>
        	<c:otherwise>
            <c:forEach var="i" begin="0" end="${type1.size()-1}">
	            <div class="infobox" onclick="location.href='${pageContext.request.contextPath}/place/?place_no=${type1[i].PLACE_NO}'">
	                <img src="/resources/img/${type1[i].place_img1}">
	                <div style="margin-left: 5%; margin-top: 3%;">
	                    <span style="font-size: 18px;">${type1[i].place_name}</span>
	                    <c:choose>
		                    <c:when test="${bookList.contains(type1[i].PLACE_NO)}">
		                    	<a href="${pageContext.request.contextPath}/bookmarkRemove?&place_no=${type1[i].PLACE_NO}" class="bookmarkBtn" data-place-id="${type1[i].PLACE_NO}" style="color:'#ff0000';">
	                   			<i class="fa-solid fa-bookmark fa-lg" style="color: #ffffff;"></i>
	                   			</a>
	                   		</c:when>
	                   		<c:otherwise>
	                   			<a href="${pageContext.request.contextPath}/bookmarkAdd?&place_no=${type1[i].PLACE_NO}" class="bookmarkBtn" data-place-id="${type1[i].PLACE_NO}" style="color:'#ffffff';">
	                   			<i class="fa-regular fa-bookmark fa-lg" style="color: #FFFFFF;"></i>
	                   			</a>
	                   		</c:otherwise>
                        </c:choose>
	                    <div style="margin-top: 5%;">
	                        <span style="font-size: 15px;">${type1[i].place_adr1} ${type1[i].place_adr2}</span>
	                    </div>
	                </div>
	            </div>
	        </c:forEach>
	        </c:otherwise>
	        </c:choose>
        </div>
    </div>

    <div class="main2">
        <div class="content2">
            <div class="box">
                <p style="text-align: center; margin-bottom: 10px;"><span style="color: black;">서울 Best</span></p>
                <c:choose>
	        	<c:when test="${type2.size()-1 < 0 }">
	        	<h2 style="margin: 200px auto">해당 장소가 없습니다.</h2>
	        	</c:when>
	        	<c:otherwise>
                <c:forEach var="i" begin="0" end="${type2.size()-1}">
	                <div class="infobox2" onclick="location.href='${pageContext.request.contextPath}/place/?place_no=${type2[i].PLACE_NO}'">
	                    <img src="/resources/img/${type2[i].place_img1}">
	                    <div style="margin-left: 5%; margin-top: 3%;">
	                        <span style="font-size: 18px;">${type2[i].place_name}</span>
	                        <c:choose>
		                    <c:when test="${bookList.contains(type2[i].PLACE_NO)}">
		                    	<a href="${pageContext.request.contextPath}/bookmarkRemove?&place_no=${type2[i].PLACE_NO}"class="bookmarkBtn" data-place-id="${type2[i].PLACE_NO}" style="color:'#ff0000';">
	                   			<i class="fa-solid fa-bookmark fa-lg" style="color: #ffffff;"></i>
	                   			</a>
	                   		</c:when>
	                   		<c:otherwise>
	                   			<a href="${pageContext.request.contextPath}/bookmarkAdd?&place_no=${type2[i].PLACE_NO}" class="bookmarkBtn" data-place-id="${type2[i].PLACE_NO}" style="color:'#ffffff';">
	                   			<i class="fa-regular fa-bookmark fa-lg" style="color: #FFFFFF;"></i>
	                   			</a>
	                   		</c:otherwise>
                        </c:choose>
	                        <div style="margin-top: 5%;">
	                            <span style="font-size: 15px;">${type2[i].place_adr1} ${type2[i].place_adr2}</span>
	                        </div>
	                    </div>
	                </div>
	            </c:forEach>
	            </c:otherwise>
	            </c:choose>
            </div>
            <div class="box">
                <p style="text-align: center; margin-bottom: 10px;"><span style="color: black;">경기 Best</span></p>
                <c:choose>
	        	<c:when test="${type3.size()-1 < 0 }">
	        	<h2 style="margin: 200px auto">해당 장소가 없습니다.</h2>
	        	</c:when>
	        	<c:otherwise>
                <c:forEach var="i" begin="0" end="${type3.size()-1}">
	                <div class="infobox3" onclick="location.href='${pageContext.request.contextPath}/place/?place_no=${type3[i].PLACE_NO}'">
	                    <img src="/resources/img/${type3[i].place_img1}">
	                    <div style="margin-left: 5%; margin-top: 3%;">
	                        <span style="font-size: 18px;">${type3[i].place_name}</span>
	                        <c:choose>
		                    <c:when test="${bookList.contains(type3[i].PLACE_NO)}">
		                    	<a href="${pageContext.request.contextPath}/bookmarkRemove?&place_no=${type3[i].PLACE_NO}" class="bookmarkBtn" data-place-id="${type3[i].PLACE_NO}" style="color:'#ff0000';">
	                   			<i class="fa-solid fa-bookmark fa-lg" style="color: #ffffff;"></i>
	                   			</a>
	                   		</c:when>
	                   		<c:otherwise>
	                   			<a href="${pageContext.request.contextPath}/bookmarkAdd?&place_no=${type3[i].PLACE_NO}" class="bookmarkBtn" data-place-id="${type3[i].PLACE_NO}" style="color:'#ffffff';">
	                   			<i class="fa-regular fa-bookmark fa-lg" style="color: #FFFFFF;"></i>
	                   			</a>
	                   		</c:otherwise>
                        </c:choose>
	                        <div style="margin-top: 5%;">
	                            <span style="font-size: 15px;">${type3[i].place_adr1} ${type3[i].place_adr2}</span>
	                        </div>
	                    </div>
	                </div>
	            </c:forEach>
	            </c:otherwise>
	            </c:choose>
            </div>
            <div class="box">
                <p style="text-align: center; margin-bottom: 10px;"><span style="color: black;">강원 best</span></p>
                <c:choose>
	        	<c:when test="${type4.size()-1 < 0 }">
	        	<h2 style="margin: 200px auto">해당 장소가 없습니다.</h2>
	        	</c:when>
	        	<c:otherwise>
                <c:forEach var="i" begin="0" end="${type4.size()-1}">
	                <div class="infobox4" onclick="location.href='${pageContext.request.contextPath}/place/?place_no=${type4[i].PLACE_NO}'">
	                    <img src="/resources/img/${type4[i].place_img1}">
	                    <div style="margin-left: 5%; margin-top: 3%;">
	                        <span style="font-size: 18px;">${type4[i].place_name}</span>
	                        <c:choose>
		                    <c:when test="${bookList.contains(type4[i].PLACE_NO)}">
		                    	<a href="${pageContext.request.contextPath}/bookmarkRemove?&place_no=${type4[i].PLACE_NO}" class="bookmarkBtn" data-place-id="${type4[i].PLACE_NO}" style="color:'#ff0000';">
	                   			<i class="fa-solid fa-bookmark fa-lg" style="color: #ffffff;"></i>
	                   			</a>
	                   		</c:when>
	                   		<c:otherwise>
	                   			<a href="${pageContext.request.contextPath}/bookmarkAdd?&place_no=${type4[i].PLACE_NO}" class="bookmarkBtn" data-place-id="${type4[i].PLACE_NO}" style="color:'#ffffff';">
	                   			<i class="fa-regular fa-bookmark fa-lg" style="color: #FFFFFF;"></i>
	                   			</a>
	                   		</c:otherwise>
                        </c:choose>
	                        <div style="margin-top: 5%;">
	                            <span style="font-size: 15px;">${type4[i].place_adr1} ${type4[i].place_adr2}</span>
	                        </div>
	                    </div>
	                </div>
	            </c:forEach>
	            </c:otherwise>
	            </c:choose>
            </div>
            <div class="box">
                <p style="text-align: center; margin-bottom: 10px;"><span style="color: black;">부산 BEST</span></p>
                <c:choose>
	        	<c:when test="${type5.size()-1 < 0 }">
	        	<h2 style="margin: 200px auto">해당 장소가 없습니다.</h2>
	        	</c:when>
	        	<c:otherwise>
                <c:forEach var="i" begin="0" end="${type5.size()-1}">
	                <div class="infobox5" onclick="location.href='${pageContext.request.contextPath}/place/?place_no=${type5[i].PLACE_NO}'">
	                    <img src="/resources/img/${type5[i].place_img1}">
	                    <div style="margin-left: 5%; margin-top: 3%;">
	                        <span style="font-size: 18px;">${type5[i].place_name}</span>
	                        <c:choose>
		                    <c:when test="${bookList.contains(type5[i].PLACE_NO)}">
		                    	<a href="${pageContext.request.contextPath}/bookmarkRemove?&place_no=${type5[i].PLACE_NO}" class="bookmarkBtn" data-place-id="${type5[i].PLACE_NO}" style="color:'#ff0000';">
	                   			<i class="fa-solid fa-bookmark fa-lg" style="color: #ffffff;"></i>
	                   			</a>
	                   		</c:when>
	                   		<c:otherwise>
	                   			<a href="${pageContext.request.contextPath}/bookmarkAdd?&place_no=${type5[i].PLACE_NO}" class="bookmarkBtn" data-place-id="${type5[i].PLACE_NO}" style="color:'#ffffff';">
	                   			<i class="fa-regular fa-bookmark fa-lg" style="color: #FFFFFF;"></i>
	                   			</a>
	                   		</c:otherwise>
                        </c:choose>
	                        <div style="margin-top: 5%;">
	                            <span style="font-size: 15px;">${type5[i].place_adr1} ${type5[i].place_adr2}</span>
	                        </div>
	                    </div>
	                </div>
                </c:forEach>
                </c:otherwise>
                </c:choose>
            </div>
            <div class="box">
                <p style="text-align: center; margin-bottom: 10px;"><span style="color: black;">제주 BEST</span></p>
                <c:choose>
	        	<c:when test="${type6.size()-1 < 0 }">
	        	<h2 style="margin: 200px auto">해당 장소가 없습니다.</h2>
	        	</c:when>
	        	<c:otherwise>
                <c:forEach var="i" begin="0" end="${type6.size()-1}">
	                <div class="infobox6" onclick="location.href='${pageContext.request.contextPath}/place/?place_no=${type6[i].PLACE_NO}'">
	                    <img src="/resources/img/${type6[i].place_img1}">
	                    <div style="margin-left: 5%; margin-top: 3%;">
	                        <span style="font-size: 18px;">${type6[i].place_name}</span>
	                        <c:choose>
		                    <c:when test="${bookList.contains(type6[i].PLACE_NO)}">
		                    	<a href="${pageContext.request.contextPath}/bookmarkRemove?&place_no=${type6[i].PLACE_NO}" class="bookmarkBtn" data-place-id="${type6[i].PLACE_NO}" style="color:'#ff0000';">
	                   			<i class="fa-solid fa-bookmark fa-lg" style="color: #ffffff;"></i>
	                   			</a>
	                   		</c:when>
	                   		<c:otherwise>
	                   			<a href="${pageContext.request.contextPath}/bookmarkAdd?&place_no=${type6[i].PLACE_NO}" class="bookmarkBtn" data-place-id="${type6[i].PLACE_NO}" style="color:'#ffffff';">
	                   			<i class="fa-regular fa-bookmark fa-lg" style="color: #FFFFFF;"></i>
	                   			</a>
	                   		</c:otherwise>
                        </c:choose>
	                        <div style="margin-top: 5%;">
	                            <span style="font-size: 15px;">${type6[i].place_adr1} ${type6[i].place_adr2}</span>
	                        </div>
	                    </div>
	                </div>
                </c:forEach>
                </c:otherwise>
                </c:choose>
            </div>
            <!-- <div class="mainbox">
                <h1 style="padding-left: 30%; padding-top: 30%;">지역별 BEST</h1>
            </div> -->
        </div>
    </div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	$(".click").on("click", function(){
		alert("로그인이 필요한 페이지 입니다.")
	})
})
</script>