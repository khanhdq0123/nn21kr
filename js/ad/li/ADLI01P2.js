		
		var startPortFlag = 1;
										
			$(document).ready(function() {

				$("#trans_typ").on("change", function (){
					//toast('onchange');
					if($(this).val() == '') {
						$("#trans_way").empty();						
					} else {
						fn_getCommonCode($(this).val(), '#trans_way');
					}
					
				});
				
				
				$("#ct_size").on("change", function (){
					var st_port_nm = $("#st_port_nm").val();
					var ar_port_nm = $("#ar_port_nm").val();
					var ct_size = $("#ct_size option:checked").text();

					$("#route_nm").val(st_port_nm.trim() + ' - ' + ar_port_nm.trim() + ' ' + ct_size.trim());
					
				});

				$("#gForm").validate({
					debug : true,
					rules : {
						trans_typ1:{required:true, maxlength:20},
						trans_typ2:{required:true, maxlength:20},
						st_region2:{required:true, maxlength:20},
						st_region4:{required:true, maxlength:20}
					}, 		
					messages: {
						trans_typ:{
							required:"운송구분을 선택하세요.",
							maxlength:jQuery.format("지역명은 최대 20자 이하로 입력하세요.")
						},
						trans_way:{
							required:"운송방법을 선택하세요.",
							maxlength:jQuery.format("지역명은 최대 20자 이하로 입력하세요.")
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
							url: "/ad/li/ADLI01/updateRoute",
							data: $(form).serialize(),
							dataType: 'json',
							contentType: 'application/x-www-form-urlencoded; charset=utf-8',
							success: function(data) {
								if(data.code != '0') {
									toast(data.msg);
									window.opener.fn_f3();
									window.close();
								} else {
									toast('저장에 실패하였습니다.');
								}
							},
							error: function(jqXHR, textStatus, errorThrown) {
								toast(jqXHR.status);						
							}
						});
					}
				});
				
			});
			
			
			var region_flag = 1;
			
			function fnSelectView(flag){
				region_flag = flag;
				var trans_typ = $("#trans_typ").val();
				var code = '';
				if(trans_typ == ''){
					toast('먼저 운송구분을 선택하세요.');
					return;
				} else {
					
					switch(trans_typ){
						case "10201":
							code = 20000;
							break;
						case "10202":
							code = 30000;
							break;
						case "10203":
							code = 40000;
							break;
						default:
							code = 0;
					    	break;
					}
				}

				var _url = '/region/selectRegionPop?code=' + code + '&engFlag=1';
				CenterOpenWindow(_url, '지역선택', '1200','560', 'scrollbars=no, status=yes');
				//CenterOpenWindow('/region/selectPortPop?code=' + trans_typ1, '포트선택', '1000','560', 'scrollbars=no, status=yes');

			}
			
			
			function fnSetSelectRegionInfo( _country, _city, _region1, _region2, _region3, _region4,_countryEng, _cityEng, _region1Eng, _region2Eng, _region3Eng, _region4Eng, _countryNo, _cityNo, _region1No, _region2No, _region3No, _region4No,_engFlag){
				
				var targetRegionNo = "";
				var targetRegionNm = "";
				var lastRegionNo = "";

				if(region_flag == 1){
					targetRegionNo = "st_port_no";
					targetRegionNm = "st_port_nm";
				} else if(region_flag == 2){
					targetRegionNo = "ar_port_no";
					targetRegionNm = "ar_port_nm";
				} 


				
				
				//lastRegionNo = (_region4No != '') ? _region4No : (_region3No != '') ? _region3No : (_region2No != '') ? _region2No : _region1No;

				if(_region4No != null && _region4No != ''){
					
					lastRegionNo = _region4No;
					
				} else if(_region3No != null && _region3No != ''){
					
					lastRegionNo = _region3No;
					
				} else if(_region2No != null && _region2No != ''){
					
					lastRegionNo = _region2No;
					
				} else if(_region1No != null && _region1No != ''){
					
					lastRegionNo = _region1No;
					
				} else if(_cityNo != null && _cityNo != ''){
					
					lastRegionNo = _cityNo;
					
				} else if(_countryNo != null && _countryNo != ''){
					
					lastRegionNo = _countryNo;
					
				}
				
				$("#" + targetRegionNo).val(lastRegionNo);
				
				if(_engFlag == 1){
					$("#" + targetRegionNm).val(_region4Eng  + ' ' + _region3Eng  + ' ' + _region2Eng  + ' ' + _region1Eng  + ' ' + _cityEng + ' ' + _countryEng);
				} else {
					$("#" + targetRegionNm).val(_country + ' ' + _city + ' ' + _region1 + ' ' + _region2 + ' ' + _region3 + ' ' + _region4);
				}
				
				
				var st_port_nm = $("#st_port_nm").val();
				var ar_port_nm = $("#ar_port_nm").val();
				var ct_size = $("#ct_size option:checked").text();

				$("#route_nm").val(st_port_nm.trim() + ' - ' + ar_port_nm.trim() + ' ' + ct_size.trim());
				
			}
			
			function fn_getCommonCode(_upcode, _target){
				
				var data ={};
			      data.code_id = _upcode;
			      data.use_yn = 'Y';
// 			      data.upcode2 = $('#upcode2').val();
			      
				var jsonStr = JSON.stringify(data);
			      
									$.ajax({
										type: "POST",
										url: "/system/code/systemLowerCodeListJson2",
										data: data,
										dataType: 'json',
										contentType: 'application/x-www-form-urlencoded; charset=utf-8',
										success: function(data) {
											
											console.log('data', data);
											
											if(data != null){
												
												var _html = "" ;
												$(data.rows).each(function(i,d){
													_html += "<option value='" + d.code_cd + "'>" + d.code_nm + "</option>";
												});	
												
												$(_target).empty().append(_html);
											}
											

										},
										error: function(jqXHR, textStatus, errorThrown) {
											toast(jqXHR.status);						
										}
									});
			}
	
			
								
		function fn_f10(){
			$("#gForm").submit();
		}	
		
		
		function fn_f11(){
			
			
			if(confirm('삭제하시겠습니까?')==true) {
			
				$.ajax({
					type: "POST",
					url: "/ad/li/ADLI01/deleteRoute",
					data: $('#gForm').serialize(),
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						if(data.code != '0') {
							toast(data.msg);
							window.opener.fn_f3();
							window.close();
						} else {
							toast('삭제에 실패하였습니다.');
						}
					},
					error: function(jqXHR, textStatus, errorThrown) {
						toast(jqXHR.status);						
					}
				});
			
			}
						
		}
		
		
		
		