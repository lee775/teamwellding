<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Bitter:ital@0;1&family=The+Nautigal&display=swap" rel="stylesheet">


<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="../resources/css/modify.css">
<!--===============================================================================================-->
<script type="text/javascript">
	$(document).ready(function() {

		$("#pwd1").focus();

		// 모든 공백 체크 정규식
		var emptCheck = /\s/g;
		// 영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
		var idPwCheck = /^[a-zA-Z0-9]{3,12}$/;

		$("#pwd1").keyup(function(e) {

			if ($("#pwd1").val().length <= 0) {
				$('p').eq(0).text("비밀번호를 입력해주세요");
				$('p').eq(0).css('color', 'red');
				$("#pwd1").focus();
				return;
			} else if (emptCheck.test($("#pwd1").val())) {
				$('p').eq(0).text("비밀번호는 공백을 포함할 수 없습니다");
				$('p').eq(0).css('color', 'red');
				$("#pwd1").focus();
				return;
			} else if (!idPwCheck.test($("#pwd1").val())) {
				$('p').eq(0).text("비밀번호는 영문 대소문자와 숫자로 4~12자리 입니다.");
				$('p').eq(0).css('color', 'red');
				$("#pwd1").focus();
				return;
			}

			else {
				$('p').eq(0).text("좋은 비밀번호 입니다");
				$('p').eq(0).css("color", "green");
				$('p').eq(0).css("font-weight", "700");

				return;
			}

		});

		$("#pwd2").keyup(function() {
			var pwd1 = $("#pwd1").val();
			var pwd2 = $("#pwd2").val();

			if ($("#pwd2").val().length <= 0) {
				$('p').eq(1).text("비밀번호를 다시 입력해주세요");
				$('p').eq(1).css("color", "red");
				$("#pwd2").focus();
				return;
			} else if (emptCheck.test($("#pwd2").val())) {
				$('p').eq(1).text("비밀번호는 공백을 포함할 수 없습니다.");
				$('p').eq(1).css("color", "red");
				$("#pwd2").focus();
				return;
			} else if (pwd1 != pwd2) {
				$('p').eq(1).text("비밀번호가 일치하지않습니다");
				$('p').eq(1).css('color', 'red');
				$("#pwd2").focus();
				return;
			}

			else {
				$('p').eq(1).text("비밀번호가 일치합니다.");
				$('p').eq(1).css("color", "green");
				$('p').eq(1).css("font-weight", "700");

				return;
			}
		});

		$("#btn").on("click", function() {

			$.ajax({
				type : "POST",
				url : "/user/update",
				data : {
					pwd1 : $("#pwd1").val(),
					name : $("#name").val(),
					number : $("#number").val(),
					year : $("#year").val(),
					month : $("#month").val(),
					day : $("#day").val(),
					nickname : $("#nickname").val(),
					email : $("#email").val()
				},
				datatype : "JSON",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("AJAX", "true");
				},
				success : function(response) {
					if (response.code == 0) {
						alert("회원수정이 완료되었습니다");
						location.href = "/";
					} else if (response.code == 400) {
						alert("파라미터 값이 잘못되어 있습니다.");
						location.href = "/";
					} else {
						alert("오류가 발생했습니다");
						location.href = "/";
					}
				},
				complete : function(data) {
					icia.common.log(data);
				},
				error : function(xhr, status, error) {
					icia.common.error(error);
				}
			});
		});
		
	   $("#btn_cc").on("click", function(){
			 //alert("회원정보수정이 취소되었습니다.");
			  Swal.fire({ 
				  icon: 'warning',
				  text: '회원정보 수정이 취소되었습니다.'
			  });
			 location.href = "/user/wishlist";
	   });
	   
 		
	  
	   
	   $("#cou").on("click",function(){
		    var option="width = 1000, height = 500, top = 100, left = 200, location = no, menubar = no, scrollbars=no";
		    window.open("/board/Coupon", "PopUP", option); 
		});   
	  
	});
</script>

</head>
<body>
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
		<div class="row" style="background:#feede8;">
			<div class="col-lg-12">
				
				<div class="row">
					<div class="col-lg-1"></div>
					
					<div class="col-lg-10">
						<h2 style="font-family: 'Bitter', serif; margin-top: 50px; padding-left: 10px;">My Page</h2>
						<nav class="bcItem">
							<ol class="breadcrumb bc" style="background: #feede8;">
								<li class="breadcrumb-item">
									<a href="/user/wishlist" id="basket">장바구니</a>
								</li>
								<li class="breadcrumb-item">
									<a href="/user/payList"  id="payment">결제내역</a>
								</li>
								<li class="breadcrumb-item">
									<a href="javascript:void(0)" id="cou">쿠폰보유현황</a>
								</li>
								<li class="breadcrumb-item active" style="position: relative; top: -2px; margin-left:4px;">
									<a href="javascript:void(0)" id="modify" style="font-size: large; font-weight: bold; color: #000;">회원정보수정</a>
								</li>
								<li class="breadcrumb-item">
									<a href="/user/userDrop">회원탈퇴</a>
								</li>
							</ol>
						</nav>
					
					</div>
					<div class="col-lg-1">
					</div>
				</div>
			</div>
		</div>
	</div>
					
					

	<div class="join_form">
		<dl class="join_write">
			<div class="join_header">
				<h1 class="logo">
					<img src="../resources/images/theWellding.png" width="120px" height="auto"/>
				</h1>
				<h1>회원정보수정</h1>
			</div>
			<dt>비밀번호</dt>
			<dd>
				<div class="input">
					<input type="password" id="pwd1" name="pwd1"
						placeholder="비밀번호를 입력해 주세요" maxlength="20">
				</div>
				<p class="msg">비밀번호를 입력해 주세오.</p>

			</dd>
			<dt>비밀번호 확인</dt>
			<dd>
				<div class="input">
					<input type="password" id="pwd2" name="pwd2"
						placeholder="비밀번호를 다시 한번 입력해 주세요" maxlength="20">
				</div>
				<p class="msg">비밀번호를 다시 입력해 주세요</p>
			</dd>
			
			<dt>이름</dt>
			<dd>
				<div class="input">
					<input type="text" id="name" name="name" placeholder="이름을 입력해주세요">
				</div>
			</dd>
			
			<dt>전화번호</dt>
			<dd>
				<div class="input">
					<input type="text" id="number" placeholder="전화번호를 입력해주세요">
				</div>
				<p class="msg"></p>
			</dd>

			<dt>닉네임</dt>
			<dd>
				<div class="input">
					<input type="text" id="nickname" placeholder="닉네임을 입력해주세요">
				</div>
				<p class="msg">
				<p class="msg"></p>
				</dd>
				<!--이메일 주석-->
			<dt>이메일</dt>
			<dd>
				<div class="input">
					<input id="email" data-bind="email" type="text"
						placeholder="이메일을 입력해주세요" value="">
				</div>
				<p class="msg"></p>
				
			<dt>결혼예정일</dt>
			<dd class="date">
				<select id="year" class="year">
					<option>년도</option>
					<option value="2022">2022</option>
					<option value="2023">2023</option>
				</select> <select id="month" class="month">
					<option>월</option>
					<option value="01">1</option>
					<option value="02">2</option>
					<option value="03">3</option>
					<option value="04">4</option>
					<option value="05">5</option>
					<option value="06">6</option>
					<option value="07">7</option>
					<option value="08">8</option>
					<option value="09">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
				</select> <select id="day" class="day">
					<option>일</option>
					<option value="01">1</option>
					<option value="02">2</option>
					<option value="03">3</option>
					<option value="04">4</option>
					<option value="05">5</option>
					<option value="06">6</option>
					<option value="07">7</option>
					<option value="08">8</option>
					<option value="09">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="16">16</option>
					<option value="17">17</option>
					<option value="18">18</option>
					<option value="19">19</option>
					<option value="20">20</option>
					<option value="21">21</option>
					<option value="22">22</option>
					<option value="23">23</option>
					<option value="24">24</option>
					<option value="25">25</option>
					<option value="26">26</option>
					<option value="27">27</option>
					<option value="28">28</option>
					<option value="29">29</option>
					<option value="30">30</option>
					<option value="31">31</option>
				</select>
			</dd>
		

			<div class="button_area">
				<button class="btn_type" id="btn">수정</button>
				<button class="btn_type" id="btn_cc">돌아가기</button>
			</div>

			<div class="footer">
				<div class="copyright">COPYRIGHT. WELLDING INC. ALL RIGHTS RESERVED</div>
			</div>
		</dl>
	</div>
	
		<%@ include file="/WEB-INF/views/include/footer.jsp" %>



</body>
</html>