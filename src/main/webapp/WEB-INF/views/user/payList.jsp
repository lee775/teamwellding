<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en">

<head>
       <%@ include file="/WEB-INF/views/include/head.jsp" %>
       <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Bitter:ital@0;1&family=The+Nautigal&display=swap" rel="stylesheet">
<script>
function fn_view(rezNo)
{
   document.bbsForm.rezNo.value = rezNo;
   document.bbsForm.action = "/user/payListView";
   document.bbsForm.submit();

}

$(document).ready(function(){
   $("#cou").on("click",function(){
       var option="width = 1000, height = 500, top = 100, left = 200, location = no, menubar = no, scrollbars=no";
       window.open("/board/Coupon", "PopUP", option); 
   });
});
</script>
</head>
    
<body>
    <jsp:include page="/WEB-INF/views/include/navigation.jsp" >
    <jsp:param name="userName" value="${wdUser.userNickname}" />
    </jsp:include>
    
    <div class="page-heading-rent-venue2">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                </div>
            </div>
        </div>
    </div>
   <div class="container-fluid">
      <div class="row">
         <div class="col-lg-12 bcline">
            <div class="row">
               <div class="col-lg-1"></div>
               <div class="col-lg-10">
                  <h2 style="font-family: 'Bitter'; margin-top: 50px; padding-left: 10px;">결제내역</h2>
                  <nav class="bcItem">
                     <ol class="breadcrumb bc" >
                        <li class="breadcrumb-item active">
                           <a href="/user/wishlist">장바구니</a>
                        </li>
                        <li class="breadcrumb-item" >
                           <a style="font-size: large; font-weight: bold;">결제내역</a>
                        </li>
                        <li class="breadcrumb-item">
                           <a href="javascript:void(0)" id="cou">쿠폰보유현황</a>
                        </li>
                        <li class="breadcrumb-item">
                           <a href="/user/modify">회원정보수정</a>
                        </li>
                     </ol>
                  </nav>
               </div>
               <div class="col-lg-1"></div>
               
               <!-- 다음 라인 -->
               <div class="col-lg-1"></div>
               
               <!-- 경계선 및 내용 -->
               <div class="col-lg-10 lineListMypage">
                        <table class="table tableWish">
                        <c:choose>
                        <c:when test="${!empty list}">
                            <tr style="border-top: 3px solid #444; background: #efefef;">
                                <th>예약번호</th>
                                <th>예약날짜</th>
                                <th>가격</th>
                            </tr>

                           <c:forEach var="wdRez" items="${list}" varStatus="status">
                            <tr style="width: 100%;">
                               <!-- 예약번호 -->
                                <td>
                                <div class="col-lg-12" style="text-align:center">
                                    <a href="javascript:void(0)" onclick="fn_view(${wdRez.rezNo})">
                                        <p class="rezview"><c:out value="${wdRez.rezNo}" /></p>
                                    </a>
                                </div>
                                </td>
                                <!-- 예약날짜 -->

                                  <td>
                                  <div class="col-lg-12" style="text-align:center">
                                     <a href="javascript:void(0)" onclick="fn_view(${wdRez.rezNo})"><p class="rezview" style="color:#555;">${wdRez.rezDate}</p></a>
                                  </div>
                                  </td>
                                  <!-- 금액 -->
                                <td>
                                <div class="col-lg-12" style="text-align:center; width: 100%;">
                                	<div style="width: 50%; float: left; text-align: right;">
	                                   	<p class="rezview"><fmt:formatNumber type="number" maxFractionDigits="3" value="${wdRez.rezFullPrice}" />원</p>
	                               	</div>
	                               	<div style="width: 50%; float: left; text-align: left; padding-left: 5px;">
	                                   	<button class="rez_btn">리뷰쓰기</button>
	                                   	<button class="rez_btn2">작성완료</button>
	                                </div> 
                                </div>  
                                </td>  
                              </tr>                         
                       	</c:forEach>
                       	</c:when>
                        <c:when test="${empty list}">
                        <tr>
                           <td colspan="3">
                             <div style="text-align: center;">
                             	<img src="../resources/images/icons/exclamation.png" style="width:100px; margin:30px;"/>
                       			<p style="padding-bottom:30px;">결제내역이 없습니다. </p>
                       		</div>
                           </td>
                        </tr>
                     	</c:when>                          
                     </c:choose>
                   	</table>

               </div>
               
               <div class="col-lg-1"></div>
            
            </div>
         </div>         
      </div>
	      <form name="reviewForm" id="reviewForm">
	         <input type="hidden" name="rezNo" value="" />
	      </form>
	      <form name="bbsForm" id="bbsForm" method="post" action="/user/payListView">
	         <input type="hidden" name="rezNo" value="" />
	      </form>
   </div>

      <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  </body>

</html>