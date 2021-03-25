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
			data:{board_no:${vo.board_no}},
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
function delComment(no){
	if (confirm('삭제하시겠습니까')){
		location.href='/pp/portfolio/board/deleteComment.do?no='+no+'&board_no=${vo.board_no}';
	}
}

</script>
</head>
<body>
<div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>자유게시판</h2>
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
						${vo.board_regdate }
					</td>
					<th>조회수</th>
					<td>
						${vo.readCnt }
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						${vo.board_title }
					</td>
					<th>작성자</th>
					<td>
						${authUser.user_name }
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3">
						${vo.board_content }
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="3">
						<a href="" target="_blank">첨부파일명.docx</a>
					</td>
				</tr>
			</tbody>
		</table>
		<h5 class="title">댓글</h5>	
					<div class="comment">					
						<form action='insertComment.do' method="post" name="frm" id="frm" action="" >
						<input type='hidden' name='board_no' value="${vo.board_no }">
						<input type='hidden' name='user_no' value="${vo.user_no }">
						<div class="review_area">
							<div class="review_write">
								
								<c:if test='${empty clist }'>
									<dl>
										<dd class="bbsno">
											댓글이 없습니다.
										</dd>
									</dl>
								</c:if>
								
								<c:forEach var="vo" items="${clist}">	
								
								<dl>
									
									<dt><strong>${vo.user_name }</strong> ${vo.board_regdate }</dt>
									<dd><strong> 내용 : </strong>${vo.board_comment }
										
										<span class="reEdit" >
											<c:if test="${authUser.user_no == vo.user_no}">
												<strong class="btn_in inbtn"><input type="button" class="r_delete" value="삭제" onclick='delComment(${vo.no })'/></strong>
											</c:if>
										</span>
									</dd>
									
								</dl>
								</c:forEach>
								</div>
						</div>
						<div class="review_area">
							<div class="review_write">
								<div class="input">									
									<div class="textarea">
										<textarea name="board_comment" id="board_comment"></textarea>
									</div>
									<div class="btn_area">
										<input type="submit" class="btn" onclick="save();" value="등록">
									</div>
								</div>
							</div>
						</div>
					</form>
					</div>
		
		
		<div class="btnSet">
			<div class="left">
				<a href="javascript:;" class="btn" onclick="location.href='index.do';">목록</a>
			</div>
			<div class="right">
				<a href="edit.do?board_no=${vo.board_no }" class="btn">수정</a>
				<a href="javascript:;" class="btn" onclick="del();">삭제</a>
			</div>
		</div>
		<div style="height:300px;"></div>
	</div>
	<!--//list-->
</div>
<!--//boardWrap-->
</body>
</html>
