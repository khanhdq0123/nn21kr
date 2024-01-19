<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<%@include file="/common/include/header.jsp"%>
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
		

		

		
		//grid
		jQuery("#staffList").jqGrid({
			datatype : "local",
			colNames : [ '(소속)업체명', '이름', '직급','vendor_no','login_id'],
			colModel:[
	            { name: 'vendor_nm', index: 'vendor_no', align: 'center', width:200, sortable: false },
	            { name: 'job_nm', index: 'job_nm', align: 'center', width:100, sortable: false },
	            { name: 'staff_nm', index: 'vendor_nm', align: 'center', width:100, sortable: false },
	            { name: 'vendor_no', index: 'vendor_no', align: 'center', width:100, sortable: false,hidden:true },
	            { name: 'login_id', index: 'login_id', align: 'center', width:100, sortable: false,hidden:true },
			],
			autowidth: true,
			height: 120
// 			multiselect: true
// 			shrinkToFit: false
		});
		
	});
	
	var fnFileDownload = function(filename_txt,attachfile_txt){
		
		$("#filename_txt").val(filename_txt);
		$("#attachfile_txt").val(attachfile_txt);
		
		var fileDownloadPath = '${fileDownloadPath}';

		
		   var downloadLink = document.createElement("a");
	          downloadLink.href = fileDownloadPath + attachfile_txt;
	          downloadLink.download = filename_txt;

	          document.body.appendChild(downloadLink);
	          downloadLink.click();
	          document.body.removeChild(downloadLink);
		
		
// 		$.ajax({
// 			/* 요청 시작 부분 */
// 			url: "/document/docFileDownloadAjax?filename_txt=" + filename_txt + "&attachfile_txt=" + attachfile_txt, //주소
// 			data: { //전송 데이터
// // 				"filename_txt" : filename_txt,
// // 				"attachfile_txt" : attachfile_txt
// 			},
// 			type: "GET", //전송 타입
// 			async: true, //비동기 여부
// 			//dataType: "TEXT", //응답받을 데이터 타입 (XML,JSON,TEXT,HTML)
			
// 			/* 응답 확인 부분 */
// 			success: function(response) {
// 				console.log("[response] : " + response);
// 				console.log("");    				
// 			},
			    			
// 			/* 에러 확인 부분 */
// 			error: function(xhr) {
// 				console.log("[error] : " + xhr);
// 				console.log("");    				
// 			},
			    			
// 			/* 완료 확인 부분 */
// 			complete:function(data,textStatus) {
// 				console.log("[complete] : " + textStatus);
// 				console.log("");    				
// 			}
// 		});
		
		
// 		$.ajax({
// 			type: "POST",
// 			url: "/document/docFileDownloadAjax",
// 			data: $("#dForm").serialize(),
// 			dataType: 'json',
// 			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
// 			success: function(data) {

// 			},
// 			error: function(jqXHR, textStatus, errorThrown) {
// 				toast(jqXHR.status);						
// 			}
// 		});
	}

</script>

</head>
<body class="sky">
<div class="layerpop_inner" id="#">
	<h1 class="ly_header">공지사항</h1>
	<!-- .ly_body -->
	<div class="ly_body">
		<div class="refer bullet6">
			<ul class="type1">
<!-- 				<li>정보를 입력/선택 후 반드시 저장버튼을 클릭하셔야 정상 반영됩니다.</li> -->
			</ul>
			<div class="refer_bt">
				<span id="waitPlease" style="color: crimson; display: none;">저장 중입니다 잠시만 기다려 주세요</span>
				<div class="min_btn mini">
					<button type="button" class="gray" id="btnClose">닫기</button>
				</div>
			</div>
		</div>
		<form action="#" id="submitForm" enctype="multipart/form-data">
			<fieldset>
			<legend>${mode == "new" ? "관리자 게시판 등록 페이지" : "관리자 게시판 상세 페이지"}</legend>
			<input type="hidden" name="mode" value="${mode}"/>
			<input type="hidden" name="doc_no" value="${info.doc_no}"/>
			<input type="hidden" id="hdnGridData1" name="staffs" />
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
	<!-- // .ly_body -->

</div>

<form id="dForm" name="dForm">
	<input type="hidden" name="filename_txt" id="filename_txt" value="" />
	<input type="hidden" name="attachfile_txt" id="attachfile_txt" value="" />
</form>

<div id="toast"></div></body>
</html>