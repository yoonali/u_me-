<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.myshop.u_me.vo.CartVo" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
  <head>
        <meta charset="utf-8">
        <title>u_me</title>
        <link rel="stylesheet" type="text/css" href="${path}/resources/css/cart.css">
        <script src="${path}/resources/js/main.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Luxurious+Roman&display=swap" rel="stylesheet">
    </head>
  <body>
    <div class="wrapper">
     <%@ include file="/WEB-INF/views/common/header.jsp" %>
      <div class="container">
        <div class="contents">
        	<%
       		CartVo getCartVo = (CartVo) session.getAttribute("getCartVo");
        	if (getCartVo != null && loginedUserVo != null && getCartVo.getUser_id() == loginedUserVo.getId()){
					//로그인 후
			%>
          <div class="cart_txt">
            <h3>장바구니 상품</h3>
          </div>
          <div class="bar">
            <table class="t_select_product">
              <colgroup>
                <col style="width: 27px" />
                <col style="width: 92px" />
                <col style="width: auto" />
                <col style="width: 98px" />
                <col style="width: 75px" />
                <col style="width: 98px" />
                <col style="width: 98px" />
                <col style="width: 85px" />
                <col style="width: 98px" />
              </colgroup>
              <thead>
                <tr>
                  <th scope="col">
                    <input type="checkbox" onclick="" id="selectAllCheckbox"/>
                  </th>
                  <th scope="col">이미지</th>
                  <th scope="col">상품정보</th>
                  <th scope="col">판매가</th>
                  <th scope="col">수량</th>
                  <th scope="col" class="mileage">적립금</th>
                  <th scope="col">배송구분</th>
                  <th scope="col">배송비</th>
                  <th scope="col">합계</th>
                </tr>
              </thead>
              <tfoot class="tf_r">
                <tr>
                  <td colspan="10">
                    상품 구매 금액
                    <strong>${total}</strong>
                    <span>+ 부가세</span>
                    + 배송비 0 (무료)
                    <span>- 상품할인금액 0</span>
                    = 합계 :
                    <strong
                      >KRW
                      <span>${total}</span>
                    </strong>
                  </td>
                </tr>
              </tfoot>
              <c:forEach var="product" items="${ProductVos}">
	              <tbody class="center">
	                <tr>
	                  <td>
	                    <input type="checkbox" class="bsk" value="${product.id}"/>
	                  </td>
	                  <td>
	                    <a href="/">
	                      <img src="${product.img}" class="pro_img" />
	                    </a>
	                  </td>
	                  <td>
	                    <strong class="name">
	                      <a href="/">${product.name}</a>
	                    </strong>
	                    <ul>
	                      <li>[옵션: s]</li>
	                    </ul>
	                  </td>
	                  <td>
	                    <strong>KRW ${product.price}</strong>
	                  </td>
	                  <td>
	                    <span>
	                      <input size="2" , value="${product.quantity}" , type="text" />
	                      <a href="up_q">
	                        <img
	                          class="up"
	                          src="${path}/resources/res/up.png"
	                          width="10px"
	                          height="auto"
	                          alt="수량 증가"
	                        />
	                      </a>
	                      <a href="down_q">
	                        <img
	                          class="down"
	                          src="${path}/resources/res/down.png"
	                          width="10px"
	                          height="auto"
	                          alt="수량 감소"
	                        />
	                      </a>
	                    </span>
	                  </td>
	                  <td>
	                    <span>-</span>
	                  </td>
	                  <td>
	                    <div>
	                      기본 배송
	                      <br />
	                    </div>
	                  </td>
	                  <td rowspan="1">무료</td>
	                  <td>
	                    <strong>KRW ${product.price}</strong>
	                  </td>
	                </tr>
	              </tbody>
              </c:forEach>
            </table>
          </div>
          <div class="txt">
            <span><img src="${path}/resources/res/caution.png" width="20px" /></span>
            <p>
              할인 적용 금액은 주문서작성의 결제예정금액에서 확인 가능합니다.
            </p>
          </div>
          <div class="select_product">
            <span class="left">
              <p class="d_text">선택 상품을</p>
              <button onclick="deleteSelectedProducts()">삭제</button>
            </span>
            <span class="right">
              <button onclick="deleteAll()">장바구니 비우기</button>
            </span>
          </div>
          <div class="total_price">
            <table class="t_select_product">
              <colgroup>
                <col style="width: 20%" />
                <col style="width: 20%" />
                <col style="width: 17%" id="discountColumn" />
                <col style="width: auto" />
              </colgroup>
              <thead>
                <tr>
                  <th scope="col">
                    <strong>총 상품 금액</strong>
                  </th>
                  <th scope="col">
                    <strong>총 배송비</strong>
                  </th>
                  <th scope="col" id="discountColumn">
                    <strong>총 할인금액</strong>
                  </th>
                  <th scope="col">
                    <strong>결제 예정금액</strong>
                  </th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>
                    <div class="txt_1">
                      <strong>
                        KRW
                        <span>
                          <span class="total_price">${total}</span>
                        </span>
                      </strong>
                    </div>
                  </td>
                  <td>
                    <div class="txt_2">
                      <strong>+ </strong>
                      <strong> KRW 0 </strong>
                    </div>
                  </td>
                  <td>
                    <div class="txt_3">
                      <strong>- </strong>
                      <strong> KRW 0 </strong>
                    </div>
                  </td>
                  <td>
                    <div class="txt_4">
                      <strong>= </strong>
                      <strong> KRW </strong>
                      <strong>${total}</strong>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <div class="order-btn">
            <span class="all_product_btn">
              <button onclick="orderAll()">전체 상품주문</button>
            </span>
            <span class="select_product_btn">
              <button onclick="orderSelectedProducts()">선택 상품주문</button>
            </span>
          </div>
           <%
		      }else {
		        //로그인 전
	       %>
	       <p style="text-align: center; margin: 30vh;">장바구니가 비어있습니다</p>   
	      <%
	      }
	      %>
        </div>
      </div>
       <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div>
    <script>
	 // JavaScript 코드
	 window.onload = function() {
	        var selectAllCheckbox = document.getElementById('selectAllCheckbox');
	        var checkboxes = document.querySelectorAll('.bsk');
	
	        selectAllCheckbox.addEventListener('change', function() {
	            checkboxes.forEach(function(checkbox) {
	                checkbox.checked = selectAllCheckbox.checked;
	            });
	        });
	
	        checkboxes.forEach(function(checkbox) {
	            checkbox.addEventListener('change', function() {
	                // 체크박스 중 하나라도 체크 해제되면 전체 선택 체크박스도 해제
	                if (!checkbox.checked) {
	                    selectAllCheckbox.checked = false;
	                }
	            });
	        });
	    };
	    
	    function deleteSelectedProducts() {
	    	  var selectedProducts = document.querySelectorAll('.bsk:checked'); // 선택된 상품 체크박스 요소들을 선택
	    	  var productIds = []; // 상품 아이디 값을 담을 배열 초기화

	    	  // 선택된 상품의 아이디 값을 배열에 추가
	    	  selectedProducts.forEach(function(product) {
	    	    var productId = product.value; // 상품 아이디 값을 가져옴
	    	    productIds.push(productId); // 상품 아이디를 배열에 추가
	    	  });

	    	  // 배열을 쿼리 파라미터 형식으로 변환
	    	  var queryParams = productIds.map(function(productId) {
	    	    return 'productId=' + encodeURIComponent(productId);
	    	  }).join('&');

	    	  // 삭제를 처리할 URL에 쿼리 파라미터를 추가하여 링크로 이동
	    	  var deleteUrl = '/u_me/remove_item?' + queryParams;
	    	  window.location.href = deleteUrl;
	    	}
	    
	    function deleteAll() {
	    	var deleteUrl = '/u_me/remove_all';
	    	 window.location.href = deleteUrl;
	    }
	    
	    
	    function orderAll() {
	    	var orderUrl = '/u_me/order';
	    	 window.location.href = orderUrl;
	    }

	    
	    function orderSelectedProducts() {
	    	  var selectedProducts = document.querySelectorAll('.bsk:checked'); // 선택된 상품 체크박스 요소들을 선택
	    	  var productIds = []; // 상품 아이디 값을 담을 배열 초기화

	    	  selectedProducts.forEach(function(product) {
	    	    var productId = product.value;
	    	    productIds.push(productId); 
	    	  });

	    	  var queryParams = productIds.map(function(productId) {
	    	    return 'productId=' + encodeURIComponent(productId);
	    	  }).join('&');

	    	  var orderUrl = '/u_me/order_item?' + queryParams;
	    	  window.location.href = orderUrl;
	    	}



    </script>
    
  </body>
</html>
