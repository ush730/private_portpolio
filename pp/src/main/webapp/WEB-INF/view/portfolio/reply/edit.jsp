<%@ page contentType="text/html; charset=utf-8" %>
<!doctype html>
 <%@ page import="user.*" %>
<html>
<head>
<title><%=util.Property.title %></title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
<script>
var oEditors; // 에디터 객체 담을 곳
$(document).ready(function(e){
	oEditors = setEditor("<%=request.getContextPath()%>", "contents"); // 에디터 셋팅
});

function goSave() {
	if ($("#title").val() == "") {
		alert('제목을 입력해 주세요.');
		$("#title").focus();
		return false;
	}
	var sHTML = oEditors.getById["contents"].getIR();
	if (sHTML == "") {
		alert('내용을 입력해 주세요.');
		$("#contents").focus();
		return false;
	} else {
		oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	}
	$('#frm').submit();
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
		<form action="update.do" method="post" name="frm" id="frm" enctype="multipart/form-data">
		<input type="hidden" name="user_no" value="${authUser.user_no }">
		<table>
			<colgroup>
				<col style="width:150px"/>
				<col style="width:*"/>
			</colgroup>
			<tbody>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" id="title" name="rep_title"  value=${vo.rep_title } title="제목을 입력해주세요"   />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea id="contents" name="rep_content" title="내용을 입력해주세요"  value=${vo.rep_content }  ></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		</form>
		<div class="btnSet">
			<div class="right">
				<div class="fl_l"><a href="index.do" class="btn">목록으로</a></div>		
				<a href="javascript:;" class="btn" onclick="goSave();">저장</a>
			</div>
		</div>
		<div style="height:300px;"></div>
	</div>
	<!--//list-->
</div>
<!--//boardWrap-->
</body>
</html>
