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
$(function() {
$("#sdate, #edate").datepicker({
	  //showOn: "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다.
	  //buttonImage: "/user/img/calendar.jpg", // 버튼 이미지
	  //buttonImageOnly: true, // 버튼에 있는 이미지만 표시한다.
	  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
	  changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
	  minDate: '-100y', // 현재날짜로부터 100년이전까지 년을 표시한다.
	  nextText: '다음 달', // next 아이콘의 툴팁.
	  prevText: '이전 달', // prev 아이콘의 툴팁.
	  numberOfMonths: [1,1], // 한번에 얼마나 많은 월을 표시할것인가. [2,3] 일 경우, 2(행) x 3(열) = 6개의 월을 표시한다.
	  stepMonths: 3, // next, prev 버튼을 클릭했을때 얼마나 많은 월을 이동하여 표시하는가. 
	  yearRange: 'c-100:c+10', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
	  //showButtonPanel: true, // 캘린더 하단에 버튼 패널을 표시한다. 
	  //currentText: '오늘 날짜' , // 오늘 날짜로 이동하는 버튼 패널
	  //closeText: '닫기',  // 닫기 버튼 패널
	  dateFormat: "yy-mm-dd", // 텍스트 필드에 입력되는 날짜 형식.
	  showAnim: "slide", //애니메이션을 적용한다.
	  showMonthAfterYear: true , // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
	  dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], // 요일의 한글 형식.
	  monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
	 });
	/*
	 $("#orderby").change(function(){
		 $("input[name='orderby']").val($("#orderby").val());
	 });
	 
	 $("#direct").change(function(){
		 $("input[name='direct']").val($("#direct").val());
	 });
	 */
});
function directChange() {
	$("input[name='direct']").val($("#direct").val());
}
function getOrderby() {
	$("input[name='orderby']").val($("#orderby").val());
	$("input[name='direct']").val($("#direct").val());
}
function moveWrite() {
	location.href='write.do';	
}
	
</script>
</head>
<body>
<div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>회원목록</h2>
	</div>
<div>
<form action="index.do" id="frm" onsubmit="getOrderby();">
<input type="text" size="6" name="sdate" id="sdate" value="${param.sdate }" readonly> ~ 
<input type="text" size="6" name="edate" id="edate" value="${param.edate }" readonly>

<input type="text" name="searchWord" value="${param.searchWord }">
<input type="hidden" name="orderby" value="${param.orderby }">
<input type="hidden" name="direct" value="${param.direct }">
<input type="submit" value="검색"> 			${reqPage }/${totalPage } 
</form>
</div>
<div class="list">
	<table>
	<caption> 회원목록 </caption>
					<colgroup>
					<col width="100px" />
					<col width="*" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
				</colgroup>
				<thead>
					<tr>
						<th>회원번호</th>
						<th>회원명</th>
						<th>아이디</th>
						<th>연락처</th>
						<th>가입일</th>
					</tr>
				</thead>
<c:forEach var="vo" items="${list}">

	<tr>
		<td>${vo.user_no }</td>
		<td>${vo.user_name }</td>
		<td><a href="detail.do?no=${vo.user_no }">${vo.user_id }</a></td>
		<td>${vo.user_tel }</td>
		<td>${vo.user_regdate }</td>
	</tr>

</c:forEach>
</table>
</div><br>

<div>
<select id="orderby">
	<option value="regdate" <c:if test="${param.orderby == 'regdate' }">selected</c:if>>가입일</option>
	<option value="name" <c:if test="${param.orderby == 'name' }">selected</c:if>>이름</option>
	<option value="id" <c:if test="${param.orderby == 'id' }">selected</c:if>>아이디</option>
</select>
<select id="direct" ><!-- onchange="directChange();" -->
	<option value="DESC" <c:if test="${param.direct == 'DESC' }">selected</c:if>>내림차순</option>
	<option value="ASC" <c:if test="${param.direct == 'ASC' }">selected</c:if>>오름차순</option>
</select>
</div>
<c:if test="${startPage > 10}">
<a href="index.do?reqPage=${startPage-1 }&sdate=${param.sdate}&edate=${param.edate}&searchWord=${param.searchWord}&orderby=${vo.orderby}&direct=${vo.direct}">[이전]</a>
</c:if>
<c:forEach var="rp" begin="${startPage }" end="${endPage }">
<a href="index.do?reqPage=${rp }&sdate=${param.sdate}&edate=${param.edate}&searchWord=${param.searchWord}&orderby=${vo.orderby}&direct=${vo.direct}">[${rp }]</a>
</c:forEach>
<c:if test="${totalPage > endPage }">
<a href="index.do?reqPage=${endPage+1 }&sdate=${param.sdate}&edate=${param.edate}&searchWord=${param.searchWord}&orderby=${vo.orderby}&direct=${vo.direct}">[다음]</a>
</c:if>
<div class="btnSet">
	<div class="right">
<a href="javascript:moveWrite();"><input type="button" value="회원가입"></a>
</div>
</div>
</div>
</body>
</html>











