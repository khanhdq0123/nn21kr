<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<%@include file="/common/include/header.jsp"%>
<script type="text/javascript">
//smarteditor
var oEditors = [];

	$(document).ready(function() {
		//grid
		

		
		jQuery("#vendorList").jqGrid({
			datatype : "local",
			colNames : [ '(소속)업체명','vendor_no'],
			colModel:[
	            { name: 'vendor_nm', index: 'vendor_nm', align: 'left', width:200, sortable: false },
	            { name: 'vendor_no', index: 'vendor_no', align: 'center', width:100, sortable: false,hidden:true }
			],
			autowidth: true,
			height: 120,
			multiselect: true
// 			shrinkToFit: false
		});


		nhn.husky.EZCreator.createInIFrame({
		    oAppRef: oEditors,
		    elPlaceHolder: "editorArea",
		    sSkinURI: "/common/smarteditor/SmartEditor2Skin.html",
		    fCreator: "createSEditor2"
		});

		$("#btn_VendorAdd").on("click", function(){
			
			CenterOpenWindow('/notice/selectVendorPop', '수신업체 선택', '500','473', 'scrollbars=no, status=yes');
			
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
				var returnValue = getGridDataToString('vendorList', 'all');
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
				form.action = '/notice/insertAdmNoticeDetail';
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
			$("#tdAttachment").prepend($pFileWrapper);
			
			// 삭제 이벤트
			$($btnFileDel).click(function(event) {
				setDetach();
			});
			
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
		

	});
	
	// 그리드에 업체 정보 추가
	function setVendorListData(dataList) {
		var addFlag = true;
		for (var loop = 0; loop < dataList.length; loop++) {
			var selRows = $("#vendorList").getDataIDs();
			for (var loop2 = 0; loop2 < selRows.length; loop2++) {
				if (dataList[loop].vendor_no == $("#vendorList").getRowData(selRows[loop2])['vendor_no']) {
					addFlag = false;
					break;
				}
			}
			if (! addFlag)
				break;
		}
		
		if (! addFlag) {
			toast("동일한 업체가 존재합니다.");
			return;
		}
		
		for (var loop = 0; loop < dataList.length; loop++) {
			var data = {
				vendor_no : dataList[loop].vendor_no,
				vendor_nm : dataList[loop].vendor_nm
			};
			$("#vendorList").addRowData(dataList[loop].vendor_no, data, "last");
			$("#vendorList").jqGrid("setSelection", dataList[loop].vendor_no);
		}
	}

	function fn_f10(){
		oEditors.getById["editorArea"].exec("UPDATE_CONTENTS_FIELD",[]);  // 에디터 내용을 폼데이터로 등록
		$("#submitForm").submit();
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
					<button type="button" class="sky" id="btnSave">저장</button>
					<button type="button" class="gray" id="btnClose">닫기</button>
				</div>
			</div>
		</div>
		<form action="#" id="submitForm" enctype="multipart/form-data">
			<fieldset>
			<legend>${mode == "new" ? "관리자 게시판 등록 페이지" : "관리자 게시판 상세 페이지"}</legend>
			<input type="hidden" name="mode" value="${mode}"/>
			<input type="hidden" name="doc_no" value="${info.doc_no}"/>
			<input type="hidden" id="hdnGridData1" name="vendorList" />
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

						<tr id="tr_gridArea" >
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>수신지사(업체)</th>
							<td colspan="3">
								<div class="min_btn" style="margin-bottom: 3pt; width: 100%; text-align: right;">
									
									<input type="button" class="btn btn-primary btn-sm" value="추가" id="btn_VendorAdd">
									
								</div>
								<div class="grid">
									<table id="vendorList"></table>
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