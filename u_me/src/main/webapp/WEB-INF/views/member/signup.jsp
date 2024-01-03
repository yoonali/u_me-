<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <title>u_me</title>
        <link rel="stylesheet" type="text/css" href="${path}/resources/css/signUp.css?after">
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
                                <h4>"Sign Up"</h4>
                            </div>
                        </div>
                        <form method="post" action="signup_ng" id="signUpForm">
                        	<div class="id-input" name="user_id" >
                            <input class="id" id="id" type="text" placeholder="ID" name="user_id">
                        </div>
                        <div class="name-input" name="nickname">
                            <input class="name" id="name" type="text" placeholder="NAME" name="name">
                        </div>
                        <div class="pw-input" name="password">
                            <input class="password" id="password" type="password" placeholder="PASSWORD" name = "password">
                        </div>
                        <div class="pwc-input">
                            <input class="password-check" id="pw_check" type="password" placeholder="PASSWORD CHECK">
                        </div>
                        <div class="phone-input" name="phone">
                            <input class="phone" id="phone" type="text" placeholder="PHONE" name = "phone">
                        </div>
                        <div class="personal">
                            <span class="check_box">
                                <input type="checkbox" id="privacyCheckbox">
                            </span>
                            <span class="pTxt">개인정보처리방침 동의</span>
                        </div>
                        <div class="confirm"  onclick="submitForm(event)">
                            <button class="confirm-btn">“Confirm”</button>
                        </div>
                        </form>
                        
                        <div class="q">
                            <div>Do you have an account?</div>
                        </div>
                        <div class="sign-in">
                            <a href="login"><div class="sign-in-btn" >"Sign In"</div></a>
                        </div>
                    </div>
                </div>
            </div>
           <%@ include file="/WEB-INF/views/common/footer.jsp" %>

        </div>
        
        <script>
        function submitForm() {
        	 event.preventDefault();
        	 
            // 아이디, 비밀번호, 비밀번호 확인을 가져오기
            var id = document.getElementById("id").value;
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("pw_check").value;

            // 필수 입력값 확인
            if (!id || !password || !confirmPassword) {
                alert("모든 필수 항목을 입력하세요.");
                return false; // 폼 제출 방지
            }

            // 비밀번호 일치 여부 확인
            if (password !== confirmPassword) {
                alert("비밀번호가 일치하지 않습니다.");
                return false; // 폼 제출 방지
            }

            // 비밀번호 길이 확인
            if (password.length < 8) {
                alert("비밀번호는 8자 이상이어야 합니다.");
                return false; // 폼 제출 방지
            }

            // 이름에 숫자 포함 여부 확인
            var userName = document.getElementById("name").value;
            if (/\d/.test(userName)) {
                alert("이름에는 숫자를 포함할 수 없습니다.");
                return false; // 폼 제출 방지
            }

            // 약관 동의 여부 확인
            var agreementTerms = document.getElementById("privacyCheckbox").checked;
            var agreementPrivacy = document.getElementById("privacyCheckbox").checked;

            if (!agreementTerms || !agreementPrivacy) {
                alert("약관에 동의해야 합니다.");
                return false; // 폼 제출 방지
            }

            // 모든 조건이 충족되면 폼 제출
            document.getElementById("signUpForm").submit();
            return false;
        }

        </script>
    </body>
</html>