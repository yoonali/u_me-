<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.myshop.u_me.vo.CartVo" %>
<c:set var="userId" value="${sessionScope.loginedUserVo}" />
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
 <head>
        <meta charset="utf-8">
        <title>u_me</title>
        <link rel="stylesheet" type="text/css" href="${path}/resources/css/order.css?after">
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
					
			%>
          <div class="cart_txt">
            <h3>주문 상품</h3>
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
               <c:forEach var="product" items="${orderProductVos}">
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
                      <p>${product.quantity}</p>
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
              상품의 옵션 및 수량 변경은 상품 상세 또는 장바구니에서 가능합니다
            </p>
          </div>
          <div class="select_product">
            <span class="left">
              <p class="d_text">선택 상품을</p>
              <button onclick="deleteSelectedProducts()">삭제</button>
            </span>
          </div>
          <div class="address">
            <div class="addr_txt">
              <h3>배송 정보</h3>
              <h4 class="required">
                <p class="star">*</p>
                필수입력사항
              </h4>
            </div>
            <table class="t_select_product">
              <colgroup>
                <col style="width: 139px" />
                <col style="width: auto" />
              </colgroup>
              <tbody>
                <tr>
                  <th scope="row">
                    받으시는 분
                    <span><img src="${path}/resources/res/star.png" width="7px" /></span>
                  </th>
                  <td>
                    <input value="${userId.name}" type="text" />
                  </td>
                </tr>
                <tr>
                  <th scope="row">
                    주소
                    <span><img src="${path}/resources/res/star.png" width="7px" /></span>
                  </th>
                  <td>
                    <input
                      maxlength="6"
                      placeholder
                      size="6"
                      readonly="1"
                      value="${addressVos.zipcode}"
                      type="text"
                      id="sample6_postcode"
                    />
                    <span>
                      <button onclick="sample6_execDaumPostcode()">우편번호 ></button>
                    </span>
                    <br />
                    <input class="add" value="${addressVos.addr}" placeholder=""  type="text" id="sample6_address"/>
                    기본 주소
                    <br />
                    <input class="add" placeholder="" value="${addressVos.addrdetail}"  type="text" id="sample6_detailAddress"/>
                    나머지 주소
                  </td>
                </tr>
                <tr class="phone">
                  <th scope="row">
                    휴대전화
                    <span><img src="${path}/resources/res/star.png" width="7px" /></span>
                  </th>
                  <td>
                    <input
                      maxlength=11"
                      placeholder
                      size="11"
                      value="${userId.phone}"
                      type="text"
                    />
                  </td>
                </tr>
                <tr>
                  <th scope="row">
                    이메일
                  </th>
                  <td>
                    <input value="" type="email" />
                  </td>
                </tr>
                <tr class="msg">
                  <th scope="row">베송 메세지</th>
                  <td>
                    <input value="" type="text" />
                  </td>
                </tr>
              </tbody>
            </table>
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
              <button id="checkoutButton">결제하기</button>
            </span>
          </div>
          <%
		      }else {
		        //로그인 전
	       %>
	       <p style="text-align: center; margin: 30vh;">주문할 상품이 없습니다!</p>   
	      <%
	      }
	      %>
        </div>
      </div>

      <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div>
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }  
                
                } 

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
<script>
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
	  var deleteUrl = '/u_me/remove_order_item?' + queryParams;
	  window.location.href = deleteUrl;
	}

document.getElementById('checkoutButton').addEventListener('click', function () {
    var isConfirmed = window.confirm('결제하시겠습니까?');

    if (isConfirmed) {
        deleteAll();
    }
});

function deleteAll() {
    var deleteUrl = '/u_me/remove_all';
    window.location.href = deleteUrl;
}
</script>
  </body>
</html>
