<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.myshop.u_me.vo.UserVo" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
  <meta charset="utf-8">
        <title>u_me</title>
        <link rel="stylesheet" type="text/css" href="${path}/resources/css/header.css">
        <script src="${path}/resources/js/main.js"></script>
        <script>
		    window.onload = function() {
		        var logoutMessage = '<%= request.getAttribute("logoutMessage") %>';
		        if (logoutMessage && logoutMessage.length > 0 && logoutMessage !== 'null') {
		            alert(logoutMessage);
		        }
		    };
		</script>
        <link href="https://fonts.googleapis.com/css2?family=Luxurious+Roman&display=swap" rel="stylesheet">
</head>
<body>
	<%
	UserVo loginedUserVo = (UserVo) session.getAttribute("loginedUserVo");
	if(loginedUserVo != null) {
		//로그인 후
	%>
	
	 <div id="header" class="pcHeader">
                <div class="headerInner">
                    <div class="shop">
                        <a href="" class="shop-btn">shop</a>
                            <div class="modal" id="myModal">
                                <div class="modal-content">
                                    <ul>
                                        <a class="font-shop">shop</a>
                                        <a href="" class="close">
                                            <img src="${path}/resources/res/close.png" alt="close-btn">
                                        </a>
                                        <li>
                                            <a href="category?categoryId=1">New</a>
                                        </li>
                                        <li>
                                            <a href="category?categoryId=2">Clothes</a>
                                        </li>
                                        <li>
                                            <a href="category?categoryId=3">Bag</a>
                                        </li>
                                        <li>
                                            <a href="category?categoryId=4">Cap</a>
                                        </li>
                                        <li>
                                            <a href="category?categoryId=5">Acc</a>
                                        </li>
                                        <li>
                                            <a href="category?categoryId=6">View All</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                    </div>
                    <div class="main_name">
                        <a href="home">"u_me"</a>
                    </div>
                    <div class="hMenu">
                        <a href="">
                            <img src="${path}/resources/res/hamburger.png" alt="메뉴바">
                        </a>
                        <div class="ham" id="hamBar">
                            <div class="ham-content">
                                <ul>
                                    <a href="" class="hamClose">
                                        <img src="${path}/resources/res/close (2).png" alt="close-btn">
                                    </a>
                                    <li>
                                        <a href="logoutConfirm">Logout</a>
                                    </li>
                                    <li>
                                        <a href="mypage">My Page</a>
                                    </li>
                                    <li>
                                        <a href="cart">Cart</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 헤더 끝 -->
      <%
      }else {
        //로그인 전
      %>
      
       <div id="header" class="pcHeader">
                <div class="headerInner">
                    <div class="shop">
                        <a href="" class="shop-btn">shop</a>
                            <div class="modal" id="myModal">
                                <div class="modal-content">
                                    <ul>
                                        <a class="font-shop">shop</a>
                                        <a href="" class="close">
                                            <img src="${path}/resources/res/close.png" alt="close-btn">
                                        </a>
                                        <li>
                                            <a href="category?categoryId=1">New</a>
                                        </li>
                                        <li>
                                            <a href="category?categoryId=2">Clothes</a>
                                        </li>
                                        <li>
                                            <a href="category?categoryId=3">Bag</a>
                                        </li>
                                        <li>
                                            <a href="category?categoryId=4">Cap</a>
                                        </li>
                                        <li>
                                            <a href="category?categoryId=5">Acc</a>
                                        </li>
                                        <li>
                                            <a href="category?categoryId=6">View All</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                    </div>
                    <div class="main_name">
                        <a href="home">"u_me"</a>
                    </div>
                    <div class="hMenu">
                        <a href="">
                            <img src="${path}/resources/res/hamburger.png" alt="메뉴바">
                        </a>
                        <div class="ham" id="hamBar">
                            <div class="ham-content">
                                <ul>
                                    <a href="" class="hamClose">
                                        <img src="${path}/resources/res/close (2).png" alt="close-btn">
                                    </a>
                                    <li>
                                        <a href="login">Login</a>
                                    </li>
                                    <li>
                                        <a href="mypage">My Page</a>
                                    </li>
                                    <li>
                                        <a href="cart">Cart</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 헤더 끝 -->
      <%
      }
      %>
</body>
</html>