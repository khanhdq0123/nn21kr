<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<%@include file="/common/include/header.jsp"%>
	<title>매뉴얼 등록</title>
	<script type="text/javascript">
	
		$(document).ready(function() {
			
			//첨부파일
			var attachList =  new Array();
			var $aFile
			var $pFileWrapper
			<c:forEach items="${attachList}" var="item1">
				attachList.push("${item1.filename_txt}");
				attachList.push("${item1.attachfile_txt}");
				$aFile = $("<a>", {id: "fileDownload", href: "${fileDownloadPath}/" + "${item1.attachfile_txt}",	target: "_self"}).css({"text-decoration": "underline",	cursor: "pointer"}).text("${item1.filename_txt}");
				$pFileWrapper = $("<p>").css("margin-bottom", "2px").append($aFile);
				$("#tdAttachment").prepend($pFileWrapper);		
			</c:forEach>
			
			
			//수정버튼
			$("#btnUpdate").on("click", function(){
				location.href="/cu/mn/CUMN01/popup2?manual_no=" + $("#manual_no").val();
			});
			
			//삭제버튼
			$("#btnDelete").on("click", function(){
				//location.href="/cu/mn/CUMN01/deleteManualMst?manual_no=" + $("#manual_no").val();
				
				$.ajax({
					type: "POST",
					url: "/cu/mn/CUMN01/deleteManualMst",
					data: $("#submitForm").serialize(),
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						if(data.code != 0){
							opener.toast(data.msg);
							opener.fn_f3();
							window.close();
						} else {
							toast('저장이 실패되었습니다.');
						}
					},
					error: function(jqXHR, textStatus, errorThrown) {
						alert(failMsg + ' ' + textStatus.msg);						
					}
				});				
				
			});
	
		});
	
	</script>
		
</head>

<body class="sky">

<div class="layerpop_inner" id="#">

	<h1 class="ly_header">메뉴얼 등록</h1>
	<!-- .ly_body -->
	<div class="ly_body">
		<div class="refer bullet6">
			<div class="refer_bt">
				<div class="min_btn mini">
				<c:if test="${login_id == info.reg_id}">
					<input type="button" class="btn btn-primary btn-sm" value="수정" 			id="btnUpdate">
					<input type="button" class="btn btn-danger btn-sm" value="삭제" 			id="btnDelete">
				</c:if>
					<input type="button" class="btn btn-close btn-sm" 	value="닫기" 			id="btnClose">
				</div>
			</div>
		</div>

		<form action="#" id="submitForm" enctype="multipart/form-data">
			<fieldset>
			<legend>${mode == "new" ? "관리자 게시판 등록 페이지" : "관리자 게시판 상세 페이지"}</legend>
			<input type="hidden" name="mode" id="mode" value="${mode}"/>
			<input type="hidden" name="manual_no" id="manual_no" value="${info.manual_no}"/>
<%-- 			<input type="hidden" id="attachfile_txt" name="attachfile_txt" value="${info.attachfile_txt}"/> --%>
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>${mode == "new" ? "관리자 게시판 등록 페이지" : "관리자 게시판 상세 페이지"}</caption>
					<colgroup>
						<col width="15%"/>
						<col width="20%"/>
						<col width="15%"/>
						<col width="50%"/>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>제목</th>
							<td colspan="3">${info.title_txt}</td>
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>내용</th>
							<td colspan="3">
							${info.content_txt}
							</td>
						</tr>
						<tr>
							<th scope="row">첨부파일</th>
							<td colspan="3" id="tdAttachment" class="addD2"></td>
						</tr>
						<tr>
							<th scope="row">등록자 ID</th>
							<td>${info.reg_id}</td>
							<th scope="row">등록일시</th>
							<td>${info.reg_dt}</td>
						</tr>
					</tbody>
				</table>
			</div>
			</fieldset>
		</form>

	</div>


</div>

<form id="dForm" name="dForm">
	<input type="hidden" name="filename_txt" id="filename_txt" value="" />
	<input type="hidden" name="attachfile_txt" id="attachfile_txt" value="" />
</form>

<div id="toast"></div></body>
</html>