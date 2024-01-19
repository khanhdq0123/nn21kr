
var newWidth = 0;

	$(document).ready(function() {

		$(window).bind('resize', function() {

		}).trigger('resize');

		fn_initEvent();	//이벤트 바인딩.

		jQuery('#list1').jqGrid({
			url: '/ve/or/VEOR03/getStorageList',
			datatype: 'json',
		   	colNames: ['vendor_no','창고/건수/화물수량', '건수',	'화물수량'
			],
			colModel: [
	            { name: 'vendor_no', 		index: 'vendor_no', 			align: 'center', 	sortable: true, width: '70', hidden:true},
	            { name: 'vendor_nm', 		index: 'vendor_nm', 			align: 'left',		sortable: true, width: '118', formatter : linkFormatter1},
	            { name: 'wh_cnt', 			index: 'wh_cnt', 				align: 'right', 	sortable: true, width: '20'},
	            { name: 'ord_cnt', 			index: 'ord_cnt', 				align: 'right', 	sortable: true, width: '20'}
			],
			autowidth: true,
			height: 472,
			mtype: 'post',
			viewrecords: true,
			loadComplete: function(data) {
				setSortingGridData(this, data);
			},
			gridComplete: function() {  // 그리드 생성 후 호출되는 이벤트
				//console.log(28);
		  	},
			loadError: function(xhr,st,err) {
				girdLoadError();
		    },
		    postData: serializeObject($('#searchForm'))
		});
		
		//헤더병합 1단
//		newWidth = $("#list1_vendor_nm").width() + $("#list1_wh_cnt").width() + $("#list7_ord_cnt").outerWidth(true);
//		
//		jQuery("#list1").jqGrid("setLabel", "vendor_nm", "컨테이너/건수/화물수량", "", {
//		        style: "width: " + newWidth + "px;",
//		        colspan: "3"
//		    });
		jQuery("#list1").jqGrid("setLabel", "wh_cnt", "", "", {style: "display: none"}); 
		jQuery("#list1").jqGrid("setLabel", "ord_cnt", "", "", {style: "display: none"}); 
		

		jQuery('#list2').jqGrid({
			url: '/ve/or/VEOR03/getTransportMst',
			datatype: 'json',
		   	colNames: ['tp_no','tp_ct_cnt','tp_ord_cnt','업체명','출발지', '도착지',	'출발일','도착일','MASTER B/L'
			],
			colModel: [
	            { name: 'tp_no', 				index: 'tp_no', 			align: 'center', 	sortable: true, width: '70', hidden:true},
	            { name: 'tp_ct_cnt', 			index: 'tp_ct_cnt', 		align: 'left',		sortable: true, width: '30', hidden:true},
	            { name: 'tp_ord_cnt', 			index: 'tp_ord_cnt', 		align: 'left',		sortable: true, width: '30', hidden:true},
	            { name: 'vendor_nm', 			index: 'vendor_nm', 		align: 'left',		sortable: true, width: '120'},
	            { name: 'send_region_nm', 		index: 'send_region_nm', 	align: 'left', 	sortable: true, width: '100'},
	            { name: 'receive_region_nm',	index: 'receive_region_nm', align: 'left', 	sortable: true, width: '100'},
	            { name: 'start_dt', 			index: 'start_dt', 			align: 'center', 	sortable: true, width: '70', formatter : linkFormatter2},
	            { name: 'arrive_dt', 			index: 'arrive_dt', 		align: 'center', 	sortable: true, width: '70', formatter : linkFormatter2},
	            { name: 'master_bl', 			index: 'master_bl', 		align: 'center', 	sortable: true, width: '70'}
			],
			autowidth: true,
			height: 200,
			mtype: 'post',
			multiselect : true,
			viewrecords: true,
			loadComplete: function(data) {
				setSortingGridData(this, data);
			},
			gridComplete: function() {  // 그리드 생성 후 호출되는 이벤트
		  	},
			loadError: function(xhr,st,err) {
				girdLoadError();
		    },	    
		    postData: serializeObject($('#searchForm'))
		});
		
		jQuery('#list3').jqGrid({
			url: '/ve/or/VEOR03/getTransportContainerList',
			datatype: 'local',
		   	colNames: ['tp_no','ct_no','Type','Size','Seal No','wh_no'
			],
			colModel: [
	            { name: 'tp_no', 		index: 'tp_no', 		align: 'center', 	sortable: true, width: '70', hidden:true},
	            { name: 'ct_no', 		index: 'ct_no', 		align: 'left', 	sortable: true, width: '50', hidden:true},
	            { name: 'ct_typ_nm', 	index: 'ct_typ_nm', 	align: 'center',		sortable: true, width: '40'},
	            { name: 'ct_size_nm', 	index: 'ct_size_nm', 	align: 'center', 	sortable: true, width: '40'},
	            { name: 'seal_no', 		index: 'seal_no', 		align: 'left', 	sortable: true, width: '50'},
	            { name: 'wh_no', 		index: 'wh_no', 		hidden:true}
			],
			autowidth: true,
			height: 200,
			mtype: 'post',
			viewrecords: true,
			multiselect : true,
			loadComplete: function(data) {
				setSortingGridData(this, data);
			},
			gridComplete: function() {  // 그리드 생성 후 호출되는 이벤트
		  	},
			loadError: function(xhr,st,err) {
				girdLoadError();
		    },
		    postData: serializeObject($('#searchForm'))
		});
		
		jQuery('#list4').jqGrid({
			url: '/ve/or/VEOR03/getTransportOrdList',
			datatype: 'local',
		   	colNames: ['tp_no','ord_no','box_cnt', 'cbm','Kg','company','From','wh_no'
			],
			colModel: [
	            { name: 'tp_no', 			index: 'tp_no', 			align: 'center', 	sortable: true, width: '70', hidden:true},
	            { name: 'ord_no', 			index: 'ord_no', 			align: 'center', 	sortable: true, width: '70', hidden:true},
	            { name: 'box_cnt', 			index: 'box_cnt', 			align: 'left',		sortable: true, width: '40'},
	            { name: 'cbm', 				index: 'cbm', 				align: 'right', 	sortable: true, width: '40'},
	            { name: 'weight', 			index: 'weight', 			align: 'right', 	sortable: true, width: '40'},
	            { name: 'send_nm', 			index: 'send_nm', 			align: 'right', 	sortable: true, width: '100'},
	            { name: 'send_region_nm', 	index: 'send_region_nm', 	align: 'right', 	sortable: true, width: '120'},
	            { name: 'wh_no', 		index: 'wh_no', 		hidden:true}
			],
			autowidth: true,
			height: 200,
			mtype: 'post',
			viewrecords: true,
			multiselect : true,
			loadComplete: function(data) {
				setSortingGridData(this, data);
			},
			gridComplete: function() {  // 그리드 생성 후 호출되는 이벤트
		  	},
			loadError: function(xhr,st,err) {
				girdLoadError();
		    },
		    postData: serializeObject($('#searchForm'))
		});
		
		jQuery('#list5').jqGrid({
			url: '/ve/or/VEOR03/getContainerList',
			datatype: 'local',
		   	colNames: ['Type','Size', 'Container No','Seal No','수정','ct_no','tp_no','','','','','ord_cnt'
			],
			colModel: [
	            { name: 'ct_typ_nm', 	index: 'ct_typ_nm', 	align: 'left',		sortable: true, width: '60', formatter : linkFormatter5},
	            { name: 'ct_size_nm', 	index: 'ct_size_nm', 	align: 'center', 	sortable: true, width: '40', formatter : linkFormatter5},
	            { name: 'ct_num', 		index: 'ct_num', 		align: 'left', 	sortable: true, width: '50'},
	            { name: 'seal_no', 		index: 'seal_no', 		align: 'left', 	sortable: true, width: '50'},
	            { name: 'btn_modify', 	index: 'btn_modify', 	align: 'center', 	sortable: true, width: '35', formatter : linkFormatter5a},
	            { name: 'ct_no', 		index: 'ct_no', 		align: 'center', 	sortable: true, width: '30', hidden:true},
	            { name: 'tp_no', 		index: 'tp_no', 		align: 'center', 	sortable: true, width: '30', hidden:true},
	            { name: 'ct_typ', 		index: 'ct_typ', 		align: 'center', 	sortable: true, width: '30', hidden:true},
	            { name: 'ct_size', 		index: 'ct_size', 		align: 'center', 	sortable: true, width: '30', hidden:true},
	            { name: 'wh_no', 		index: 'wh_no', 		align: 'center', 	sortable: true, width: '30', hidden:true},
	            { name: 'fcl_yn', 		index: 'fcl_yn', 		align: 'center', 	sortable: true, width: '30', hidden:true},
	            { name: 'ord_cnt', 		index: 'ord_cnt', 		align: 'center', 	sortable: true, width: '30', hidden:true}
			],
			autowidth: true,
			height: 200,
			mtype: 'post',
			viewrecords: true,
			multiselect : true,
			loadComplete: function(data) {
				setSortingGridData(this, data);
			},
			gridComplete: function() {  // 그리드 생성 후 호출되는 이벤트
		  	},
			loadError: function(xhr,st,err) {
				girdLoadError();
		    },
		    postData: serializeObject($('#searchForm'))
		});
		
		jQuery('#list6').jqGrid({
			url: '/ve/or/VEOR03/getContainerOrdList',
			datatype: 'local',
		   	colNames: ['ct_no','wh_no','ord_no','cnt', 'total','shipper','consignee','schedule'
			],
			colModel: [
	            { name: 'ct_no', 			index: 'ct_no', 			align: 'center', 	sortable: true, width: '70'},
	            { name: 'wh_no', 			index: 'wh_no', 			align: 'center', 	sortable: true, width: '70'},
	            { name: 'ord_no', 			index: 'ord_no', 			align: 'center', 	sortable: true, width: '70'},
	            { name: 'box_cnt', 			index: 'box_cnt', 			align: 'right',		sortable: true, width: '40'},
	            { name: 'tot_box_cnt', 		index: 'tot_box_cnt', 		align: 'right', 	sortable: true, width: '40'},
	            { name: 'send_nm', 			index: 'send_nm', 			align: 'left', 		sortable: true, width: '80'},
	            { name: 'receive_nm', 		index: 'receive_nm', 		align: 'left', 		sortable: true, width: '80'},
	            { name: 'schedule_txt', 	index: 'schedule_txt', 		align: 'center', 	sortable: true, width: '60'}
			],
			autowidth: true,
			height: 200,
			mtype: 'post',
			viewrecords: true,
			multiselect : true,
			loadComplete: function(data) {
				setSortingGridData(this, data);
			},
			gridComplete: function() {  // 그리드 생성 후 호출되는 이벤트
		  	},
			loadError: function(xhr,st,err) {
				girdLoadError();
		    },
		    postData: serializeObject($('#searchForm'))
		});
		
		
		jQuery('#list7').jqGrid({
			url: '/ve/or/VEOR03/getStorageItemList',
			datatype: 'json',
		   	colNames: ['ord_no','ord_item_no','remain','total', 'CBM','Kg','company','From','To','Shipper','Schedule','TransportWay','ct_no','tp_no','wh_no'
			],
			colModel: [
	            { name: 'ord_no', 			index: 'ord_no', 			align: 'center', 	sortable: true, width: '70', hidden:true},
	            { name: 'ord_item_no', 		index: 'ord_item_no', 		align: 'center', 	sortable: true, width: '70', hidden:true},
	            { name: 'remain_box_cnt', 	index: 'remain_box_cnt', 	align: 'right',		sortable: true, width: '20', editable:true, editrules:{required:true, integer:true, maxValue:32767}},
	            { name: 'box_cnt', 			index: 'box_cnt', 			align: 'right',		sortable: true, width: '20'},
	            { name: 'cbm', 				index: 'cbm', 				align: 'right', 	sortable: true, width: '30'},
	            { name: 'weight', 			index: 'weight', 			align: 'right', 	sortable: true, width: '30'},
	            { name: 'send_nm', 			index: 'send_nm', 			align: 'transport_nm', 	sortable: true, width: '80'},
	            { name: 'send_region_nm', 	index: 'send_region_nm', 		align: 'left', 	sortable: true, width: '130'},
	            { name: 'receive_region_nm', index: 'receive_region_nm', 	align: 'left', 	sortable: true, width: '130'},
	            { name: 'receive_nm', 		index: 'receive_nm', 		align: 'left', 		sortable: true, width: '80'},
	            { name: 'schedule_txt', 	index: 'schedule_txt', 		align: 'center', 	sortable: true, width: '60'},
	            { name: 'transport_nm', 	index: 'transport_nm', 		align: 'left', 		sortable: true, width: '70'},
	            { name: 'ct_no', 			index: 'ct_no', 			align: 'center', 	sortable: true, width: '70', hidden:true},
	            { name: 'tp_no', 			index: 'tp_no', 			align: 'center', 	sortable: true, width: '70', hidden:true},
	            { name: 'wh_no', 			index: 'wh_no', 			align: 'center', 	sortable: true, width: '70', hidden:true}
			],
			autowidth: false,
			cellsubmit : 'clientArray',
			multiselect : true,
			cellEdit : true,
			gridview:true,
			editable:true,
			height: 200,
			mtype: 'post',
			viewrecords: true,
			multiselect : true,
			loadComplete: function(data) {
				setSortingGridData(this, data);
			},
			gridComplete: function() {  // 그리드 생성 후 호출되는 이벤트
				//console.log('list7');
		  	},
			loadError: function(xhr,st,err) {
				girdLoadError();
		    },
		    postData: serializeObject($('#searchForm'))
		});
		

		
		//헤더병합  2단
//		$("#list7").jqGrid('setGroupHeaders', {
//			useColSpanStyle: true,
//			  groupHeaders:[
//				{ startColumnName: 'remain_box_cnt', numberOfColumns: 2, titleText: 'CT' }
//			  ]
//	    });




		// jQuery validation
//		$("#searchForm").validate({
//			rules: {
//				title_txt: {maxlength: 100},
//				delay_time: {number: true},
//				gl_user_id: {maxlength: 20},
//				user_name: {maxlength: 30},
//				search_start_dt: {dpDate: true},
//				search_end_dt: {dpDate: true, dpCompareDate:{notBefore: '#search_start_dt'}}
//			},
//			messages: {
//				title_txt: {maxlength: jQuery.format("제목은 최대 {0} 글자 이하로 입력하세요.")},
//				delay_time: {number: '지연일은 숫자만 입력하세요.'},
//				gl_user_id: {maxlength: jQuery.format('문의자 ID는 최대 {0} 글자 이하로 입력하세요.')},
//				user_name: {maxlength: jQuery.format('문의자명은 최대 {0} 글자 이하로 입력하세요.')},
//				search_start_dt: {dpDate: "등록일 검색 시작일자는 yyyy-mm-dd 형식으로 입력하세요."},
//				search_end_dt: {dpDate: "등록일 검색 종료일자는 yyyy-mm-dd 형식으로 입력하세요.",
//						dpCompareDate: "등록일 검색 종료일은 시작일보다 같거나 이후 일자를 선택하세요."}
//			},
//			onfocusout:false,
//			invalidHandler: function(form, validator) {
//				showValidationError(form, validator);               
//			},
//			errorPlacement: function(error, element) {},
//			submitHandler: function(form) {
//
//				
//				$("#list1").setGridParam({
//					page : 1,
//					postData : serializeObject($('#searchForm')),
//					datatype: 'json'
//				});
//				
//				$("#list1").trigger("reloadGrid");
//			}
//		});
		
		

	
	});
	
	
	function linkFormatter(cellVal, options, rowObj) {
		var linkURL = '';
			
		return linkURL;
	}
	
    
	// jqGrid Navigator
	//jQuery('#list1').jqGrid('navGrid','#pager1',{search:false, edit:false, add:false, del:false, refresh:false});

	// Link 처리
	function linkFormatter1(cellVal, options, rowObj) {	
 		var linkURL = '<a href="javascript:fn_grid1RowClick(' + rowObj['vendor_no'] + ',\'' + rowObj['vendor_nm'] + '\');">' + rowObj['vendor_nm'] + '</a>';
		return linkURL;
	}
	
	function linkFormatter2(cellVal, options, rowObj) {	
 		var linkURL = '<a href="javascript:fn_grid2RowClick(' + rowObj['tp_no'] + ');">' + cellVal + '</a>';
		return linkURL;
	}
	
	function linkFormatter5(cellVal, options, rowObj) {
 		var linkURL = '<a href="javascript:fn_grid5RowClick(' + rowObj['ct_no'] + ');">' + cellVal + '</a>';
		return linkURL;
	}
	
	function linkFormatter5a(cellVal, options, rowObj) {			
 		var linkURL = '<a href="javascript:fnSelectLayer(\'컨테이너 생성\',\'selectContainerRegLayerPop\',\'' + options.rowId+ '\',\'\');">수정</a>';
		return linkURL;
	}
	

	



	//창고 클릭
	function fn_grid1RowClick(wh_no, wh_nm){
		
		$("#wh_no").val(wh_no);	//창고번호
		
		$("#list5").setGridParam({	//컨테이너
			datatype: "json",
			postData : serializeObject($('#searchForm'))
		}).trigger("reloadGrid");	
		
		$("#list7").setGridParam({	//화물
			datatype: "json",
			postData : serializeObject($('#searchForm'))
		}).trigger("reloadGrid");		


		//헤더병합 1단
		if(newWidth == 0)
		newWidth = $("#list7_remain_box_cnt").width() + $("#list7_box_cnt").outerWidth(true) + $("#list7_cbm").outerWidth(true) + $("#list7_weight").outerWidth(true);
		
		jQuery("#list7").jqGrid("setLabel", "remain_box_cnt", "CT/CBM/Kg", "", {
		        style: "width: " + newWidth + "px;",
		        colspan: "4"
		    });
		jQuery("#list7").jqGrid("setLabel", "box_cnt", "", "", {style: "display: none"}); 
		jQuery("#list7").jqGrid("setLabel", "cbm", "", "", {style: "display: none"});
		jQuery("#list7").jqGrid("setLabel", "weight", "", "", {style: "display: none"});
		
		$('#list6').clearGridData();
		
		$("#btnMoveToTransportItem").val("DownTo " + wh_nm);
		

	}
	
	//운송예약 클릭
	function fn_grid2RowClick(tp_no){	
		
		$("#list3").setGridParam({	//컨테이너
			datatype: "json",
			postData : {
				tp_no: tp_no
			}
		}).trigger("reloadGrid");
			
		$("#list4").setGridParam({	//화물
			datatype: "json",
			postData : {
				tp_no: tp_no
			}
		}).trigger("reloadGrid");
		
	}
	
	//컨테이너 클릭
	function fn_grid5RowClick(ct_no){
		
		$("#list6").setGridParam({	//화물
			datatype: "json",
			postData : {
				ct_no: ct_no
			}
		}).trigger("reloadGrid");
		
	}


	//이벤트 바인딩
	function fn_initEvent(){


		$("#btnRegTransport").on("click", function(){
			fnSelectLayer('운송예약','selectTransportRegLayerPop','','');
		});
		//운송예약 저장
		$("#btnSave2").on("click", function(){
			$("#gForm1").submit();
		});


		//컨테이너 등록폼
		$("#btnRegContainer").on("click", function(){
			fnSelectLayer('컨테이너 생성','selectContainerRegLayerPop','','');
		});
		
		//컨테이너 저장
		$("#btnSave3").on("click", function(){
			$("#gForm2").submit();
		});
		
		//btnToContainer
		$("#btnToContainer").on("click", function(){
			
			selRows5 = $("#list5").getGridParam('selarrrow');
			
			if(selRows5.length == 0){
				toast('컨테이너를 선택하세요.'); return;
			}
			
			if(selRows5.length > 1){
				toast('컨테이너를 1개만 선택하세요.'); return;
			}

			var selRowData5 = $("#list5").getRowData(selRows5);
			selRows7 = $("#list7").getGridParam('selarrrow');
			
			for(var i=0; i<selRows7.length; i++) {
				$('#list7').jqGrid('setCell', selRows7[i], 'ct_no', selRowData5.ct_no);
			}
			
			saveGridSelected("list7", 'selected', 'save', "/ve/or/VEOR03/insertContainerOrdList");
		});
		
		
		
		//btnDropInfoWareHouse
		$("#btnDropInfoWareHouse").on("click", function(){
			
			var selRows6 = $("#list6").getGridParam('selarrrow');
			
			if(selRows6.length == 0){
				toast('창고로 내릴 화물을 선택하세요.'); return;
			}

			saveGridSelected("list6", 'selected', 'save', "/ve/or/VEOR03/dropInfoWareHouse");
		});
		
		
		
		//btnReturnContainer	컨테이너 반납
		$("#btnReturnContainer").on("click", function(){

			var selRows5 = $("#list5").getGridParam('selarrrow');
			var selRowData5;
			var tot_ord_cnt = 0;
			
			if(selRows5.length == 0){
				toast('반납할 컨테이너를 선택하세요.'); return;
			}
			
			for(var i=0; i<selRows5.length; i++) {
				selRowData5 = $("#list5").getRowData(selRows5[i]);
				tot_ord_cnt += parseInt( selRowData5.ord_cnt);
			}
			
			if(tot_ord_cnt > 0){
				toast('화물이 있는 컨테이너가 있습니다.  화물을 비워야 반납할 수 있습니다.'); return;
			}
			
			saveGridSelected("list5", 'selected', 'delete', "/ve/or/VEOR03/returnContainer");
		});
		

		
		//btnToTransport
		$("#btnToTransport").on("click", function(){

			
			var selRows2 = $("#list2").getGridParam('selarrrow');
			
			if(selRows2.length == 0){
				toast('운송예약을 선택하세요.'); return;
			}
			
			if(selRows2.length > 1){
				toast('운송예약을 1개만 선택하세요.'); return;
			}

			var selRowData2 = $("#list2").getRowData(selRows2);
			
			var selRows5 = $("#list5").getGridParam('selarrrow');
			var selRows7 = $("#list7").getGridParam('selarrrow');
			
			if(selRows5.length == 0 && selRows7.length == 0){
				toast('컨테이너 또는 화물을 선택하세요.'); return;
			}
			
			if(selRows5.length > 0){
				
				for(var i=0; i<selRows5.length; i++) {
					$('#list5').jqGrid('setCell', selRows5[i], 'tp_no', selRowData2.tp_no);
				}
				
				saveGridSelected("list5", 'selected', 'save', "/ve/or/VEOR03/insertTransportContainerList");
				
			}
			
			if(selRows7.length > 0){
				
				for(var i=0; i<selRows7.length; i++) {
					$('#list7').jqGrid('setCell', selRows7[i], 'tp_no', selRowData2.tp_no);
				}
				
				saveGridSelected("list7", 'selected', 'save', "/ve/or/VEOR03/insertTransportOrdList");
				
			}
			
		});
		
		
		//btnRegOkTransport	예약OK
		$("#btnRegOkTransport").on("click", function(){

			var selRows2 = $("#list2").getGridParam('selarrrow');
			var selRowData2;
			var tot_tp_ct_cnt = 0;
			var tot_tp_ord_cnt = 0;
			var chkFlag = true;
			
			if(selRows2.length == 0){
				toast('예약완료 할 건을 선택하세요.'); return;
			}
			
			for(var i=0; i<selRows2.length; i++) {
				selRowData2 = $("#list2").getRowData(selRows2[i]);
				tot_tp_ct_cnt = parseInt( selRowData2.tp_ct_cnt);
				tot_tp_ord_cnt = parseInt( selRowData2.tp_ord_cnt);
				
				if(tot_tp_ct_cnt == 0 && tot_tp_ord_cnt == 0){
					chkFlag = false;
				}
			}
			
			if(!chkFlag){
				toast('화물이 등록되지않은 운송예약건이 있습니다. 화물을 등록해야만 운송예약이 가능합니다.'); return;
			}
			
			saveGridSelected("list2", 'selected', 'update', "/ve/or/VEOR03/reserveOkTransport");
		});
		
		//btnCancelTransport	예약취소
		$("#btnCancelTransport").on("click", function(){

			var selRows2 = $("#list2").getGridParam('selarrrow');
			var selRowData2;
			var tot_tp_ct_cnt = 0;
			var tot_tp_ord_cnt = 0;	
			
			if(selRows2.length == 0){
				toast(' 취소할 예약건을 선택하세요.'); return;
			}
			
			for(var i=0; i<selRows2.length; i++) {
				selRowData2 = $("#list2").getRowData(selRows2[i]);
				tot_tp_ct_cnt += parseInt( selRowData2.tp_ct_cnt);
				tot_tp_ord_cnt += parseInt( selRowData2.tp_ord_cnt);
			}
			
			if(tot_tp_ct_cnt > 0 || tot_tp_ord_cnt > 0){
				toast('화물이 또는 컨테이너가 있는 운송접수건이 있습니다.  화물을 비워야 취소 할 수 있습니다.'); return;
			}
			
			saveGridSelected("list2", 'selected', 'delete', "/ve/or/VEOR03/cancelTransport");
		});
		
		
		//btnMoveToTransportItem	예약화물 창고로 이동
		$("#btnMoveToTransportItem").on("click", function(){

			var wh_no = $("#wh_no").val();

			var selRows3 = $("#list3").getGridParam('selarrrow');
			var selRows4 = $("#list4").getGridParam('selarrrow');
			
			if(selRows3.length == 0 && selRows4.length == 0){
				toast('창고로 반환할 컨테이너 또는 화물을 선택하세요'); return;
			}
			
			if(wh_no == ""){
				toast('반환시킬 창고를 선택하세요'); return;
			}
			
			
			
			
			if(selRows3.length > 0){
			
				for(var i=0; i<selRows3.length; i++) {
					$('#list3').jqGrid('setCell', selRows3[i], 'wh_no', wh_no);
				}
				
				saveGridSelected("list3", 'selected', 'update', "/ve/or/VEOR03/moveToWhCt");
			}
			
			if(selRows4.length > 0){
				
				for(var i=0; i<selRows4.length; i++) {
					$('#list4').jqGrid('setCell', selRows4[i], 'wh_no', wh_no);
				}				
				
				saveGridSelected("list4", 'selected', 'update', "/ve/or/VEOR03/moveToWhItem");
			}

		});
		
		
		//btnModStock  - 재고수정
		$("#btnModStock").on("click", function(){
			
			var selRows7 = $("#list7").getGridParam('selarrrow');
			
			if(selRows7.length == 0){
				toast('수정할 화물을 선택하세요.'); return;
			}

			saveGridSelected("list7", 'selected', 'save', "/ve/or/VEOR03/updateOrdWhModStock");
			
		});
		
		
		
		
		
		
		
		
		
		//운송예약 저장
		$("#gForm1").validate({
			debug : true,
			rules : {
				start_vendor_nm:{	required: true	},
				arrive_vendor_nm:{	required: true	},
				send_region_nm:{	required: true	},
				receive_region_nm:{	required: true	},
				wh_no:{		required: true	}
			},
			messages: {
				start_vendor_nm:{	required:"출발지사를 선택하세요"},
				arrive_vendor_nm:{	required:"도착지사를 선택하세요"},
				send_region_nm:{	required:"출발지를 선택하세요"},
				receive_region_nm:{	required:"도착지를 선택하세요"}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
	        },
			errorPlacement: function(error, element) {
				// nothing
			},
			submitHandler: function(form) {


			//rd_ord_typ2
			
			var transport_way = $("input[name=transport_way]:checked").val();
			
			toast("transport_way " + transport_way);

				$.ajax({
					type: "POST",
					url: "/ve/or/VEOR03/insertTransportMst",
					data: $(form).serialize(),
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						if(data.code != 0){
//							toast('저장되었습니다.');
							
							toast('저장되었습니다.');
							
							$("#list5").setGridParam({	//화물
								datatype: "json",
								postData : serializeObject($('#searchForm'))
							}).trigger("reloadGrid");
						} else {
							toast('저장이 실패되었습니다.');
						}
						fnCloseLayer('selectContainerRegLayerPop');
					},
					error: function(jqXHR, textStatus, errorThrown) {
						toast(textStatus.msg);						
					}
				});
				
			}
		});
		
		
		//컨테이너 저장
		$("#gForm2").validate({
			debug : true,
			rules : {
				ct_typ:{	required: true	},
				ct_size:{	required: true	},
				ct_num:{	required: true	},
				seal_no:{	required: true	},
				wh_no:{		required: true	}
			},
			messages: {
				ct_typ:{	required:"컨테이너 type을 선택하세요"},
				ct_size:{	required:"컨테이너 규격을 선택하세요"},
				wh_no:{	required:"창고를 선택하세요"}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
	        },
			errorPlacement: function(error, element) {
				// nothing
			},
			submitHandler: function(form) {

				$.ajax({
					type: "POST",
					url: "/ve/or/VEOR03/insertContainerMst",
					data: $(form).serialize(),
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						if(data.code != 0){
							toast('저장되었습니다.');
							$("#list5").setGridParam({	//화물
								datatype: "json",
								postData : serializeObject($('#searchForm'))
							}).trigger("reloadGrid");
						} else {
							toast('저장이 실패되었습니다.');
						}
						fnCloseLayer('selectContainerRegLayerPop');
					},
					error: function(jqXHR, textStatus, errorThrown) {
						toast(textStatus.msg);						
					}
				});
				
			}
		});
		

		//운송예약 > 운송방법 선택
		$("#rd_ord_typ2,#rd_ord_typ3,#rd_ord_typ4,#rd_ord_typ5").on("click", function(){

			$(".wrap-air, .wrap-car, .wrap-ship, .wrap-sub").hide();

			switch(this.id){
				
				case "rd_ord_typ2":
					$(".wrap-air").show();
					break;
				
				case "rd_ord_typ3":
					$(".wrap-car").show();
					break;
				
				case "rd_ord_typ4":
					$(".wrap-ship").show();
					break;
				
				case "rd_ord_typ5":
					$(".wrap-sub").show();
					break;
					
			}

		});

		
		//sameple code
		$("#btnDel").click(function (){
			saveGridSelected("tmsGrid", 'selected', 'delete', "/system/tms/deleteTmsListJson");
		});
		
		$("#btnSaveTms").click(function (){
			saveGridSelected("tmsGrid", 'selected', 'save', "/system/tms/insertContainerOrdList");
		});
		
		
		//운송회사 선택팝업
		$("#car_comp_nm").click(function (){	//육상
			fnSelectLayer2('운송사 선택','selectTransportCompLayerPop1','','');
		});
		$("#ship_comp_nm").click(function (){	//해상
			fnSelectLayer2('운송사 선택','selectTransportCompLayerPop2','','');
		});
		$("#air_comp_nm").click(function (){	//항공
			fnSelectLayer2('운송사 선택','selectTransportCompLayerPop3','','');
		});
		$("#sub_comp_nm").click(function (){	//Hand Carry
			fnSelectLayer2('운송사 선택','selectTransportCompLayerPop5','','');
		});
		
		//운송회사 (신규입력) 완료
		$("#btnSelect1").click(function (){	//육상
			$("#car_comp_nm").val($("#car_comp_nm2").val());
			$("#car_driver").val($("#car_driver2").val());
			$("#car_driver_tel").val($("#car_driver_tel2").val());
			$("#car_no").val($("#car_no2").val());
			$("#car_size").val($("#car_size2").val());
			fnCloseLayer2('selectTransportCompLayerPop1');
		});
		$("#btnSelect2").click(function (){	//해상
			$("#ship_comp_nm").val($("#ship_comp_nm2").val());
			$("#ship_vessel_nm").val($("#ship_vessel_nm2").val());
			fnCloseLayer2('selectTransportCompLayerPop2');
		});
		$("#btnSelect3").click(function (){	//항공
			$("#air_comp_nm").val($("#air_comp_nm2").val());
			fnCloseLayer2('selectTransportCompLayerPop3');
		});
		$("#btnSelect5").click(function (){	//HandCarry
			$("#sub_comp_nm").val($("#sub_comp_nm2").val());
			$("#sub_from_tel").val($("#sub_from_tel2").val());
			$("#sub_to_tel").val($("#sub_to_tel2").val());
			fnCloseLayer2('selectTransportCompLayerPop5');
		});

		//운송회사 기존내역 선택
		$("#transportCompList1 tr").click(function (){	//육상
			var car_comp_nm = $(this).find(".car_comp_nm").text();
			var car_driver = $(this).find(".car_driver").text();
			var car_driver_tel = $(this).find(".car_driver_tel").text();
			var car_no = $(this).find(".car_no").text();
			var car_size = $(this).find(".car_size").text();				
			$("#car_comp_nm").val(car_comp_nm);
			$("#car_driver").val(car_driver);
			$("#car_driver_tel").val(car_driver_tel);
			$("#car_no").val(car_no);
			$("#car_size").val(car_size);
			fnCloseLayer2('selectTransportCompLayerPop2');
		});
		$("#transportCompList2 tr").click(function (){	//해상
			var ship_comp_nm = $(this).find(".ship_comp_nm").text();
			var ship_vessel_nm = $(this).find(".ship_vessel_nm").text();				
			$("#ship_comp_nm").val(ship_comp_nm);
			$("#ship_vessel_nm").val(ship_vessel_nm);
			fnCloseLayer2('selectTransportCompLayerPop2');
		});
		$("#transportCompList3 tr").click(function (){	//항공
			var air_comp_nm = $(this).find(".air_comp_nm").text();				
			$("#air_comp_nm").val(air_comp_nm);
			fnCloseLayer2('selectTransportCompLayerPop2');
		});
		$("#transportCompList5 tr").click(function (){	//HandCarry
			var sub_comp_nm = $(this).find(".sub_comp_nm").text();
			var sub_from_tel = $(this).find(".sub_from_tel").text();		
			var sub_to_tel = $(this).find(".sub_to_tel").text();		
			$("#sub_comp_nm").val(sub_comp_nm);
			$("#sub_from_tel").val(sub_from_tel);
			$("#sub_to_tel").val(sub_to_tel);
			fnCloseLayer2('selectTransportCompLayerPop2');
		});



		
	}
	//~ event

	



	/* 레이어팝업 */
	var retCdId = '';
	var retNmId = '';
	var selectLayerId = '';
	
	function fnSelectLayer(_tit, _layerId, _retCdId, _retNmId){
		
		if(_layerId == 'selectContainerRegLayerPop'){
			if(_retCdId != ""){
				var selRowData = $("#list5").getRowData(_retCdId);
				gForm2.ct_no.value = selRowData.ct_no;
				gForm2.ct_typ.value = selRowData.ct_typ;
				gForm2.ct_size.value = selRowData.ct_size;
				gForm2.ct_num.value = selRowData.ct_num;
				gForm2.seal_no.value = selRowData.seal_no;
				gForm2.wh_no.value = selRowData.wh_no;
				
				if(selRowData.fcl_yn == 'Y'){
					$('#gForm2 input[name=fcl_yn]').prop('checked',true);
				} else {
					$('#gForm2 input[name=fcl_yn]').prop('checked',false);
				}
				
			} else {
				gForm2.ct_no.value = '';
				gForm2.ct_typ.value = '';
				gForm2.ct_size.value = '';
				gForm2.ct_num.value = '';
				gForm2.seal_no.value = '';
				gForm2.wh_no.value = '';
			}
			
		}
		
		selectLayerId = _layerId;
		retCdId = _retCdId;
		retNmId = _retNmId;
		$(".layer-mask").show();
		var $layer = $('#' + _layerId);
		$layer.center();
		$layer.show();
		$layer.find(".tit").text(_tit);
	}
	
	function fnCloseLayer(id){
		$(".layer-mask").hide();
		$('#' + selectLayerId).hide();	
	}
	
		/* 레이어팝업 */
	var retCdId2 = '';
	var retNmId2 = '';
	var selectLayerId2 = '';
	
	function fnSelectLayer2(_tit, _layerId, _retCdId, _retNmId){

		selectLayerId2 = _layerId;
		retCdId = _retCdId;
		retNmId = _retNmId;
		$(".layer-mask2").show();
		
		var $layer = $('#' + _layerId);
		$layer.center();
		$layer.show();
		$layer.find(".tit").text(_tit);
	}
	
	function fnCloseLayer2(id){
		$(".layer-mask2").hide();
		$('#' + selectLayerId2).hide();	
	}
	
	var region_flag = 1;
	
	//지역선택
	function fnSelectRegionPop(regionFlag){
		region_flag = regionFlag;
		var _url = '/region/selectRegionPop?code=10000&engFlag=1';
		CenterOpenWindow(_url, '지역선택', '1200','560', 'scrollbars=no, status=yes');
	}
	
	function fnSetSelectRegionInfo( _country, _city, _region1, _region2, _region3, _region4,_countryEng, _cityEng, _region1Eng, _region2Eng, _region3Eng, _region4Eng, _countryNo, _cityNo, _region1No, _region2No, _region3No, _region4No,_engFlag){
		
		
		var targetRegionNo = "";
		var targetRegionNm = "";
		var lastRegionNo = "";

		if(region_flag == 1){
			targetRegionNo = "shipping_region_no";
			targetRegionNm = "shipping_region_nm";
		} else if(region_flag == 2){
			targetRegionNo = "send_region_no";
			targetRegionNm = "send_region_nm";
		} else if(region_flag == 3){
			targetRegionNo = "receive_region_no";
			targetRegionNm = "receive_region_nm";
		}

		
		//lastRegionNo = (_region4No != null && _region4No != '') ? _region4No : (_region3No != null && _region3No != '') ? _region3No : _region2No;

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

		$("#" + targetRegionNo).val(lastRegionNo);
		
		if(_engFlag == 1){
			$("#" + targetRegionNm).val(_region4Eng  + ' ' + _region3Eng  + ' ' + _region2Eng  + ' ' + _region1Eng  + ' ' + _cityEng + ' ' + _countryEng);
		} else {
			$("#" + targetRegionNm).val(_country + ' ' + _city + ' ' + _region1 + ' ' + _region2 + ' ' + _region3 + ' ' + _region4);
		}
		
	}
	
	




	
	
	
	