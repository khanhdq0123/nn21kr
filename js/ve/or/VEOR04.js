
	$(document).ready(function() {

		// 그리드 - 프로토타입 
		jQuery('#list1').jqGrid({
			url: '/ve/or/VEOR04/getTransportList',
			datatype: 'local',
		   	colNames: ['tp_no','Date', 'Title',	'MASTER B/L', '컨테이너번호', '규격', '날짜', 'Area', 'Warehouse', 'count/weight/CBM','Status'
			],
			colModel: [
	            { name: 'tp_no', 			index: 'tp_no', 			align: 'center', 	sortable: true, width: '70', hidden:true},
	            { name: 'reg_dt', 			index: 'reg_dt', 			align: 'center', 	sortable: true, width: '70', cellattr: catMerge},
	            { name: 'comp_nm', 			index: 'comp_nm', 			align: 'left', 		sortable: true, width: '140'},
	            { name: 'master_bl', 		index: 'master_bl', 		align: 'center',		sortable: true, width: '70'},
	            { name: 'ct_num', 			index: 'ct_num', 			align: 'center',		sortable: true, width: '65'},
	            { name: 'ct_size_nm',		index: 'ct_size_nm',		align: 'center',	sortable: true, width: '30'},
	            { name: 'from_to_date', 	index: 'from_to_date', 		align: 'center', 	sortable: true, width: '60', formatter : linkFormatter},
	            { name: 'from_to_region', 	index: 'from_to_region', 	align: 'left', 		sortable: true, width: '160'},
	            { name: 'wh_nm', 			index: 'wh_nm', 			align: 'left', 		sortable: true, width: '70'},
	            { name: 'item_info', 		index: 'item_info', 		align: 'center', 	sortable: true, width: '120'},
	            { name: 'tp_st_nm', 		index: 'tp_st_nm', 			align: 'center', 	sortable: true, width: '50'},
//	            { name: 'excel', 			index: 'excel', 			align: 'right', 	sortable: true, width: '50'}
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
	
	

	
	function linkFormatter(cellVal, options, rowObj) {	
 		var linkURL = '<a href="/ve/or/VEOR09/page?tp_no=' + rowObj['tp_no'] + '&screen_id=VEOR09&menu_nm=출고현황상세&js_url=/ve/or/VEOR09">' + cellVal + '</a>';
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
		var url = "/ve/or/VEOR04/popup";
		var ord_typ = $("#ord_typ").val();
		var inout_typ = $("#inout_typ").val();
		
		url += ord_typ;
		url += "?inout_typ=" + inout_typ;
		
		CenterOpenWindow(url, '접수 등록', '1280','1024', 'scrollbars=yes, status=no');
	}
	
	
	