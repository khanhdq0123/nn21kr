<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="/common/include/header.jsp"%>
	<title>매뉴얼 등록</title>
	<script type="text/javascript" src="/js/ad/mn/ADMN01P.js"></script>
</head>
<body class="sky">

<div class="layerpop_inner" id="#">

	<h1 class="ly_header">매뉴얼 등록</h1>
	<!-- .ly_body -->
	<div class="ly_body">
		<div class="refer bullet6">
			<div class="refer_bt">
				<div class="min_btn mini">
					<input type="button" class="btn btn-primary btn-sm" value="저장[F10]" 	id="btnSave">
					<input type="button" class="btn btn-close btn-sm" 	value="닫기" 			id="btnClose">
				</div>
			</div>
		</div>

		
		<form action="#" id="submitForm" enctype="multipart/form-data">
			<fieldset>
			<legend>${mode == "new" ? "관리자 게시판 등록 페이지" : "관리자 게시판 상세 페이지"}</legend>
			<input type="hidden" name="mode" value="${mode}"/>
			<input type="hidden" name="doc_no" value="${info.doc_no}"/>
			<input type="hidden" id="hdnGridData1" name="staffs" />
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
							<td colspan="3"><input type="text" class="iptSize" name="title_txt" value="${info.title_txt}" style="width: 99%;" maxlength="200" /></td>
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>내용</th>
							<td colspan="3">
							<textarea name="content_txt" id="editorArea" rows="16" style="width: 96%;">${info.content_txt}</textarea>
							</td>
						</tr>

						<tr>
							<th scope="row" rowspan="3">첨부파일</th>
							<td colspan="3" id="tdAttachment" class="addD2">
								<input type="file" class="file_1" id="inptFile0" name="attachFile0" title="파일첨부" style="width: 40%"/>
							</td>
						</tr>
						<tr>
							<td colspan="3" id="tdAttachment" class="addD2">
								<input type="file" class="file_1" id="inptFile1" name="attachFile1" title="파일첨부" style="width: 40%"/>
							</td>
						</tr>
						<tr>
							<td colspan="3" id="tdAttachment" class="addD2">
								<input type="file" class="file_1" id="inptFile2" name="attachFile2" title="파일첨부" style="width: 40%"/>
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


</div>

<div id="toast"></div></body>
</html>