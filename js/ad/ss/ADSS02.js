	$(document).ready(function() {
		// 그리드 
		jQuery("#list1").jqGrid({
			url: "/system/board/boardListJson",
			datatype: "local",
		   	colNames: ['제목', '등록 일시','조회 수','다운로드 수'],
			colModel: [
				{ name: 'title_txt', index: 'title_txt', align: 'left', formatter : linkFormatter, unformat : linkUnFormatter, sortable: true, width: '480'}, 
				{ name: 'reg_dt', index: 'reg_dt', align: 'center', sortable: true, width: '100' }, 
				{ name: 'view_cnt', index: 'view_cnt', align: 'center', sortable: true, width: '60' },
				{ name: 'download_cnt', index: 'download_cnt', align: 'center', sortable: true, width: '60' }
			],
			autowidth: true,
			height: 500,
			pager: '#pager1',
// 			page:1,
// 			rows:20,
			rowNum: 10,
			rowList: [20, 50, 100],
	// 		shrinkToFit: false,
	// 		multiselect: true,
			mtype:"post",
			viewrecords: true,
			loadComplete: function(data) {
				setSortingGridData(this, data);
			}, 
			onPaging: function(btn) {
				if($('#'+btn).hasClass('ui-state-disabled')) {
					return 'stop';
				} else { 
					$("#list1").jqGrid("clearGridData").jqGrid('setGridParam',{ datatype:'json' });
					return true;
				}
			},
			loadError : function(xhr,st,err) {
				girdLoadError();
		    },
		    postData: serializeObject($("#searchForm"))  
		});
		
		// jqGrid linkFormatter
		function linkFormatter(cellVal, options, rowObj) {
			var params = "?mode=amend"
			var linkURL = '<a href="javascript:CenterOpenWindow(\'/system/board/sysBoardDetail4customer' + params + '&id='
					+ rowObj['board_no']
					+ '\', \'open\', \'1000\', \'800\', \'scrollbars=yes, status=no\');">'
					+ cellVal + '</a>';
			return linkURL;
		}
		
		// 신규등록 팝업
		$("#btnNewPost").click(function() {
			var width=1000, height=800;
			var params = "?mode=new"
			CenterOpenWindow("/system/board/sysBoardDetail4customer" + params, "_blank", width, height, "scrollbars=yes, status=no");
		});
			
		// 검색 날짜 채우기
		$("#spnSetReg button, #spnSetDisp button").click(function() {
			switch (this.id) {
			case 'btnRegSetToday': setSearchDate("reg_dt_from", "reg_dt_to", "today"); break;
			case 'btnRegSetWeekago': setSearchDate("reg_dt_from", "reg_dt_to", "weekago"); break;
			case 'btnRegSetMonthago': setSearchDate("reg_dt_from", "reg_dt_to", "monthago"); break;
			case 'btnDispSetToday': setSearchDate("disp_dt_from", "disp_dt_to", "today"); break;
			case 'btnDispSetWeekago': setSearchDate("disp_dt_from", "disp_dt_to", "weekago"); break;
			case 'btnDispSetMonthago': setSearchDate("disp_dt_from", "disp_dt_to", "monthago"); break;
			}
		});
		
		// grid 검색
//		jQuery("#btnSearch").click(function() {
//			$("#searchForm").submit();
//		});
		
		
		
		// 초기화 버튼
		$('#btnReset').click(function() {
			$('#searchForm')[0].reset();
		});
		
		// jQuery validation
		$("#searchForm").validate({
			rules: {
				title_txt: { maxlength: 100 },
				regstaff_id: { maxlength: 20 },
				reg_dt_from: { dpDate: true },
				reg_dt_to: { dpDate: true, dpCompareDate:{notBefore: '#reg_dt_from'} },
				disp_dt_from: { dpDate: true },
				disp_dt_to: { dpDate: true, dpCompareDate:{notBefore: '#disp_dt_from'} }
			},
			messages: {
				title_txt: { maxlength: jQuery.format("제목은 최대 {0} 글자 이하로 입력하세요.") },
				regstaff_id: { maxlength: jQuery.format("등록자 ID는 최대 {0} 글자 이하로 입력하세요.") },
				reg_dt_from: { dpDate: "등록일 검색 시작일자는 yyyy-mm-dd 형식으로 입력하세요." },
				reg_dt_to: {
					dpDate: "등록일 검색 종료일자는 yyyy-mm-dd 형식으로 입력하세요.",
					dpCompareDate: "등록일 검색 종료일은 시작일보다 같거나 이후 일자를 선택하세요."
				},
				disp_dt_from: { dpDate: "게시일 검색 시작일자는 yyyy-mm-dd 형식으로 입력하세요." },
				disp_dt_to: {
					dpDate: "게시일 검색 종료일자는 yyyy-mm-dd 형식으로 입력하세요.",
					dpCompareDate: "게시일 검색 종료일은 시작일보다 같거나 이후 일자를 선택하세요."
				}
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
	
	function fn_f3(){
		$("#searchForm").submit();
	}
	