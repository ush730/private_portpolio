<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="util.*" %>
<%@ page import="user.*" %>
<%@ page import="java.util.*" %>
<!doctype html>
<html lang="ko">
<head>
<title><%=util.Property.title %></title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
<script>
function goSearch() {
	$("#searchForm").submit();
}
</script>
</head>
<body>
<div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>공지사항</h2>
	</div>
	<!--//pageTitle-->
	<!--//search-->
	<div class="list">
			<table>
				<caption> 목록 </caption>
				<colgroup>
					<col width="50px" />
					<col width="*" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="vo" items="${list}">							
					<tr style='cursor:pointer;' onclick="location.href='detail.do?board_no=${vo.notice_no }'">
						<td class="first"><input type="checkbox" name="nos" id="no" value="${vo.notice_no }"/></td>
						<td>${vo.notice_no }</td>
						<td class="txt_l">${vo.notice_title}</td>
	
						<td class="date">${vo.notice_regdate }</td>
						<td class="hit" >${vo.readCnt }</td>
					</tr>						
				</c:forEach>					
				</tbody>
			</table>
			<div class="pagenate clear">								
				<c:if test="${startPage > 10}">
					<a href="index.do?reqPage=${startPage-1 }&searchWord=${param.searchWord}">[이전]</a>
				</c:if>
				<c:forEach var="rp" begin="${startPage }" end="${endPage }">
					<a href="index.do?reqPage=${rp }&searchWord=${param.searchWord}">[${rp }]</a>
				</c:forEach>
				<c:if test="${totalPage > endPage }">
					<a href="index.do?reqPage=${endPage+1 }&searchWord=${param.searchWord}">[다음]</a>
				</c:if>
			</div>
						<div class="bbsSearch">
				<form method="get" name="searchForm" id="searchForm" action="index.do">
					<span class="srchSelect">
						<select name="searchType">
							<option value="" <c:if test="${param.searchType == 0 }">selected</c:if>>전체</option>
							<option value="1" <c:if test="${param.searchType == 1 }">selected</c:if>>제목만</option>
							<option value="2" <c:if test="${param.searchType == 2 }">selected</c:if>>내용만</option>
							<option value="3" <c:if test="${param.searchType == 3 }">selected</c:if>>제목 + 내용</option>
							<option value="4" <c:if test="${param.searchType == 4 }">selected</c:if>>작성자</option>
						</select>
					</span>
					<span class="searchWord">							
						<input type="text" name="searchWord" value="${param.searchWord }">
						<input type="button" id="" value="검색" title="검색" onclick="goSearch();">
					</span>
					
				</form>					
			</div>		
		</div>
		<div class="btnSet">
			<div class="right">
				<a href="write.do" class="btn">작성</a>
			</div>
		</div>
	</div>
	<!--//list-->

<!--//boardWrap-->
</body>
</html>
