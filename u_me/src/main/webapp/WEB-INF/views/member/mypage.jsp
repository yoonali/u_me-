<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="userId" value="${sessionScope.loginedUserVo}" />
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
  <head>
        <meta charset="utf-8">
        <title>u_me</title>
        <link rel="stylesheet" type="text/css" href="${path}/resources/css/mypage.css?after">
        <script src="${path}/resources/js/main.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Luxurious+Roman&display=swap" rel="stylesheet">
    </head>
  <body>
    <div class="wrapper">
     <%@ include file="/WEB-INF/views/common/header.jsp" %>
     <div class="container">
        <div class="contents">
       		<%
				if(loginedUserVo != null) {
					//로그인 후
			%>
          <div class="mypage_txt">
            <p><span id="username">${userId.name}</span>님 반갑습니다!</p>
          </div>
          <div class="my_info">
          <form action="addr_in" method="post" name="addrForm">
          	<table class="t_mypage">
              <colgroup>
                <col style="width: 150px" />
                <col style="width: auto" />
              </colgroup>
              <tbody>
                <tr>
                  <th scope="row">
                    아이디
                    <span><img src="${path}/resources/res/star.png" width="7px" /></span>
                  </th>
                  <td>
                  <span>
                   <p>${userId.user_id}</p>
                  </span>
                  </td>
                </tr>
                <tr>
                  <th scope="row">
                    비밀번호
                    <span><img src="${path}/resources/res/star.png" width="7px" /></span>
                  </th>
                  <td>
                    <input
                      class="member_pw"
                      placeholder=""
                      value
                      type="password"
                      name="password"
                    />
                    (영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10~16자)
                  </td>
                </tr>
                <tr>
                  <th scope="row">
                    비밀번호 확인
                    <span><img src="${path}/resources/res/star.png" width="7px" /></span>
                  </th>
                  <td>
                    <input
                      class="member_password_no"
                      placeholder=""
                      value
                      type="password"
                    />
                  </td>
                </tr>
                <tr>
                  <th scope="row">
                    이름
                    <span><img src="${path}/resources/res/star.png" width="7px" /></span>
                  </th>
                  <td>
                    <input
                      class="member_name"
                      placeholder="${userId.name}"
                      value
                      type="text"
                      name="name"
                    />
                  </td>
                </tr>
                <tr>
                  <th scope="row">주소</th>
                  <td>
                    <input class="post" placeholder="" id="sample6_postcode" value="${addressVos.zipcode}" type="text" name="zipcode" />
                    <span>
                      <input type="button" value="우편번호 찾기" onclick="sample6_execDaumPostcode()" onsubmit=""/>
                    </span>
                    <br />
                    <input class="add" placeholder="" id="sample6_address" value="${addressVos.addr}" type="text" name="addr" />
                    기본 주소
                    <br />
                    <input class="add" placeholder="" id="sample6_detailAddress" value="${addressVos.addrdetail}" type="text" name="addrdetail" />
                    나머지 주소
                  </td>
                </tr>
              </tbody>
            </table>
            <input type="hidden" name="user_id" value="${userId.id}">
            <div class="order-btn">
	            <span class="all_product_btn">
	              <button onsubmit="addrForm()">변경하기</button>
	            </span>
	          </div>
          </form>
            
             <%
		      }else {
		        //로그인 전
	       %>
	       <p style="text-align: center; margin: 20vh;">로그인 먼저 해주세요!</p>
	              
	      <%
	      }
	      %>
          </div>
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
  </body>
</html>
