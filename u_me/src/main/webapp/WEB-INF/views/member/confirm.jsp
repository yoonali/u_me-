<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <title>u_me</title>
        <link rel="stylesheet" type="text/css" href="${path}/resources/css/ok.css">
        <script src="${path}/resources/js/main.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Luxurious+Roman&display=swap" rel="stylesheet">
    </head>
  <body>
    <div class="wrapper">
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
      <div class="container">
        <div class="contents">
          <div class="confirm">
            <div class="confirmTxt">
              <div>
                <h4>회원가입이 완료되었습니다</h4>
              </div>
            </div>
            <div class="s_info">
              <div class="id">
                <p>
                  <span><img src="${path}/resources/res/heart.png" width="10px" /></span>
                  아이디
                </p>
                <strong><c:out value="${user_id}"/></strong>
              </div>
              <div class="name">
                <p>
                  <span><img src="${path}/resources/res/heart.png" width="10px" /></span>
                  이름
                </p>
                <strong><c:out value="${name}"/></strong>
              </div>
            </div>
            <div class="go-to-main">
              <a href="${path}/login"
                ><div class="main-btn">로그인 하러가기</div>
              </a>
            </div>
          </div>
        </div>
      </div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div>
  </body>
</html>
