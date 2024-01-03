<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <title>u_me</title>
        <link rel="stylesheet" type="text/css" href="${path}/resources/css/main.css">
        <script src="${path}/resources/js/main.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Luxurious+Roman&display=swap" rel="stylesheet">
    </head>
    <body id="main">
        <div id="wrapper">
             <%@ include file="/WEB-INF/views/common/header.jsp" %>
     
            <div class="main_pic">
                <img id="pic1" src="${path}/resources/res/main.png" alt="메인 사진">
            </div>
    
            <div class="m_banner">
                <div class="Inner">
                    <div class="bnTxt">
                        <h4>“You're the prettiest woman in Beverly Hills.”</h4>
                        <p>2023 fall - winter Collection</p>
                    </div>
                    <div class="imgArea">
                        <img src="${path}/resources/res/bn_img.png" alt="베너 사진">
                    </div>
                </div>
            </div>
    
            <div class="c_banner">
                <div class="content">
                    <div class="content-1">
                        <div class="img1">
                            <a href="/">
                                <img src="${path}/resources/res/prd1.png">
                            </a>
                        </div>
                        <div class="contentTxt1">
                            <p>Two Ribbon cardigan - ivory</p>
                            <p>KRW 15,000</p>
                        </div>
                    </div>
                    <div class="content-2">
                        <div class="img2">
                            <a href="/">
                                <img src="${path}/resources/res/prd2.png">
                            </a>
                        </div>
                        <div class="contentTxt2">
                            <p>mink knit cardigan - pink</p>
                            <p>KRW 23,000</p>
                        </div>
                    </div>
                    <div class="content-3">
                        <div class="img3">
                            <a href="/">
                                <img src="${path}/resources/res/prd4.png">
                            </a>
                        </div>
                        <div class="contentTxt3">
                            <p>Fluffy skirt - gray</p>
                            <p>KRW 34,000</p>
                        </div>
                    </div>
                </div>
            </div>
    
         <%@ include file="/WEB-INF/views/common/footer.jsp" %>
        </div>
    </body>
</html>
