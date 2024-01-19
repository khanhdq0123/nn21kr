<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript">

	var vendor_no = '${info.vendor_no}';
	var vendor_nm = '${info.vendor_nm}';
	
		<c:set var="staff_typ" value="${sessionScope['STAFFINFORMATION']['staff_typ']}" />

		$(document).ready(function() {
			
			var submitUrl = "/partner/insertCustomerInfo";
			if('${info.vendor_no}') {
				submitUrl = "/partner/updateParnterInfo";
			} else {
				
			} 

		    jQuery("#memberList").jqGrid({
		  		url:'/system/staff/staffListJson',
		  		datatype: "local",				   
		  		colNames:['담당업무', '직책', '성명', '아이디', '비번','핸드폰','E-Mail','SNS'],
		  		colModel:[
		  			{name:'job_nm'		, index:'job_nm', 		width:120, align:"left", sortable:true, editable:false},
		  			{name:'position_nm'	, index:'position_nm', 	width:120, align:"left", sortable:true, editable:false},
		  			{name:'staff_nm'	, index:'staff_nm', 	width:120, align:"left", sortable:true, editable:false},
		  			{name:'login_id'	, index:'login_id', 	width:120, align:"left", sortable:true, editable:false},
		  			{name:'passwd_txt'	, index:'passwd_txt', 	width:180, align:"left", sortable:true, editable:false},
		  			{name:'mobile_txt'	, index:'mobile_txt', 	width:180, align:"left", sortable:true, editable:false},
		  			{name:'email_txt'	, index:'email_txt', 	width:180, align:"left", sortable:true, editable:false},
		  			{name:'sns'			, index:'sns', 			width:280, align:"left", sortable:true, editable:false}
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
		  		colNames:['성명','SNS구분', 'SNS주소'],
		  		colModel:[
		  			{name:'staff_nm'		, index:'job_nm', 		width:200, align:"left", sortable:true, editable:false},
		  			{name:'sns_typ_nm'		, index:'job_nm', 		width:200, align:"left", sortable:true, editable:false},
		  			{name:'sns_id'			, index:'sns_id', 	width:600, align:"left", sortable:true, editable:false}
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
				onfocusout:false,
				invalidHandler: function(form, validator) {
					showValidationError(form, validator);
	            },
				errorPlacement: function(error, element) {},
				submitHandler: function(form) {
					
					if($("#vendor_typ").val() == ''){
						toast("현력사구분을 선택하세요!");
						return false;
					}
					
					
					$.ajax({
						type: "POST",
						url: submitUrl,
						data: $(form).serialize(),
						dataType: 'json',
						contentType: 'application/x-www-form-urlencoded; charset=utf-8',
						success: function(data) {
							
							if(data.code == '0') {
								opener.toast(data.msg);
						
									$("#btnSearch", opener.document).trigger("click");
									self.close();
	
							} else {
	
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
			
// 			$.validator.addMethod("required", function(value, element, param) {
// 				var title = $('label[for='+$(element).attr('id')+']').text();
// 				customMsg = title + '를(을) 입력해주세요';
				
// 				if ( !this.depend(param, element) ) {
// 					return "dependency-mismatch";
// 				}
// 				if ( element.nodeName.toLowerCase() === "select" ) {
// 					// could be an array for select-multiple or a string, both are fine this way
// 					customMsg = title + '를(을) 선택해주세요';
					
// 					var val = $(element).val();
// 					return val && val.length > 0;
// 				}
// 				if ( this.checkable(element) ) {
// 					customMsg = title + '를(을) 선택해주세요';
					
// 					return this.getLength(value, element) > 0;
// 				}
				
// 				return $.trim(value).length > 0;
// 		     }, customMsgFunction);
			
			//number + '-'
			$.validator.addMethod("dashNum", function(value, element) { 
				return this.optional(element) || /^[0-9-+]+$/.test(value); 
			}, "");

			//sns추가
			$('#addSnsBtn').click(function (){
				//$("#snsList").jqGrid('addRow', {rowID:Math.random(), position: "first", initdata:{} });
				return false;
			});

			//value setting
			if('${info.vendor_no}') {
				$('#tax_cd').val('${info.tax_cd}');
				$('#sms_yn').val('${info.sms_yn}');
				$('input[name=stats_typ_cd]').filter('[value=${info.stats_typ_cd}]').trigger('click');
				$('#bank_cd').val('${info.bank_cd}');
				$('#charge_typ_cd').val('${info.charge_typ_cd}');
				$('input[name=penalty_typ]').filter('[value=${info.penalty_typ}]').trigger('click');
				



				<c:choose>
					<c:when test="${staff_typ ne '1'}">
						setInputDisabled(true);						
					</c:when>
					<c:otherwise>
						setInputDisabled(false);					
					</c:otherwise>
				</c:choose>

					
					$('#addCategoryBtn').hide();
					$('#delCategoryBtn').hide();

			}

			$('#btnClose').click(function (){
				self.close();
			});
			

			
			
			$("#addUserBtn").click( function() {
				CenterOpenWindow('/system/staff/staffDetailPop?type=add&staff_typ=2&vendor_no='+vendor_no, '사용자등록', '900','425', 'scrollbars=no, status=yes');
			});
			
			$("#addSnsBtn").click( function() {
				CenterOpenWindow('/system/staff/staffSnsPop?type=add&staff_typ=2&vendor_no='+vendor_no, 'SNS등록', '800','260', 'scrollbars=no, status=yes');
			});
			
			//접수하기
			$("#btnOrdReg").click( function() {
				cfOrderReg(1);
				window.close();
			});
			
			
			
		});	


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

		
		function fn_f10(){
			$('#partnerForm').submit();
		}
		
	</script>
	
	
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

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
        	
        	$("#zipnum_cd").val(data.zonecode);
        	$("#lot_basadd_txt").val(data.jibunAddress);
        	$("#road_basadd_txt").val(data.roadAddress);

        	$("#lot_dtladd_txt").val("");
        	$("#road_dtladd_txt").val("");
        	
        	console.log('zonecode',data.zonecode);
        	console.log('jibunAddress',data.jibunAddress);
        	console.log('jibunAddressEnglish',data.jibunAddressEnglish);
        	console.log('roadAddress',data.roadAddress);
        	console.log('roadAddressEnglish',data.roadAddressEnglish);
        	

        	
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
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
	$("#lot_basadd_txt").val("SHINHEUNG-DONG 1GA, JUNG-GU, INCHEON-CITY, KOREA.");
	$("#lot_dtladd_txt").val("IL BLDG 3F, 31-1");
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
// 	if(_engFlag == 1)
// 		$("#basadd_txt").val(_region4Eng  + ' ' + _region3Eng  + ' ' + _region2Eng  + ' ' + _region1Eng  + ' ' + _cityEng + ' ' + _countryEng);
// 	else
// 		$("#road_basadd_txt").val(_country + ' ' + _city + ' ' + _region1 + ' ' + _region2 + ' ' + _region3 + ' ' + _region4);
	
	$("#basadd_txt").val(_region4Eng  + ' ' + _region3Eng  + ' ' + _region2Eng  + ' ' + _region1Eng  + ' ' + _cityEng + ' ' + _countryEng);
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


$(document).ready(function() {
	
	

		
	$("#vendor_typ").val(${info.vendor_typ});

	
	
		
	//품목 선택
	$("#selectItemLayerPop .lypop_tbl td").on("click", function(){
		$("#item_txt").val($(this).text());
		$('#selectItemLayerPop').hide();	
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

					var business_type_txt_val = $("#div_business_type_txt li.on").text();
					var business_txt_val = $(this).text();
					
					$("#business_type_txt").val(business_type_txt_val);
					$("#business_txt").val(business_txt_val);
					
					//$("#item_txt").val($(this).text());
					$('#selectBusinessTypeLayerPop').hide();	
				});
				
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast( textStatus.msg);						
			}
		});
		
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
	
	
});




</script>
	
<style>
#selectItemLayerPop th {text-align:center !important; height:40px;}
#selectItemLayerPop td {text-align:center; height:40px; border-right:1px dotted #e5e5e5; cursor:pointer;}
#selectItemLayerPop td:hover {background-color:#fcf340; font-weight:bold; font-size:12px;}


#selectBusinessTypeLayerPop th {background-color:#ffffff;}
#selectBusinessTypeLayerPop td {background-color:#ffffff;}
#div_business_type_txt{overflow:auto;}
#div_business_type_txt li {background-color:#ffffff; line-height:25px; text-align:left; border-bottom:1px dotted #e5e5e5; cursor:pointer;}
#div_business_type_txt li:hover {background-color:#fcf340;}

#div_business_txt {overflow:auto;}
#div_business_txt li {line-height:25px; text-align:left; border-bottom:1px dotted #e5e5e5; cursor:pointer;}
#div_business_txt li:hover {background-color:#fcf340;}

#div_business_type_txt li.on {background-color:#fcf340;}
</style>

</head>
<body class="sky">


	<c:if test="${empty info.vendor_no}">
		<c:set var="pTitle" value="업체 등록" />
	</c:if>
	<c:if test="${!empty info.vendor_no}">
		<c:set var="pTitle" value="업체 상세" />
	</c:if>

	
	
	<div class="layerpop_inner"  id="partnerPop">
	
		<h1 class="ly_header">${pTitle}</h1>
		<!-- .ly_body -->
		<div class="ly_body">
			<div class="refer bullet6">
				<ul class="type1">
					<li>정보를 입력 하시고 반드시 저장버튼을 클릭하셔야 정상 등록 됩니다.</li>
				</ul>
				
				<div class="refer_bt" >
					<div class="min_btn mini">	
					<c:if test="${!empty info.vendor_no}">
<!-- 						<input type="button" class="btn btn-info btn-sm" value="접수하기" 	id="btnOrdReg">		 -->
					</c:if>			
						<input type="button" class="btn btn-primary btn-sm" value="저장" 	id="btnSave">
					<c:if test="${!empty info.vendor_no}">
						<input type="button" class="btn btn-danger btn-sm" 	value="삭제" 	id="btnDelete">
					</c:if>							
						<input type="button" class="btn btn-close btn-sm" 	value="닫기" 	id="btnClose">
					</div>
				</div>
				
			</div>
			<div class="layer_contents">
				<div class="inb_con active">
					<form method="post" id="partnerForm" >
						<input type="hidden" id="vendor_no" 	name="vendor_no" 		value="${info.vendor_no}" />
						<c:if test="${!empty vendor_typ}">
						<input type="hidden" id="vendor_typ" 	name="vendor_typ" 		value="${vendor_typ}" />
						</c:if>
						
						<fieldset>
						<legend>${pTitle} 정보</legend>
							<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl" style="border-top: 0px;">
							<caption>${pTitle} 정보</caption>
								<colgroup>
									<col width="16%" />
									<col width="34%" />
									<col width="16%" />
									<col width="34%" />
								</colgroup>
								<tbody>
									<tr>
							
										<td colspan="4"><h3 >업체 기본 정보</h3></td>
				
									</tr>
									
									<c:if test="${empty vendor_typ}">
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="business_txt">협력사구분</label></th>
										<td>
											<select name="vendor_typ" id="vendor_typ" required >
												<option value="">선택하세요.</option>
												<option value="4" <c:if test="${info.vendor_typ eq '4'}">selected</c:if> >관세사</option>
<%-- 												<option value="5" <c:if test="${info.vendor_typ eq '5'}">selected</c:if> >창고</option> --%>
												<option value="6" <c:if test="${info.vendor_typ eq '6'}">selected</c:if> >운송사</option>
												<option value="7" <c:if test="${info.vendor_typ eq '7'}">selected</c:if> >무역회사</option>
												<option value="8" <c:if test="${info.vendor_typ eq '8'}">selected</c:if> >통관회사</option>
											</select>
										</td>
										<th scope="row">사업자번호</th>
										<td><input type="text" id="tel_txt" name="biz_num_txt" value="${info.biz_num_txt}" style="width:80%" maxlength="30"  /></td>
									</tr>
									</c:if>
									
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="vendor_nm_eng">상호명(영문)</label></th>
										<td><input type="text" id="vendor_nm_eng" name="vendor_nm_eng" value="${info.vendor_nm_eng}" style="width:80%" maxlength="50" required /></td>
										<th scope="row"><label for="tel_txt">전화</label></th>
										<td><input type="text" id="tel_txt" name="tel_txt" value="${info.tel_txt}" style="width:80%" maxlength="30"  /></td>
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="vendor_nm">상호명</label></th>
										<td><input type="text" id="vendor_nm" name="vendor_nm" value="${info.vendor_nm}" style="width:80%" maxlength="30" title="상호명을 입력하세요" required /></td>
										<th scope="row"><label>팩스</label></th>
										<td><input type="text" id="fax_txt" name="fax_txt" value="${info.fax_txt}" style="width:80%" maxlength="30"  /></td>
									</tr>
									<tr>
										<th scope="row"><label>홈페이지</label></th>
										<td><input type="text" id="homepage_url" name="homepage_url" value="${info.homepage_url}" style="width:80%" maxlength="30"  /></td>
										<th scope="row"><label>메일</label></th>
										<td><input type="text" id="email_txt" name="email_txt" value="${info.email_txt}" style="width:80%" maxlength="30"  /></td>
									</tr>
	
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="desc_addr_txt">사업장주소(영문)</label></th>
										<td colspan="3">				
											<input type="text" id="basadd_txt" name="basadd_txt" value="${info.basadd_txt}" onclick="fnSelectRegionPop(1);" class="readonly" style="width:48%;" placeholder="여기를 눌러 선택하세요." required readonly/> &nbsp;
											<input type="text" id="dtladd_txt" name="dtladd_txt" value="${info.dtladd_txt}" style="width:32%;" maxlength="150" required />
										</td>
									</tr>
									
									<tr>
										<th scope="row"><label for="desc_addr_txt">사업장주소(자국어)</label></th>
										<td colspan="3">				
											<input type="text" id="road_basadd_txt" name="road_basadd_txt" value="${info.road_basadd_txt}" onclick="fnSelectRegionPop(2);" class="readonly" style="width:48%;" placeholder="여기를 눌러 선택하세요." readonly/> &nbsp;
											<input type="text" id="road_dtladd_txt" name="road_dtladd_txt" value="${info.road_dtladd_txt}" style="width:32%;" maxlength="150" />
										</td>
									</tr>
	
									<tr>
										<th scope="row"><label for="business_type_txt">업태</label></th>
<%-- 										<td><input type="text" id="business_type_txt" name="business_type_txt" value="${info.business_type_txt}" class="readonly" onclick="fnViewBusinessTypeLayer();" style="width:80%" maxlength="30"  readonly /></td> --%>
										<td><input type="text" id="business_type_txt" name="business_type_txt" value="${info.business_type_txt}"  style="width:80%" maxlength="30" /></td>
										<th scope="row"><label for="business_txt">업종</label></th>
<%-- 										<td><input type="text" id="business_txt" name="business_txt" value="${info.business_txt}" class="readonly" onclick="fnViewBusinessTypeLayer();" style="width:80%" maxlength="30"  readonly /></td> --%>
										<td><input type="text" id="business_txt" name="business_txt" value="${info.business_txt}" style="width:80%" maxlength="30" /></td>
									</tr>
	
									<tr>
										<th scope="row"><label for="business_txt">품목</label></th>
<%-- 										<td><input type="text" id="item_txt" name="item_txt" value="${info.item_txt}" onclick="fnViewItemLayer();" style="width:80%;" class="readonly" maxlength="30"  readonly /></td> --%>
										<td><input type="text" id="item_txt" name="item_txt" value="${info.item_txt}"  style="width:80%;" maxlength="30"   /></td>
										<th scope="row"></th>
										<td></td>
									</tr>

								<c:if test="${!empty info.vendor_no}">
<!-- 									<tr class="division" style="height:50px;vertical-align:bottom;"> -->
<!-- 										<td colspan="4"><h3>직원정보</h3> -->
<!-- 											<div class="min_btn" style="float:right;margin-top:-25px;padding-right:20px;"> -->
<!-- 												<button type="button" class="sky" id="addUserBtn">추가</button> -->
<%-- 												<c:if test="${empty info.vendor_no}"></c:if> --%>
<!-- 												<button type="button" class="gray" id="delUserBtn">삭제</button> -->
<!-- 											</div> -->
<!-- 										</td> -->
<!-- 									</tr> -->
<!-- 									<tr> -->
<!-- 										<td colspan="4"> -->
<!-- 										<div class="grid" min="450" style="padding-left:0px;"> -->
<!-- 											<table id="memberList"></table>					 -->
<!-- 										</div> -->
<!-- 										</td> -->
<!-- 									</tr> -->
									
<!-- 									<tr class="division" style="height:50px;vertical-align:bottom;"> -->
<!-- 										<td colspan="4"><h3>sns정보</h3> -->
<!-- 											<div class="min_btn" style="float:right;margin-top:-25px;padding-right:20px;"> -->
<!-- 												<button type="button" class="sky" id="addSnsBtn">추가</button> -->
<%-- 												<c:if test="${empty info.vendor_no}"></c:if> --%>
<!-- 												<button type="button" class="gray" id="delSnsrBtn">삭제</button> -->
<!-- 											</div> -->
<!-- 										</td> -->
<!-- 									</tr> -->
<!-- 									<tr> -->
<!-- 										<td colspan="4"> -->
<!-- 										<div class="grid" min="450" style="padding-left:0px;"> -->
<!-- 											<table id="snsList"></table>					 -->
<!-- 										</div> -->
<!-- 										</td> -->
<!-- 									</tr> -->
								</c:if>

									
								</tbody>
							</table>
						</fieldset>
					</form>
									
					<form id="rForm" name="rForm" method="post" action="#">
					<input type="hidden" id="code" name="code" />
					</form>
					
				</div>
			</div>
		</div>
		<!-- // .ly_body -->
	
	</div>




	<div class="lypopWrap" style="width:92%; display:none;" id="selectBusinessTypeLayerPop" >
		<!-- header -->
		<div class="header">
			<h3>업태/업종 선택</h3>
			<p class="btnR">
				<a href="#" class="gray" onclick="$('#selectBusinessTypeLayerPop').hide();">닫기</a>
			</p>
		</div>

		<div class="contents">
			<!-- 본문 -->
			<form method="post" action="" id="select_item_form">
				<fieldset>
					<legend>업태/업종 선택</legend>
					<div class="lypop_tbl_wrap infoadd">

					<table cellspacing="0" cellpadding="0" summary="" class="lypop_tbl">
					<caption>업태/업종 선택</caption>
						<colgroup>
							<col width="35%" />
							<col width="65%" />
						</colgroup>
						<tbody>
							<tr>
								<th class="skyblue">업태선택</th>
								<td class="skyblue b">업종선택</td>
							</tr>
							<tr>
								<th>
									<div id="div_business_type_txt" style="height:480px;">
										<ul>
										<c:forEach var="info" items="${businessKindList}">
											<li code="<c:out value="${info.code}"/>"><c:out value="${info.code_nm}"/></li>
										</c:forEach>
										</ul>
									</div>
								</th>
								<td>
									<div id="div_business_txt" style="height:480px;">
										<ul>
										</ul>
									</div>
								</td>
							</tr>
						</tbody>
					</table>

					
					</div>
				</fieldset>
			</form>
			<!-- //본문 -->
		</div>


	</div>



	
	<div class="lypopWrap" style="width:92%; display:none;" id="selectItemLayerPop" >
		<!-- header -->
		<div class="header">
			<h3>품목 선택</h3>
			<p class="btnR">
				<a href="#" class="gray" onclick="$('#selectItemLayerPop').hide();">닫기</a>
			</p>
		</div>
		<!-- //header -->
		<!-- contents -->
		<div class="contents">
			<!-- 본문 -->
			<form method="post" action="" id="select_item_form">
				<fieldset>
					<legend>품목선택</legend>
					<div class="lypop_tbl_wrap infoadd">
					
					
					
					
					<table cellspacing="0" cellpadding="0" summary="" class="lypop_tbl">
					<caption>품목선택</caption>
						<colgroup>
							<col width="10%" />
							<col width="9%" />
							<col width="9%" />
							<col width="9%" />
							<col width="9%" />
							<col width="9%" />
							<col width="9%" />
							<col width="9%" />
							<col width="9%" />
							<col width="9%" />
							<col width="9%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">&nbsp;</th>
								<td>0</td>
								<td>1</td>
								<td>2</td>
								<td>3</td>
								<td>4</td>
								<td>5</td>
								<td>6</td>
								<td>7</td>
								<td>8</td>
								<td>9</td>
							</tr>
							<tr>
								<th scope="row">0</th>
								<td></td>
								<td>산 동물</td>
								<td>육과 식용설육</td>
								<td>어류</td>
								<td>낙동품</td>
								<td>기타 동물성 생산품</td>
								<td>산 수목및 절화</td>
								<td>채소</td>
								<td>과실/견과류</td>
								<td>커피/향신료</td>
							</tr>
							<tr>
								<th scope="row">10</th>
								<td>곡물</td>
								<td>제분공업 생산품</td>
								<td>채유용종자</td>
								<td>식물성 수액과 액스</td>
								<td>기타 식물성 유지</td>
								<td>동/실물성 유지</td>
								<td>유/어류 조제품</td>
								<td>당류 설탕과자</td>
								<td>코코아</td>
								<td>곡물/곡분의 조제품</td>
							</tr>
							<tr>
								<th scope="row">20</th>
								<td>채소/과실의 조제품</td>
								<td>각종의 조제 식료품</td>
								<td>음료/알코올 식초</td>
								<td>사료</td>
								<td>담배</td>
								<td>암석광물</td>
								<td>금속광물</td>
								<td>광물성 연료 에너지</td>
								<td>무기화학품</td>
								<td>유기화학품</td>
							</tr>
							<tr>
								<th scope="row">30</th>
								<td>의료용품</td>
								<td>비료</td>
								<td>유연/착색제</td>
								<td>향료/화장품</td>
								<td>비누/왁스</td>
								<td>단백질계 물질</td>
								<td>화약류/성냥</td>
								<td>사진/영화용 재료</td>
								<td>각종 화학공엄생산품</td>
								<td>플라스틱</td>
							</tr>
							<tr>
								<th scope="row">40</th>
								<td>고무</td>
								<td>원피</td>
								<td>가죽제품</td>
								<td>모피</td>
								<td>목재 및 목탄</td>
								<td>코르크</td>
								<td>조물재료의 제품</td>
								<td>펄프</td>
								<td>지와 지제품</td>
								<td>인쇄서적/신문/회화</td>
							</tr>
							<tr>
								<th scope="row">50</th>
								<td>견</td>
								<td>모</td>
								<td>면</td>
								<td>기타 식물성 방직용 섬유</td>
								<td>인조 필라멘트</td>
								<td>인조스테이플 섬유</td>
								<td>워딩/펄프/부직포</td>
								<td>양탄자류</td>
								<td>특수직물</td>
								<td>침투/도포 직물</td>
							</tr>
							<tr>
								<th scope="row">60</th>
								<td>편물</td>
								<td>편물제 의류</td>
								<td>비편물제 의류</td>
								<td>기타 방직용 섬유제품</td>
								<td>신발류</td>
								<td>모자류</td>
								<td>산류/지팡이</td>
								<td>조제 우모/조화/인모제품</td>
								<td>석/시멘트 제품</td>
								<td>도자 제품</td>
							</tr>
							<tr>
								<th scope="row">70</th>
								<td>유리와 유리제품</td>
								<td>진주/귀석 귀금속</td>
								<td>철강</td>
								<td>철강제품</td>
								<td>동</td>
								<td>니켈</td>
								<td>알루미늄</td>
								<td>유보</td>
								<td>연</td>
								<td>아연</td>
							</tr>
							<tr>
								<th scope="row">80</th>
								<td>주석</td>
								<td>기타 비금속</td>
								<td>비금속에의 공구</td>
								<td>비금속제의 각종 제품</td>
								<td>기계류</td>
								<td>전기기기</td>
								<td>철도차량</td>
								<td>자동차</td>
								<td>항공기</td>
								<td>선박</td>
							</tr>
							<tr>
								<th scope="row">90</th>
								<td>광학/정밀의료기기</td>
								<td>시계</td>
								<td>악기</td>
								<td>무기</td>
								<td>가구/침구 조립식건축</td>
								<td>완구/운동용구</td>
								<td>잡품</td>
								<td>예술품/수집과 골동품</td>
								<td></td>
								<td></td>
							</tr>	

						</tbody>
					</table>
					

					

		
					
					
					
					</div>
				</fieldset>
			</form>
			<!-- //본문 -->
		</div>
		<!-- //contents -->
	</div>
	
	
	

 <div id="toast"></div></body>

</html>