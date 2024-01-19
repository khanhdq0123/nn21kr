var inout_typ;

	$(document).ready(function() {

		// 그리드 - 프로토타입 
		jQuery('#list1').jqGrid({
			url: '/cu/or/CUOR02/search',
			datatype: 'local',
		   	colNames: ['ord_no','접수구분', '운송일자', '운송노선', 'Company Name', 'Booking Summary', 'Box', 'Kg', 'CBM', '수입금액', '무역송금'],
			colModel: [
	            { name: 'ord_no', 			index: 'ord_no', 			align: 'center', 	sortable: true, width: '70', hidden:true},
	            { name: 'ord_typ_nm', 		index: 'ord_typ_nm', 		align: 'center', 	sortable: true, width: '85'},
	            { name: 'summary_info1', 	index: 'summary_info1', 	align: 'center',	sortable: true, width: '200', formatter : linkFormatter1},
	            { name: 'summary_info2',	index: 'summary_info2',		align: 'center',	sortable: true, width: '200', formatter : linkFormatter2},
	            { name: 'summary_info3', 	index: 'summary_info3', 	align: 'center', 	sortable: true, width: '300', formatter : linkFormatter3},
	            { name: 'summary_info4', 	index: 'summary_info4', 	align: 'center', 	sortable: true, width: '200', formatter : linkFormatter4},
	            { name: 'box_qty', 			index: 'box_qty', 			align: 'center', 	sortable: true, width: '60'},
	            { name: 'kg', 				index: 'kg', 				align: 'center', 	sortable: true, width: '60'},
	            { name: 'cbm', 				index: 'cbm', 				align: 'center', 	sortable: true, width: '60'},
	            { name: 'tot_amt', 			index: 'tot_amt', 			align: 'right', 	sortable: true, width: '80', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}},
	            { name: 'remittance_yn', 	index: 'remittance_yn', 	align: 'center', 	sortable: true, width: '60'}
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
			loadError: function(xhr,st,err) {
				girdLoadError();
		    },
		    postData: serializeObject($('#searchForm'))
		});
		
		var prevCellVal = { cellId: undefined, value: undefined };	//이전셀의 값

//		function catMerge(rowId, val, rowObject, cm, rdata){			
//
//			var result;
//			if (prevCellVal.value == val) {
//				result = ' style="display: none" rowspanid="' + prevCellVal.cellId + '"';
//			} else {
//				var cellId = this.id + '_row_' + rowId + '_' + cm.name;
//				result = ' rowspan="1" id="' + cellId + '"';
//				prevCellVal = { cellId: cellId, value: val };
//			}
//			
//			return result;
//		};

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
 		linkURL += '<a href="javascript:CenterOpenWindow(\'/cu/or/CUOR02/popup' + '?ord_no=' + rowObj['ord_no'] + '\', \'open\', \'1280\', \'780\', \'scrollbars=yes, status=no\');">';
		linkURL += rowObj['start_dt'].substr(5,5) + '(' + rowObj['send_region_nm'] + ')';
		linkURL += ' ~ ' + rowObj['arrive_dt'].substr(5,5) + '(' + rowObj['receive_region_nm'] + ')';
		linkURL += '</a>';
				
		return linkURL;
	}
	
	function linkFormatter1(cellVal, options, rowObj) {
		var linkURL = '';
		linkURL = rowObj['start_dt'] + ' ~ ' + rowObj['arrive_dt'];
		return linkURL;
	}
	
	function linkFormatter2(cellVal, options, rowObj) {
		var linkURL = '';
		linkURL += '<a href="javascript:CenterOpenWindow(\'/cu/or/CUOR01/popup' + '?ord_no=' + rowObj['ord_no'] + '\', \'open\', \'1280\', \'780\', \'scrollbars=yes, status=no\');">';
		linkURL += rowObj['send_region_nm'] + ' ~ ' + rowObj['receive_region_nm'];
		linkURL += '</a>';
		return linkURL;
	}
	
	function linkFormatter3(cellVal, options, rowObj) {
		var linkURL = '';
		
		if(rowObj['inout_typ'] == '1'){			
			linkURL = 'From' + ' <b> ' + rowObj['send_no'] + ' </b> ' + gfn_nvl(rowObj['send_nm'],'');
		} else {
			linkURL = 'To' + ' <b> ' + rowObj['receive_no'] + ' </b> ' + gfn_nvl(rowObj['receive_nm'],'');
		}
		
		return linkURL;
	}
	
	function linkFormatter4(cellVal, options, rowObj) {
		var linkURL = '';
		linkURL = rowObj['item_nm'] + '[' + rowObj['item_cnt'] + ']';
		return linkURL;
	}

	
	//조회
	function fn_f3(){	
		$('#list1').clearGridData();
		$("#searchForm").submit();
	}
	
	//신규등록
	function fn_f9(){
		var url = "/cu/or/CUOR02/popup";
		var ord_typ = $("#ord_typ").val();
		var inout_typ = $("#inout_typ").val();
		
		url += ord_typ;
		url += "?inout_typ=" + inout_typ;
		
		CenterOpenWindow(url, '접수 등록', '1280','1024', 'scrollbars=yes, status=no');
	}
	
	
	