<%-- 
	작성자 : 이형근(fixalot@exint.co.kr)
	백오피스 > 게시판관리 > 관리자 공지사항 상세페이지 (메인페이지에서 팝업 혹은 조회 용 페이지)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<%@include file="/common/include/header.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
	
		// 내용에 맞춘 화면 높이 리사이징
	// 	var h = (window.innerHeight) ? document.documentElement.offsetHeight : document.body.scrollHeight;
	//     var h_v = (window.innerHeight) ? window.innerHeight :document.documentElement.clientHeight;
	//     h = h - h_v;
	//     window.resizeBy(0, h);
	    
		// close & set cookie
		$("#dont_show_again").click(function() {
			$.get("/board/notice/setNoticePopCookie.do", "id=${info.noticebbs_no}", function(data) {
				close();
			});
			
		});
		
		// 첨부파일이 있을 경우 엘리먼트(이벤트) 추가
		<c:if test="${not empty info.att_seq}">
			$("#trContent").after('<tr><th scope="row">첨부파일</th><td colspan="3" id="td_fileUpload"></td></tr>');
			
			var $aFile = $("<a>", {
				id: "fileDownload",
				href: "${fileDownloadPath}/" + "${info.attachfile_txt}",
				target: "_blank"
			}).css({
				"text-decoration": "underline",
				cursor: "pointer"
			}).text("${info.filename_txt}");
			var $pFileWrapper = $("<p>").css("margin-bottom", "2px").append($aFile);
			$("#td_fileUpload").prepend($pFileWrapper);
		</c:if>
		
		
	});
</script>

</head>
<body class="sky" style="overflow:auto; overflow:x-hidden">
<div class="layerpop_inner" id="#">
	<!-- .ly_body -->
	<div class="ly_body">
		<div class="layer_contents" style="padding-bottom:48px">
			${param.testValue}<br/>
			<span id="result"></span>
			<table cellspacing="0" cellpadding="0" class="layer_tbl">
			<caption>${mode == "new" ? "관리자 게시판 등록 페이지" : "관리자 게시판 상세 페이지"}</caption>
				<colgroup>
					<col width="20%"/>
					<col width="30%"/>
					<col width="20%"/>
					<col width="30%"/>
				</colgroup>
				<tbody>
					<tr>
<!-- 					<th scope="row">제목</th> -->
						<td colspan="4"><h1>${info.title_txt}</h1></td>
					</tr>
					<tr id="trContent">
						<!--  <td colspan="4" style="height:230px; overflow:auto;">${info.content_txt}</td> -->
						<td colspan="4">
							<div style="overflow:auto;">
								${info.content_txt}
							</div>
						</td>
					</tr>
					<!-- 
					<tr>
						<th scope="row">등록자명</th>
						<td>${info.regstaff_id}</td>
						<th scope="row">등록일시</th>
						<td>${info.reg_dt}</td>
					</tr>
					<tr class="division">
						<th scope="row">수정자명</th>
						<td>${info.modstaff_id}</td>
						<th scope="row">수정일시</th>
						<td>${info.mod_dt}</td>
					</tr>
					 -->
				</tbody>
			</table>
		</div>
		
		<!--  footer  -->
		<div class="refer bullet6" style="margin:0; position:fixed; left:0; bottom:0; width:100%; padding:10px 0;">
			<c:if test="${param.mode=='pop'}">
			<div style="float:left; margin:5px 0 0 20px;">
				<label for="dont_show_again" style="margin-right:5px;">하루 동안 다시 보이지 않기</label><input type="checkbox" id="dont_show_again"/>
			</div>
			</c:if>
			<div class="refer_bt" style="margin-right:20px;">
				<div class="min_btn mini">
					<button type="button" class="gray" id="btnClose">닫기</button>
				</div>
			</div>
		</div>
		<!--  //footer  -->
		
	</div>
	<!-- // .ly_body -->

</div>

<div id="toast"></div></body>
</html>