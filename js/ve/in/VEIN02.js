
var submitUrl = "/common/updateStaffInfo";
var vendor_no;
	$(document).ready(function() {
	
		vendor_no = $("#vendor_no").val();
	
		$("#partnerForm").validate({
		debug : true,
		rules : {
			vendor_nm:{
				required: true
			},
			vendor_nm_eng:{
				required: true
			},
			charge_tel_txt:{
				dashNum: true
			},
			charge_mobil_txt:{
				dashNum: true
			}, 
			charge_email_txt:{
				email: true
			}
			,staff_enm1:{required: true}
			,mobile_txt1:{required: true}
			,staff_nm1:{required: true}
			,email_txt1:{required: true}
			,login_id1:{required: true}
		},
		messages: {
			vendor_nm:{
				required: "상호명을 입력하세요"
			},
			vendor_enm:{
				required: "상호명(영문)을 입력하세요"
			},
			charge_tel_txt:{
				dashNum: "전화번호는 숫자 및 '-' 만 입력가능합니다"
			},
			charge_mobil_txt:{
				dashNum: "휴대폰은 숫자 및 '-' 만 입력가능합니다"
			},
			charge_email_txt:{
				email: "Email을 정확하게 입력해주세요"
			}

		},
		onfocusout:false,
		invalidHandler: function(form, validator) {
			showValidationError(form, validator);
			//setInputDisabled(false);	<!-- 2014.04.14 지사 상세 저장 관련 주석 -->	
        },
		errorPlacement: function(error, element) {},
		submitHandler: function(form) {

			$.ajax({
				type: "POST",
				url: submitUrl,
				data: $(form).serialize(),
				dataType: 'json',
				contentType: 'application/x-www-form-urlencoded; charset=utf-8',
				success: function(data) {
					if(data.code == '0') {
						toast(data.msg);	
					} else {
						toast(data.msg);
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					toast(jqXHR.status);						
				}
			});
			
		}
	});
	
	
	});	
	
	
	
	function fn_f10(){
		$('#partnerForm').submit();		
	}
	
	var fnAddSns = function(staff_id){
		CenterOpenWindow('/system/staff/staffSnsPop?type=add&staff_typ=3&vendor_no='+vendor_no+'&staff_id='+staff_id, 'SNS등록', '800','260', 'scrollbars=no, status=yes');
	}	


	var fnDelSns = function(staff_sns_seq){
		
		$("#staff_sns_seq").val(staff_sns_seq);
		
		$.ajax({
			type: "POST",
			url: "/system/staff/deleteStaffSns",
			data: $("#partnerForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code == '0') {
					toast(data.msg);
					location.reload();
					//window.opener.fnReload();
					//window.close();
				}	
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast( textStatus.msg);						
			}
		});
		
	}
		