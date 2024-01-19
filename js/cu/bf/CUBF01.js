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
			url: '/cu/bf/CUBF01/selectBusinessFormList',
			datatype: 'local',
		   	colNames: ['businessform_no','businessform_typ','등록일시','제목','등록자'
			],
			colModel: [
	            { name: 'businessform_no', 	index: 'businessform_no', 		hidden:true},
	            { name: 'businessform_typ', 	index: 'businessform_typ',  	hidden:true},
	            { name: 'reg_dt',		index: 'reg_dt',	align: 'center', 	sortable: true, width: '100'},
	            { name: 'title_txt',	index: 'title_txt',	align: 'left', 	sortable: true, width: '400', formatter : linkFormatter},
	            { name: 'reg_id', 		index: 'reg_id', 	align: 'center', 		sortable: true, width: '100'}
			],
			autowidth: true,
			height: 500,
			pager: '#pager1',
			rowNum: 20,
			rowList: [20, 50, 100, 1000],
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
			var linkURL = '<a href="javascript:CenterOpenWindow(\'/cu/bf/CUBF01/popup1' 
					+ '?businessform_no=' + rowObj['businessform_no']
					+ '\', \'open\', \'900\', \'640\', \'scrollbars=yes, status=no\');">'
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

		// jQuery validation
		$("#searchForm").validate({
			rules: {
				title_txt: {maxlength: 100},
				search_start_dt: {dpDate: true},
				search_end_dt: {dpDate: true, dpCompareDate:{notBefore: '#search_start_dt'}}
			},
			messages: {
				title_txt: {maxlength: jQuery.format("제목은 최대 {0} 글자 이하로 입력하세요.")},
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
	});
	
	
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
	CenterOpenWindow('/cu/bf/CUBF01/popup?node=new', 'open', '1000', '640', 'scrollbars=yes, status=no');
}

//저장
function fn_f10(){
	saveGridSelected("list1", 'selected', 'save', "/cu/bf/CUBF01/update");
}

//삭제
function fn_f11(){
	saveGridSelected("list1", 'selected', 'delete', "/cu/bf/CUBF01/delete");
}
	
	
	
	