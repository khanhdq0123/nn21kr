
var idDupCheck = false;


		$(document).ready(function() {
			
			var submitUrl = "/partner/insertParnterInfo";
			if(vendor_no!= "") {
				submitUrl = "/partner/updateParnterInfo";
			} else {
				
			} 
			
			
			if(vendor_no == ''){

			} else {
				
			}

		    jQuery("#memberList").jqGrid({
		  		url:'/system/staff/staffListJson',
		  		datatype: "local",				   
		  		colNames:['staff_id','담당업무', '직책', '성명', '아이디', '핸드폰','E-Mail','SNS','sns추가'],
		  		colModel:[
					{name:'staff_id'	, index:'staff_id', 	width:90, hidden:true},
		  			{name:'job_nm'		, index:'job_nm', 		width:60, align:"left", sortable:true, editable:false},
		  			{name:'position_nm'	, index:'position_nm', 	width:60, align:"left", sortable:true, editable:false},
		  			{name:'staff_nm'	, index:'staff_nm', 	width:60, align:"left", sortable:true, editable:false},
		  			{name:'login_id'	, index:'login_id', 	width:90, align:"left", sortable:true, editable:false},
		  			{name:'mobile_txt'	, index:'mobile_txt', 	width:80, align:"left", sortable:true, editable:false},
		  			{name:'email_txt'	, index:'email_txt', 	width:120, align:"left", sortable:true, editable:false},
		  			{name:'sns'			, index:'sns', 			width:300, align:"left", sortable:true, editable:false},
		  			{name:'sns'			, index:'sns', 			width:40, align:"center", formatter:snsLinkFormatter}
		  		],
		  		mtype:"get",
		  		autowidth: true,	// 부모 객체의 width를 따른다
		  		height: 140,
		  		sortname: 'groupauth_id',
		  	    viewrecords: true,
		  	    multiselect : true,
		  	    cellEdit : true,
		  		cellsubmit : 'clientArray',
		  		gridview: true,
		  		// 서버에러시 처리
		  		loadError : function(xhr,st,err) {
		  			girdLoadError();
		  	    },
		  		// 데이터 로드 완료 후 처리 
		  	  	loadComplete: function(data) {},

				postData : {
					vendor_no:function() {
						return $("#vendor_no").val();
					},
					additionalParam:'dummy'
				},
		  	   
		  	    // cell이 변경되었을 경우 처리
		  	    afterSaveCell : function(id, name, val, iRow, iCol) {
		  	    	//checkWhenColumnUpdated("regionGrid", id);
		  	    },
		  	    //스크롤바 자동 생성
		  	    shrinkToFit:true			    
		  	});
			
			
		    $("#memberList").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");

		    jQuery("#snsList").jqGrid({
		  		url:'/system/staff/staffSnsListJson',
		  		datatype: "local",				   
		  		colNames:['성명','SNS구분', 'SNS주소','staff_sns_seq'],
		  		colModel:[
		  			{name:'staff_nm'		, index:'job_nm', 		width:200, align:"left", sortable:true, editable:false},
		  			{name:'sns_typ_nm'		, index:'job_nm', 		width:200, align:"left", sortable:true, editable:false},
		  			{name:'sns_id'			, index:'sns_id', 	width:600, align:"left", sortable:true, editable:false},
		  			{name:'staff_sns_seq'			, index:'staff_sns_seq', 	hidden:true}
		  		],
		  		mtype:"get",
		  		autowidth: true,	// 부모 객체의 width를 따른다
		  		height: 160,
		  		sortname: 'groupauth_id',
		  	    viewrecords: true,
		  	    multiselect : true,
		  	    cellEdit : true,
		  		cellsubmit : 'clientArray',
		  		gridview: true,
		  		// 서버에러시 처리
		  		loadError : function(xhr,st,err) {
		  			girdLoadError();
		  	    },
		  		// 데이터 로드 완료 후 처리 
		  	  	loadComplete: function(data) {},

				postData : {
					vendor_no:function() {
						return $("#vendor_no").val();
					},
					additionalParam:'dummy'
				},
		  	   
		  	    // cell이 변경되었을 경우 처리
		  	    afterSaveCell : function(id, name, val, iRow, iCol) {
		  	    	//checkWhenColumnUpdated("regionGrid", id);
		  	    },
		  	    //스크롤바 자동 생성
		  	    shrinkToFit:true			    
		  	});
		    
		    
		    $("#snsList").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
		    
		    

			
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
							
										$("#btnSearch", opener.document).trigger("click");
										
										//location.href = "/partner/partnerListPop?vendor_no=" + data.vendor_no;
										self.close();
	
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

			//validate 필수항목 message 처리(label 항목 필수)
			var customMsg = '';
			var customMsgFunction = function() { return customMsg; };
			

			$.validator.addMethod("dashNum", function(value, element) { 
				return this.optional(element) || /^[0-9-+]+$/.test(value); 
			}, "");
			
			//sns추가
			$('#addSnsBtn').click(function (){
				//$("#snsList").jqGrid('addRow', {rowID:Math.random(), position: "first", initdata:{} });
				return false;
			});
			

			$('#btnStep1').click(function (){
				$('#partnerForm').submit();
			});


			//지사 삭제
			$("#btnDelete").click( function() {
				
				var _vendor_no = $("#vendor_no").val();

				if(_vendor_no == '10007' || _vendor_no == '10129'){
					toast('테스트중인 지사(또는 업체)입니다! 당분간 삭제가 불가능합니다.');					
					return false;
				}
								
				if(confirm("삭제하시겠습니까?" + "\r\n 등록된 게시물 및 직원정보 모두 삭제됩니다.")){
					
					$.ajax({
						type: "POST",
						url: "/partner/deleteParnterInfo",
						data: $("#partnerForm").serialize(),
						dataType: 'json',
						contentType: 'application/x-www-form-urlencoded; charset=utf-8',
						success: function(data) {
							if(data.code == '0') {
								opener.toast(data.msg);
								opener.fn_f3();
								window.close();
							} else {
								toast('삭제가 실패되었습니다.');
							}
						},
						error: function(jqXHR, textStatus, errorThrown) {
							toast(jqXHR.status);						
						}
					});
					
				}
				
			});
			
			
			$('#btnClose').click(function (){
				self.close();
			});

			//사용자 추가
			$("#addUserBtn").click( function() {
				CenterOpenWindow('/system/staff/staffDetailPop?type=add&staff_typ=2&vendor_no='+vendor_no, '사용자등록', '900','425', 'scrollbars=no, status=yes');
			});
			
			//사용자 삭제
			$("#delUserBtn").click( function() {
				saveGridSelected("memberList", 'selected', 'delete', "/system/staff/deleteStaffList");
			});
			
			//SNS 삭제
			$("#delSnsBtn").click( function() {
				saveGridSelected("snsList", 'selected', 'delete', "/system/staff/deleteStaffSnsList");
			});
			
			
			
			$("#addSnsBtn").click( function() {
				CenterOpenWindow('/system/staff/staffSnsPop?type=add&staff_typ=2&vendor_no='+vendor_no, 'SNS등록', '800','260', 'scrollbars=no, status=yes');
			});
			
			$(".addSnsBtn").click( function() {
				CenterOpenWindow('/system/staff/staffSnsPop?type=add&staff_typ=2&vendor_no='+vendor_no, 'SNS등록', '800','260', 'scrollbars=no, status=yes');
			});
			
			//접수하기
			$("#btnOrdReg").click( function() {			
				cfOrderReg(1,vendor_no);
				window.close();
			});
			
			
		});	// ~ready
			



	var fnAddSns = function(staff_id){
		CenterOpenWindow('/system/staff/staffSnsPop?type=add&staff_typ=3&vendor_no='+vendor_no+'&staff_id='+staff_id, 'SNS등록', '800','260', 'scrollbars=no, status=yes');
	}


	function snsLinkFormatter(cellVal, options, rowObj) {
		var linkURL = '<a href="javascript:CenterOpenWindow(\'/system/staff/staffSnsPop?type=add&staff_typ=3&vendor_no=' + rowObj['vendor_no']+'&staff_id=' + rowObj['staff_id'] + '\', \'open1\', \'800\', \'260\', \'scrollbars=yes, status=no\');">';
		linkURL += '<b>sns추가</b></a>';										
		return linkURL;
	}


		
		function allGridEditMode(gridName, cellName, cellRow){
			var selRows = $("#listCategory").getDataIDs();
			for(var i=0; i<selRows.length; i++) {
				$('#listCategory').editRow(selRows[i], true); 
			}
			
			selRows = $("#listDeliveryFee").getDataIDs();
			for(var i=0; i<selRows.length; i++) {
				$('#listDeliveryFee').editRow(selRows[i], true); 
			}
			
			selRows = $("#listClaimAdmin").getDataIDs();
			for(var i=0; i<selRows.length; i++) {
				$('#listClaimAdmin').editRow(selRows[i], true); 
			}
			
			selRows = $("#listReturnFee").getDataIDs();
			for(var i=0; i<selRows.length; i++) {
				$('#listReturnFee').editRow(selRows[i], true); 
			}
			
			if(gridName !== undefined) {
				$("#"+gridName+" tr:eq("+(cellRow+1)+")").find('input[name='+cellName+']').focus();
			}
		}
		

		
		function getGridDataToStringPartner(gridName, type) {					
			return JSON.stringify(getGridDataToJsonPartner(gridName, type));
		}
		
		function getGridDataToJsonPartner(gridName, type) {					
			//$("#"+gridName).editCell(0,0,false); 
			
			var selRows;
			if(type == 'selected') {
				selRows = $("#"+gridName).getGridParam('selarrrow');
			} else if(type == 'all'){
				selRows = $("#"+gridName).getDataIDs();
			}	
			
			$("#"+gridName).setGridParam({cellEdit:false});
			var colModel = $("#"+gridName).getGridParam('colModel');
			var gridData = [];
			
			for(var i=0; i<selRows.length; i++) {
				var rowData = $("#"+gridName).getRowData(selRows[i]);

				for(var j=0; j<colModel.length; j++) {
					
					var colData = rowData[colModel[j].name];
					
					if((typeof colData != "undefined") &&
							( colData.toLowerCase().indexOf("<input") >= 0 
							  || colData.toLowerCase().indexOf("<select") >= 0
							  || colData.toLowerCase().indexOf("<textarea") >= 0
							)
					) {
						toast('편집중인 항목이 있습니다. 편집모드를 종료하세요.');
						$("#"+gridName).setGridParam({cellEdit:true});
						return false;
					}
				}
				
				gridData.push(rowData);
			}
				
			return gridData;

		}
		
		function setInputDisabled(flag){	
			
			
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

var fnTest = function(){
	
	$("#vendor_nm_eng").val(" International Logistics Company");
	$("#vendor_nm").val("주식회사 국제종합물류");
	$("#homepage_url").val("http://iltest.nn21.net/");
	$("#tel_txt").val("032-772-8481");
	$("#fax_txt").val("032-772-8484");
	$("#email_txt").val("ilmaster@nn21.com");
	$("#basadd_txt").val("SHINHEUNG-DONG 1GA, JUNG-GU, INCHEON-CITY, KOREA.");
	$("#dtladd_txt").val("IL BLDG 3F, 31-1");
	$("#road_basadd_txt").val("SHINHEUNG-DONG 1GA, JUNG-GU, INCHEON-CITY, KOREA.");
	$("#road_dtladd_txt").val("IL BLDG 3F, 31-1");
	$("#business_txt").val("물류/유통");
	$("#business_type_txt").val("물류/유통");
	$("#item_txt").val("국제물류, 포워딩,  관세사");

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
	
	var lastRegionNo = '';
	
//	if(_engFlag == 1)
//		$("#basadd_txt").val(_region4Eng  + ' ' + _region3Eng  + ' ' + _region2Eng  + ' ' + _region1Eng  + ' ' + _cityEng + ' ' + _countryEng);
//	else
//		$("#road_basadd_txt").val(_country + ' ' + _city + ' ' + _region1 + ' ' + _region2 + ' ' + _region3 + ' ' + _region4);

	$("#basadd_txt").val(_region4Eng  + ' ' + _region3Eng  + ' ' + _region2Eng  + ' ' + _region1Eng  + ' ' + _cityEng + ' ' + _countryEng);
	$("#road_basadd_txt").val(_country + ' ' + _city + ' ' + _region1 + ' ' + _region2 + ' ' + _region3 + ' ' + _region4);		
			
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


	$("#region_no").val(lastRegionNo);
		
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
					
					/*
					var business_type_txt_val = $("#div_business_type_txt li.on").text();
					var business_txt_val = $(this).text();
					
					$("#business_type_txt").val(business_type_txt_val);
					$("#business_txt").val(business_txt_val);
					
					$('#selectBusinessTypeLayerPop').hide();
					*/
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
	
	$("#chkSame1").click(function(event) {
		var chkSame1 = $("#chkSame1:checked").val();

		
		if(chkSame1 == 1){
			$("#staff_enm2").val($("#staff_enm1").val());
			$("#mobile_txt2").val($("#mobile_txt1").val());
			$("#staff_nm2").val($("#staff_nm1").val());
			$("#email_txt2").val($("#email_txt1").val());
			$("#login_id2").val($("#login_id1").val());
			$("#passwd_txt2").val($("#passwd_txt1").val());
			$("#passwd_txt22").val($("#passwd_txt12").val());
		} else {
			$("#staff_enm2").val("");
			$("#mobile_txt2").val("");
			$("#staff_nm2").val("");
			$("#email_txt2").val("");
			$("#login_id2").val("");
			$("#passwd_txt2").val("");
			$("#passwd_txt22").val("");
		}
	});
	
	
	

	
});



function setLoginId(data) {
	
	if(idCheckFlag == 1)
		$('#login_id1').val(data);
	else if(idCheckFlag == 2)
		$('#login_id2').val(data);
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
		data: $(partnerForm).serialize(),
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


function fn_f10(){
	$('#partnerForm').submit();
}
			
			
var fnDelStaff = function(login_id){

	
	var data = {};
	data.staff_id = login_id;
	
	
	$.ajax({
		type: "POST",
		url: "/system/staff/deleteStaff",
		data: data,
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

function fnUpdateStaff(staff_id){
	CenterOpenWindow('/system/staff/staffDetailPop?type=modify&staff_typ=2&vendor_no='+vendor_no+'&staff_id='+staff_id, '사용자등록', '900','425', 'scrollbars=no, status=yes');
}			
