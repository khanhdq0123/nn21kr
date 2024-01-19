		
var oEditors = [];	//smarteditor		
var startPortFlag = 1;
										
	$(document).ready(function() {
				
		
		nhn.husky.EZCreator.createInIFrame({
		    oAppRef: oEditors,
		    elPlaceHolder: "editorArea",
		    sSkinURI: "/common/smarteditor/SmartEditor2Skin.html",
		    fCreator: "createSEditor2"
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
				form.action = '/ad/mn/ADMN01/saveManual';
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

		
	});

	//저장
	function fn_f10(){
		oEditors.getById["editorArea"].exec("UPDATE_CONTENTS_FIELD",[]);  // 에디터 내용을 폼데이터로 등록
		$("#submitForm").submit();
	}
		
		
		
		