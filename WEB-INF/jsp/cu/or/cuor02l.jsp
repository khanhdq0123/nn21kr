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
			var url = "/order/orderRegCForm";
			var ord_typ = $("#ord_typ").val();
			var inout_typ = $("#inout_typ").val();
			
			url += ord_typ;
			url += "?inout_typ=" + inout_typ;
			
			CenterOpenWindow(url, '운송접수 등록', '1280','1024', 'scrollbars=no, status=yes');
		});
		
		
		
		$("input[name=s_ord_typ]").on("click",function(){
			$('#searchForm').submit();
		});
		
		
// 		$("#btnNew2").click( function() {
// 			CenterOpenWindow('/order/orderRegCForm2', '보관접수 등록', '1280','1024', 'scrollbars=no, status=yes');
// 		});
// 		$("#btnNew3").click( function() {
// 			CenterOpenWindow('/order/orderRegCForm3', '견적접수 등록', '1280','1024', 'scrollbars=no, status=yes');
// 		});
// 		$("#btnNew4").click( function() {
// 			CenterOpenWindow('/order/orderRegCForm4', '원산지접수 등록', '1280','1024', 'scrollbars=no, status=yes');
// 		});
// 		$("#btnNew5").click( function() {
// 			CenterOpenWindow('/order/orderRegCForm5', '통관접수 등록', '1280','1024', 'scrollbars=no, status=yes');
// 		});
		
		
		
		
		// 그리드 - 프로토타입 
		jQuery('#list1').jqGrid({
			url: '/order/orderListJson',
			datatype: 'local',
		   	colNames: ['route_no','Date', 'Sort',	'Booking Summary', 'Company Name', 'Consignee', 'Item', 'CT', 'Kg', 'CBM'],
			colModel: [
	            { name: 'route_no', index: 'route_no', align: 'center', sortable: true, width: '70' ,hidden:true},
	            { name: 'reg_dt', index: 'reg_dt', align: 'center', sortable: true, width: '64'},
	            { name: 'ord_typ_nm', index: 'ord_typ_nm', align: 'center', sortable: true, width: '100'},
	            
	            { name: 'booking_summary', index: 'booking_summary', align: 'left', formatter : linkFormatter, sortable: true, width: '300'},
	            { name: 'send_nm', index: 'send_nm', align: 'center',  sortable: true, width: '200'},
	            { name: 'receive_nm', index: 'receive_nm', align: 'center',  sortable: true, width: '200'},
	            
	            { name: 'item_nm', index: 'item_nm', align: 'left', sortable: true, width: '150',},
	            { name: 'box_qty', index: 'box_qty', align: 'left', sortable: true, width: '60'},
	            { name: 'kg', index: 'kg', align: 'left', sortable: true, width: '60'},
	            { name: 'cbm', index: 'cbm', align: 'left', sortable: true, width: '60'}
			],
			autowidth: true,
			height: 500,
// 			pager: '#pager1',
// 			rowNum: 20,
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
		
	
		$('#searchForm').submit();
		
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
				
		if(rowObj['transport_way_nm'] != null) linkURL = rowObj['transport_way_nm'];
		
		
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
	

	$(document).ready(function(){
		
		$(".ctn-tabmenu-wrap .ctn-tabmenu_list").on("click",function(){
			
			var i = $(this).index();  		
			
			var ord_typ = $(this).attr("data-ord-typ");
			$("#s_ord_typ").val(ord_typ);
			$('#searchForm').submit();
			
			$(this).addClass("active").siblings().removeClass("active");
			$(".tapcont-wrap .tapcont").hide();
			$(".tapcont-wrap .tapcont").eq(i).show();
			
		});
		
		$(".report .bullet6 input[type=button]").on("click",function(){
			
			var i = $(this).index();  		

// 			var ord_typ = $(this).attr("data-ord-typ");
// 			$("#s_ord_typ").val(ord_typ);
// 			$('#searchForm').submit();
			
			$(this).addClass("btn-primary").siblings().removeClass("btn-primary");
			$(this).removeClass("btn-close").siblings().addClass("btn-close");

			
		});
		
		
		$("#btnExcelDownload").click( function(){

			var downUrl = "/order/order/orderListExcel.do?"
				+ $("#searchForm").serialize()
				+ "&page=" + $('#list1').getGridParam('page')
				+ "&rows=" + $('#list1').getGridParam('rowNum');
			
			$.fileDownload(downUrl)
		 		.done(function() { toast('파일 다운로드에 성공하였습니다.')})
		 		.fail(function() { toast('파일 다운로드에 실패하였습니다.')});
		});
		
		
	});
	
</script>


</head>
<body class="sky">


    
<form method="get" id="searchForm">

	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">거래현황</h3>
			<h3 class="screen-id">cuco02l</h3>
			<span class="bullet6">거래 관리 &gt; 거래현황</span>
		</div>


		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<section>
				<div class="radio-group">
	                <div class="option"><input type="radio" id="rd_ord_typ"  name="s_ord_typ" value=""><label class="radio-container" for="rd_ord_typ">전체</label></div>
	                <div class="option"><input type="radio" id="rd_ord_typ1" name="s_ord_typ" value="1" checked="checked"><label class="radio-container" for="rd_ord_typ1">운송</label></div>
	                <div class="option"><input type="radio" id="rd_ord_typ2" name="s_ord_typ" value="2"><label class="radio-container" for="rd_ord_typ2">보관</label></div>
	                <div class="option"><input type="radio" id="rd_ord_typ3" name="s_ord_typ" value="3"><label class="radio-container" for="rd_ord_typ3">견적</label></div>
	                <div class="option"><input type="radio" id="rd_ord_typ4" name="s_ord_typ" value="4"><label class="radio-container" for="rd_ord_typ4">원산지</label></div>
	                <div class="option"><input type="radio" id="rd_ord_typ5" name="s_ord_typ" value="5"><label class="radio-container" for="rd_ord_typ5">통관</label></div>
	            </div>
	
				<div class="radio-group ml20">
	                <div class="option"><input type="radio" id="rd_inout_typ1" name="s_inout_typ" value="1" checked=""><label class="radio-container" for="rd_inout_typ1">수입</label></div>
	                <div class="option"><input type="radio" id="rd_inout_typ2" name="s_inout_typ" value="2"><label class="radio-container" for="rd_inout_typ2">수출</label></div>
	            </div>
			
			</section>
			
			<div class="report">
				<div class="bullet6"></div>
				<div class="min_btn">
					<select style="width:100px;" id="ord_typ" name="ord_typ">
						<option value="1">운송접수</option>
	                    <option value="2">보관접수</option>
	                    <option value="3">견적접수</option>
	                    <option value="4">원산지접수</option>
	                    <option value="5">통관접수</option>
                    </select>
                    <select style="width:100px; margin-right:10px;" id="inout_typ" name="inout_typ">
						<option value="1">수출</option>
	                    <option value="2">수입</option>
                    </select>
					<input type="button" class="btn btn-primary btn-sm" value="접수신청" id="btnNew">
					<input type="button" class="btn btn-success btn-sm" value="엑셀 다운로드" id="btnExcelDownload">
				</div>
			</div>
		

		
			<!-- grid -->
			<div class="grid">
				<table id="list1"></table>
			</div>
			<!-- grid end -->	


		</div>
		<!-- //product_admin -->
	</div>
	<!-- //content_wrap -->
	
</form>	
<div id="toast"></div></body>
</html>
