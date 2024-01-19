
	$(document).ready(function() {

		// 그리드 - 프로토타입 
		jQuery('#list1').jqGrid({
			url: '/ve/or/VEOR02/search',
			datatype: 'local',
		   	colNames: ['ord_no','Storced','Destination', 'Start', 'Arrival', '운송', '고객', 'count', 'Kg', 'CBM'
			],
			colModel: [
	            { name: 'ord_no', 		index: 'route_no', 			align: 'center', 	sortable: true, width: '70', hidden:true},
	            { name: 'reg_dt', 			index: 'receive_dt', 			align: 'center', 	sortable: true, width: '50', formatter: "date", formatoptions: { newformat: " m/d" }},
	            { name: 'receive_region_nm', 			index: 'receive_region_nm', 			align: 'center', 	sortable: true, width: '80'},
	            { name: 'start_dt', 			index: 'start_dt', 			align: 'center', 	sortable: true, width: '90', formatter: "date", formatoptions: { newformat: " Y/m/d" }},
	            { name: 'arrive_dt', 		index: 'arrive_dt', 		align: 'center', 	sortable: true, width: '90', formatter: "date", formatoptions: { newformat: " Y/m/d" }},
	            { name: 'transport_way_nm',	index: 'transport_way_nm',	align: 'center',	sortable: true, width: '120'},
	            { name: 'shipment_dt', 	index: 'shipment_dt', 	align: 'left',		sortable: true, width: '400', formatter : linkFormatter},
	            { name: 'box_qty', 			index: 'box_qty', 			align: 'right', 	sortable: true, width: '60', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}},
	            { name: 'kg', 				index: 'kg', 				align: 'right', 	sortable: true, width: '60', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}},
	            { name: 'cbm', 				index: 'cbm', 				align: 'right', 	sortable: true, width: '60', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}},
//	            { name: 'p', 				index: 'p', 				align: 'right', 	sortable: true, width: '60'},
//	            { name: 'mc', 				index: 'mc', 				align: 'right', 	sortable: true, width: '60'}
			],
			autowidth: true,
			height: 500,
//			pager: '#pager1',
//			rowNum: 20,
//			rowList: [20, 50, 100, 1000],
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
		
		
		
		$("#searchForm").on("change",function (){
			$('#list1').clearGridData();
			$("#searchForm").submit();
		});
	
		fn_f3();	//로딩시 호출	
	
	});
	
	
	
	
    
	// jqGrid Navigator
	//jQuery('#list1').jqGrid('navGrid','#pager1',{search:false, edit:false, add:false, del:false, refresh:false});

	// Link 처리
	function linkFormatter(cellVal, options, rowObj) {
		var linkURL = '';
 		linkURL += '<a href="javascript:CenterOpenWindow(\'/ve/or/VEOR02/popup' + '?ord_no=' + rowObj['ord_no'] + '\', \'open\', \'1280\', \'760\', \'scrollbars=yes, status=no\');">';
				
		//if(rowObj['transport_way_nm'] != null) linkURL += rowObj['transport_way_nm'];
		//linkURL += '      ' + rowObj['start_dt'].substr(5,5) + '(' + rowObj['send_region_nm'] + ')';
		//linkURL += ' ~ ' + rowObj['arrive_dt'].substr(5,5) + '(' + rowObj['receive_region_nm'] + ')';
		linkURL += rowObj['send_cd'] + ' ~ ' + rowObj['receive_cd'] + '   ';
		linkURL += rowObj['send_nm'] + ' ~ ' + rowObj['receive_nm'];
		linkURL += '</a>';
				
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

	
	//조회
	function fn_f3(){
		$('#list1').clearGridData();
		$("#searchForm").submit();
	}
	
	//신규등록
	function fn_f9(){
		//var url = "/order/orderRegForm";
		var url = "/ve/or/VEOR02/popup";
		var ord_typ = $("#ord_typ").val();
		var inout_typ = $("#inout_typ").val();
		
		url += ord_typ;
		url += "?inout_typ=" + inout_typ;
		
		CenterOpenWindow(url, '접수 등록', '1280','1024', 'scrollbars=yes, status=no');
	}
	
	
	