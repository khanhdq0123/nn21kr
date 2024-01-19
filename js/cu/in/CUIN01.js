
var submitUrl = "/partner/updateParnterInfo";

	$(document).ready(function() {
	
	
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

var fnSearchPost = function(){
    new daum.Postcode({
        oncomplete: function(data) {
        	
        	/*
	        	zipnum_cd
				lot_basadd_txt
				lot_dtladd_txt
				road_basadd_txt
				road_dtladd_txt
        	*/
        	
        	//$("#zipnum_cd").val(data.zonecode);
        	//$("#lot_basadd_txt").val(data.jibunAddress);
        	$("#road_basadd_txt").val(data.roadAddress);

        	//$("#lot_dtladd_txt").val("");
        	$("#dtladd_txt").val("");
        	
        	$("#basadd_txt").val(data.roadAddressEnglish);

        }
    }).open();
}

var fnReload = function(){
	
	$("#memberList").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
	$("#snsList").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
	
	
}

function fnSelectRegionPop(engFlag){
	var _url = '/region/selectRegionPop?code=10000&engFlag='+ engFlag;
	CenterOpenWindow(_url, '지역선택', '1200','560', 'scrollbars=no, status=yes');
}

function fnSetSelectRegionInfo( _country, _city, _region1, _region2, _region3, _region4,_countryEng, _cityEng, _region1Eng, _region2Eng, _region3Eng, _region4Eng, _countryNo, _cityNo, _region1No, _region2No, _region3No, _region4No,_engFlag){
	if(_engFlag == 1)
		$("#basadd_txt").val(_region4Eng  + ' ' + _region3Eng  + ' ' + _region2Eng  + ' ' + _region1Eng  + ' ' + _cityEng + ' ' + _countryEng);
	else
		$("#road_basadd_txt").val(_country + ' ' + _city + ' ' + _region1 + ' ' + _region2 + ' ' + _region3 + ' ' + _region4);
}
		