<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="productId" value="${param.productId}" />
<c:set var="userId" value="${sessionScope.loginedUserVo}" />
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
  <meta charset="utf-8">
        <title>u_me</title>
        <link rel="stylesheet" type="text/css" href="${path}/resources/css/productdesc.css">
        <script src="${path}/resources/js/main.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Luxurious+Roman&display=swap" rel="stylesheet">
</head>
    <body>
        <div class="wrapper">
           <%@ include file="/WEB-INF/views/common/header.jsp" %>
            <div class="container">
                <div class="content">
                    <div class="container2">
                        <div class="item_l" id="item_l">
                            <div class="img_d">
	                           	<c:forEach var="img" items="${Imgs}">
	                                <br>
	                                <img src="${img}">
                               </c:forEach>
                            </div>
                        </div>
                        <div class="item_r" id="item_r">
                            <div class="infoArea">
                                <div class="prd_desc">
                                    <p class="prd_name">
                                        <span>${productDetailVo.name}</span>
                                    </p>
                                    <p class="prd_price">
                                        <span>KRW ${productDetailVo.price}</span>
                                    </p>
                                </div>
                                <div>
                                    <select class="size">
                                        <option value="" disabled selected>-[필수] OPTION-</option>
                                        <option value="size-1">S</option>
                                        <option value="size-2">M</option>
                                    </select>
                                </div>
                                <div class="description">
                                    <div class="desc_mainT">
                                        <h4>제품정보</h4>
                                    </div>
                                    <div class="desc_txt" id="product-description">
		                                <p>
		                                    ${productDetailVo.description}
		                                </p>
		                            </div>
		                            <form action="inCart" method="POST">
		                            <input type="hidden" name="product_id" value="${productId}">
		                            <input type="hidden" name="user_id" value="${userId.id}">
                                    <div class="b_btn">
                                        <button>장바구니</button>
                                    </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
       
    
       <%@ include file="/WEB-INF/views/common/footer.jsp" %>

        </div>
    </body>
</html>