<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="user.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title><%=util.Property.title %></title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
<script>
function del() {
	if (confirm('정말 탈퇴하시겠습니까?')) {
		$.ajax({
		url:'/pp/portfolio/user/delete.do',
		data:{user_no:${vo.user_no}},
		type:'HTML',
		method:'GET',
		cache:false,
		async:false,
		success:function(res) {
		//console.log(data);
		if (res == 'true') {
		alert('정상적으로 탈퇴되었습니다.');
		location.href="${param.url}";
						
		} else {
		alert('탈퇴 오류');
	}
}
});
}
}
</script>
</head>


<body>
	  <div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>회원정보</h2>
	</div>
	<div class="write">
			<form action="update.do" method="post" id="frm" name="frm"  enctype="multipart/form-data">
			<input type="hidden" name="user_no" value="${vo.user_no }">
			<table>
				<colgroup>
				<col style="width:150px"/>
				<col style="width:*"/>
				</colgroup>
				<tbody>
					<tr>
						<th>*아이디</th>
						<td>${vo.user_id }</td>
					</tr>
					<tr>
						<th>*이름</th>
						<td>${vo.user_name }</td>
					</tr>
					<tr>
						<th>*이메일</th>
						<td>${vo.user_email }</td>
					</tr>
					<tr>
						<th>*연락처</th>
						<td>${vo.user_tel }</td>
					</tr>
					<tr>
						<th>*성별</th>
						<td>${vo.user_gender}</td>
					</tr>
					<tr>
						<th>*생년월일<br></th>
						<td>${vo.user_birth }</td>
					</tr>
					<tr>
						<th>*주소</th>
						<td>
							${vo.addr1 } ${vo.addr2 }
						</td>
					<tr>
						<th>*우편번호</th>
						<td>${vo.zipcode }</td>
					</tr>
				
					</tbody>
				</table>
				</form>
			<div class="btnSet">

			<input type="button" class="btn" value="회원정보 수정" onclick='location.href="edit.do?user_no=${vo.user_no}";'>
					<a href="javascript:del();" class="btn" id="submitBtn">회원탈퇴</a>
			<input type="button" class="btn" value="처음으로" onclick='location.href="/pp/index.do";'>
			</div>
			</div>

			</div>



</body>
</html>