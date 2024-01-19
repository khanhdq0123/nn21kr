		$(document).ready(function() {

			jQuery("#list1").jqGrid({
				url:jsUrl + '/search',
//				datatype: "json",				   
				datatype: "local",				   
				colNames:['ord_no','Date','Customer No & Company','Booking Summary','Items','Packing','KG','CBM','청구','입금','잔액','화물'],
				colModel:[
					{name:'ord_no',				index:'ord_no',				hidden:true},	//필드
					{name:'start_dt',			index:'start_dt',				width:80,	align:"center"},	//필드
		            {name: 'customer_company',	index: 'customer_company',	align: 'center',	sortable: true, width: '350', formatter : linkFormatter2},
					{name: 'booking_summary', 	index: 'booking_summary', 	align: 'left',		sortable: true, width: '300', formatter : linkFormatter},
					{name:'item_nm',			index:'item_nm',			width:100,	align:"center"},	//필드
		            {name: 'box_qty', 			index: 'box_qty', 			width:60,	align: 'right', 	sortable: true},
		            {name: 'kg', 				index: 'kg', 				width:60,	align: 'right', 	sortable: true},
		            {name: 'cbm', 				index: 'cbm', 				width:60,	align: 'right', 	sortable: true},
					{name:'tot_amt',			index:'tot_amt',			width:60,	align:'right', 		formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}},
					{name:'field9',				index:'field9',				width:60,	align:"center"},	//필드
					{name:'field9',				index:'field9',				width:60,	align:"center"},	//필드
					{name:'field10',			index:'field10',			width:60,	align:"center"}	//필드
				],
				mtype:"post",
				//autowidth: true,	// 부모 객체의 width를 따른다
				rowNum:500,	   	
				//rowList:[20,50,100],
				height: 400,
				// pager: '#pager1',
				pager: '',
			    //viewrecords: true,	
			    multiselect : true,
// 			    cellEdit : true,
				cellsubmit : 'clientArray',
				gridview: true,
				loadError : function(xhr,st,err) {	// 서버에러시 처리
					girdLoadError();
			    },				    
			    loadComplete: function(data) {	// 데이터 로드 완료 후 처리 
			    	setSortingGridData(this, data);
			    }, 
			    postData : serializeObject($('#searchForm')),	// 그리드 부가 파라미터 정보
			    afterSaveCell : function(id, name, val, iRow, iCol) {	// cell이 변경되었을 경우 처리
			    	checkWhenColumnUpdated("list1", id);
			    }		
			});


			$("#searchForm").validate({
				debug : true,
				rules : {		

				},
				messages: { 
					regdt_from:{
						dpDate: '등록 시작일자는 yyyy-mm-dd 형식으로 입력하세요.'
					},
					regdt_to:{
						dpDate: '등록 종료일자는 yyyy-mm-dd 형식으로 입력하세요.',
						dpCompareDate: '등록 종료일은 시작일보다 같거나 이후 일자를 선택하세요.'
					}	
				},
				onfocusout:false,
				invalidHandler: function(form, validator) {
					showValidationError(form, validator);               
	            },
				errorPlacement: function(error, element) {
					// nothing
				},
				submitHandler: function(form) {		
					$("#list1").setGridParam({
						page : 1,
						postData : serializeObject($('#searchForm'))
					});
					$("#list1").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
				}
			});
			
			$('.btnDate').click(function (){
				setSearchDate('regdt_from', 'regdt_to', $(this).attr('val'));
				return false;
			});



			
			$("#btnAdd").on("click", function(){	//신규등록
				fn_f9();
			});

		});	
		
				// Link 처리
		function linkFormatter(cellVal, options, rowObj) {
			var linkURL = '';
	 		//linkURL += '<a href="javascript:CenterOpenWindow(\'/ve/or/VEOR01/popup' + '?ord_no=' + rowObj['ord_no'] + '\', \'open\', \'1280\', \'780\', \'scrollbars=yes, status=no\');">';
					
			if(rowObj['transport_way_nm'] != null) linkURL += rowObj['transport_way_nm'];
			
			linkURL += '      ' + rowObj['start_dt'].substr(5,5) + '(' + rowObj['send_region_nm'] + ')';
			linkURL += ' ~ ' + rowObj['arrive_dt'].substr(5,5) + '(' + rowObj['receive_region_nm'] + ')';
			//linkURL += '</a>';
					
			return linkURL;
		}
		
		function linkFormatter2(cellVal, options, rowObj) {
			var linkURL = '';
			
			linkURL += '<b>' + rowObj['send_no'] + '</b> ' + rowObj['send_nm'];
			linkURL += ' ~ <b>' + rowObj['receive_no'] + '</b> ' + rowObj['receive_nm'];
					
			return linkURL;
		}
		
		//조회
		function fn_f3(){
			$("#searchForm").submit();
		}
		
		//신규등록
		function fn_f9(){
			CenterOpenWindow(jsUrl + '/popup', 'open', '600', '320', 'scrollbars=yes, status=no');
		}

		