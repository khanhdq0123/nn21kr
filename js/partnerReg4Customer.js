
var idDupCheck = false;


		$(document).ready(function() {
			
			var submitUrl = "/partner/insertParnter4Customer";


			$("#rForm").validate({
				debug : true,
				rules : {
					vendor_nm:{required: true}
					,vendor_nm_eng:{required: true}
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
	            },
				errorPlacement: function(error, element) {},
				submitHandler: function(form) {

						$.ajax({
							type: "POST",
							url: submitUrl,
							data: $(rForm).serialize(),
							dataType: 'json',
							contentType: 'application/x-www-form-urlencoded; charset=utf-8',
							success: function(data) {
								if(data.code == '0') {
									toast(data.msg);
							
										$("#btnSearch", opener.document).trigger("click");
										
//										location.href = "/partner/partnerListPop?vendor_no=" + data.vendor_no;
										self.close();
	
								} else {
									toast(data.msg);
									//setInputDisabled(false);
									//allGridEditMode();
								}
							},
							error: function(jqXHR, textStatus, errorThrown) {
								toast(jqXHR.status);						
							}
						});
				}
			});

			//validate 필수항목 message 처리(label 항목 필수)
			var customMsg = '';
			var customMsgFunction = function() { return customMsg; };
			

			$.validator.addMethod("dashNum", function(value, element) { 
				return this.optional(element) || /^[0-9-+]+$/.test(value); 
			}, "");
			

			$('#btnSave').click(function (){
				$('#rForm').submit();
			});

			$('#btnClose').click(function (){
				self.close();
			});

		});	


var fnSearchPost = function(){
    new daum.Postcode({
        oncomplete: function(data) {
        	        	
        	//$("#zipnum_cd").val(data.zonecode);
        	//$("#lot_basadd_txt").val(data.jibunAddress);
        	$("#road_basadd_txt").val(data.roadAddress);

        	//$("#lot_dtladd_txt").val("");
        	$("#dtladd_txt").val("");
        	
        	$("#basadd_txt").val(data.roadAddressEnglish);

            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
        }
    }).open();
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




function fnViewBusinessTypeLayer(){
	$('#selectBusinessTypeLayerPop').center();
	$('#selectBusinessTypeLayerPop').show();	
}

function fnViewItemLayer(){
	$('#selectItemLayerPop').center();
	$('#selectItemLayerPop').show();	
}

//품목 선택완료
function fnSelectedItem(){
	
	selectedItem = "";
	var i = 0;
	$("#selectItemLayerPop .lypop_tbl td").each(function(){
		if($(this).hasClass("on")){
			if(i==0) 
				selectedItem += $(this).text();
			else 
				selectedItem += ',' + $(this).text();
			
			i++;
		}
	});

	$("#item_txt").val(selectedItem);
	$('#selectItemLayerPop').hide();	
}

//업종 선택완료
function fnSelectedBusiness(){
	
	selectedBusiness = "";
	var i = 0;
	$("#div_business_txt ul li").each(function(){
		if($(this).hasClass("on")){
			if(i==0) 
				selectedBusiness += $(this).text();
			else 
				selectedBusiness += ',' + $(this).text();
			
			i++;
		}
	});

	var business_type_txt_val = $("#div_business_type_txt li.on").text();
// 	var business_txt_val = $(this).text();
	
	$("#business_type_txt").val(business_type_txt_val);
	$("#business_txt").val(selectedBusiness);
	
	$('#selectBusinessTypeLayerPop').hide();	
}



$(document).ready(function() {
		
	//품목 선택
	$("#selectItemLayerPop .lypop_tbl td").on("click", function(){
		
		if($(this).hasClass("on")){
			$(this).removeClass("on");
		} else {
			$(this).addClass("on");
		}

		//$("#item_txt").val($(this).text());
		//$('#selectItemLayerPop').hide();	
	});
		
	
	$("#div_business_type_txt li").on("click", function(){
		var code = $(this).attr("code");
		$("#code").val(code);
		
		$(this).addClass("on").siblings().removeClass("on");
		
		$.ajax({
			type: "POST",
			url: "/partner/businessKindListJson",
			data: $("#rForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				var _html = "" ;
				$(data.rows).each(function(i,d){
					_html += "<li>" + d.code_nm + "</li>";
				});	
				$("#div_business_txt ul").html(_html);
				
				//업태/업종 선택
				$("#div_business_txt li").on("click", function(){
					
					if($(this).hasClass("on")){
						$(this).removeClass("on");
					} else {
						$(this).addClass("on");
					}

				});
				
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast( textStatus.msg);						
			}
		});

	});
	
	$("#btnDup").click(function(event) {
		if($("#login_id").val() == '') {
			toast("로그인ID를 입력 후 중복확인을 해주세요.");
			return false;
		}
		CenterOpenWindow('/system/staff/loginIdDupPop?loginId='+$("#login_id").val(), '중복확인', '480','220', 'scrollbars=yes, status=yes');
		event.preventDefault(); 
	});	
	
	$("#btnDup1").click(function(event) {
		idCheckFlag = 1;
		if($("#login_id1").val() == '') {
			toast("로그인ID를 입력 후 중복확인을 해주세요.");
			return false;
		}
		CenterOpenWindow('/system/staff/loginIdDupPop?loginId='+$("#login_id1").val(), '중복확인', '480','220', 'scrollbars=yes, status=yes');
		event.preventDefault(); 
	});
	
	$("#btnDup2").click(function(event) {
		idCheckFlag = 2;
		if($("#login_id2").val() == '') {
			toast("로그인ID를 입력 후 중복확인을 해주세요.");
			return false;
		}
		CenterOpenWindow('/system/staff/loginIdDupPop?loginId='+$("#login_id2").val(), '중복확인', '480','220', 'scrollbars=yes, status=yes');
		event.preventDefault(); 
	});

	$("#btnDup3").click(function(event) {
		idCheckFlag = 3;
		if($("#login_id3").val() == '') {
			toast("로그인ID를 입력 후 중복확인을 해주세요.");
			return false;
		}
		CenterOpenWindow('/system/staff/loginIdDupPop?loginId='+$("#login_id3").val(), '중복확인', '480','220', 'scrollbars=yes, status=yes');
		event.preventDefault(); 
	});
	
});



function setLoginId(data) {
	
	if(idCheckFlag == 1)
		$('#login_id1').val(data);
	else if(idCheckFlag == 2)
		$('#login_id2').val(data);
	else if(idCheckFlag == 3)
		$('#login_id3').val(data);
	else
		$('#login_id').val(data);
		
	idDupCheck = true;		
		
		
}





function fnCheckVendorCode(){
	var vendor_cd = $("#vendor_cd").val();
	var vendor_cd1 = $("#vendor_cd1").val();
	var vendor_cd2 = $("#vendor_cd2").val();
	
	if(vendor_cd1 == null || vendor_cd1 == ''){
		toast('please type area code');
		$("#vendor_cd1").focus();
		return false;
	}
	
	$("#vendor_cd1").val(vendor_cd1.toUpperCase());
		
	$.ajax({
		type: "POST",
		url: "/partner/getVendorCode",
		data: $(rForm).serialize(),
		dataType: 'json',
		contentType: 'application/x-www-form-urlencoded; charset=utf-8',
		success: function(data) {
			$("#vendor_cd").val(data.vendor_cd);
			$("#vendor_cd2").val(data.vendor_cd2);
		},
		error: function(jqXHR, textStatus, errorThrown) {
			toast("오류가 발생했습니다" );						
		}
	});
	
	
} 




