<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<%@include file="/common/include/header.jsp"%>
<style>
#tdAttachment input {display:block;}
</style>
<script type="text/javascript">
var oEditors = [];	//smarteditor

	$(document).ready(function() {
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
			height: 120,
			multiselect: true
// 			shrinkToFit: false
		});

		//smarteditor

		nhn.husky.EZCreator.createInIFrame({
		    oAppRef: oEditors,
		    elPlaceHolder: "editorArea",
		    sSkinURI: "/common/smarteditor/SmartEditor2Skin.html",
		    fCreator: "createSEditor2"
		});

		// 업체 추가
		$("#btn_vendorAdd").click(function() {
			openPop(1, 'isMultiSelect=Y');
		});
		
		// 업체 삭제
		$('#btn_vendorDel').click(function (){
			var selRows = $("#vendorList").getGridParam('selarrrow');
			if(selRows.length==0) {
				toast('삭제할 항목을 선택하세요.');
			}
			for(var i=selRows.length-1; i>=0; i--) {
				$('#vendorList').delRowData(selRows[i]);
			}
		});
		
		
	

		
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
		
		// jQuery validation new Method
		$.validator.addMethod("validTime", function(value, element) {
			if (!value) {
				value = "00:00"; 
				return true;
			}
		    return /^([0-9]|[0-1][0-9]|[2][0-3]):([0-5][0-9])$/.test(value);    
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
				
				// 공지범위값 체크 후 그리드값을 폼으로
				var returnValue = getGridDataToString('staffList', 'all');
// 				if ($('#noticeArea2').is(':checked') && returnValue == '[]') {
// 					toast("공지사항 범위가 지정업체일 경우 업체를 추가해야합니다.");
// 					return false;
// 				}
				$("#hdnGridData1").val(returnValue);
				
				// turnOffSaveButton
				$('#btnSave').off('click');
				
				var iframeId = 'unique' + (new Date().getTime());  //generate a random id
				var iframe = $('<iframe src="javascript:false;" name="'+iframeId+'"/>');  //create an empty iframe
				iframe.hide();  //hide it
				$('#submitForm').attr('target',iframeId);  //set form target to iframe			
				
				iframe.appendTo('body');  //Add iframe to body
				form.action = '/notice/insertNoticeDetail';
				form.method = 'post';
				form.submit();
				
				$('#btnSave').hide();
				
				iframe.load(function(e) {
					
		            var doc = getDoc(iframe[0]);
		            var docRoot = doc.body ? doc.body : doc.documentElement;
		            var data = docRoot.innerHTML;
		            //data is returned from server.
		            $(window.opener.document).find("#btnSearch").trigger("click");
		            
					if (data == "0") {
						toast("등록하였습니다.");
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
			//$("#tdAttachment").prepend($pFileWrapper);
			
			// 삭제 이벤트
			$($btnFileDel).click(function(event) {
				setDetach();
			});
			
			$("#inptFile").change(function() {
				if (warnMsgFlag) {
					if (confirm("글 저장 시 기존 파일은 삭제됩니다."))
						setDetach();					
					else {
						//$("#tdAttachment > input:text").val("");
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
		

	});
	
	//저장
	function fn_f10(){
		oEditors.getById["editorArea"].exec("UPDATE_CONTENTS_FIELD",[]);  // 에디터 내용을 폼데이터로 등록
		$("#submitForm").submit();
	}
	
	
	
	var fileSeq = 1;
	
	function fnFileAdd(){
		if(fileSeq > 9){
			toast('10개 까지만 등록이 가능합니다.');
			return false;
		}
		var _file = "<input type='file' class='mb4 file file_1' id='attachFile" + fileSeq + "' name='attachFile" + fileSeq + "'  />";
		$("#tdAttachment").append(_file);
		fileSeq++;
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
				<li>정보를 입력/선택 후 반드시 저장버튼을 클릭하셔야 정상 반영됩니다.</li>
			</ul>
			<div class="refer_bt">
				<span id="waitPlease" style="color: crimson; display: none;">저장 중입니다 잠시만 기다려 주세요</span>
				<div class="min_btn mini">					
					<input type="button" class="btn btn-primary btn-sm" value="저장[F10]" 	id="btnSave">
					<input type="button" class="btn btn-close 	btn-sm" value="닫기" 			id="btnClose">					
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
							<th scope="row" rowspan="3">첨부파일 <input type="button" class="btn btn-success btn-xs" value="+" id="btnAddFile" onclick="fnFileAdd();"></th>
							<td colspan="3" id="tdAttachment" class="addD2">
								<input type='file' class='mb4' id='attachFile0' name='attachFile0'  />
								
		
								
							</td>
						</tr>
						<tr id="tr_gridArea" style="display:none;">
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>공지 업체</th>
							<td colspan="3">
									<div class="min_btn" style="margin-bottom: 3pt; width: 100%; text-align: right;">
										<button type="button" class="sky" id="btn_vendorAdd" >추가</button>
										<button type="button" class="gray" id="btn_vendorDel">삭제</button>
									</div>
									<div class="grid" id="grid_ptnr" min="400">
										<table id="vendorList"></table>
									</div>
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