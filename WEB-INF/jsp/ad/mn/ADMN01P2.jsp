<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<%@include file="/common/include/header.jsp"%>
	<title>매뉴얼 수정</title>
	<script type="text/javascript">
	
	var oEditors = [];	//smarteditor		
	var startPortFlag = 1;
	
		$(document).ready(function() {
			
			nhn.husky.EZCreator.createInIFrame({
			    oAppRef: oEditors,
			    elPlaceHolder: "editorArea",
			    sSkinURI: "/common/smarteditor/SmartEditor2Skin.html",
			    fCreator: "createSEditor2"
			});			
			
			//첨부파일
			var attachList =  new Array();
			var $aFile
			var $pFileWrapper
			<c:forEach items="${attachList}" var="item1">
				attachList.push("${item1.filename_txt}");
				attachList.push("${item1.attachfile_txt}");
				$aFile = $("<a>", {id: "fileDownload", href: "${fileDownloadPath}/" + "${item1.attachfile_txt}",	target: "_self"}).css({"text-decoration": "underline",	cursor: "pointer"}).text("${item1.filename_txt}");
				$aDelBtn = '  <input type="button" class="btn btn-close btn-xs" onclick="fn_delFile(${item1.att_seq});" value="삭제">';
				$pFileWrapper = $("<p>").css("margin-bottom", "2px").append($aFile).append($aDelBtn);
				$("#tdAttachment").prepend($pFileWrapper);		
			</c:forEach>
			
			// file validation
			$('#inptFile').fileupload({
				replaceFileInput: false,
		        add: function (e, data) {
		        	var uploadValid = true
		            $(data.files).each(function (index, file) {
						if (!(/(\.ppt|\.pptx|\.xls|\.xlsx|\.doc|\.docx\.hwp|\.jpg|\.jpeg|\.gif|\.png|\.bmp|\.tif)$/i)
								.test(file.name)) {
							toast('업로드 가능한 파일 확장자가 아닙니다 (PPT, XLS, DOC, HWP, JPG, GIF, PNG, BMP, TIF)');
			                uploadValid = false;
						} else if (file.size > (5 * 1024 * 1024)) { // 5mb
							toast('파일 용량은 5Mb를 초과할 수 없습니다.');
							uploadValid = false;
		 	            }
		            });
		            
		            if(! uploadValid) {
		            	if (/MSIE/.test(window.navigator.userAgent)) {
		            		$('#inptFile').replaceWith($('#inptFile').clone(true));
		            	} else
		            		$('#inptFile').val('');
		            	$('.file_1').val('');
		            }
		        }
		    });
			
			// jQuery validation
			$("#submitForm").validate({
				rules: {
					notice_typ: { required: true },
					title_txt: { required: true, maxlength: 100 },
					start_dt1: { required: true, dpDate: true },
					start_dt2: { validTime: true },
					end_dt1: { required: true, dpDate: true, dpCompareDate:{ notBefore: '#start_dt1' } },
					end_dt2: { validTime: true },
					imp_yn: { required: true },
					use_yn: { required: true },
					disp_seq: { required: true, number: true },
					noti_area_typ: { required: true }
				},
				messages: {
					title_txt: { required: "제목을 입력하세요", maxlength: jQuery.format("제목은 최대 {0} 글자 이하로 입력하세요." ) }
				},
				onfocusout:false,
				invalidHandler: function(form, validator) {
					showValidationError(form, validator);  
				},
				errorPlacement: function(error, element) {},
				submitHandler: function(form) {

					$('#btnSave').off('click');
					
					var iframeId = 'unique' + (new Date().getTime());  //generate a random id
					var iframe = $('<iframe src="javascript:false;" name="'+iframeId+'"/>');  //create an empty iframe
					iframe.hide();  //hide it
					$('#submitForm').attr('target',iframeId);  //set form target to iframe			
					
					iframe.appendTo('body');  //Add iframe to body
					form.action = '/ad/mn/ADMN01/updateManual';
					form.method = 'post';
					form.submit();
					
					iframe.load(function(e) {
						
			            var doc = getDoc(iframe[0]);
			            var docRoot = doc.body ? doc.body : doc.documentElement;
			            var data = docRoot.innerHTML;
			            //data is returned from server.
			            $(window.opener.document).find("#btnSearch").trigger("click");
			            
						if (data == "0") {
							toast("수정하였습니다.");
							self.close();
						}else if (data == "-1") {
							toast("등록하신 첨부파일은 업로드 가능한 파일 확장자가 아닙니다");
							$('#btnSave').click(function() {
								$("#submitForm").submit();
							});
						}
						else {
							$('#btnSave').click(function() {
								$("#submitForm").submit();
							});
							ajaxError();
						}
			        });
				}
			});

		});
		
		//저장
		function fn_f10(){
			oEditors.getById["editorArea"].exec("UPDATE_CONTENTS_FIELD",[]);  // 에디터 내용을 폼데이터로 등록
			$("#submitForm").submit();
		}
	
		function fn_delFile(att_seq){
			
			$("#att_seq").val(att_seq);
			
			$.ajax({
				type: "POST",
				url: "/ad/mn/ADMN01/deleteManualAttach",
				data: $("#submitForm").serialize(),
				dataType: 'json',
				contentType: 'application/x-www-form-urlencoded; charset=utf-8',
				success: function(data) {
					if(data.code != '0') {
						toast(data.msg);
						location.reload();
					}	
				},
				error: function(jqXHR, textStatus, errorThrown) {
					toast( textStatus.msg);						
				}
			});

		}
		
	</script>
</head>

<body class="sky">

<div class="layerpop_inner" id="#">

	<h1 class="ly_header">매뉴얼 수정</h1>
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
			<input type="hidden" name="manual_no" value="${info.manual_no}"/>
			<input type="hidden" id="attachfile_txt" name="attachfile_txt" value="${info.attachfile_txt}"/>
			<input type="hidden" id="att_seq" name="att_seq" value=""/>
			
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
					<c:choose>
						<c:when test="${not empty attachList}">
						<tr>
							<th scope="row" rowspan="4">첨부파일4</th>
							<td colspan="3" id="tdAttachment" class="addD2"></td>
						</tr>
						<tr>
							<td colspan="3" class="addD2">
								<input type="file" class="file_1" id="inptFile0" name="attachFile0" title="파일첨부" style="width: 40%"/>
							</td>
						</tr>
						</c:when>
						<c:otherwise>
						<tr>
							<th scope="row" rowspan="3">첨부파일3</th>
							<td colspan="3" class="addD2">
								<input type="file" class="file_1" id="inptFile0" name="attachFile0" title="파일첨부" style="width: 40%"/>
							</td>
						</tr>
						</c:otherwise>
					</c:choose>						

						<tr>
							<td colspan="3" class="addD2">
								<input type="file" class="file_1" id="inptFile1" name="attachFile1" title="파일첨부" style="width: 40%"/>
							</td>
						</tr>
						<tr>
							<td colspan="3" class="addD2">
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