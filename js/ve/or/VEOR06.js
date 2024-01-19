
	$(document).ready(function() {

		// 그리드 - 프로토타입 
		jQuery('#list1').jqGrid({
			url: '/ve/or/VEOR06/search',
			datatype: 'local',
		   	colNames: ['route_no','Date', 'Sort',	'Booking Summary', 'Customer No & Company Name', 'Item', 'CT', 'Kg', 'CBM'
			],
			colModel: [
	            { name: 'route_no', 		index: 'route_no', 			align: 'center', 	sortable: true, width: '70', hidden:true},
	            { name: 'reg_dt', 			index: 'reg_dt', 			align: 'center', 	sortable: true, width: '85', cellattr: catMerge},
	            { name: 'ord_typ_nm', 		index: 'ord_typ_nm', 		align: 'center', 	sortable: true, width: '100'},
	            { name: 'booking_summary', 	index: 'booking_summary', 	align: 'left',		sortable: true, width: '300', formatter : linkFormatter},
	            { name: 'customer_company',	index: 'customer_company',	align: 'center',	sortable: true, width: '350', formatter : linkFormatter2},
	            { name: 'item_nm', 			index: 'item_nm', 			align: 'left', 		sortable: true, width: '150'},
	            { name: 'box_qty', 			index: 'box_qty', 			align: 'right', 	sortable: true, width: '60'},
	            { name: 'kg', 				index: 'kg', 				align: 'right', 	sortable: true, width: '60'},
	            { name: 'cbm', 				index: 'cbm', 				align: 'right', 	sortable: true, width: '60'}
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
			gridComplete: function() {  // 그리드 생성 후 호출되는 이벤트
			    var grid = this;
			    $('td[rowspan="1"]', grid).each(function () {
					var spans = $('td[rowspanid="' + this.id + '"]', grid).length + 1;
			      	if (spans > 1) {
			        	$(this).attr('rowspan', spans);
			      	}
			    });
		  	},
//			onPaging: function(btn) {
//				if($('#'+btn).hasClass('ui-state-disabled')) {
//					return 'stop';
//				} else { 
//					$('#list1').jqGrid('clearGridData').jqGrid('setGridParam',{ datatype:'json' });
//					return true;
//				}
//			},
			loadError: function(xhr,st,err) {
				girdLoadError();
		    },
		    postData: serializeObject($('#searchForm'))
		});
		
		var prevCellVal = { cellId: undefined, value: undefined };	//이전셀의 값

		function catMerge(rowId, val, rowObject, cm, rdata){			

			var result;
			if (prevCellVal.value == val) {
				result = ' style="display: none" rowspanid="' + prevCellVal.cellId + '"';
			} else {
				var cellId = this.id + '_row_' + rowId + '_' + cm.name;
				result = ' rowspan="1" id="' + cellId + '"';
				prevCellVal = { cellId: cellId, value: val };
			}
			
			return result;
		};

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
 		linkURL += '<a href="javascript:CenterOpenWindow(\'/ve/or/VEOR06/popup' + '?ord_no=' + rowObj['ord_no'] + '\', \'open\', \'1280\', \'780\', \'scrollbars=yes, status=no\');">';
				
		if(rowObj['transport_way_nm'] != null) linkURL += rowObj['transport_way_nm'];
		
		linkURL += '      ' + rowObj['start_dt'].substr(5,5) + '(' + rowObj['send_region_nm'] + ')';
		linkURL += ' ~ ' + rowObj['arrive_dt'].substr(5,5) + '(' + rowObj['receive_region_nm'] + ')';
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
	

	
	
	