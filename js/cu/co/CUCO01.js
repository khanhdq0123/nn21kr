		$(document).ready(function() {

			jQuery("#list1").jqGrid({
				url:'/partner/partnerListJson',
//				datatype: "json",				   
				datatype: "local",				   
				colNames:['고객코드','회사명', 'TEL', 'FAX', 'E-Mail','Memo'],
				colModel:[
					{name:'vendor_no',		index:'vendor_no',		width:80,	align:"center"},
					{name:'vendor_nm',		index:'vendor_nm',		width:320,	align:"left", formatter:partnerLinkFormatter},
					{name:'tel_txt',		index:'tel_txt',		width:80,	align:"center"},
					{name:'fax_txt',		index:'fax_txt',		width:80,	align:"center"},
					{name:'email_txt',		index:'email_txt',		width:120,	align:"center"},
					{name:'memo_txt',		index:'memo_txt',		width:140,	align:"center"},
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
				// 서버에러시 처리
				loadError : function(xhr,st,err) {
					girdLoadError();
			    },				    
			    // 데이터 로드 완료 후 처리 
			    loadComplete: function(data) {
			    	setSortingGridData(this, data);
			    }, 
			    // 그리드 부가 파라미터 정보
			    postData : serializeObject($('#searchForm')),
			 	// cell이 변경되었을 경우 처리
			    afterSaveCell : function(id, name, val, iRow, iCol) {
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
			CenterOpenWindow('/partner/partnerRegPop1.do', 'open', '980', '600', 'scrollbars=yes, status=no');
		}

		// Link 처리
		function partnerLinkFormatter(cellVal, options, rowObj) {
			var linkURL = '<a href="javascript:CenterOpenWindow(\'/partner/partnerListPop.do?vendor_no=' + rowObj['vendor_no'] + '\', \'open\', \'1200\', \'800\', \'scrollbars=yes, status=no\');">'+cellVal+'</a>';										
			return linkURL;
		}
		