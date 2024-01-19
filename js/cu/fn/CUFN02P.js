/**
 * 무역송금 게시판
 */
$(document).ready(function() {	
	$.fn.getUrlParameter = function (sParam) {
        var sPageURL = decodeURIComponent(window.location.search.substring(1)),
                sURLVariables = sPageURL.split('&'),
                sParameterName,
                i;

        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].split('=');

            if (sParameterName[0] === sParam) {
                return sParameterName[1] === undefined ? true : sParameterName[1];
            }
        }
    };
    
    console.log($('#step').val() + "order_by : "+ $('#order_by').val());
    var type = $.fn.getUrlParameter('mode');
    let url = '/cu/fn/CUFN02/insert';
    if(type == 'amend'){
    	$('#btnSave').hide();
    	//$('input').prop('disabled', true);
    	url = '/cu/fn/CUFN02/update';
    }else{
    	url = '/cu/fn/CUFN02/insert';
    	$('#btnEdit').hide();
		$('#btnReply').hide();    	
    }
    
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "editorArea",
	    sSkinURI: "/common/smarteditor/SmartEditor2Skin.html",
	    fCreator: "createSEditor2"
	});

	//수정버튼 클릭시 
	$("#btnEdit").click(function(){
		$('#btnEdit').hide();
		$('#btnReply').hide();
		$('#btnSave').show();
		url = '/cu/fn/CUFN02/update'; //답글 
	});
	
	//답글버튼 클릭시 
	$("#btnReply").click(function(){
		$('#btnEdit').hide();		
		$('#btnSave').show();			
		url = '/cu/fn/CUFN02/reply'; //답글 
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
	 
	$("#gForm").validate({
		debug : true,
		rules : {
			title_txt:{required:true, maxlength:100},
			sort_seq:{required:true, number:true, max:32767}
		}, 		
		messages: {
			title_txt:{
				required:"제목을 입력 하세요",
				maxlength:jQuery.format("제목은 최대 {0} 글자 이하로 입력하세요.")
			},
			content_txt:{
				required:"내용을 입력 하세요",				
			}
		},
		onfocusout:false,
		invalidHandler: function(form, validator) {
			showValidationError(form, validator);               
        },
		errorPlacement: function(error, element) {},
		submitHandler: function(form) {	
			//e.preventDefault();
			oEditors.getById["editorArea"].exec("UPDATE_CONTENTS_FIELD",[]);  // 에디터 내용을 폼데이터로 등록
			// turnOffSaveButtonf
			$('#btnSave').off('click');
			var iframeId = 'unique' + (new Date().getTime());  //generate a random id
			var iframe = $('<iframe src="javascript:false;" name="'+iframeId+'"/>');  //create an empty iframe
			iframe.hide();  //hide it
			$('#gForm').attr('target',iframeId);  //set form target to iframe			
			
			iframe.appendTo('body');  //Add iframe to body
			form.action = url;
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
						$("#gForm").submit();
					});
				}
				else {
					$('#btnSave').click(function() {
						$("#gForm").submit();
					});
					ajaxError();
				}
	        });
			 
		}
	});
});
 
function fn_f10(){	 
	$("#gForm").submit();
}