<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
         <meta charset="utf-8">
        <title>u_me</title>
        <link rel="stylesheet" type="text/css" href="${path}/resources/css/category.css">
        <script src="${path}/resources/js/main.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Luxurious+Roman&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="wrapper">
        
         <%@ include file="/WEB-INF/views/common/header.jsp" %>
       
            <div class="container">
                <div class="contents">
                    <div class="products">
                        <div class="mainTxt">
						    <h4>"${categoryName}"</h4>
                        </div>
                 
                        <div class="shop_productwrap">
                            <ul class="prdList grid4">
                           	<c:forEach var="product" items="${ProductVos}" varStatus="loop">
                                <li class="prdWrapper_${product.category_id}">
                                    <a href="product?productId=${loop.index + 1}">
                                    	<div class="prd_${product.category_id}">
                                            <div class="prdImg">
                                               <img src="${product.img}">
                                            </div>
                                        <div class="description">
                                            <p name>
                                              	<span>${product.name}</span>
                                            </p>
                                            <p name>
                                               <span>KRW ${product.price}</span>
                                            </p>
                                        </div>
                                    </div>
                                    </a>
                                </li>
                                 </c:forEach>
                                 
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

           <%@ include file="/WEB-INF/views/common/footer.jsp" %>

        </div>
    </body>
</html>