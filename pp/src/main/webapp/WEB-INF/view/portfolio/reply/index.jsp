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
<div class="sub">
	<div class="size">
		<h3 class="sub_title">자유게시판</h3>
	</div>
	<div class="bbs">
	<table class="list">
			<p><span><strong>총 ${totCount }개</strong>  |  ${reqPage }/${totalPage }</span></p>
			<form><input type="hidden" name="user_no" value="${authUser.user_no }"></form>
				<caption> 답변글 목록 </caption>
				<colgroup>
					<col width="80px" />
					<col width="*" />
					<col width="100px" />
					<col width="100px" />
				</colgroup>
				<thead>
					<tr>
					<th scope="col">글번호</th>
					<th scope="col">제목</th> 
					<th scope="col">작성자</th>
					<th scope="col">작성일</th> 
					</tr>
				</thead>
				<tbody>
				<c:forEach var="vo" items="${list}">
					<tr style='cursor:pointer;' onclick="location.href='detail.do?rep_no=${vo.rep_no }'">
						<td>${vo.rep_no }</td>
						<td class="txt_l">${vo.rep_title }</td>
						<td class="writer"> ${authUser.user_name }</td>
						<td class="date">${vo.rep_regdate }</td>

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
		<div class="btnSet">
			<div class="right">
				<a href="write.do" class="btn">글쓰기</a>
			</div>
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
	<!--//list-->
</div>
<!--//boardWrap-->
</body>
</html>
