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
function del() {	
	
	if (confirm('정말 삭제하시겠습니까?')) {
		$.ajax({
			url:'delete.do',
			data:{rep_no:${vo.rep_no}},
			type:'HTML',
			method:'GET',
			cache:false,
			async:false,
			success:function(res) {
				//console.log(data);
				if (res == 'true') {
					alert('정상적으로 삭제되었습니다.');
					location.href='index.do';
				} else {
					alert('삭제 오류');
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
		<h2>답변게시판</h2>
	</div>
	<!--//pageTitle-->
	<!--//search-->
	<div class="write">
		<form name="frm" id="frm" action="process.do" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="cmd" value="write">
		<table>
			<colgroup>
				<col style="width:150px"/>
				<col style="width:*"/>
				<col style="width:150px"/>
				<col style="width:*"/>
			</colgroup>
			<tbody>
				<tr>
					<th>작성일</th>
					<td>
						${vo.rep_regdate }
					</td>
				
					<th>조회수</th>
						<td>
							111
						</td>
					</tr>
					<tr>
					<th>제목</th>
					<td>
						${vo.rep_title }
					</td>
					<th>작성자</th>
					<td>
						${authUser.user_name }
					</td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="3">
						${vo.rep_content}
					</td>
				</tr>
			</tbody>
		</table>
		</form>
		<div class="btnSet">
			<div class="left">
				<a href="javascript:;" class="btn" onclick="location.href='index.do';">목록</a>
			</div>
			<div class="right">
			<a href="reply.do?rep_no=${vo.rep_no }" class="btn">답글</a>
				<a href="edit.do?rep_no=${vo.rep_no }" class="btn">수정</a>
				<a href="javascript:;" class="btn" onclick="del();">삭제</a>
			</div>
		</div>
		<div style="height:300px;"></div>
	</div>
	</div>
	<!--//list-->

<!--//boardWrap-->
</body>
</html>
