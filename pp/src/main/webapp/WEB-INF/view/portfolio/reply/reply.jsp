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
<div id="wrap">
	<!-- canvas -->
	<div id="canvas">
		<!-- S T A R T :: headerArea-->
		<!-- E N D :: headerArea--> 
		<!-- S T A R T :: containerArea-->
		<div id="container">
			<div id="content">
				<div class="con_tit">
					<h2>QNA 답글 작성</h2>
				</div>
				<!-- //con_tit -->
				<div class="con">
					<!-- 내용 : s -->
					<div id="bbs">
						<div id="bread">
							<form action="insertReply.do" method="post" name="frm" id="frm" action="" enctype="multipart/form-data" onsubmit="return formCheck()">
							<input type="hidden" name="rep_no" value="${vo.rep_no }">
	
								
								<tbody>
									<tr>
										<th scope="row"><label for="">*제목</label></th>
										<td colspan="10">
											<input type="text" id="title" name="rep_title" class="w100" title="제목을 입력해주세요" value="[Re:${vo.rep_title }]" />	
										</td>
									</tr>								
									<tr>
										<th scope="row"><label for="">*내용</label></th>
										<td colspan="10">
											<textarea id="contents" name="rep_content" title="내용을 입력해주세요" style="width:100%;"></textarea>	
										</td>
									</tr>									
								</tbody>
						
							<input type ="hidden" name="ref" value="${vo.ref }">						
							<input type ="hidden" name="seq" value="${vo.seq }">						
							<input type ="hidden" name="lev" value="${vo.lev }">									
													
							</form>
							<div class="right">

									<a class="btn" href="index.do"><strong>목록</strong></a>
									<a class="btn" style="cursor:pointer;" href="javascript:$('#frm').submit();"><strong>저장</strong></a>
	
							</div>
							<!--//btn-->
						</div>
						<!-- //bread -->
					</div>
					<!-- //bbs --> 
					<!-- 내용 : e -->
				</div>
				<!--//con -->
			</div>
			<!--//content -->
		</div>
		<!--//container --> 
		<!-- E N D :: containerArea-->
	</div>
	<!--//canvas -->
</div>
<!--//wrap -->

</body>
</html>