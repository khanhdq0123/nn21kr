
	var addRowNo = 10000;
	var route_no = '';

	$(document).ready(function() {
		$("#spnSetReg button").click(function() {
			var when = '';
			if (this.id == 'btnRegSetToday') when = 'today';
			if (this.id == 'btnRegSetWeekago') when = 'weekago';
			if (this.id == 'btnRegSetMonthago') when = 'monthago';
			setSearchDate('search_start_dt', 'search_end_dt', when);
		});

		// 그리드 - 프로토타입 
		jQuery('#list1').jqGrid({
			url: '/ad/li/ADLI01/search',
			datatype: 'local',
		   	colNames: ['route_no','운송구분코드','지사코드','컨테이너 규격코드', '출발지코드', '도착지코드', '운송방법코드', 
		   				'관할지사','TITLE'
			],
			colModel: [
	            { name: 'route_no', 	index: 'route_no', 		hidden:true},
	            { name: 'trans_typ', 	index: 'trans_typ',  	hidden:true},
	            { name: 'vendor_no', 	index: 'vendor_no', 	align:'center', width: '40'},
	            { name: 'ct_size', 		index: 'ct_size', 		hidden:true},
	            { name: 'st_port_no', 	index: 'st_port_no', 	hidden:true},
	            { name: 'ar_port_no', 	index: 'ar_port_no', 	hidden:true},
	            { name: 'trans_way', 	index: 'trans_way', 	hidden:true},
	            { name: 'vendor_nm', 	index: 'vendor_nm', 	align: 'left', 	sortable: true, width: '80', formatter : codeLinkFormatter},
	            { name: 'route_nm',	index: 'route_nm',	align: 'left', 	sortable: true, width: '220', formatter : codeLinkFormatter}

			],
			autowidth: false,
			height: 500,
//			pager: '#pager1',
//			rowNum: 20,
//			rowList: [20, 50, 100, 1000],
			mtype: 'post',
			viewrecords: true,
			loadComplete: function(data) {
				setSortingGridData(this, data);
			}, 
			onPaging: function(btn) {
				if($('#'+btn).hasClass('ui-state-disabled')) {
					return 'stop';
				} else { 
					$('#list1').jqGrid('clearGridData').jqGrid('setGridParam',{ datatype:'json' });
					return true;
				}
			},
			loadError: function(xhr,st,err) {
				girdLoadError();
		    },
		    postData: serializeObject($('#searchForm'))
		});
		
		
		jQuery('#list2').jqGrid({
			url: '/ad/pr/ADPR01/search',
			datatype: 'local',
		   	colNames: ['pl_no','route_no',
		   				'TITLE','EXW','DDP','CNF','FOB','화폐','비용'
			],
			colModel: [
	            { name: 'pl_no', 		index: 'pl_no', 		hidden:true},
	            { name: 'route_no', 	index: 'route_no', 		hidden:true},
	            { name: 'pl_nm', 		index: 'pl_nm', 		align: 'left', 		sortable: true, width: '250', editable:true},
	            { name: 'exw',			index: 'exw',			align: 'center', 	sortable: true, width: '40', editable:true, formatter:"select", edittype:"select", editoptions:{value:"C:C;S:S"}},
				{ name: 'ddp',			index: 'ddp',			align: 'center', 	sortable: true, width: '40', editable:true, formatter:"select", edittype:"select", editoptions:{value:"C:C;S:S"}},
				{ name: 'cnf',			index: 'cnf',			align: 'center', 	sortable: true, width: '40', editable:true, formatter:"select", edittype:"select", editoptions:{value:"C:C;S:S"}},
				{ name: 'fob',			index: 'fob',			align: 'center', 	sortable: true, width: '40', editable:true, formatter:"select", edittype:"select", editoptions:{value:"C:C;S:S"}},
	            { name: 'unit_cd',		index: 'unit_cd',		align: 'center',	sortable: true, width: '30', editable:true, formatter:"select", edittype:"select", editoptions:{value:unitTypeList}},
				{ name: 'amt', 			index: 'amt', 			align: 'right', 	sortable: true, width: '60', editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}}
			],
			autowidth: false,
			height: 500,
			pager: '#pager1',
//			rowNum: 20,
//			rowList: [20, 50, 100, 1000],
			mtype: 'post',
		    multiselect : true,
		    cellEdit : true,
			cellsubmit : 'clientArray',
			gridview: true,			
			viewrecords: true,
			loadComplete: function(data) {
				setSortingGridData(this, data);
			}, 
			onPaging: function(btn) {
				if($('#'+btn).hasClass('ui-state-disabled')) {
					return 'stop';
				} else { 
					$('#list1').jqGrid('clearGridData').jqGrid('setGridParam',{ datatype:'json' });
					return true;
				}
			},
			loadError: function(xhr,st,err) {
				girdLoadError();
		    },
		    postData: serializeObject($('#searchForm'))
		});
		
		function codeLinkFormatter(cellVal, options, rowObj) {
				
				var cellval = String(cellVal);
				
				cellval = '<a href="javascript:searchContentsData(\'' + rowObj['route_no'] + '\',\'' + rowObj['route_nm'] + '\');" cellVal="'+ rowObj['route_no'] +'">'+cellval+'</a>';										
				
				return  cellval === "" ? $.fn.fmatter.defaultFormat(cellval,options) : cellval;
		}
		
		function codeUnLinkFormatter(cellVal, options, cell) {
			return $('a', cell).attr('cellVal');
		}

		

		
	    function catMerge(rowId, cellvalue, rowObject, cm, rdata){
	        var coltwo = rowObject.user_name;
// 	        if(coltwo == 1){
	        	return 'colspan=2;';
// 	        }
	    }
		
		// jqGrid Navigator
		jQuery('#list1').jqGrid('navGrid','#pager1',{search:false, edit:false, add:false, del:false, refresh:false});
	
		// Link 처리
		function linkFormatter(cellVal, options, rowObj) {
			var linkURL = '<a href="javascript:CenterOpenWindow(\'/ad/li/ADPR01/popup2' 
					+ '?route_no=' + rowObj['route_no']
					+ '\', \'open\', \'900\', \'500\', \'scrollbars=yes, status=no\');">'
					+ cellVal + '</a>';
			return linkURL;
		}
		
		// 검색 날짜 자동 채우기
		$('#spnSetReg button').click(function() {
			if (this.id == 'btnRegSetToday')
				setSearchDate('search_start_dt', 'search_end_dt', 'today');
			if (this.id == 'btnRegSetWeekago')
				setSearchDate('search_start_dt', 'search_end_dt', 'weekago');
			if (this.id == 'btnRegSetMonthago')
				setSearchDate('search_start_dt', 'search_end_dt', 'monthago');
		});
		
		// grid 검색
		$('#btnSearch').click(function() {
			$('#searchForm').submit();
		});
		
		// 초기화 버튼
		$('#btnReset').click(function() {
			$('#searchForm')[0].reset();
		});
		
		// 노선관리유형 불러오기
		if(typeList != null){	
			for (var loop = 0; loop < typeList.length; loop++) {
				var ele = typeList[loop];
				if (ele.parent_type_id == '0') {
					$('#upper_voc_type_id').append($('<option>', {
						value: ele.voc_type_id
					}).text(ele.voc_type_nm));
				}
			}
			
			$('#upper_voc_type_id').change(function() {
				$('#voc_type_id').empty();
				var upperTypeId = $(this).val();
				
				if (upperTypeId == '') {
					// 폼 데이터 초기화 문제가 발생하는 부분. 컨트롤러에서 처리한다.
					$('#voc_type_id').prop('disabled', true);
				} else {
					$('#voc_type_id').prop('disabled', false);
					$('#voc_type_id').append($('<option value="" selected="selected">').text('전체'));
					for (var loop = 0; loop < typeList.length; loop++) {
						var ele = typeList[loop];
						if (ele.parent_type_id == upperTypeId) {
							$('#voc_type_id').append($('<option>', {
								value: ele.voc_type_id
							}).text(ele.voc_type_nm));	
						}
					}
				}
				
			});
		}
		
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
		
		fn_f3();	//로딩시 호출
		
		
		
		$("#btnAddRow").on("click", function(){
			
			if(route_no == ''){
				toast('노선을 먼저 선택하세요.');
				return false;
			}

			var data = {
				route_no : route_no,
				pl_nm : '',
				unit_cd : '11701',
				exw : 'C',
				ddp : 'C',
				cnf : 'C',
				fob : 'C',
				amt : ''
			};
			
			$("#list2").addRowData(addRowNo, data, "last");

			addRowNo++;
		});
		
	});
	// ~ready
	
	
	
			
	
	
	function searchContentsData(_route_no, _route_nm) {
		
		route_no = _route_no;
		$("#tit_route_nm").html(_route_nm);
		
		contentsSubmit = true;
		
		$("#list2").setGridParam({
			datatype: "json",
			page : 1,
			postData : {
				route_no:function() {
					return route_no;
				},
				additionalParam:'dummy'
			},
		}).trigger("reloadGrid");
	}	
		
	//검색
	function fn_f3(){
		$('#searchForm').submit();
	}
	
	//리셋
	function fn_f4(){
		$('#searchForm').reset();
	}
	
	//신규등록
	function fn_f9(){
		CenterOpenWindow('/ad/pr/ADPR01/popup', 'open', '900', '500', 'scrollbars=yes, status=no');
	}
	
	//저장
	function fn_f10(){
		saveGridSelected("list2", 'selected', 'save', "/ad/pr/ADPR01/update");
	}
	
	//삭제
	function fn_f11(){
		saveGridSelected("list2", 'selected', 'delete', "/ad/pr/ADPR01/delete");
	}
		
	
	
	