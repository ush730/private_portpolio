<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="user.*" %>
<%@ page import="java.util.*" %>
<%
UserVo data = (UserVo)request.getAttribute("data");
%>
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
<title>PP</title>

</head>
<script>
function goSave() {
	
	if ($("#cst_id").val() == "") {
		alert("아이디를 입력해주세요.");
		$("#cst_id").focus();
		return false;
	}
	if ($("#cst_tel").val() == "") {
		alert("휴대폰 번호를 입력해주세요.");
		$("#cst_tel").focus();
		return false;
	}
	
}
</script>
<body>
    
	<form action="searchpwd.do" name="board" method="post">
    <div class="sub">
		<div class="size">
			<h3 class="sub_title">비밀번호 찾기</h3>
			
			<div class="member">
				<div class="box">
					<p>아이디와 휴대폰 번호를 입력해 주세요.
					</p>
					<fieldset class="login_form">
						<ul>
							<li><input type="text" name="cst_id" id="cst_id3" placeholder="아이디"></li>
							<li><input type="text" name="cst_tel" id="cst_tel" onkeyup="isNumberOrHyphen(this);cvtPhoneNumber(this);" placeholder="휴대폰번호"></li>
						</ul>
						<div class="login_btn">
						<input type="submit" value="비밀번호찾기" onclick="goSave();" alt="비밀번호찾기" />
						</div>
					</fieldset>
					<div class="btnSet clear">
						<div>
							<a href="idsearch.do" class="btn" >아이디 찾기</a> 
						</div>
					</div>
				</div>
			</div>

		</div>
    </div>
	</form>
    

</body>
</html>
