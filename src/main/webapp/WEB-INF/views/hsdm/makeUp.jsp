<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>
$(document).ready(function(){
	//조회버튼클릭. 조회항목,조회값,현재커런트페이지에 대한 정보 가져가기
	$("#btnSearch").on("click", function(){
		document.bbsForm.mCode.value = "";
		document.bbsForm.searchType.value = $("#_searchType").val();
		document.bbsForm.searchValue.value = $("#_searchValue").val();
		document.bbsForm.curPage.value = 1;
		
		var year = $("#year").val();
		var month = $("#month").val();
		var day = $("#day").val();
		var wDate = year+month+day;
		
		if(wDate.length != 0 && wDate.length != 8)
		{
			Swal.fire({ 
				icon: 'warning', // Alert 타입 
				//title: '검색오류입니다.', // Alert 제목
				text: '날짜로 검색하기를 원하신다면 년, 월, 일을 빠짐없이 전부 입력해주세요.' // Alert 내용
			});
			return;
		}
		
		document.bbsForm.year.value = $("#year").val();
		document.bbsForm.month.value = $("#month").val();
		document.bbsForm.day.value = $("#day").val();
		
		document.bbsForm.action = "/hsdm/makeUp";
		document.bbsForm.submit();
	});
	
});

function fn_view(mCode)
{
	document.bbsForm.mCode.value = mCode; //실행하면 bbsForm 안에 <input type="hidden" name="hiBbsSeq" value="" />의 value에 값이 들어가게됨
	document.bbsForm.year.value = $("#year").val();
	document.bbsForm.month.value = $("#month").val();
	document.bbsForm.day.value = $("#day").val();
	document.bbsForm.action = "/hsdm/makeupView";	//서치타입과 서치밸유는 이미 들어가있으니까(위에서 설정) 넣을 필요없음
	document.bbsForm.submit();
}     

function fn_list(curPage)
{
   document.bbsForm.mCode.value = "";
   document.bbsForm.curPage.value = curPage;
   document.bbsForm.year.value = $("#year").val();
   document.bbsForm.month.value = $("#month").val();
   document.bbsForm.day.value = $("#day").val();
   document.bbsForm.action = "/hsdm/makeUp";
   document.bbsForm.submit();
}

</script> 
</head> 
<body>
	<!-- 메뉴바 시작 -->
    	<jsp:include page="/WEB-INF/views/include/navigation.jsp" >
    	<jsp:param name="userName" value="${wdUser.userNickname}" />
    	</jsp:include>
	<!-- 메뉴바 종료 -->
<!-- ############################ 여기부터 내용 시작 ############################ -->

<section class="top">
	<div class="back"></div>
</section>

    <!-- ***** About Us Page ***** -->
    <div class="page-heading-shows-events4">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h2>MAKEUP</h2>
                    <!-- span>Check out upcoming and past shows & events and grab your ticket right now.</span -->
                </div>
            </div>
        </div>
    </div>


    <div class="tickets-page">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="search-box">
                        <form id="subscribe" action="" method="get">
                            <div class="row">
                                <div class="col-lg-5">
                                    <div class="search-heading">
                                        <h4 class="let_sp">결혼예정일<span class="span_design"></span></h4>
                                    </div>
                                    <div class="search-heading">
                                        <h4> 예약하고 싶은 메이크업샵이나 지역이 있으신가요?</h4>
                                    </div>
                                </div>
                                
                                <div class="col-lg-7">
                                    <div class="row">
                                    <!-- * -->
                                        <div class="col-lg-4">
                                        	<select id="year" name="year" class="year">
												<option value="">년도</option>
												<option value="2022" <c:if test="${year eq '2022'}">selected</c:if>>2022</option>
												<option value="2023" <c:if test="${year eq '2023'}">selected</c:if>>2023</option>
											</select>
                                        </div>
                                        <div class="col-lg-4">
                                            <select id="month" name="month" class="month">
												<option value="">월</option>
												<option value="01" <c:if test="${month eq '01'}">selected</c:if>>1</option>
												<option value="02" <c:if test="${month eq '02'}">selected</c:if>>2</option>
												<option value="03" <c:if test="${month eq '03'}">selected</c:if>>3</option>
												<option value="04" <c:if test="${month eq '04'}">selected</c:if>>4</option>
												<option value="05" <c:if test="${month eq '05'}">selected</c:if>>5</option>
												<option value="06" <c:if test="${month eq '06'}">selected</c:if>>6</option>
												<option value="07" <c:if test="${month eq '07'}">selected</c:if>>7</option>
												<option value="08" <c:if test="${month eq '08'}">selected</c:if>>8</option>
												<option value="09" <c:if test="${month eq '09'}">selected</c:if>>9</option>
												<option value="10" <c:if test="${month eq '10'}">selected</c:if>>10</option>
												<option value="11" <c:if test="${month eq '11'}">selected</c:if>>11</option>
												<option value="12" <c:if test="${month eq '12'}">selected</c:if>>12</option>
											</select>
                                        </div>
                                        <div class="col-lg-4">
                                        	<select id="day" name="day" class="day">
												<option value="">일</option>
												<option value="01" <c:if test="${day eq '01'}">selected</c:if>>1</option>
												<option value="02" <c:if test="${day eq '02'}">selected</c:if>>2</option>
												<option value="03" <c:if test="${day eq '03'}">selected</c:if>>3</option>
												<option value="04" <c:if test="${day eq '04'}">selected</c:if>>4</option>
												<option value="05" <c:if test="${day eq '05'}">selected</c:if>>5</option>
												<option value="06" <c:if test="${day eq '06'}">selected</c:if>>6</option>
												<option value="07" <c:if test="${day eq '07'}">selected</c:if>>7</option>
												<option value="08" <c:if test="${day eq '08'}">selected</c:if>>8</option>
												<option value="09" <c:if test="${day eq '09'}">selected</c:if>>9</option>
												<option value="10" <c:if test="${day eq '10'}">selected</c:if>>10</option>
												<option value="11" <c:if test="${day eq '11'}">selected</c:if>>11</option>
												<option value="12" <c:if test="${day eq '12'}">selected</c:if>>12</option>
												<option value="13" <c:if test="${day eq '13'}">selected</c:if>>13</option>
												<option value="14" <c:if test="${day eq '14'}">selected</c:if>>14</option>
												<option value="15" <c:if test="${day eq '15'}">selected</c:if>>15</option>
												<option value="16" <c:if test="${day eq '16'}">selected</c:if>>16</option>
												<option value="17" <c:if test="${day eq '17'}">selected</c:if>>17</option>
												<option value="18" <c:if test="${day eq '18'}">selected</c:if>>18</option>
												<option value="19" <c:if test="${day eq '19'}">selected</c:if>>19</option>
												<option value="20" <c:if test="${day eq '20'}">selected</c:if>>20</option>
												<option value="21" <c:if test="${day eq '21'}">selected</c:if>>21</option>
												<option value="22" <c:if test="${day eq '22'}">selected</c:if>>22</option>
												<option value="23" <c:if test="${day eq '23'}">selected</c:if>>23</option>
												<option value="24" <c:if test="${day eq '24'}">selected</c:if>>24</option>
												<option value="25" <c:if test="${day eq '25'}">selected</c:if>>25</option>
												<option value="26" <c:if test="${day eq '26'}">selected</c:if>>26</option>
												<option value="27" <c:if test="${day eq '27'}">selected</c:if>>27</option>
												<option value="28" <c:if test="${day eq '28'}">selected</c:if>>28</option>
												<option value="29" <c:if test="${day eq '29'}">selected</c:if>>29</option>
												<option value="30" <c:if test="${day eq '30'}">selected</c:if>>30</option>
												<option value="31" <c:if test="${day eq '31'}">selected</c:if>>31</option>
											</select>
                                        </div>
                                    <!-- * -->
                                        <div class="col-lg-3">
                                            <select value="searchType" name="_searchType" id="_searchType">
                                            	<option value="">조회 항목</option>
                                                <option value="1" <c:if test="${searchType eq '1'}">selected</c:if>>메이크업샵명</option>
                                                <option value="2" <c:if test="${searchType eq '2'}">selected</c:if>>지역</option>
                                            </select>
                                        </div>
                                        <div class="col-lg-7">
                                            <input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" maxlength="25" class="svalue" placeholder="조회값을 입력하세요." />
                                        </div>
                                        <div class="col-lg-2">
                                            <fieldset>
                                            <button type="button" id="btnSearch" class="btn"><img class="imgNav" src="/resources/images/icons/search.jpg" width="auto" height="22px"></button>
                                            </fieldset>
                                        </div>
                                        
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
              </div>
           </div>
                    <div style="border-bottom:1px solid #dadada; width: 100%;"></div>
                </div>
                 <div class="tickets-page">
      			  <div class="container">
        		    <div class="row">
            
                <div class="col-lg-12" style="text-align: center; height: 70px;">
                    <div class="heading">
                        <h2><!-- Makeup --></h2>
                    </div>
                </div>
<c:if test="${!empty list}">        
	<c:forEach var="wdMakeup" items="${list}" varStatus="status">
                <div class="col-lg-4">
                    <div class="ticket-item">
                        <div class="thumb5" onclick="fn_view('${wdMakeup.mCode}')" style="cursor:pointer;">
                            <img src="../resources/images/makeup/${wdMakeup.mImgName}" alt="">
                        </div>
                        <div class="down-content">
                        	<div class="sd_title2"><c:out value="${wdMakeup.mName}" /></div>
                            <!-- <div class="sd_detail"><c:out value="" /></div>-->
                            <ul>    
                            	<li class="sd_adress"><i class="fa fa-map-marker"></i><c:out value="${wdMakeup.mLocation}" /></li>
                                <li class="price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${wdMakeup.mPrice}" />원</li>
                                <li class="dis_price"><span class="discount"><c:out value="${wdMakeup.mDiscount}" />%</span> <span class="dis-price"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdMakeup.mPrice * (1-wdMakeup.mDiscount*0.01)}" />원</span></li>
                            </ul>
                            <div class="main-dark-button">
                                <a href="javascript:void(0)" onclick="fn_view('${wdMakeup.mCode}')">자세히 보기</a>
                            </div>
                        </div>
                    </div>
                </div>       
	</c:forEach>
</c:if>        

                
                <div class="col-lg-12">
                    <div class="pagination">
                        <ul>
				<c:if test="${!empty paging}">
					<c:if test="${paging.prevBlockPage gt 0}">                         
                            <li><a  class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">Prev</a></li>
					</c:if>
				    <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
				    	<c:choose>
				    		<c:when test="${i ne curPage}">
    		         		<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
							</c:when>
							<c:otherwise>
											<li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default;">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				 	<c:if test="${paging.nextBlockPage gt 0}">        
         					<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">Next</a></li>
					</c:if>
				</c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        
		<form name="bbsForm" id="bbsForm" method="post">
			<input type="hidden" name="mCode" value="" /> <!-- 상세페이지 들어갈때 필요하니까 그때만 이 값이 들어가면됨 -->
	        <input type="hidden" name="year" value="${year}" />
	        <input type="hidden" name="month" value="${month}" />
	        <input type="hidden" name="day" value="${day}" /> 
			<input type="hidden" name="searchType" value="${searchType}" />
			<input type="hidden" name="searchValue" value="${searchValue}" />
			<input type="hidden" name="curPage" value="${curPage}" />
		</form>

    </div>
    
<!-- ############################ 여기까지 내용 끝 ############################ -->
	<!-- *** 욱채수정Footer 시작 *** -->
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<!-- *** 욱채수정Footer 종료 *** -->
</body>
</html>