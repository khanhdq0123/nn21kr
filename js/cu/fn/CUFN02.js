	$(document).ready(function() {			
			
			jQuery("#list1").jqGrid({
				url:'/cu/fn/CUFN02/search',						  
				datatype: "local",				   
				colNames:['No','회사', 'Title', 'Writer', '등록일', '담당지사', '접수지사','승인','삭제'],
				colModel:[
					{name:'debitcredit_no',			index:'debitcredit_no',			width:80,	align:"center", sortable:true, editable:false, formatter : linkFormatter},	//No
					{name:'company_nm',			    index:'company_nm',			width:80,	align:"center", sortable:true, editable:false, formatter : linkFormatter},	//회사코드
					{name:'title',					index:'title',					width:80,	align:"left", sortable:true, editable:false, formatter : linkFormatter},	//제목					
					{name:'writer_id',			    index:'writer_id',				width:100,	align:"center" , sortable:true, editable:false , formatter : linkFormatter}, 	//Writer
					{name:'reg_dt',					index:'reg_dt',					width:100,	align:"center" , sortable:true,editable:true, editoptions:{dataInit:function(e) {$(e).datepicker();}}}, 	//등록일
					{name:'branch_in_charge_nm',	index:'branch_in_charge_nm',		width:180,	align:"center" , sortable:true, editable:true}, //담당지사
					{name:'reception_branch',		index:'reception_branch',		width:180,	align:"center" , sortable:true, editable:true,editoptions:{dataInit:function(e) {$(e).datepicker();}}}, 	//접수지사
					{name:'approver',				index:'approver',				width:80,	align:"center", sortable:true, editable:false}	, //승인
					{name:'btn',				    index:'btn',				    width:80,	align:"center", sortable:true, editable:false   }  //삭제  
				],
				autowidth: true,
				mtype:"post",
				//autowidth: true,	// 부모 객체의 width를 따른다
				rowNum:500,	   	
				//rowList:[20,50,100],
				height: 600,
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
//
			 
			// Link 처리
			function linkFormatter(cellVal, options, rowObj) {
				var params = "?mode=amend";
				var linkURL = '<a href="javascript:CenterOpenWindow(\'/cu/fn/CUFN02/popup' 
					    + params
						+ '&no=' + rowObj['debitcredit_no']
						+ '\', \'open\', \'900\', \'600\', \'scrollbars=yes, status=no\');">'
						+ cellVal + '</a>';
				return linkURL;
			}
			
			
			$("#btnAdd").on("click", function(){	//신규등록
				fn_f9();
			});
			
//			$("#btnSaveAddFn").click(function (){
//				fn_f10();
//			});

		});	
				
	
		//조회
		function fn_f3(){
			$("#searchForm").submit();
		}
		
		//신규등록
		function fn_f9(){
			CenterOpenWindow('/cu/fn/CUFN02/popup', 'open', '990', '580', 'scrollbars=yes, status=no');
		}
		
		//저장
		function fn_f10(){
			saveGridSelected("list1", 'selected', 'save', "/cu/fn/CUFN02/insert");
		}
		
		
		
				

		