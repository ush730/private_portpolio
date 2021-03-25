<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>HTML with Hanbit</title>
    <meta charset = "utf-8">
    <meta name="viewport" content="user-scalable=no,initial-scale=1,maximum-scale=1">
    <script src="http://code.jquery.com/jquery-3.4.1.js"></script>

    <script src="/user/js/jquery.imagesloaded.min.js"></script>
    <script src="/user/js/jquery.masonry.min.js"></script>
    <style>
        * {
            margin:0;padding:0;
            font-family: 'Malgun Gotic', sans-serif;
        }
        a { text-decoration: none;}
        img { border: 0;}
        li { list-style: none;}
        html { background: #f7f5f5;}

        /* 헤더 */
        #main-header {
            height:40px;
            background:#faf7f7;
            position:relative;
        }
        .header-search-form {float:left;}
        .header-menu {float:right;}
        .header-title {
            position:absolute;
            width:200px; height:40px;
            left:50%; margin-left:-100px;
            background:url('logo.png');
            background-repeat:no-repeat;
            text-indent:-9999px;
        }
        /* 풀다운 메뉴 */
        .outer-menu {
            float:left;
            width:100px; height:20px;
            line-height:20px;
            padding:10px 0;
            position:relative;
            text-align:center;
            font-size:13px;
            font-weight:bold;
            z-index:9999;
        }
        .outer-menu:hover {background:#e1dfdfdf;}
        .inner-menu{ 
            display:none;
            background:#ffffff;
            margin-top:10px;
            width:100%;
            border-top:1px solid #cccaca;
            box-shadow:0 2px 4px rgba(34,25,26,0.5);
        }
        .inner-menu a {
            display:block;
            padding:5px 10px;
            z-index:5000;
        }
        .inner-menu a:hover {
            background:#e1dfdf;
        }
        /* 내비게이션 메뉴 */
        #main-navigation {
            height:30px;
            background:#faf7f7;
            border-top:1px solid #cfcaca;
            box-shadow:1px 3px 3px rgba(34,25,25,0.4);
        }
        #main-navigation > ul {
            overflow:hidden;
            text-align:center;
        }
        #main-navigation > ul > li {
            display:inline;
            padding:0 5px;
            line-height:30px;
            font-size:13px;
            color:#524d4d;
            text-shadow:0 1px 1p white;
        }
        #main-navigation > ul > li:hover {
            background:#e1dfdfdf;
            border-radius:2px;
        }
        /* 검색양식 */
        .header-search-form {
            height:26px;
            padding:7px;
        }
        .input-search {
            display:block;
            float:left;
            background-color:#ffffff;
            border:1px solid #cccccc;
            border-radius:15px 0 0 15px;
            box-shadow:inset 0 1px 1px rgba(0,0,0,0.05);
            width:120px; height:26px;
            padding:0 0 0 10px;
            font-size:12px;
            color:#555555;
        }
        .input-search:focus {
            border-color:rgba(82,168,236,0.8);
            outline:0;
            box-shadow:inset 0 1px 1px rgba(0,0,0,0.05);
        }
        .input-search-submit {
            display:block;
            /* float:left; */
            width:50px; height:26px;
            border-radius:0 15px 15px 0;
            border:1px solid #cccccc;
            margin-left:-1px;
            /* vertical-align:top; */
            display:inline-block;
        }
        /* 종이 */
        .paper {
            width:190px;
            margin-top:10px;
            padding:15px 15px 0;
            font-size:11px;
            background:#ffffff;
            box-shadow:0 1px 3px rgba(34,25,25,0.4);
            cursor:pointer;
        }
        .paper-content {
            margin:0 -15px;
            margin-top:10px;
            padding:10px 15px;
            background:#f2f0f0;
            overflow:hidden;
        }
        .paper-description {
            margin:10px 0;
        }
        .paper-link {
            display:block;
            float:left;
        }
        .paper-text {
            float:left;
            width:150px;
            margin-left:10px;
        }
        /* 섹션 */
        #main-section, #btn_section {
            width:920px;
            margin:0 auto;
        }
        /* 세줄 */
        @media (max-width:919px) {
            #main-section {width:690px;}
        }
        /* 네줄 */
        @media (min-width:930px) and (max-width:1149px) {
            #main-section {width:920px;}
        }
        /* 다섯줄 */
        @media (min-width:1150px) and (max-width:1379px) {
            #main-section {width:1150px;}
        }
        /* 여섯줄 */
        @media (min-width:1380px) {
            #main-section, #btn_section {width:1380px;}
        }
        /* 라이트박스 */
        #darken-background {
            position:absolute;
            top:0; left:0; right:0;
            height:100%;
            display:none;
            background:rgba(0,0,0,0.9);
            z-index:10000;
            overflow-y:scroll;
        }
        #lightbox {
            width:700px;
            margin:20px auto; padding:15px;
            border:1px solid #333333;
            border-radius: 5px;
            background:white;
            box-shadow : 0 5px 5px rgba(34,25,25,0.4);
            text-align:center;
        }
        .user-information{overflow:hidden; text-align:left};
        .user-information-image {float:left; width:70px;}
        .user-information-text {float:right; width:620px;}
        .lightbox-splitter { margin:10px 0;}
    </style>
    <script>
        
        $(function() {
            // 풀다운
            $('.outer-menu').hover(function() {
                $(this).find('.inner-menu').css('display', 'block');
            }, function() {
                $(this).find('.inner-menu').css('display', 'none');
            });

            // 페이지
            $('#main-section').imagesLoaded(function() {
                $('#main-section').masonry({
                    itemSelector : '.paper',
                    columnwidth : 230,
                    isAnimated:true
                });
            });

            
            function hideLightBox() {
                $('#darken-background').hide();
                $('body').css('overflow', '');
            }
            // 라이트박스 제거 이벤트
            $("#darken-background").click(function() {
                hideLightBox();
            });
            // 클릭이벤트
           
            $('.paper').click(function() {
            //	console.log($(this).data("no"));
            	ajaxView($(this).data("no"));
                //showLightBox();
            });
            // 라이트박스 제거이벤트 보조
            $('#lightbox').click(function(event) {
                event.stopPropagation();
            });
        });
        
     // 라이트박스
        function showLightBox() {
            $('#darken-background').show();
            $('#darken-background').css('top', $(window).scrollTop());
            $('body').css('overflow:hidden');
        }
        
        function ajaxView(no) {
        	///
        	$.ajax({
        		url : '/user/gallery/dogAjax.do',
        		async : false,
        		data : {
        			'no' : no
        		},
        		dataType : 'JSON',
        		success : function(data) {
        			//var obj = data.dog;
        			//console.log(obj);
					$("#dog_kind").text(data.kind+" (조회수:"+data.readcount+")");
					$("#dog_price").text(data.color);
					$("#dog_image").attr("src", "/user/upload/gallery/"+data.image);
					$("#editBtn").attr("onclick", "location.href='edit.do?no="+no+"';");
					$("#delBtn").attr("onclick", "delDog("+no+");");
        		},
        		error : function(data) {
        			console.log(data);
        		}
        	});
        	showLightBox();
        }
        
        function delDog(id) {
        	if (confirm("삭제하시겠습니까?")) {
        		// location.href='/dog/dog/delete.do?id='+id;
        		$.ajax({
        			url : 'delete.do?no='no,
        			success : function(res) {
        				if (res == 'true') {
        					alert('정상적으로 삭제되어었습니다.')
        					location.reload();
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
    <header id="main-header">
        <div class="header-search-form">
            <form>
                <input type="search" class="input-search" name="keyword" value="">
                <input type="submit" class="input-search-submit" value="검색">
            </form>
        </div>
        <h1 class="header-title">Interest</h1>
        <div class="header-menu">
            <ul class="outer-menu">
                <li>
                    <a href="#">정보</a>
                    <ul class="inner-menu">
                        <li><a href="#">데이터</a></li>
                        <li><a href="#">데이터</a></li>
                        <li><a href="#">데이터</a></li>
                        <li><a href="#">데이터</a></li>
                        <li><a href="#">데이터</a></li>
                        <li><a href="#">데이터</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="outer-menu">
                <li>
                    <a href="#">사용자</a>
                    <ul class="inner-menu">
                        <li><a href="#">데이터</a></li>
                        <li><a href="#">데이터</a></li>
                        <li><a href="#">데이터</a></li>
                        <li><a href="#">데이터</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </header>
    <nav id="main-navigation">
        <ul>
            <li><a href="#">Following</a></li>
            <li><a href="#">Categories</a></li>
            <li><a href="#">Everything</a></li>
            <li><a href="#">Popular</a></li>
            <li><a href="#">Gift</a></li>
        </ul>
    </nav>
    <section id="main-section">
    <c:forEach var="vo" items="${list}">
        <div class="paper" data-no="${vo.no }">
            <div class="paper-holder">
                <a><img width="190" src="/user/upload/gallery/${vo.image}"></a>
            </div>
            <p class="paper-description">${vo.kind}</p>
            <div class="paper-content">
                <p class="paper-text">색상 : ${vo.color}</p>
            </div>
        </div>
      </c:forEach>
     
    </section>
   	<section id = "btn_section">
   		<input type = "button" value ="등록" onclick="location.href='/user/gallery/write.do';">
   	</section>
    <div id="darken-background">
        <div id="lightbox">
            <div class="user-information">
                <div class="user-information-text">
                    <h3 id="dog_kind">말티즈</h3>
                    <p id="dog_color">흰색</p>
                </div>
            </div>
            <hr class="lightbox-spllitter">
            <img id="dog_image" src="http://placekitten.com/600/750">
            <input type="button" id = "editBtn" value="수정">
            <input type="button" id = "delBtn" value="삭제">
        </div>
    </div>
</body>
</html>