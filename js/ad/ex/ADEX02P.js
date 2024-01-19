/**
 * 환율 상세 정보
 */
$(document).ready(function() {

	
	$("#gForm").validate({
		debug : true,
		rules : {
			exch_cd:{required:true, maxlength:50},
			foreign_currency_cost:{required:true, number:true, max:32767}
		}, 		
		messages: {
			exch_cd:{
				required:"국가명을 선택 하세요",
				maxlength:jQuery.format("국가명은 드롭박스로 입력하세요.")
			},
			foreign_currency_cost:{
				required:"외화비용을 입력 하세요",
				maxlength:jQuery.format("외화비용은 숫자로 입력 하세요.")
			},
			foreign_currency_cost:{
				required:"환전비용을 입력 하세요",
				maxlength:jQuery.format("환전비용은 숫자로 입력 하세요.")
			},
			sort_seq:{
				required:"정렬순서를 입력하세요",
				number:"정렬순서는 숫자로 입력하셔야합니다.",
				maxlength:jQuery.format("정렬순서는 최대 32767 이하로 입력하세요.")
			}
		},
		onfocusout:false,
		invalidHandler: function(form, validator) {
			showValidationError(form, validator);               
        },
		errorPlacement: function(error, element) {},
		submitHandler: function(form) {			
			
			var app_st_dt = $("#app_st_dt").val();
			var app_ed_dt = $("#app_ed_dt").val();
			
			if(app_st_dt == ''){
				toast('적용 시작일을선택하세요');
				return false;
			}
			
			if(app_ed_dt == ''){
				toast('적용 종료일을 선택하세요');
				return false;
			}

			$("#cost_usd").val($("#cost_usd").val().replace(/,/g, ""));
			$("#cost_cny").val($("#cost_cny").val().replace(/,/g, ""));
			$("#cost_vnd").val($("#cost_vnd").val().replace(/,/g, ""));
			$("#cost_jpy").val($("#cost_jpy").val().replace(/,/g, ""));
			$("#cost_hkd").val($("#cost_hkd").val().replace(/,/g, ""));
			$("#cost_eur").val($("#cost_eur").val().replace(/,/g, ""));
			$("#cost_idr").val($("#cost_idr").val().replace(/,/g, ""));
			$("#cost_php").val($("#cost_php").val().replace(/,/g, ""));
			$("#cost_thb").val($("#cost_thb").val().replace(/,/g, ""));
			
			$.ajax({
				type: "POST",
				url: "/ad/ex/ADEX02/insert",
				data: $(form).serialize(),
				dataType: 'json',
				contentType: 'application/x-www-form-urlencoded; charset=utf-8',
				success: function(data) {
					if(data.code != '0') {
						window.opener.toast(data.msg);
						window.opener.fn_f3();
						//window.close();
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
	$("#gForm").submit();
}
		
		