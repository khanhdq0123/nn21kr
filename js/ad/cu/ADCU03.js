


		$(document).ready(function() {
						
			jQuery("#list1").jqGrid({
				url:'/ad/cu/ADCU03/search',
//				datatype: "json",				   
				datatype: "local",				   
				colNames:['지사','고객사','직원정보'],
				colModel:[
					{name:'vendor_nm',		index:'vendor_nm',		width:180,		align:"left", cellattr: catMerge},
//					{name:'vendor_staff_info',		index:'vendor_staff_info',		width:180,		align:"left", cellattr: catMerge},
//					{name:'vendor_no',		index:'vendor_no',		width:100,		align:"left"},
//					{name:'comp_no',		index:'comp_no',		width:100,		align:"left"},
					{name:'comp_nm',		index:'comp_nm',		width:180,		align:"left"},
					{name:'staff_info',		index:'staff_info',		width:500,		align:"left"},
				],
				mtype:"post",
				//autowidth: true,	// 부모 객체의 width를 따른다
				rowNum:500,	   	
				//rowList:[20,50,100],
				height: 600,
				// pager: '#pager1',
				pager: '',
			    //viewrecords: true,	
//			    multiselect : true,
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
			    gridComplete: function() {  // 그리드 생성 후 호출되는 이벤트
				    var grid = this;
				    $('td[rowspan="1"]', grid).each(function () {
						var spans = $('td[rowspanid="' + this.id + '"]', grid).length + 1;
				      	if (spans > 1) {
				        	$(this).attr('rowspan', spans);
				      	}
				    });
			  	},
			    // 그리드 부가 파라미터 정보
			    postData : serializeObject($('#searchForm')),
			 	// cell이 변경되었을 경우 처리
			    afterSaveCell : function(id, name, val, iRow, iCol) {
			    	checkWhenColumnUpdated("list1", id);
			    }		
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


			$("#searchForm").validate({
				debug : true,
				rules : {		
					regdt_from:{
						dpDate:true
					},
					regdt_to:{
						dpDate:true,
						dpCompareDate:{notBefore:'#regdt_from'}
					}
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

			//새로등록
			$('#btnAdd').click(function (){
				CenterOpenWindow('/partner/joinMembership2', 'open', '1200', '720', 'scrollbars=yes, status=no');
			});

			// Link 처리
			function partnerLinkFormatter(cellVal, options, rowObj) {
				var linkURL = '<a href="javascript:CenterOpenWindow(\'/partner/partnerListPop.do?vendor_no=' + rowObj['vendor_no'] + '\', \'open\', \'1200\', \'800\', \'scrollbars=yes, status=no\');">'+cellVal+'</a>';										
				return linkURL;
			}

		});	
		

		
		
		function fn_f3(){
			$('#list1').clearGridData();
			$("#searchForm").submit();
			
		}
		
		function fn_f9(){
			CenterOpenWindow('/partner/joinMembership2', 'open', '1200', '720', 'scrollbars=yes, status=no');
		}
		
		
		
		
		
		