/**
 * 환율 상세 정보
 */
$(document).ready(function() {

	$("#app_dt").on("change", function(){

		$.ajax({
			type: "POST",
			url: "/ad/ex/ADEX01/getRecentCustomsExchangeRate",
			data: $("#gForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
			
			var app_dt = $("#app_dt").val();
			if(data.info == null){
				$("input[type=text]").val("");
				$("#app_dt").val(app_dt);
			} else {
			
				if(data.info.cost_usd == null) data.info.cost_usd = "";
				if(data.info.cost_cny == null) data.info.cost_cny = "";
				if(data.info.cost_vnd == null) data.info.cost_vnd = "";
				if(data.info.cost_jpy == null) data.info.cost_jpy = "";
				if(data.info.cost_hkd == null) data.info.cost_hkd = "";
				if(data.info.cost_eur == null) data.info.cost_eur = "";
				if(data.info.cost_idr == null) data.info.cost_idr = "";
				if(data.info.cost_php == null) data.info.cost_php = "";
				if(data.info.cost_thb == null) data.info.cost_thb = "";
	
				$("#cost_usd").val(data.info.cost_usd);
				$("#cost_cny").val(data.info.cost_cny);
				$("#cost_vnd").val(data.info.cost_vnd);
				$("#cost_jpy").val(data.info.cost_jpy);
				$("#cost_hkd").val(data.info.cost_hkd);
				$("#cost_eur").val(data.info.cost_eur);
				$("#cost_idr").val(data.info.cost_idr);
				$("#cost_php").val(data.info.cost_php);
				$("#cost_thb").val(data.info.cost_thb);
				
				if(data.info.unit_usd == null) data.info.unit_usd = "1";
				if(data.info.unit_cny == null) data.info.unit_cny = "1";
				if(data.info.unit_vnd == null) data.info.unit_vnd = "100";
				if(data.info.unit_jpy == null) data.info.unit_jpy = "100";
				if(data.info.unit_hkd == null) data.info.unit_hkd = "1";
				if(data.info.unit_eur == null) data.info.unit_eur = "1";
				if(data.info.unit_idr == null) data.info.unit_idr = "100";
				if(data.info.unit_php == null) data.info.unit_php = "1";
				if(data.info.unit_thb == null) data.info.unit_thb = "1";
				
				$("#unit_usd").val(data.info.unit_usd);
				$("#unit_cny").val(data.info.unit_cny);
				$("#unit_vnd").val(data.info.unit_vnd);
				$("#unit_jpy").val(data.info.unit_jpy);
				$("#unit_hkd").val(data.info.unit_hkd);
				$("#unit_eur").val(data.info.unit_eur);
				$("#unit_idr").val(data.info.unit_idr);
				$("#unit_php").val(data.info.unit_php);
				$("#unit_thb").val(data.info.unit_thb);
				
			}
				
			}
		});
				
				
		
	});
	
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
			
			var app_dt = $("#app_dt").val();
			
			if(app_dt == ''){
				toast('적용날짜를 선택하세요');
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
				url: "/ad/ex/ADEX01/insert",
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
		
		