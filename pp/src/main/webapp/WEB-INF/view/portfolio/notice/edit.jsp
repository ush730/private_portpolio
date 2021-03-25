<%@ page contentType="text/html; charset=utf-8" %>
<!doctype html>
<html lang="ko">
<head>
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
		<h2>공지사항</h2>
	</div>
	<!--//pageTitle-->
	<!--//search-->
	<div class="write">
		<form name="frm" id="frm" action="process.do" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="cmd" value="edit">
		<input type="hidden" name="idx" value="1">
		<table>
			<colgroup>
				<col style="width:150px"/>
				<col style="width:*"/>
			</colgroup>
			<tbody>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" id="title" name="title" value="공지사항 제목입니다."  title="제목을 입력해주세요" value=${vo.notice_title } />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea id="contents" name="contents" rows="25">${vo.notice_contents }</textarea>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td>
							<p>기존파일 : 첨부파일.docx<br />
								<input type="checkbox" id="filename_chk" name="filename_chk" value="1" title="첨부파일을 삭제하시려면 체크해주세요" />
								<label for="filename_chk">기존파일삭제</label>
							</p>
						<input type="file" name="filename_tmp">
					</td>
				</tr>
			</tbody>
		</table>
		</form>
		<div class="btnSet">
			<div class="right">
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
