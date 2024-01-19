<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript">

	var vendor_no = '${info.vendor_no}';
	var vendor_nm = '${info.vendor_nm}';
	var idCheckFlag = 1;
	var selectedItem = '';		//선택된 품목
	var selectedBusiness = '';	//선택된 업종
	var staff_typ = "${sessionScope['STAFFINFORMATION']['staff_typ']}";

	$(document).ready(function() {


	    jQuery("#memberList").jqGrid({
	  		url:'/system/staff/staffListJson',
	  		datatype: "local",				   
	  		colNames:['staff_id','담당업무', '직책', '성명', '아이디', '핸드폰','E-Mail'],
	  		colModel:[
				{name:'staff_id'	, index:'staff_id', 	width:90, hidden:true},
	  			{name:'job_nm'		, index:'job_nm', 		width:50, align:"left", sortable:true, editable:false},
	  			{name:'position_nm'	, index:'position_nm', 	width:40, align:"left", sortable:true, editable:false},
	  			{name:'staff_nm'	, index:'staff_nm', 	width:50, align:"left", sortable:true, editable:false},
	  			{name:'login_id'	, index:'login_id', 	width:90, align:"left", sortable:true, editable:false},
	  			{name:'mobile_txt'	, index:'mobile_txt', 	width:90, align:"left", sortable:true, editable:false},
	  			{name:'email_txt'	, index:'email_txt', 	width:120, align:"left", sortable:true, editable:false},
	  		],
	  		mtype:"get",
	  		autowidth: true,	// 부모 객체의 width를 따른다
	  		height: 140,
	  		sortname: 'groupauth_id',
	  	    viewrecords: true,
// 	  	    multiselect : true,
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
	    
	    jQuery("#orderList").jqGrid({
	  		url:'/order/orderListJson',
	  		datatype: "local",				   
	  		colNames:['ord_no','기간', '회사', 'CT'],
	  		colModel:[
				{name:'ord_no'	, index:'ord_no', 	width:90, hidden:true},
	            { name: 'booking_summary', 	index: 'booking_summary', 	align: 'left',		sortable: true, width: '300', formatter : linkFormatter},
	            { name: 'customer_company',	index: 'customer_company',	align: 'center',	sortable: true, width: '350', formatter : linkFormatter2},
	  			{name:'box_qty'	, index:'box_qty', 	width:60, align:"left", sortable:true, editable:false},
	  		],
	  		mtype:"get",
	  		autowidth: true,	// 부모 객체의 width를 따른다
	  		height: 200,
	  		sortname: 'groupauth_id',
	  	    viewrecords: true,
// 	  	    multiselect : true,
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

	    
	    $("#orderList").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
	    
	    
	    jQuery("#partnerList").jqGrid({
	  		url:'/partner/partnerListJson',
	  		datatype: "local",				   
	  		colNames:['vendor_no','구분', '코드', '회사명'],
	  		colModel:[
				{name:'vendor_no'	, index:'vendor_no', 	width:90, hidden:true},
				{name:'vendor_typ_nm'	, index:'vendor_typ_nm', 	width:60, align:"left", sortable:true, editable:false},
				{name:'vendor_no'	, index:'vendor_no', 	width:60, align:"left", sortable:true, editable:false},
				{name:'vendor_nm'	, index:'vendor_nm', 	width:280, align:"left", sortable:true, editable:false},
	  		],
	  		mtype:"get",
	  		autowidth: true,	// 부모 객체의 width를 따른다
	  		height: 200,
	  		sortname: 'groupauth_id',
	  	    viewrecords: true,
// 	  	    multiselect : true,
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

	    
	    $("#partnerList").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
	    
	    
	    jQuery("#customerList5").jqGrid({
	  		url:'/partner/customerListJson',
	  		datatype: "local",				   
	  		colNames:['vendor_no','코드', '창고명'],
	  		colModel:[
				{name:'vendor_no'	, index:'vendor_no', 	width:90, hidden:true},
				{name:'vendor_no'	, index:'vendor_no', 	width:60, align:"left", sortable:true, editable:false},
				{name:'vendor_nm'	, index:'vendor_nm', 	width:280, align:"left", sortable:true, editable:false},
	  		],
	  		mtype:"get",
	  		autowidth: true,	// 부모 객체의 width를 따른다
	  		height: 200,
	  		sortname: 'groupauth_id',
	  	    viewrecords: true,
// 	  	    multiselect : true,
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
				vendor_no:$("#vendor_no").val(),
				vendor_typ:'5',
				additionalParam:'dummy'
			},
	  	   
	  	    // cell이 변경되었을 경우 처리
	  	    afterSaveCell : function(id, name, val, iRow, iCol) {
	  	    	//checkWhenColumnUpdated("regionGrid", id);
	  	    },
	  	    //스크롤바 자동 생성
	  	    shrinkToFit:true			    
	  	});

	    
	    $("#customerList5").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
	    
	    
	    
	    
	    $("#btnCompModify").on("click", function(){
			CenterOpenWindow('/partner/partnerListPop.do?vendor_no=' + vendor_no, '수신인 선택', '1280','800', 'scrollbars=no, status=yes');
	    });
	    
	});
		
	function linkFormatter(cellVal, options, rowObj) {
		var linkURL = '';
 		linkURL += '<a href="javascript:CenterOpenWindow(\'/cu/or/CUOR01/popup' + '?ord_no=' + rowObj['ord_no'] + '&vendor_no=' + vendor_no + '\', \'open\', \'1280\', \'780\', \'scrollbars=yes, status=no\');">';
				
		if(rowObj['transport_way_nm'] != null) linkURL += rowObj['transport_way_nm'];
		
		linkURL += '      ' + rowObj['start_dt'].substr(5,5) + '(' + rowObj['send_region_nm'] + ')';
		linkURL += ' ~ ' + rowObj['arrive_dt'].substr(5,5) + '(' + rowObj['receive_region_nm'] + ')';
		linkURL += '</a>';
				
		return linkURL;
	}
	
	function linkFormatter2(cellVal, options, rowObj) {
		var linkURL = '';
		
		linkURL = rowObj['send_nm'];
		linkURL += ' ~ ' + rowObj['receive_nm'];
				
		return linkURL;
	}
	
	</script>
	
		<c:set var="staff_typ" value="${sessionScope['STAFFINFORMATION']['staff_typ']}" />
	
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="/js/partnerListPop.js"></script>

<style>

.on {background-color:#fcf340; font-weight:bold;}

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
	


	<div class="layerpop_inner"  id="partnerPop">
	
		<h1 class="ly_header">고객 상세</h1>
		<!-- .ly_body -->
		<div class="ly_body">
			<div class="refer bullet6">
				<ul class="type1">
<!-- 					<li>정보를 입력 하시고 반드시 저장버튼을 클릭하셔야 정상 등록 됩니다.</li> -->
				</ul>
				<div class="refer_bt" >
					<div class="min_btn mini">						
						<input type="button" class="btn btn-info btn-sm" value="접수하기" 	id="btnOrdReg">	
						<input type="button" class="btn btn-primary btn-sm" value="회사정보수정" id="btnCompModify">	
						<input type="button" class="btn btn-close btn-sm" 	value="닫기" 	id="btnClose">
					</div>
				</div>
			</div>
			
			
			<div class="tagCover">
					<form method="post" id="partnerForm" name="partnerForm">
						<input type="hidden" id="vendor_no" 	name="vendor_no" 		value="${info.vendor_no}" />
						<input type="hidden" id="charge_yn" 	name="charge_yn" 		value="${info.charge_yn}" />
						<input type="hidden"	id="vendor_cd"	name="vendor_cd"	value="" />
						<input type="hidden" id="vendor_typ" 	name="vendor_typ" 		value="3" />
					</form>

				<div class="typeleft qnaWlist">
				
				<h3 class="mb5">최근 요청</h3>
				<div class="grid" min="450" style="padding-left:0px;">
					<table id="orderList"></table>					
				</div>

				<h3 class="mt20 mb5">관련 회사</h3>
				<div class="grid" min="450" style="padding-left:0px;">
					<table id="partnerList"></table>					
				</div>
				
				<h3 class="mt20 mb5">창고</h3>
				<div class="grid" min="450" style="padding-left:0px;">
					<table id="customerList5"></table>					
				</div>

					
				</div>
				
				
				
				
				<div class="typeright qnaWlist">
				
					<h3 class="styleH3">회사 정보</h3>
	
					<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl" style="border-top: 0px;">
					<caption>${pTitle} 정보</caption>
						<colgroup>
							<col width="100px" />
							<col width="150px" />
							<col width="100px" />
							<col width="150px" />
						</colgroup>
						<tbody>							
							<tr>
								<th scope="row"><label>고객번호</label></th>
								<td colspan="3" class="b">${info.vendor_cd}</td>
							</tr>
							
							<tr>
								<th scope="row">상호명(영문)</th>
								<td>${info.vendor_nm_eng}</td>
								<th scope="row"><label>전화</label></th>
								<td>${info.tel_txt}</td>
							</tr>
							<tr>
								<th scope="row"><label>상호명(자국어)</label></th>
								<td>${info.vendor_nm}</td>
								<th scope="row"><label>팩스</label></th>
								<td>${info.fax_txt}</td>
							</tr>
							<tr>
								<th scope="row"><label>홈페이지</label></th>
								<td>${info.homepage_url}</td>
								<th scope="row"><label>메일</label></th>
								<td>${info.email_txt}</td>
							</tr>

							<tr>
								<th scope="row"><label for="desc_addr_txt">사업장주소(영문)</label></th>
								<td colspan="3">				
									${info.basadd_txt} ${info.dtladd_txt}
								</td>
							</tr>
							
							<tr>
								<th scope="row"><label for="desc_addr_txt">사업장주소(자국어)</label></th>
								<td colspan="3">	
									${info.road_basadd_txt} ${info.road_dtladd_txt}
								</td>
							</tr>


							<tr>
								<th scope="row"><label for="business_type_txt">업태</label></th>
								<td colspan="3">${info.business_type_txt}</td>
							</tr>
							
							<tr>
								<th scope="row"><label for="business_txt">업종</label></th>
								<td colspan="3">${info.business_txt}</td>
							</tr>

							<tr>
								<th scope="row"><label for="business_txt">품목</label></th>
								<td colspan="3">${info.item_txt}</td>
							</tr>
							
							



							<tr class="division" style="height:50px;vertical-align:bottom;">
								<td colspan="4"><h3>직원정보</h3>
									<div class="min_btn" style="float:right;margin-top:-25px;padding-right:20px;">
										
<!-- 										<input type="button" class="btn btn-primary btn-xs" id="addUserBtn" value="사용자 추가"> -->
<!-- 										<input type="button" class="btn btn-danger btn-xs" id="delUserBtn" value="삭제"> -->

									</div>
								</td>
							</tr>
							<tr>
								<td colspan="4">
								<div class="grid" min="450" style="padding-left:0px;">
									<table id="memberList"></table>					
								</div>
								</td>
							</tr>
							



							
						</tbody>
					</table>
					
				</div>
			</div>					
			

		</div>
		<!-- // .ly_body -->
	
	</div>






 <div id="toast"></div></body>

</html>