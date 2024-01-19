<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<%@include file="/common/include/header.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		//grid
		jQuery("#vendorList").jqGrid({
			datatype : "local",
		   	colNames : [ '업체 코드', '업체명' ],
			colModel : [
	            { name: 'vendor_no', index: 'vendor_no', align: 'center', sortable: false },
	            { name: 'vendor_nm', index: 'vendor_nm', align: 'center', sortable: false }
			],
			autowidth: true,
			height: 120,
			multiselect: true
// 			shrinkToFit: false
		});
		
		// grid on/off
		$('#noticeArea1, #noticeArea2').change(function() {
			if (this.value == 1) {
				$('#tr_gridArea').hide();
			} else {
				$('#tr_gridArea').show();
			}
			
			resizeApp();
		});
		<c:if test="${not empty info.noti_area_typ}">
			if ('${info.noti_area_typ}' == 1) 
				$('#noticeArea1').click();
			else
				$('#noticeArea2').click();
		</c:if>
		
		//공지업체지정 enable/disable
		checkNoticeType();
		$('input:radio[name="notice_typ"]').change(function() {
			checkNoticeType();
		});
		
		// 중요여부 체크 시
		$('[name="imp_yn"]').change(function() {
		    if ($(this).val() == 'y') {
		        $('#disp_seq').val('0').prop('readonly', true).css('background-color', 'whitesmoke');
		    } else {
		        $('#disp_seq').prop('readonly', false).css('background-color', '');
		    }
		});
		<c:if test="${not empty info.imp_yn}">
			if ('${info.imp_yn}' == 'y') 
				$('[name="imp_yn"][value="y"]').click();
			else
				$('[name="imp_yn"][value="n"]').click();
		</c:if>
		
		//smarteditor
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
		    oAppRef: oEditors,
		    elPlaceHolder: "editorArea",
		    sSkinURI: "/common/smarteditor/SmartEditor2Skin.html",
		    fCreator: "createSEditor2"
		});
				
		//insert or update
		$('#btnSave').click(function() {
			oEditors.getById["editorArea"].exec("UPDATE_CONTENTS_FIELD",[]);  // 에디터 내용을 폼데이터로 등록
			$("#submitForm").submit();
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
	
		// ":" 자동입력 (삭제함)
		//$("#start_dt2, #end_dt2").on({
			//keydown: function(event) {
				//if (event.keyCode == 59 || event.keyCode == 186) {
					//return false;
				//}
			//}, keyup: function(event) {
				//var value = $(this).val();
				//if (value.length == 2) {
					//$(this).val(value + ":");
				//}
			//}
		//});
		
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
				notice_typ: { required: "시스템구분을 선택하세요." },
				title_txt: { required: "제목을 입력하세요", maxlength: jQuery.format("제목은 최대 {0} 글자 이하로 입력하세요." ) },
				start_dt1: {
					required: "게시 시작일을 입력하세요.",
					dpDate: '게시 시작일은 yyyy-mm-dd 형식으로 입력하세요.'
				},
				start_dt2: {
					validTime: "게시 시작 시간은 00:00 ~ 23:59 사이로 입력하세요."
				},
				end_dt1: {
					required: "게시 종료일을 입력하세요.",
					dpDate: '게시 종료일은 yyyy-mm-dd 형식으로 입력하세요.',
					dpCompareDate: '게시 종료일은 시작일보다 같거나 이후 일자를 선택하세요.'
				},
				end_dt2: {
					validTime: "게시 종료 시간은 00:00 ~ 23:59 사이로 입력하세요."
				},
				imp_yn: { required: "중요 여부를 선택하세요." },
				use_yn: { required: "게시 여부를 선택하세요." },
				disp_seq: { required: "전시 순서를 선택하세요.", number: "전시 순서는 숫자만 가능합니다." },
				noti_area_typ: { required: "공지 범위를 선택하세요." }
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);  
			},
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {
				
				// 게시 시간 validation
				var stime = $('#start_dt2').val().replace(/:/g, '');
				var etime = $('#end_dt2').val().replace(/:/g, '');
				
				if(stime.length == 3){
					stime = "0"+stime
				}
				
				if(stime > etime){
					toast("게시 시작 시간이 종료 시간보다 큽니다. 게시 시간을 변경해 주세요.");
					return false;
				}
				
				// 공지범위값 체크 후 그리드값을 폼으로
				var returnValue = getGridDataToString('vendorList', 'all');
				if ($('#noticeArea2').is(':checked') && returnValue == '[]') {
					toast("공지사항 범위가 지정업체일 경우 업체를 추가해야합니다.");
					return false;
				}
				$("#hdnGridData1").val(returnValue);
				
				// turnOffSaveButton
				$('#btnSave').off('click');
				
				var iframeId = 'unique' + (new Date().getTime());  //generate a random id
				var iframe = $('<iframe src="javascript:false;" name="'+iframeId+'"/>');  //create an empty iframe
				iframe.hide();  //hide it
				$('#submitForm').attr('target',iframeId);  //set form target to iframe			
				
				iframe.appendTo('body');  //Add iframe to body
				form.action = '/board/notice/adminNoticeDetailAjax.do';
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
			
		// 업체정보가 있을 경우 그리드에 추가
		<c:if test="${not empty vendorList}">
			var vendorList = ${vendorList};
			for (var loop = 0; loop <= vendorList.length; loop++)
				$("#vendorList").jqGrid('addRowData', loop+1, vendorList[loop]);		
		</c:if>
		
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
		
		// 게시시간에 숫자와 : 만 입력 받게 
		//$(document).on("keyup", "input:text[datetime]",
			//function() {
				//$(this).val( $(this).val().replace(/[^0-9:]/gi,"") );
			//}
		//);
	});
	
	function checkNoticeType() {
		var type = $("input:radio[name='notice_typ']:checked");
		if (type.val() == 0 || type.val() == 1) { // 전체 or admin
			$("#noticeArea1").click();
			$("#noticeArea2").attr("disabled", true);
		} else if (type.val() == 2) { // 공급업체
			$("#noticeArea2").attr("disabled", false);
		}
	}
	
	// 그리드에 업체 정보 추가
	function setVendorData(dataList) {
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
	
	function fn_f3(){
		$("#searchForm").submit();
	}
</script>

</head>
<body class="sky">
<div class="layerpop_inner" id="#">
	<h1 class="ly_header">${mode == "new" ? "관리자 게시판 등록 페이지" : "관리자 게시판 상세 페이지"}</h1>
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
			<input type="text" name="noticebbs_no" value="${info.noticebbs_no}"/>
			<input type="hidden" id="hdnGridData1" name="vendor" />
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
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>시스템구분</th>
							<td colspan="3"><input type="radio" name="notice_typ" value="0" id="a1" ${info.notice_typ == "0" ? "checked='checked'" : "" }/>
								<label class="int_space" for="a1">전체</label>
								<input type="radio" name="notice_typ" value="1" id="a2" ${info.notice_typ == "1" ? "checked='checked'" : "" }/>
								<label class="int_space" for="a2">내부관리자</label>
								<input type="radio" name="notice_typ" value="2" id="a3" ${info.notice_typ == "2" ? "checked='checked'" : "" }/>
								<label class="int_space" for="a3">지사</label>
								<input type="radio" name="notice_typ" value="3" id="a4" ${info.notice_typ == "3" ? "checked='checked'" : "" }/>
								<label class="int_space" for="a4">고객사</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>제목</th>
							<td colspan="3"><input type="text" class="iptSize" name="title_txt" value="${info.title_txt}" style="width: 99%;" maxlength="200" /></td>
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>내용</th>
							<td colspan="3">
							<textarea name="content_txt" id="editorArea" rows="20" style="width: 96%;">${info.content_txt}</textarea>
							</td>
						</tr>
						<tr>
							<th scope="row">첨부파일</th>
							<td colspan="3" id="tdAttachment" class="addD2">
								<input type="file" class="file_1" id="inptFile" name="attachFile" title="파일첨부" style="width: 40%"/>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>게시기간<br/>(시작~종료일시)</th>
							<td colspan="3" class="pickerAlign">
								<span class="calendar">
									<input type="text" maxlength="10" class="datepicker2" id="start_dt1" name="start_dt1" value="${info.start_dt1}"/>
								</span>
								<input type="text" id="start_dt2" name="start_dt2" maxlength="5" value="${info.start_dt2}" datetime="true" />
								<span class="space">~</span> 
								<span class="calendar">
									<input type="text" maxlength="10" class="datepicker2" id="end_dt1" name="end_dt1" value="${info.end_dt1}"/>
								</span>
								<input type="text" id="end_dt2" name="end_dt2" maxlength="5" value="${info.end_dt2}" datetime="true" />
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>중요 여부</th>
							<td colspan="3">
								<input type="radio" name="imp_yn" id="a4" value="y"/>
								<label class="int_space" for="a4">Y</label>
								<input type="radio" name="imp_yn" id="a5" value="n"/>
								<label class="int_space" for="a5">N</label></td>
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>팝업 여부</th>
							<td colspan="3">
								<input type="radio" name="pop_yn" id="a6" value="y" ${info.pop_yn == "y" ? "checked='checked'" : ""}/>
								<label class="int_space" for="a6">Y</label>
								<input type="radio" name="pop_yn" id="a7" value="n" ${info.pop_yn == "n" ? "checked='checked'" : ""}/>
								<label class="int_space" for="a7">N</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>게시 여부</th>
							<td colspan="3">
								<input type="radio" name="use_yn" id="a8" value="y" ${info.use_yn == "y" ? "checked='checked'" : ""}/>
								<label class="int_space" for="a8">게시</label>
								<input type="radio" name="use_yn" id="a9" value="n" ${info.use_yn == "n" ? "checked='checked'" : ""}/>
								<label class="int_space" for="a9">미게시</label></td>
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>전시 순서</th>
							<td colspan="3">
								<input type="text" id="disp_seq" name="disp_seq" value="${info.disp_seq}" style="width: 20%;" maxlength="5"/>
							</td>
						</tr>
						<tr id="tr_beforeGrid">
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>공지 범위</th>
							<td colspan="3">
								<input type="radio" name="noti_area_typ" id="noticeArea1" value="1"/>
								<label class="int_space" for="noticeArea1">전체</label>
								<input type="radio" name="noti_area_typ" id="noticeArea2" value="2" ${info.notice_typ == "1" ? "disabled='disabled'" : "" }/>
								<label class="int_space" for="noticeArea2">지정업체</label></td>
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