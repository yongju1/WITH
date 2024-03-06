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

<script>
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
    <div class="main">
        <div class="content">
        	<c:forEach var="i" begin="0" end="${type0.size()-1}">
        		<c:choose>
	        		<c:when test="${i==0}">
		            	<div class="infobox" style="margin-left: 0;">
		            </c:when>
		            <c:otherwise>
		            	<div class="infobox">
		            </c:otherwise>
	            </c:choose>
	                <img src="/resources/img/${type0[i].place_img}">
	                <div style="margin-left: 5%; margin-top: 3%;">
	                    <span style="font-size: 18px;">${type0[i].place_name}</span>
	                    <a><i class="fa-regular fa-bookmark fa-lg" style="color: #ffffff;"></i></a>
	                    <div style="margin-top: 5%;">
	                        <span style="font-size: 15px;">${type0[i].place_adr1}${type0[i].place_adr2}</span>
	                    </div>
	                </div>
	            </div>
	        </c:forEach>
            <div class="mainbox">
                <h1 style="padding-left: 30%; padding-top: 30%;">맛집 BEST</h1>
            </div>
        </div>

    </div>
    <div class="main" style="float: right;">
        <div class="content">
            <div class="mainbox" style="margin-left: 0;">
                <h1 style="padding-left: 30%; padding-top: 30%;">카페 BEST</h1>
            </div>
            <c:forEach var="i" begin="0" end="${type1.size()-1}">
	            <div class="infobox">
	                <img src="/resources/img/${type1[i].place_img}">
	                <div style="margin-left: 5%; margin-top: 3%;">
	                    <span style="font-size: 18px;">${type1[i].place_name}</span>
	                    <i class="fa-regular fa-bookmark fa-lg" style="color: #ffffff;"></i>
	                    <div style="margin-top: 5%;">
	                        <span style="font-size: 15px;">${type1[i].place_adr1}${type1[i].place_adr2}</span>
	                    </div>
	                </div>
	            </div>
	        </c:forEach>
        </div>
    </div>

    <div class="main2">
        <div class="content2">
            <div class="box">
                <p style="text-align: center;">서울 Best</p>
                <c:forEach var="i" begin="0" end="${type2.size()-1}">
	                <div class="infobox2">
	                    <img src="/resources/img/${type2[i].place_img}">
	                    <div style="margin-left: 5%; margin-top: 3%;">
	                        <span style="font-size: 18px;">${type2[i].place_name}</span>
	                        <i class="fa-regular fa-bookmark fa-lg" style="color: #ffffff;"></i>
	                        <div style="margin-top: 5%;">
	                            <span style="font-size: 15px;">${type2[i].place_adr1}${type2[i].place_adr2}</span>
	                        </div>
	                    </div>
	                </div>
	            </c:forEach>
            </div>
            <div class="box">
                <p style="text-align: center;">경기 Best</p>
                <c:forEach var="i" begin="0" end="${type3.size()-1}">
	                <div class="infobox3">
	                    <img src="/resources/img/${type3[i].place_img}">
	                    <div style="margin-left: 5%; margin-top: 3%;">
	                        <span style="font-size: 18px;">${type3[i].place_name}</span>
	                        <i class="fa-regular fa-bookmark fa-lg" style="color: #ffffff;"></i>
	                        <div style="margin-top: 5%;">
	                            <span style="font-size: 15px;">${type3[i].place_adr1}${type3[i].place_adr2}</span>
	                        </div>
	                    </div>
	                </div>
	            </c:forEach>
            </div>
            <div class="box">
                <p style="text-align: center;">강원 best</p>
                <c:forEach var="i" begin="0" end="${type4.size()-1}">
	                <div class="infobox4">
	                    <img src="/resources/img/${type4[i].place_img}">
	                    <div style="margin-left: 5%; margin-top: 3%;">
	                        <span style="font-size: 18px;">${type4[i].place_name}</span>
	                        <i class="fa-regular fa-bookmark fa-lg" style="color: #ffffff;"></i>
	                        <div style="margin-top: 5%;">
	                            <span style="font-size: 15px;">${type4[i].place_adr1}${type4[i].place_adr2}</span>
	                        </div>
	                    </div>
	                </div>
	            </c:forEach>
            </div>
            <div class="box">
                <p style="text-align: center;">부산 BEST</p>
                <c:forEach var="i" begin="0" end="${type5.size()-1}">
	                <div class="infobox5">
	                    <img src="/resources/img/${type5[i].place_img}">
	                    <div style="margin-left: 5%; margin-top: 3%;">
	                        <span style="font-size: 18px;">${type5[i].place_name}</span>
	                        <i class="fa-regular fa-bookmark fa-lg" style="color: #ffffff;"></i>
	                        <div style="margin-top: 5%;">
	                            <span style="font-size: 15px;">${type5[i].place_adr1}${type5[i].place_adr2}</span>
	                        </div>
	                    </div>
	                </div>
                </c:forEach>
            </div>
            <div class="box">
                <p style="text-align: center;">제주 BEST</p>
                <c:forEach var="i" begin="0" end="${type6.size()-1}">
	                <div class="infobox6">
	                    <img src="/resources/img/${type6[i].place_img}">
	                    <div style="margin-left: 5%; margin-top: 3%;">
	                        <span style="font-size: 18px;">${type5[i].place_name}</span>
	                        <i class="fa-regular fa-bookmark fa-lg" style="color: #ffffff;"></i>
	                        <div style="margin-top: 5%;">
	                            <span style="font-size: 15px;">${type6[i].place_adr1}${type6[i].place_adr2}</span>
	                        </div>
	                    </div>
	                </div>
                </c:forEach>
            </div>
            <!-- <div class="mainbox">
                <h1 style="padding-left: 30%; padding-top: 30%;">지역별 BEST</h1>
            </div> -->
        </div>
    </div>
</body>
