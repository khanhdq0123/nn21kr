<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<%@include file="/common/include/header.jsp"%>
<script type="text/javascript">

	$(document).ready(function() {

		
// 		$("#btnSave").click(function() {
			
// 			var inptFile = $("#inptFile").val();
			
// 			if(inptFile == ''){
// 				toast('업로드할 파일을 선택하세요.');
// 				return;
// 			}
// 			$("#submitForm").submit();
// 		});
		
		

		

		$("#btnCommentSave").click(function() {
			//comment save
			$.ajax({
				type: "POST",
				url: '/system/tms/insertTmsComment',
				data: $("#submitForm").serialize(),
				dataType: 'json',
				contentType: 'application/x-www-form-urlencoded; charset=utf-8',
				success: function(data) {
					if(data.code == '0') {
						toast(data.msg);
						location.reload();
					} else {
						toast(data.msg);
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					toast(jqXHR.status);						
				}
			});
			
		});
		
		$("#submitForm").validate({
			rules: {
// 				board_typ: { required: true },
// 				title_txt: { required: true, maxlength: 100 },
// 				start_dt1: { required: true, dpDate: true },
// 				start_dt2: { validTime: true },
// 				end_dt1: { required: true, dpDate: true, dpCompareDate:{ notBefore: '#start_dt1' } },
// 				end_dt2: { validTime: true },
// 				imp_yn: { required: true },
// 				use_yn: { required: true },
// 				disp_seq: { required: true, number: true },
// 				noti_area_typ: { required: true }
			},
			messages: {
// 				title_txt: { required: "제목을 입력하세요", maxlength: jQuery.format("제목은 최대 {0} 글자 이하로 입력하세요." ) }
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
				form.action = '/system/tms/insertTmsFile';
				form.method = 'post';
				form.submit();
				
				iframe.load(function(e) {
					
		            var doc = getDoc(iframe[0]);
		            var docRoot = doc.body ? doc.body : doc.documentElement;
		            var data = docRoot.innerHTML;
		            //data is returned from server.
		            $(window.opener.document).find("#btnSearch").trigger("click");
		            
					if (data == "0") {
						toast("등록하였습니다.");
						opener.location.reload();
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

		// 첨부파일이 있을 경우 관련 엘리먼트(이벤트) 추가
		<c:if test="${not empty attachFile.att_seq}">
			var warnMsgFlag = true;
			
			// 파일 삭제 시 설정할 flag값
			var $hdnDelFlag = $("<input>", {
				type: 'hidden',
				name: 'fileDelFlag',
				value: true
			});
		
			var $aFile = $("<a>", {
				id: "fileDownload",
				href: "${fileDownloadPath}/" + "${attachFile.attachfile_txt}", // fileDownloadPath 이미지 서버 변경해야 함
				target: "_self"
			}).css({
				"text-decoration": "underline",
				cursor: "pointer"
			}).text("${attachFile.filename_txt}");
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
			url: '/system/tms/deleteTmsComment',
			data: $("#submitForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code == '0') {
					toast(data.msg);
					location.reload();
				} else {
					toast(data.msg);
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	function fnDeleteFile(att_seq){

		$("#att_seq").val(att_seq);
		
		$.ajax({
			type: "POST",
			url: '/system/tms/deleteTmsAttach',
			data: $("#submitForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code == '0') {
					toast(data.msg);
					location.reload();
					opener.location.reload();
				} else {
					toast(data.msg);
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	
	
	
	function fn_f10(){
		var inptFile = $("#inptFile").val();
		if(inptFile == ''){
			toast('업로드할 파일을 선택하세요.');
			return;
		}
		$("#submitForm").submit();
	}
	
	
</script>

</head>
<body class="sky">
<div class="layerpop_inner" id="#">
	<h1 class="ly_header">프로그램현황 게시판 상세</h1>
	<!-- .ly_body -->
	<div class="ly_body">
		<div class="refer bullet6">

			<div class="refer_bt">

				<div class="min_btn mini">
					
					<input type="button" class="btn btn-close btn-xs" id="btnClose" value="닫기">
				</div>
			</div>
		</div>
		<form action="#" id="submitForm" enctype="multipart/form-data">
			<fieldset>
			<legend>${mode == "new" ? "관리자 게시판 등록 페이지" : "관리자 게시판 상세 페이지"}</legend>
			<input type="hidden" name="tms_no" id="tms_no" value="${tmsInfo.tms_no}"/>
			<input type="hidden" name="comment_seq" id="comment_seq" value="" />
			<input type="hidden" name="att_seq" id="att_seq" value="${attachFile.att_seq}" />
			<input type="hidden" name="attachfile_txt" id="attachfile_txt" value="${attachFile.attachfile_txt}" />

			
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>${mode == "new" ? "관리자 게시판 등록 페이지" : "관리자 게시판 상세 페이지"}</caption>
					<colgroup>
						<col width="15%"/>
						<col width="35%"/>
						<col width="35%"/>
						<col width="15%"/>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">메뉴</th>
							<td colspan="3">${tmsInfo.part1} > ${tmsInfo.part2} > ${tmsInfo.title}</td>
						</tr>


						<tr>
							<th scope="row">기획서</th>
							<td colspan="3" id="tdAttachment" class="addD2">
							<c:if test="${empty attachFile.att_seq}">
								<input type="file" class="file_1" id="inptFile" name="attachFile" title="파일첨부" style="width: 40%"/>
								<input type="button" class="btn btn-primary btn-xs" id="btnSave" value="기획서업로드">
							</c:if>
							<c:if test="${not empty attachFile.att_seq}">
								<input type="button" class="btn btn-close btn-xs" onclick="fnDeleteFile(${attachFile.att_seq});" value="삭제">
							</c:if>
							</td>
						</tr>


<!-- 						<tr> -->
<!-- 							<th scope="row">등록자 ID</th> -->
<%-- 							<td>${tmsInfo.reg_id}</td> --%>
<!-- 							<th scope="row">등록일시</th> -->
<%-- 							<td>${tmsInfo.reg_dt}</td> --%>
<!-- 						</tr> -->
<!-- 						<tr class="division"> -->
<!-- 							<th scope="row">수정자 ID</th> -->
<%-- 							<td>${tmsInfo.mod_id}</td> --%>
<!-- 							<th scope="row">수정일시</th> -->
<%-- 							<td>${tmsInfo.mod_dt}</td> --%>
<!-- 						</tr> -->
						
						<tr>
							<td colspan="3" id="" class="addD2"><textarea name="comment_txt" id="comment_txt" rows="5" style="width: 99%;"></textarea></td>
							<td scope="row"><input type="button" class="btn btn-primary btn-xs" id="btnCommentSave" value="메모저장" style="width:100%; height:92px;" ></td>
						</tr>

					</tbody>
				</table>
				
				<table cellspacing="0" cellpadding="0" class="layer_tbl mt20">
					<colgroup>
						<col width="60%"/>
						<col width="15%"/>
						<col width="15%"/>
						<col width="10%"/>
					</colgroup>
					<tbody>
						<tr>
							<th class="ac">comment</th>
							<th>등록인</th>
							<th>등록일시</th>
							<th>삭제</th>
						</tr>
						
						<c:forEach var="list" items="${tmsCommentList}">
						<tr>
							<td style="white-space:pre;">${list.comment_txt}</td>
							<td>${list.reg_id}</td>
							<td>${list.reg_dt}	</td>
							<td><input type="button" class="btn btn-close btn-xs" onclick="fnDeleteComment(${list.comment_seq});" value="삭제"></td>
						</tr>
						</c:forEach>
						

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