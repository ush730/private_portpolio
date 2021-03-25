<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.security.SecureRandom"  %>
<%@ page import="java.math.BigInteger"  %>
<%@ page import="java.net.URLEncoder"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%
String client_id = "mBXwunle4aCgU4nIy3Pi";
String redirectURI = URLEncoder.encode("http://localhost:8080/dtoi/sns/naver/naverCallback.jsp");
SecureRandom random = new SecureRandom();
String state = new BigInteger(130, random).toString(32);
session.setAttribute("state", state);
String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id="+client_id+"&redirect_uri="+redirectURI+"&state="+state;
%>

<html lang="ko">
<head>
<title><%=util.Property.title %></title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>

<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script	src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>
<c:if test="${!empty msg}">
	alert('${msg}');
</c:if>
	$(function() {
		$("form input[type='button']").click(function(){
			if ($("#user_id").val().trim() == '') {
				alert('아이디를 입력해 주세요');
				$("#user_id").focus();
				return false;
			}
			if ($("#user_pwd").val().trim() == '') {
				alert('비밀번호를 입력해 주세요');
				$("#user_pwd").focus();
				return false;
			}
			// 폼전송
			$(".loginFrm").submit();
		});
	});
</script>
<script>
$(function() {
	$("#naverLogin").click(function() {
		window.open('<%=apiURL%>','naverLogin','width=400,height=400');
	});
});
</script>
<script type='text/javascript'>
$(function() {
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('53bc1d6b243db7dc8d16a9b9aed747b4');
    
    /*
    // 카카오 로그인 버튼을 생성합니다.
    Kakao.Auth.createLoginButton({
      container: '#kakao-login-btn',
      success: function(authObj) {
        alert(JSON.stringify(authObj));
      },
      fail: function(err) {
         alert(JSON.stringify(err));
      }
    });
    */
    
    $("#kakaoBtn").click(function() {
        // 로그인 창을 띄웁니다.
        Kakao.Auth.loginForm({
			success: function(authObj) {
           		console.log(JSON.stringify(authObj));

				Kakao.API.request({
					url: '/v2/user/me',
					success: function(res) {
				
						console.log('kakao id : '+res.id);
						console.log('kakao email : '+res.kakao_account.email);
						console.log('kakao birthday : '+res.kakao_account.birthday);
						console.log('kakao gender : '+res.kakao_account.gender);
						console.log('kakao nickname : ' +res.properties['nickname']);
				
				 	},
				 	fail: function(error) {
						alert(JSON.stringify(error));
				 	}
				});
			},
			fail: function(err) {
			  alert(JSON.stringify(err));
			}
        });
    });
  //]]>
});
</script>
</head>
<body>
	<div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>회원 로그인</h2>
	</div>
	</div>
		  <div class="sub">
		  
			<div class="size">

				<form action="login.do" method="post" class="loginFrm">
				<input type="hidden" name="url" value="${param.url }"/>
				<input type="hidden" name="param" value="${param.param }"/>

				<div class="member">
				<div class="box">
					<fieldset class="login_form">
						<ul>
							<li><input type="text" name="user_id" id="user_id" placeholder="아이디"></li>
							<li><input type="password" name="user_pwd" id="user_pwd" placeholder="비밀번호"></li><br>
						</ul>
			

			<input type="button" class="btn bgGray" value="로그인">



</fieldset>
</div>
</div>

<img src="/pp/gallery/naverlogin.PNG" id="naverLogin"
alt="네이버로그인" width="250" height="65" align="center" border="0"><br>

<img src="/pp/gallery/kakaologin.png" id="kakaoBtn"
alt="카카오로그인" width="250" height="65" align="center" border="0"><br>
<div class="bottom_area">
<input type="checkbox" id="reg" name="reg"/><label for="reg">아이디 저장</label>&emsp;&emsp;&emsp;&nbsp;&nbsp;&nbsp;<br>
<a href="/pp/portfolio/user/idsearch.do">아이디찾기</a>&nbsp;/&nbsp;<a href="/pp/portfolio/user/pwdsearch.do">비밀번호 찾기</a>
</div>


</form>
</div>
</div>
</body>

</html>