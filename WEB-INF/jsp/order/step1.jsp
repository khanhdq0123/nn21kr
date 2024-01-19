<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<%@include file="/common/include/header.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		
		$("#spnSetReg button").click(function() {
			var when = '';
			if (this.id == 'btnRegSetToday') when = 'today';
			if (this.id == 'btnRegSetWeekago') when = 'weekago';
			if (this.id == 'btnRegSetMonthago') when = 'monthago';
			setSearchDate('search_start_dt', 'search_end_dt', when);
		});
		
		
		$("#btnNew").click( function() {
			CenterOpenWindow('/order/orderRegForm', '운송접수 등록', '1280','1024', 'scrollbars=no, status=yes');
		});
		$("#btnNew2").click( function() {
			CenterOpenWindow('/order/orderRegForm2', '보관접수 등록', '1280','1024', 'scrollbars=no, status=yes');
		});
		$("#btnNew3").click( function() {
			CenterOpenWindow('/order/orderRegForm3', '견적접수 등록', '1280','1024', 'scrollbars=no, status=yes');
		});
		$("#btnNew4").click( function() {
			CenterOpenWindow('/order/orderRegForm4', '원산지접수 등록', '1280','1024', 'scrollbars=no, status=yes');
		});
		$("#btnNew5").click( function() {
			CenterOpenWindow('/order/orderRegForm5', '통관접수 등록', '1280','1024', 'scrollbars=no, status=yes');
		});
		
		
		
		
		// 그리드 - 프로토타입 
		jQuery('#list1').jqGrid({
			url: '/order/orderListJson',
			datatype: 'local',
		   	colNames: ['route_no','Date', 'Sort',	'Booking Summary', 'Customer No & Company Name', 'Item', 'CT', 'Kg', 'CBM'
			],
			colModel: [
	            { name: 'route_no', index: 'route_no', align: 'center', sortable: true, width: '70' ,hidden:true},
	            { name: 'reg_dt', index: 'reg_dt', align: 'center', sortable: true, width: '64'},
	            { name: 'ord_typ_nm', index: 'ord_typ_nm', align: 'center', sortable: true, width: '100'},
	            
	            { name: 'booking_summary', index: 'booking_summary', align: 'left', formatter : linkFormatter, sortable: true, width: '300'},
	            { name: 'customer_company', index: 'customer_company', align: 'center', formatter : linkFormatter2, sortable: true, width: '350'},
	            
	            { name: 'item_nm', index: 'item_nm', align: 'left', sortable: true, width: '150',},
	            { name: 'box_qty', index: 'box_qty', align: 'left', sortable: true, width: '60'},
	            { name: 'kg', index: 'kg', align: 'left', sortable: true, width: '60'},
	            { name: 'cbm', index: 'cbm', align: 'left', sortable: true, width: '60'}
			],
			autowidth: true,
			height: 500,
			pager: '#pager1',
			rowNum: 500,
// 			rowList: [20, 50, 100, 1000],
			mtype: 'post',
			viewrecords: true,
			loadComplete: function(data) {
				setSortingGridData(this, data);
			}, 
			onPaging: function(btn) {
				if($('#'+btn).hasClass('ui-state-disabled')) {
					return 'stop';
				} else { 
					$('#list1').jqGrid('clearGridData').jqGrid('setGridParam',{ datatype:'json' });
					return true;
				}
			},
			loadError: function(xhr,st,err) {
				girdLoadError();
		    },
		    postData: serializeObject($('#searchForm'))
		});
		
		
	
		
		// 검색 날짜 자동 채우기
		$('#spnSetReg button').click(function() {
			if (this.id == 'btnRegSetToday')
				setSearchDate('search_start_dt', 'search_end_dt', 'today');
			if (this.id == 'btnRegSetWeekago')
				setSearchDate('search_start_dt', 'search_end_dt', 'weekago');
			if (this.id == 'btnRegSetMonthago')
				setSearchDate('search_start_dt', 'search_end_dt', 'monthago');
		});
		
		// grid 검색
		$('#btnSearch').click(function() {
			$('#searchForm').submit();
		});
		
		// 초기화 버튼
		$('#btnReset').click(function() {
			$('#searchForm')[0].reset();
		});
		

		// jQuery validation
		$("#searchForm").validate({
			rules: {
				title_txt: {maxlength: 100},
				delay_time: {number: true},
				gl_user_id: {maxlength: 20},
				user_name: {maxlength: 30},
				search_start_dt: {dpDate: true},
				search_end_dt: {dpDate: true, dpCompareDate:{notBefore: '#search_start_dt'}}
			},
			messages: {
				title_txt: {maxlength: jQuery.format("제목은 최대 {0} 글자 이하로 입력하세요.")},
				delay_time: {number: '지연일은 숫자만 입력하세요.'},
				gl_user_id: {maxlength: jQuery.format('문의자 ID는 최대 {0} 글자 이하로 입력하세요.')},
				user_name: {maxlength: jQuery.format('문의자명은 최대 {0} 글자 이하로 입력하세요.')},
				search_start_dt: {dpDate: "등록일 검색 시작일자는 yyyy-mm-dd 형식으로 입력하세요."},
				search_end_dt: {dpDate: "등록일 검색 종료일자는 yyyy-mm-dd 형식으로 입력하세요.",
						dpCompareDate: "등록일 검색 종료일은 시작일보다 같거나 이후 일자를 선택하세요."}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
			},
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {
				$("#list1").setGridParam({
					page : 1,
					postData : serializeObject($('#searchForm')),
					datatype: 'json'
				});
				
				$("#list1").trigger("reloadGrid");
			}
		});
		
	
	});
	
	
	
	
    
	// jqGrid Navigator
	jQuery('#list1').jqGrid('navGrid','#pager1',{search:false, edit:false, add:false, del:false, refresh:false});

	// Link 처리
	function linkFormatter(cellVal, options, rowObj) {
		var linkURL = '';
// 		var linkURL = '<a href="javascript:CenterOpenWindow(\'/region/regionInfo' 
// 				+ '?id=' + rowObj['voc_id']
// 				+ '\', \'open\', \'800\', \'600\', \'scrollbars=yes, status=no\');">'
// 				+ cellVal + '</a>';
				
				
		linkURL = rowObj['transport_way_nm'];
		
		
		linkURL += '      ' + rowObj['start_dt'].substr(5,5) + '(' + rowObj['send_region_nm'] + ')';
		linkURL += ' ~ ' + rowObj['arrive_dt'].substr(5,5) + '(' + rowObj['receive_region_nm'] + ')';
		
		
				
		return linkURL;
	}
	
	function linkFormatter2(cellVal, options, rowObj) {
		var linkURL = '';
// 		var linkURL = '<a href="javascript:CenterOpenWindow(\'/region/regionInfo' 
// 				+ '?id=' + rowObj['voc_id']
// 				+ '\', \'open\', \'800\', \'600\', \'scrollbars=yes, status=no\');">'
// 				+ cellVal + '</a>';
				
				
// 		linkURL = rowObj['start_vendor_no'] + ' ' + rowObj['start_vendor_nm'];
// 		linkURL += ' ~ ' + rowObj['arrive_vendor_no'] + ' ' + rowObj['arrive_vendor_nm'];
		
		linkURL = rowObj['start_vendor_nm'];
		linkURL += ' ~ ' + rowObj['arrive_vendor_nm'];
				
		return linkURL;
	}
</script>

</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">발송예약/입고대기</h3>
			
			<span class="bullet6">접수관리 &gt; 발송예약/입고대기</span>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form method="get" id="searchForm">
					<fieldset>
						<legend>발송예약/입고대기</legend>
						<div class="product_tbl">
							<table cellspacing="0" cellpadding="0" class="tbl_type2 tbl_cell">
								<colgroup>
									<col width="100%" />
								</colgroup>
								<tbody>
									<tr>
										<td>
											<div class="tbl_wrap">

												<dl class="section">
													<dt>Shipper</dt>
													<dd>
														<input type="text" name="shipper_no" id="shipper_no" value="" style="width:90%;" />
													</dd>
													<dt>Consignee</dt>
													<dd>
														<input type="text" name="consignee_no" id="consignee_no" value="" style="width:90%;"  />
													</dd>
													
												</dl>

												<dl class="section">
													<dt>등록일</dt>
													<dd class="cols">
														<span class="calendar">
															<input type="text" maxlength="10" class="datepicker" id="search_start_dt" name="search_start_dt"/>
														</span>
														&nbsp;~&nbsp; 
														<span class="calendar">
															<input type="text" maxlength="10" class="datepicker" id="search_end_dt" name="search_end_dt"/>
														</span>
														
														<span id="spnSetReg">
															<button type="button" class="btn_c6" id="btnRegSetToday">오늘</button>
															<button type="button" class="btn_c6" id="btnRegSetWeekago">1주일</button>
															<button type="button" class="btn_c6" id="btnRegSetMonthago">1개월</button>
														</span>
													</dd>
												</dl>
											</div>
											<div class="tbl_wrap active mark"></div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</fieldset>
				</form>
			</div>
			

			<div class="product_bt">
				<button type="button" class="search" id="btnSearch">
					<span>검색</span>
				</button>
				<button type="button" class="reset" id="btnReset">
					<span>초기화</span>
				</button>
			</div>
			<div class="report">
				<div class="min_btn">
					<input type="button" class="btn btn-primary btn-sm" value="운송접수" id="btnNew">
					<input type="button" class="btn btn-primary btn-sm" value="보관접수" id="btnNew2">
					<input type="button" class="btn btn-primary btn-sm" value="견적접수" id="btnNew3">
					<input type="button" class="btn btn-primary btn-sm" value="원산지접수" id="btnNew4">
					<input type="button" class="btn btn-primary btn-sm" value="통관접수" id="btnNew5">
				</div>
			</div>
		
			<!-- grid -->
			<div class="grid">
				<table id="list1"></table>
				<div id="pager1"></div>			
			</div>
			<!-- grid end -->	


		</div>
		<!-- //product_admin -->
	</div>
	<!-- //content_wrap -->
<div id="toast"></div></body>
</html>
