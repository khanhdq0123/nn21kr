
	$(document).ready(function() {

		// 그리드 - 프로토타입 
		jQuery('#list1').jqGrid({
			url: '/ve/or/VEOR09/selectTransportOrdList',
			datatype: 'local',
		   	colNames: ['tp_no','발화인','수취인','도착지','출발일','도착일','화물수량','중량','CBM'
			],
			colModel: [
	            { name: 'tp_no', 			index: 'tp_no', 			align: 'center', 	sortable: true, width: '70', hidden:true},
	            { name: 'send_cd', 		index: 'send_cd', 		align: 'center', 	sortable: true, width: '80'},
	            { name: 'receive_info', 		index: 'receive_info', 		align: 'left', 	sortable: true, width: '250', formatter : linkFormatter},
	            { name: 'receive_region_nm', 		index: 'receive_region_nm', 		align: 'left', 	sortable: true, width: '200'},
	            { name: 'start_dt', 		index: 'start_dt', 		align: 'center', 	sortable: true, width: '80', formatter : linkFormatterOrd},
	            { name: 'arrive_dt', 		index: 'arrive_dt', 		align: 'center', 	sortable: true, width: '80', formatter : linkFormatterOrd},
	            { name: 'box_qty', 		index: 'box_qty', 		align: 'center', 	sortable: true, width: '70'},
	            { name: 'kg', 		index: 'kg', 		align: 'center', 	sortable: true, width: '70', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}},
	            { name: 'cbm', 		index: 'cbm', 		align: 'center', 	sortable: true, width: '70'},
			],			
			autowidth: true,
			height: 500,
//			pager: '#pager1',
//			rowNum: 20,
//			rowList: [20, 50, 100, 1000],
			mtype: 'post',
			viewrecords: true,
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
//			onPaging: function(btn) {
//				if($('#'+btn).hasClass('ui-state-disabled')) {
//					return 'stop';
//				} else { 
//					$('#list1').jqGrid('clearGridData').jqGrid('setGridParam',{ datatype:'json' });
//					return true;
//				}
//			},
			loadError: function(xhr,st,err) {
				girdLoadError();
		    },
		    postData: serializeObject($('#searchForm'))
		});
		
		function linkFormatter(cellVal, options, rowObj) {	
			var _cd = rowObj['receive_cd'] == null ? '' : '[' + rowObj['receive_cd'] + '] ';
	 		var linkURL = _cd + rowObj['receive_nm'] ;
			return linkURL;
		}

		function linkFormatterOrd(cellVal, options, rowObj) {
			var linkURL = '';
			linkURL += '<a href="/ve/or/VEOR01/detail?ord_no=' + rowObj['ord_no'] + '&screen_id=VEOR01D&menu_nm=접수상세&js_url=/ve/or/VEOR01D">';
			linkURL += cellVal;
			linkURL += '</a>';		
			return linkURL;
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
		
		
		//btnTpMsn
		$("#btnTpMsn").on("click",function(){
			fnUpdateTpMsn();
		});
		
		//btnInsertTpComment
		$("#btnInsertTpComment").on("click",function(){
			fnInsertTpComment();
		});
		
		$("#searchForm").on("change",function (){
			$('#list1').clearGridData();
			$("#searchForm").submit();
		});
	
		fn_f3();			//로딩시 호출	
		fnSetTpComment();	//코멘트
	
	});
	
	function fnSetTpComment(){
		
		var data ={};
		data.tp_no = $("#tp_no").val();
		
		$.ajax({
			type: "POST",
			url: '/ve/or/VEOR09/selectTransportCommentList',
			data: data,
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				
				var _html = '';

				$(data.rows).each(function(i,d){
					_html += '<p><span>' + d.tp_comment + '</span><input type="button" onclick="fnDelTpComment(' + d.tp_comment_no + ');" class="btn btn-danger btn-xs ml10" value="삭제"></p>';
					_html += '<p><span class="gray">' + d.reg_dt + ' &nbsp;&nbsp;&nbsp; ' + d.reg_id +  '</span></p>';
				});
					

				
				$("#tp_comment_wrap").html(_html);

			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	//fnDelTpComment
	function fnDelTpComment(_no){

		var data ={};
      	data.tp_comment_no = _no;

		$.ajax({
			type: "POST",
			url: '/ve/or/VEOR09/deleteTransportComment',
			data: data,
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code != '0') {
					fnSetTpComment();
					toast('삭제되었습니다.');
				} else {
					toast('삭제실패!');
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
		
	}
	
	function fnInsertTpComment(){
		
		if($("#tp_comment").val() == ''){
			toast('코멘트를 입력하세요.');
			$("#tp_comment").focus();
			return false;
		}
		
		var data ={};
      	data.tp_no = $("#tp_no").val();
      	data.tp_comment = $("#tp_comment").val();

		$.ajax({
			type: "POST",
			url: '/ve/or/VEOR09/insertTransportComment',
			data: data,
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code != '0') {
					fnSetTpComment();
					toast('저장되었습니다.');
				} else {
					toast('저장실패!');
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
		
	}
	
	function fnUpdateTpMsn(){
		
		var data ={};
      	data.tp_no = $("#tp_no").val();
      	data.mrn = $("#mrn").val();
		data.msn = $("#msn").val();

		$.ajax({
			type: "POST",
			url: '/ve/or/VEOR09/updateTransportMst',
			data: data,
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code != '0') {
					toast('저장되었습니다.');
				} else {
					toast('저장실패!');
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
		
	}
	

	// Link 처리
	function linkFormatter(cellVal, options, rowObj) {
		var linkURL = '';
 		linkURL += '<a href="javascript:CenterOpenWindow(\'/ve/or/VEOR09/popup' + '?ord_no=' + rowObj['ord_no'] + '\', \'open\', \'1280\', \'780\', \'scrollbars=yes, status=no\');">';
				
		if(rowObj['transport_way_nm'] != null) linkURL += rowObj['transport_way_nm'];
		
		linkURL += '      ' + rowObj['start_dt'].substr(5,5) + '(' + rowObj['send_region_nm'] + ')';
		linkURL += ' ~ ' + rowObj['arrive_dt'].substr(5,5) + '(' + rowObj['receive_region_nm'] + ')';
		linkURL += '</a>';
				
		return linkURL;
	}

	//조회
	function fn_f3(){
		$('#list1').clearGridData();
		$("#searchForm").submit();
	}
	
	//신규등록
	function fn_f9(){
		//var url = "/order/orderRegForm";
		var url = "/ve/or/VEOR09/popup";
		var ord_typ = $("#ord_typ").val();
		var inout_typ = $("#inout_typ").val();
		
		url += ord_typ;
		url += "?inout_typ=" + inout_typ;
		
		CenterOpenWindow(url, '접수 등록', '1280','1024', 'scrollbars=yes, status=no');
	}
	
	
	