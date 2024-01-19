		$(document).ready(function() {

			jQuery("#list1").jqGrid({
				url:jsUrl + '/search',
//				datatype: "json",				   
				datatype: "local",				   
				colNames:['ord_no','청구일자','도착일','요약','청구금액','납부금액','미수금액'],
				colModel:[
					{name:'ord_no',				index:'ord_no',		hidden:true},	//필드
					{name:'start_dt',				index:'start_dt',				width:80,	align:"center"},	//필드
					{name:'receive_dt',				index:'receive_dt',				width:80,	align:"center"},	//필드
					{name:'field4',				index:'field4',				width:300,	align:"center"},	//필드
					{name:'tot_amt',				index:'tot_amt',				width:100,	align:'right', 		formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}},
					{name:'tot_amt',				index:'tot_amt',				width:100,	align:'right', 		formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}},
					{name:'tot_amt',			index:'tot_amt',				width:100,	align:'right', 		formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}}
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

			// grid 검색
//			$("#btnSearch").click( function(){
//				$('#list1').clearGridData();
//				$("#searchForm").submit();
//			});

			// Link 처리
			function linkFormatter(cellVal, options, rowObj) {
				var linkURL = '<a href="javascript:CenterOpenWindow(\'' + jsUrl + '/popup?exch_no=' + rowObj['exch_no'] + '\', \'open\', \'1200\', \'800\', \'scrollbars=yes, status=no\');">'+cellVal+'</a>';										
				return linkURL;
			}
			
			$("#btnAdd").on("click", function(){	//신규등록
				fn_f9();
			});

		});	
		
		//조회
		function fn_f3(){
			$("#searchForm").submit();
		}
		
		//신규등록
		function fn_f9(){
			CenterOpenWindow(jsUrl + '/popup', 'open', '600', '320', 'scrollbars=yes, status=no');
		}

		