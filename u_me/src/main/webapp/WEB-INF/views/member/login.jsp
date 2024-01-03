<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <title>u_me</title>
        <link rel="stylesheet" type="text/css" href="${path}/resources/css/login.css?after">
        <script src="${path}/resources/js/main.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Luxurious+Roman&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="wrapper">
            <%@ include file="/WEB-INF/views/common/header.jsp" %>

            <div class="container">
                <div class="contents">
                    <div class="login">
                        <div class="loginTxt">
                            <div>
                                <h4>"Login"</h4>
                            </div>
                        </div>
                        <form action="loginConfirm" method="post" name="login"> 
	                        <div class="id-input" id="signInForm">
	                            <input class="id" type="text" placeholder="ID" name="user_id">
	                        </div>
	                        <div class="pw-input">
	                            <input class="password" type="password" placeholder="PASSWORD" name="password">
	                        </div>
	                        <div class="sign-in">
	                            <a href="login"><div class="sign-in-btn"><button onclick="handleLoginFormSubmit();">"Sign In"</button></div></a>
	                        </div>
                        </form>
                        <div class="find">
                            <span class="find-id"><a href="/">Find ID</a></span>
                            <span class="slash">/</span>
                            <span class="find-pw"><a href="/">PASSWORD</a></span>
                        </div>
                        <div class="sign-up">
                            <a href="signup"><div class="sign-up-btn">"Sign Up"</div></a>
                        </div>
                    </div>
                </div>
            </div>
            <!--로그인 창 구현 끝-->
            
             <%@ include file="/WEB-INF/views/common/footer.jsp" %>

        </div>
    </body>
</html>