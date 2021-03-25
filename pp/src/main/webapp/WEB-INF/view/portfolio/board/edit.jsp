<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
 <%@ page import="user.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=util.Property.title %></title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
<script>
var oEditors = [];
$(function() {
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "contents", // textarea ID
		sSkinURI: "<%=request.getContextPath()%>/smarteditor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			fOnBeforeUnload : function(){
				
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["contents"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
});
function formCheck() {
	if ($("#title").val().trim() == '') {
		alert('제목을 입력하세요');
		$("#title").focus();
		return false;
	}
	//
	var html = oEditors.getById["contents"].getIR(); // 값 가져오기
	if (html == '') {
		alert('내용을 입력하세요');
	}
	oEditors.getById['contents'].exec("UPDATE_CONTENTS_FIELD",[]); // 에디터있던 내용을 textarea에 담기
}
</script>
</head>
<body> 
<div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>자유게시판-수정</h2>
	</div>
		<div class="write">
		<form action="update.do" method="post" name="frm" id="frm" action="" enctype="multipart/form-data" onsubmit="return formCheck()">
			<input type='hidden' name='board_no' value='${vo.board_no }'>
			<input type="hidden" name="user_no" value="${vo.user_no }">
			<table class="write">
					<colgroup>
						<col style="width:150px"/>
						<col style="width:*"/>
					</colgroup>
					<tbody>
					<tr>
						<th>제목</th>
						<td>
							<input type="text" id="title" name="board_title" class="w100" title="제목을 입력해주세요"  value=${vo.board_title }/>
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea id="contents" name="board_content" title="내용을 입력해주세요" style="width:100%;" value=${vo.board_content }></textarea>
						</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td>
								<p>기존파일 : ${vo.filename }<br />
								<input type="checkbox" id="filename_chk" name="filename_chk" value="1" title="첨부파일을 삭제하시려면 체크해주세요" />
								<label for="filename_chk">기존파일삭제</label>
							</p>
					</td>
				</tr>
					</tbody>
				</table>
			</form>
			<div class="btnSet clear">
			<div class="fl_l"><a href="index.do" class="btn">목록으로</a></div>			
			<div class="fl_l"><a href="javascript:$('#frm').submit();" class="btn"><strong>저장</strong></a></div>
			</div>
		</div>
</div>