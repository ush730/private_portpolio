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

function formCheck() {
	if ($("#user_id").val().trim() == '') {
		alert('아이디를 입력해주세요');
		$("#user_id").focus();
		return false;
	}
	var con = true;
	if ($("#user_id").val().length >= 3) { // 아이디 값이 3자 이상인 경우
		$.ajax({
			url:'/pp/portfolio/user/isDuplicateId.do',
			data:{id:$("#user_id").val()},
			type:'HTML',
			method:'GET',
			cache:false,
			async:false,
			success:function(data) {
				//console.log(data);
				if (data == 'true') {
					alert('아이디가 중복되었습니다.');
					$("#user_id").focus();
					con = false;
				}
				else if (data == 'false'){
					alert('이 아이디는 사용할 수 있습니다.');
					con = false;
				}
			}

		});
	} else {
		alert('아이디는 3자 이상 입력해 주세요');
		$("#user_id").focus();
		return false;
	}
}

function goSave() {

	if ($("#user_pwd").val().trim() == '') {
		alert('비밀번호를 입력해 주세요');
		$("#user_pwd").focus();
		return false;
	}
	if ($("#user_pwd_check").val().trim() == '') {
		alert('비밀번호를 확인해주세요');
		$("#user_pwd_check").focus();
		return false;
	}
	if ($("#user_pwd_check").val().trim() !== $("#user_pwd").val()) {
		alert('비밀번호가 일치하지 않습니다.');
		$("#user_pwd_check").focus();
		return false;
	}
	if ($("#user_name").val().trim() == '') {
		alert('이름을 입력해 주세요');
		$("#user_name").focus();
		return false;
	}
	if ($("#user_email").val().trim() == '') {
		alert('e메일 주소를 입력해 주세요');
		$("#user_email").focus();
		return false;
	}
	if ($("#user_tel").val().trim() == '') {
		alert('연락처를 입력해 주세요');
		$("#user_tel").focus();
		return false;
	}

	if ($("#user_birth").val().trim() == '') {
		alert('생일을 입력해 주세요');
		$("#user_birth").focus();
		return false;
	}
	if ($("#user_birth").val().length < 10) {
		alert('생일을 xxxx(년)-xx(월)-xx(일) 순으로 정확히 입력해 주세요');
		$("#user_birth").focus();
		return false;
	}
	if(!$(':input:radio[id=user_gender]:checked').val()) {   
		   alert("성별을 선택해 주세요.");
		   return;
		}	
	if ($("#zipcode").val().trim() == '') {
		alert('우편번호를 입력해 주세요');
		$("#zipcode").focus();
		return false;
	}
	if ($("#addr1").val().trim() == '') {
		alert('주소를 입력해 주세요');
		$("#addr1").focus();
		return false;
	
}
	// 폼에 있는 모든 데이터를 한번에 읽어오는 방법
	var data = $("#frm").serialize();
	console.log(data);
	$.ajax({
		url:'/pp/portfolio/user/insert.do',
		data:data,
		type:'HTML',
		method:'POST',
		cache:false,
		success:function(data) {
			//console.log(data);
			if (data == 'true') {
				alert("정상적으로 등록되었습니다.");
				
				// 모든 입력란을 초기화
				//$("input[type='text'], input[type='password']").val("");
				//$("#frm")[0].reset();
				location.href="/pp/index.do";
			} else {
				alert("등록 실패");
			}
		}
	});
}

</script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function zip_api() {
        new daum.Postcode({
            oncomplete: function(data) {
            	// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //document.getElementById("sample6_extraAddress").value = extraAddr;
                    addr += ' '+extraAddr;
                
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                //document.getElementById('zipcode').value = data.zonecode;
                $("#zipcode").val(data.zonecode);
                //document.getElementById("addr1").value = addr;
                $("#addr1").val(addr);
                // 커서를 상세주소 필드로 이동한다.
                //document.getElementById("addr2").focus();
                $("#addr2").focus();
            }
        }).open();
    }
</script>
</head>
<body>
	<div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>회원가입</h2>
	</div>
	</div>
	<div class="write">
			<form action="insert.do" method="post" id="frm" name="frm"  enctype="multipart/form-data">
			<table class="board_write">
				<caption>회원가입</caption>
				<colgroup>
					<col style="width:150px"/>
					<col width="width:500px" />
				</colgroup>
				<tbody>
					<tr>
						<th>*아이디</th>
						<td>
							<input type="text" name="user_id" id="user_id" class="inNextBtn" class="wid200" style="float:left;">
							<span class="user_id_check"><a href="javascript:;" onclick="formCheck();" class="btn bgGray" style="float:left; width:auto; clear:none;">중복확인</a></span>
						</td>
					</tr>
					<tr>
						<th>*비밀번호</th>
						<td><input type="password" name="user_pwd" id="user_pwd" class="wid200" style="float:left;"> </td>
					</tr>
					<tr>
						<th>*비밀번호<span>확인</span></th>
						<td><input type="password" name="user_pwd_check" id="user_pwd_check" class="wid200" style="float:left;"></td>
					</tr>
					<tr>
						<th>*이름</th>
						<td><input type="text" name="user_name" id="user_name" class="wid200" style="float:left;"></td>
					</tr>
					<tr>
						<th>*이메일</th>
						<td><input type="text" name="user_email" id="user_email" class="wid200" style="float:left;"></td>
					</tr>
					<tr>
						<th>*연락처</th>
						<td><input type="text" name="user_tel" id="user_tel" class="wid50" maxlength="15" onkeyup="isNumberOrHyphen(this);cvtPhoneNumber(this);" style="float:left;"></td>
					</tr>

					<tr>
						<th>*생년월일<br></th>
						<td><input type="text" name="user_birth" id="user_birth" class="wid200" onkeyup="isNumberOrHyphen(this);cvtDateTime(this);" style="float:left;"></td>
					</tr>
					<tr>
						<th>*성별</th>
						<td><input type="radio" name = "user_gender" value="남성" id="user_gender">남성
						<input type="radio" name = "user_gender" value="여성" id="user_gender">여성 </td>
					</tr>
					<tr>
						<th>*주소</th>
						<td>
							<input type="button" value="우편번호" onclick="zip_api();" class="btn bgGray" style="float:left;">
							<input type="text" name="zipcode" id="zipcode" size="5" readonly>
							<input type="text" name="addr1" id="addr1" readonly class="wid50" maxlength="15" style="float:left;">
							<input type="text" name="addr2" id="addr2" class="wid200" style="float:left;">
						</td>
					</tr>
					</tbody>
				</table>
							<input type="hidden" name="user_id_check" id="user_id_check" value="0"/>
				</form>
				<div class="btnSet clear">
					<div><a href="javascript:;" class="btn" onclick="goSave();">가입</a> <a href="javascript:;" class="btn" onclick="history.back();">취소</a></div>
				</div>
			</div>
 



</body>
</html>