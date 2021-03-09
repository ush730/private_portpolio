<%@ page contentType="text/html; charset=utf-8" %>
<!doctype html>
<html lang="ko">
<head>
<title><%=util.Property.title %></title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
</head>
<body>
<div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>프로필</h2>
	</div>
	<!--//pageTitle-->
	<div class="write">
		<table>
			<colgroup>
				<col style="width:150px"/>
				<col style="width:*"/>
				<col style="width:150px"/>
				<col style="width:*"/>
			</colgroup>
			<tbody>
				<tr>
					<th>이름</th>
					<td>홍길동</td>
					<th>나이</th>
					<td>
						30세
					</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>
					</td>
					<th>이메일</th>
					<td>
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3">
						서울시 금천구 가산디지털2로 115 811호
					</td>
				</tr>
				<tr>
					<th rowspan="2">학력</th>
					<td colspan="3">
						00 고등학교
					</td>
				</tr>
				<tr>
					<td colspan="3">
						00 대학교 00 과
					</td>
				</tr>
				<tr>
					<th rowspan="2">이력</th>
					<td colspan="3">
						00 회사 00 팀 (1년 6개월) - 00업무
					</td>
				</tr>
				<tr>
					<td colspan="3">
						00 회사 00 팀 (1년 6개월) - 00업무
					</td>
				</tr>
				<tr>
					<th rowspan="2">자격증</th>
					<td colspan="3">
						정보처리기사
					</td>
				</tr>
				<tr>
					<td colspan="3">
						SQLD
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<!--//boardWrap-->
</body>
</html>