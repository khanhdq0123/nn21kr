		$(document).ready(function() {

			jQuery("#list1").jqGrid({
				url:jsUrl + '/search',
//				datatype: "json",				   
				datatype: "local",				   
				colNames:['필드1','필드2','필드3','필드4','필드5','필드6','필드7','필드8','필드9','필드10',],
				colModel:[
					{name:'field1',				index:'field1',				width:100,	align:"center"},	//필드
					{name:'field2',				index:'field2',				width:100,	align:"center"},	//필드
					{name:'field3',				index:'field3',				width:100,	align:"center"},	//필드
					{name:'field4',				index:'field4',				width:100,	align:"center"},	//필드
					{name:'field5',				index:'field5',				width:100,	align:"center"},	//필드
					{name:'field6',				index:'field6',				width:100,	align:"center"},	//필드
					{name:'field7',				index:'field7',				width:100,	align:"center"},	//필드
					{name:'field8',				index:'field8',				width:100,	align:"center"},	//필드
					{name:'field9',				index:'field9',				width:100,	align:"center"},	//필드
					{name:'field10',			index:'field10',				width:100,	align:"center"}	//필드
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

		