<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<%@include file="/common/include/header.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		//grid
		jQuery("#commentList").jqGrid({
			url:'/system/board/boardCommentListJson',
			datatype : "local",
		   	colNames : [ 'comment', '등록인', '등록일시', '삭제'],
			colModel : [
	            { name: 'comment_txt', index: 'comment_txt', align: 'left', sortable: false, width:'300' },
	            { name: 'reg_id', index: 'reg_id', align: 'center', sortable: false, width:'80' },
	            { name: 'reg_dt', index: 'reg_dt', align: 'center', sortable: false, width:'80' },
	            { name: 'comment_seq', index: 'comment_seq', align: 'center', sortable: false, width:'50', formatter:codeLinkFormatter }
			],
			autowidth: true,
			height: 120,
			rowNum: 500
// 			multiselect: true
// 			shrinkToFit: false
		});

		$("#commentList").setGridParam({
			datatype: "json",
			page : 1,
			postData : serializeObject($('#submitForm'))
		}).trigger("reloadGrid");
		
		$("#btnCommentSave").click(function() {
			//comment save
			$.ajax({
				type: "POST",
				url: '/system/board/insertSysBoardComment',
				data: $("#submitForm").serialize(),
				dataType: 'json',
				contentType: 'application/x-www-form-urlencoded; charset=utf-8',
				success: function(data) {
					if(data.code == '0') {
						toast(data.msg);
						$("#commentList").setGridParam({
							datatype: "json",
							page : 1,
							postData : serializeObject($('#submitForm'))
						}).trigger("reloadGrid");
					} else {
						toast(data.msg);
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					toast(jqXHR.status);						
				}
			});
			
		});
		


		// 첨부파일이 있을 경우 관련 엘리먼트(이벤트) 추가
		<c:if test="${not empty info.att_seq}">
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
			//var $btnFileDel = $("<button>", { type: "button" }).text("삭제").css("margin-left", "2px").appendTo($pFileWrapper);
			$("#tdAttachment").prepend($pFileWrapper);
			
			// 삭제 이벤트
// 			$($btnFileDel).click(function(event) {
// 				setDetach();
// 			});
			
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
				$("#submitForm").append($hdnDelFlag);
			}
		</c:if>
		
		// 게시시간에 숫자와 : 만 입력 받게 
		//$(document).on("keyup", "input:text[datetime]",
			//function() {
				//$(this).val( $(this).val().replace(/[^0-9:]/gi,"") );
			//}
		//);
	});
	

	function codeLinkFormatter(cellVal, options, rowObj) {
		
		var cellval = String(cellVal);
		
		cellval = '<a href="javascript:fnDeleteComment(\'' + rowObj['comment_seq'] + '\');" cellVal="'+ rowObj['comment_seq'] +'">삭제</a>';										
		
		return  cellval === "" ? $.fn.fmatter.defaultFormat(cellval,options) : cellval;
	}
	
	
	function fnDeleteComment(comment_seq){
		
		$("#comment_seq").val(comment_seq);
		
		$.ajax({
			type: "POST",
			url: '/system/board/deleteSysBoardComment',
			data: $("#submitForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code == '0') {
					toast(data.msg);
					$("#commentList").setGridParam({
						datatype: "json",
						page : 1,
						postData : serializeObject($('#submitForm'))
					}).trigger("reloadGrid");
				} else {
					toast(data.msg);
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	
	
	
</script>

</head>
<body class="sky">
<div class="layerpop_inner" id="#">
	<h1 class="ly_header">${mode == "new" ? "관리자 게시판 등록 페이지" : "관리자 게시판 상세 페이지"}</h1>
	<!-- .ly_body -->
	<div class="ly_body">
		<div class="refer bullet6">

			<div class="refer_bt">

				<div class="min_btn mini">
					<button type="button" class="gray" id="btnClose">닫기</button>
				</div>
			</div>
		</div>
		<form action="#" id="submitForm">
			<fieldset>
			<legend>${mode == "new" ? "관리자 게시판 등록 페이지" : "관리자 게시판 상세 페이지"}</legend>
			<input type="hidden" name="board_no" id="board_no" value="${info.board_no}"/>
			<input type="hidden" name="comment_seq" id="comment_seq" value="" />
			
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
						<tr class="division">
							<th scope="row">수정자 ID</th>
							<td>${info.mod_id}</td>
							<th scope="row">수정일시</th>
							<td>${info.mod_dt}</td>
						</tr>
						
						<tr>
							<th scope="row">comment</th>
							<td colspan="3" id="" class="addD2">
								<input type="text" name="comment_txt" id="comment_txt" style="width: 86%;" />
								<button type="button" class="blue3" id="btnCommentSave">저장</button>
							</td>
						</tr>
						
						<tr>
							<td colspan="4" id="" class="addD2">
								<div class="grid" id="grid_ptnr" min="400">
									<table id="commentList"></table>
								</div>
							</td>
						</tr>

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