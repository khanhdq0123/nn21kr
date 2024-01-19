	$(document).ready(function() {			

			jQuery("#list1").jqGrid({
				url:'/ad/ex/ADEX02/search',
//				datatype: "json",				   
				datatype: "local",				   
				colNames:['customs_exch_no','시작일','종료일', 'USD($)', 'CNY(￥)', 'VND(₫)', 'JPY(Y)', 'HKD(HK$)','EUR(€)','IDR(Rp)','PHP(₱)','THB(฿)'],
				colModel:[
					{name:'customs_exch_no',	index:'customs_exch_no',	hidden:true},
					{name:'app_st_dt',	index:'app_st_dt',	width:90,	align:"center" , sortable:true, editable:true,editoptions:{dataInit:function(e) {$(e).datepicker();}}}, //시작일
					{name:'app_ed_dt',	index:'app_ed_dt',	width:90,	align:"center" , sortable:true, editable:true,editoptions:{dataInit:function(e) {$(e).datepicker();}}}, //종료일
					{name:'cost_usd',	index:'cost_usd',	width:70,	align:"right" , sortable:true, editable:true}, 	//
					{name:'cost_cny',	index:'cost_cny',	width:70,	align:"right" , sortable:true, editable:true}, 	//
					{name:'cost_vnd',	index:'cost_vnd',	width:70,	align:"right" , sortable:true, editable:true}, 	//
					{name:'cost_jpy',	index:'cost_jpy',	width:70,	align:"right" , sortable:true, editable:true}, 	//
					{name:'cost_hkd',	index:'cost_hkd',	width:70,	align:"right" , sortable:true, editable:true}, 	//
					{name:'cost_eur',	index:'cost_eur',	width:70,	align:"right" , sortable:true, editable:true}, 	//
					{name:'cost_idr',	index:'cost_idr',	width:70,	align:"right" , sortable:true, editable:true}, 	//
					{name:'cost_php',	index:'cost_php',	width:70,	align:"right" , sortable:true, editable:true}, 	//
					{name:'cost_thb',	index:'cost_thb',	width:70,	align:"right" , sortable:true, editable:true} 	//
				],
				autowidth: true,
				mtype:"post",
				//autowidth: true,	// 부모 객체의 width를 따른다
				rowNum:500,	   	
				//rowList:[20,50,100],
				height: 400,
				// pager: '#pager1',
				pager: '',
			    //viewrecords: true,	
			    multiselect : true,
 			    cellEdit : true,
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

			// grid 검색
//			$("#btnSearch").click( function(){
//				$('#list1').clearGridData();
//				$("#searchForm").submit();
//			});

			// Link 처리
			function linkFormatter(cellVal, options, rowObj) {
				var linkURL = '<a href="javascript:CenterOpenWindow(\'/ad/ex/ADEX02/detail?exch_no=' + rowObj['exch_no'] + '\', \'open\', \'1200\', \'800\', \'scrollbars=yes, status=no\');">'+cellVal+'</a>';										
				return linkURL;
			}
			
			$("#btnAdd").on("click", function(){	//신규등록
				fn_f9();
			});
			
			$("#btnSaveAdex").click(function (){
				fn_f10();
			});

		});	
				
	
		//조회
		function fn_f3(){
			$("#searchForm").submit();
		}
		
		//신규등록
		function fn_f9(){
			CenterOpenWindow('/ad/ex/ADEX02/popup', 'open', '500', '550', 'scrollbars=yes, status=no');
		}
		
		//저장
		function fn_f10(){
			saveGridSelected("list1", 'selected', 'save', "/ad/ex/ADEX02/update");
		}
		
		
				

		