<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title><%=util.Property.title %></title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
<meta name="format-detection" content="telephone=no, address=no, email=no">
<meta name="keywords" content="">
<meta name="description" content="">
<title>portfolio</title>

</head>
<script>
//아이디 찾기
function searchId(){
	var datas = {"user_name":$("#user_name").val(), "user_tel" : $("#user_tel").val()};
	if($("#user_name").val()==''){
		alert("회원님의 이름을 입력해주세요.");
		return false;
	}else if($("#user_tel").val()==''){
		alert("회원님의 휴대폰 번호를 입력해주세요.");
		return false;
	}else if($("#user_name").val()!=null && $("#user_tel").val()!=null){
		$.ajax ({
			type:'POST',
			url:"/pp/portfolio/user/searchid.do",
			data:datas,
			async:false,
			success:function(data) {
				var user_id = data.trim();
				if (user_id != "") {
					alert("회원님의 아이디는 "+data+"입니다.");
				} else {
					alert("존재하지 않는 이름이거나 존재하지 않는 휴대폰번호 입니다.");
				}
				return false;
			}
		});
	};
	return false;
};
</script>
<body>
   
	<form id="searchid" action="searchid.do" method="post" onsubmit="return searchId(); ">
    <div class="sub">
		<div class="size">
			<h3 class="sub_title">아이디 찾기</h3>
			
			<div class="member">
				<div class="box">
					<p>이름과 휴대폰 번호를 입력해 주세요.
					</p>
					<fieldset class="login_form">
						<ul>
							<li><input type="text" name="user_name" id="user_name" placeholder="이름"></li>
							<li><input type="text" name="user_tel" id="user_tel" onkeyup="isNumberOrHyphen(this);cvtPhoneNumber(this);" placeholder="휴대폰번호"></li>
						</ul>
						<div class="login_btn"><input type="submit" value="아이디찾기" alt="아이디찾기"/></div>
					</fieldset>
					<div class="btnSet clear">
						<div>
							<a href="pwdsearch.do" class="btn">비밀번호 찾기</a> 
						</div>
					</div>
				</div>
			</div>

		</div>
    </div>
	</form>


</body>
</html>
