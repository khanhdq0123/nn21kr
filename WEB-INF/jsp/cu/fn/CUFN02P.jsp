<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
	<head>
		<%@include file="/common/include/header.jsp"%>
		<script type="text/javascript" src="/js/cu/fn/CUFN02P.js"></script>
		
		<title>무역송금게시판</title>
		<script type="text/javascript">
			//스크립트 를 작성			 
			// 첨부파일이 있을 경우 관련 엘리먼트(이벤트) 추가
			<c:if test="${not empty info.att_seq && mode == 'amend'}">
				var warnMsgFlag = true;
				
				// 파일 삭제 시 설정할 flag값
				var $hdnDelFlag = $("<input>", {
					type: 'hidden',
					name: 'fileDelFlag',
					value: true
				});
			
				var $aFile = $("<a>", {
					id: "fileDownload",
					href: "${fileDownloadPath}/" + "${info.attachfile_txt}", // fileDownloadPath 이미지 서버 변경해야 함
					target: "_blank"
				}).css({
					"text-decoration": "underline",
					cursor: "pointer"
				}).text("${info.filename_txt}");
				var $pFileWrapper = $("<p>").css("margin-bottom", "2px").append($aFile);
				var $btnFileDel = $("<button>", { type: "button" }).text("삭제").css("margin-left", "2px").appendTo($pFileWrapper);
				$("#tdAttachment").prepend($pFileWrapper);
				
				$("#inptFile").change(function() {
					if (warnMsgFlag) {
						if (confirm("글 저장 시 기존 파일은 삭제됩니다."))
							setDetach();					
						else {
							$("#tdAttachment > input:text").val("");
							$("#inptFile").val("");
						}
					} else {
						setDetach()		
					}
				});
				
				function setDetach() {
					$pFileWrapper.hide();
					warnMsgFlag = false;
					$("#gForm").append($hdnDelFlag);
				}
			</c:if>
		</script>
	<style>
		.st_port_wrap input {background-color:#eee;}
		.ar_port_wrap input {background-color:#eee;}
	</style>
	</head>
    <body class="sky">
	<div class="layerpop_inner" id="#">
		<h1 class="ly_header">무역송금 등록</h1>
		<!-- .ly_body -->
		<div class="ly_body">
			<div class="refer bullet6">
				<ul class="type1">
					<li>정보를 입력/선택 후 반드시 저장버튼을 클릭하셔야 정상 반영됩니다.</li>
				</ul>
				<div class="refer_bt">
					<span id="waitPlease" style="color: crimson; display: none;">저장 중입니다 잠시만 기다려 주세요</span>
					<div class="min_btn mini">
					     <button type="button" class="sky" id="btnEdit">수정</button>
					     <button type="button" class="sky" id="btnReply">답글</button>
						 <button type="button" class="sky" id="btnSave">저장</button>
						 <button type="button" class="gray" id="btnClose">닫기</button>
					</div>
				</div>
			</div>
			<form action="#" id="gForm"  enctype="multipart/form-data">
				<input type="hidden" id="family" name="family" value="${info.family}" />
				<input type="hidden" id="order_by" name="order_by" value="${info.order_by}" />
				<input type="hidden" id="step" name="step" value="${info.step}" />
		
				<fieldset>
				<legend>${mode == "new" ? "관리자 게시판 등록 페이지" : "관리자 게시판 상세 페이지"}</legend>
				<input type="hidden" name="mode" value="${mode}"/>
				<input type="hidden" name="no" value="${info.no}"/>				
				<input type="hidden" id="attachfile_txt" name="attachfile_txt" value="${info.attachfile_txt}"/>
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
								<td colspan="3"><input type="text" class="iptSize" name="title_txt" id="title_txt" value="${info.title}" style="width: 99%;" maxlength="200" /></td>
							</tr>
							<tr>
								<th scope="row"><span class="starMark">필수입력 항목입니다.</span>내용</th>
								<td colspan="3">
								<textarea name="content_txt" id="editorArea" rows="16" style="width: 96%;">${info.content}</textarea>
								</td>
							</tr>
							<tr>
								<th scope="row">첨부파일</th>
								<td colspan="3" id="tdAttachment" class="addD2">
									<input type="file" class="file_1" id="inptFile" name="attachFile" title="파일첨부" style="width: 40%"/>
								</td>
							</tr>							
							<c:if test="${mode == 'amend'}">
								<tr>
									<th scope="row">등록자 ID</th>
									<td>${info.regstaff_id}</td>
									<th scope="row">등록일시</th>
									<td>${info.reg_dt}</td>
								</tr>
								<tr class="division">
									<th scope="row">수정자 ID</th>
									<td>${info.modstaff_id}</td>
									<th scope="row">수정일시</th>
									<td>${info.mod_dt}</td>
							</tr>
							</c:if>
	

	
						</tbody>
					</table>
				</div>
			</fieldset>
		</form>
		</div>
		<!-- // .ly_body -->	
	</div>

<div id="toast"></div></body>
</html>