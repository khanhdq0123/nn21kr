		
	var addRowNo = 10000;
	var route_no = '';	
	var startPortFlag = 1;
	var calcFlag = true;
						
	/* 환율정보 */								
	var cost_usd = 1;
	var cost_cny = 1;
	var cost_vnd = 100;
	var cost_jpy = 100;
	var cost_hkd = 1;
	var cost_eur = 1;
	var cost_idr = 100;
	var cost_php = 1;
	var cost_thb = 1;
	
	var unit_usd = 1;
	var unit_cny = 1;
	var unit_vnd = 1;
	var unit_jpy = 1;
	var unit_hkd = 1;
	var unit_eur = 1;
	var unit_idr = 1;
	var unit_php = 1;
	var unit_thb = 1;	
					
	$(document).ready(function() {
		
		fnEvenBind();
		
		jQuery('#costList').jqGrid({
			url: '/ad/pr/ADPR01/search',
			datatype: 'local',
		   	colNames: ['ord_no','청구회사','구분','항목명','단위','비용'
			],
			colModel: [
	            { name: 'ord_no', 			index: 'ord_no', 		hidden:true},
	            { name: 'charge_vendor_no', index: 'charge_vendor_no',	align: 'left', 		sortable: true, width: '200', editable:true, formatter:"select", edittype:"select", editoptions:{value:compList}},
	            { name: 'charge_typ', 		index: 'charge_typ', 		align: 'left', 		sortable: true, width: '100', editable:true, formatter:"select", edittype:"select", editoptions:{value:chargeTypeList}},
	            { name: 'pl_nm', 			index: 'pl_nm', 			align: 'left', 		sortable: true, width: '200', editable:true},
	            { name: 'unit_cd',			index: 'unit_cd',			align: 'center',	sortable: true, width: '50', editable:true, formatter:"select", edittype:"select", editoptions:{value:unitTypeList}},
				{ name: 'amt', 				index: 'amt', 				align: 'right', 	sortable: true, width: '100', editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}}
			],
			autowidth: true,
			height: 200,
			mtype: 'post',
		    multiselect : true,
		    cellEdit : true,
			cellsubmit : 'clientArray',
			gridview: true,			
			viewrecords: true,
			loadComplete: function(data) {
				setSortingGridData(this, data);
			}, 
			loadError: function(xhr,st,err) {
				girdLoadError();
		    },
		    afterEditCell:function(rowid, cellname, value, iRow, iCol){
			    $("#"+rowid+"_"+cellname).blur(function(){
			        $("#costList").jqGrid("saveCell",iRow,iCol);
			    });
			},
		    postData: serializeObject($('#submitForm'))
		});
		
		
		$("#submitForm").validate({
			rules: {
//				notice_typ: { required: true },
//				title_txt: { required: true, maxlength: 100 },
//				start_dt1: { required: true, dpDate: true },
//				start_dt2: { validTime: true },
//				end_dt1: { required: true, dpDate: true, dpCompareDate:{ notBefore: '#start_dt1' } },
//				end_dt2: { validTime: true },
//				imp_yn: { required: true },
//				use_yn: { required: true },
//				disp_seq: { required: true, number: true },
//				noti_area_typ: { required: true }
			},
			messages: {
				title_txt: { required: "제목을 입력하세요", maxlength: jQuery.format("제목은 최대 {0} 글자 이하로 입력하세요." ) }
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);  
			},
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {
				
				var returnValue = getGridDataToString('costList', 'all');

				$("#hdnGridData1").val(returnValue);

				$('#btnSave').off('click');
				
				var iframeId = 'unique' + (new Date().getTime());  //generate a random id
				var iframe = $('<iframe src="javascript:false;" name="'+iframeId+'"/>');  //create an empty iframe
				iframe.hide();  //hide it
				$('#submitForm').attr('target',iframeId);  //set form target to iframe			
				
				iframe.appendTo('body');  //Add iframe to body
				form.action = '/ve/or/VEOR02/chargeSave';
				form.method = 'post';
				form.submit();
				
				iframe.load(function(e) {
					
		            var doc = getDoc(iframe[0]);
		            var docRoot = doc.body ? doc.body : doc.documentElement;
		            var data = docRoot.innerHTML;
		            
		            $(window.opener.document).find("#btnSearch").trigger("click");
		            
					if (data == "0") {
						toast("등록하였습니다.");
						self.close();
					} else if (data == "-1") {
						toast("등록하신 첨부파일은 업로드 가능한 파일 확장자가 아닙니다");
						$('#btnSave').click(function() {
							$("#submitForm").submit();
						});
					} else {
						$('#btnSave').click(function() {
							$("#submitForm").submit();
						});
						ajaxError();
					}
					
		        });
			}
		});
		
		$("#btnAddRow").on("click", function(){

			var data = {
				charge_typ : '12701',
				charge_vendor_no : start_vendor_no,
				pl_nm : '',
				unit_cd : '11702',
				amt : '0'
			};
			
			$("#costList").addRowData(addRowNo, data, "last");

			addRowNo++;
		});
				
		fn_setRate();

	});






	function fn_setRate(){
		
		$.ajax({
			type: "POST",
			url: "/ad/ex/ADEX01/getRecentExchangeRate",
			data: $("#submitForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {

				if(data.info == null){
					toast('등록된 환율데이터가 없습니다.');
					return false;
				}

				cost_usd = data.info.cost_usd;
				cost_cny = data.info.cost_cny;
				cost_vnd = data.info.cost_vnd;
				cost_jpy = data.info.cost_jpy;
				cost_hkd = data.info.cost_hkd;
				cost_eur = data.info.cost_eur;
				cost_idr = data.info.cost_idr;
				cost_php = data.info.cost_php;
				cost_thb = data.info.cost_thb;
				unit_usd = data.info.unit_usd;
				unit_cny = data.info.unit_cny;
				unit_vnd = data.info.unit_vnd;
				unit_jpy = data.info.unit_jpy;
				unit_hkd = data.info.unit_hkd;
				unit_eur = data.info.unit_eur;
				unit_idr = data.info.unit_idr;
				unit_php = data.info.unit_php;
				unit_thb = data.info.unit_thb;
				
			}
		});
		
	}
	
	var itemSeq = 1;
			
	function fnItemDelete(){
		var selRows = $("#itemList").getGridParam('selarrrow');
		if(selRows.length==0) {
			toast('삭제할 항목을 선택하세요.');
		}
		for(var i=selRows.length-1; i>=0; i--) {
			$('#itemList').delRowData(selRows[i]);
		}
	}
	
	
	var shipperFileSeq = 1;
	var consigneeFileSeq = 1;

	var region_flag = 1;
			

			
	function fnEvenBind(){
		$(".select-layer1 ul li").on("click", function(){
			var cd = $(this).attr("cd");
			var nm = $(this).attr("nm");

			$('#' + retCdId).val(cd);
			$('#' + retNmId).val(nm);
			
			fnCloseLayer(selectLayerId);
		});
		
		
		$("#btnDelete").on("click", function(){
			fn_f11();
		});
		
		//운임확정
		$("#btnFixCharge").on("click", function(){
			fnFixCharge();
		});
		
		$("#btnSave2").on("click", function(){
			fn_f10();
		});
		


		$("#route_no").on("change", function(){
			searchContentsData();
		});

		
		$("input:text").focus(function(){
			this.select();
		});


		$("#btnCalc").on("click", function(){
			fn_calc();
		});

		$("input[name=charge_target_typ]").on("click",function(){
			searchContentsData();
		});
		
		
		$("#s_charge_unit,#r_charge_unit").val('11702');

	}
	
	

	function fn_f10(){

		var selRows = $("#costList").getGridParam('selarrrow');
		var chkFlag = false;
		var chkMsg = '';
		
		if(selRows.length == 0){
			toast('저장할 항목이 없습니다.'); return;
		}
		
		if(selRows.length > 0){
			
			for(var i=0; i<selRows.length; i++) {
				$('#costList').jqGrid('setCell', selRows[i], 'ord_no', ord_no);
				
				if($("#costList").getRowData(selRows[i])['charge_vendor_no'] == ''){
					chkFlag = true;
					chkMsg = "정산지사를 선택하세요.";
				}
				
				if($("#costList").getRowData(selRows[i])['charge_typ'] == ''){
					chkFlag = true;
					chkMsg = "정산구분을 선택하세요.";
				}
				
				if($("#costList").getRowData(selRows[i])['unit_cd'] == ''){
					chkFlag = true;
					chkMsg = "(화폐)단위를 선택하세요.";
				}
				
				if($("#costList").getRowData(selRows[i])['amt'] == ''){
					chkFlag = true;
					chkMsg = "비용(을) 입력하세요.";
				}

			}
		}

		if(chkFlag){
			toast(chkMsg);
			return false;
		}

		if(calcFlag){
			toast('계산버튼을 클릭하여 합계금액을 확인 후 확정버튼을 눌러주세요.');
			return false;
		}

		$("#submitForm").submit();

		//saveGridSelected("costList", 'selected', 'save', "/ve/or/VEOR02/chargeSave");
					
	}	
	
	function fn_f11(){
		
		if(confirm('삭제하시겠습니까?')==true) {
		
			$.ajax({
				type: "POST",
				url: "/ve/or/VEOR01/deleteOrder",
				data: $('#submitForm').serialize(),
				dataType: 'json',
				contentType: 'application/x-www-form-urlencoded; charset=utf-8',
				success: function(data) {
					if(data.code != '0') {
						toast(data.msg);
						opener.fn_f3();
						window.close();
					} else {
						toast('삭제에 실패하였습니다.');
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					toast(jqXHR.status);						
				}
			});
		}
	}




	
	/* 레이어팝업 */
	var retCdId = '';
	var retNmId = '';
	var selectLayerId = '';
	
	function fnSelectLayer(_tit, _layerId, _retCdId, _retNmId){
		
		selectLayerId = _layerId;
		retCdId = _retCdId;
		retNmId = _retNmId;
		$(".layer-mask").show();
		var $layer = $('#' + _layerId);
		$layer.center();
		$layer.show();
		$layer.find(".tit").text(_tit);
	}
	
	function fnCloseLayer(id){
		$(".layer-mask").hide();
		$('#' + selectLayerId).hide();	
	}


	//운임확정 팝업호출
	function fnFixCharge(){
		var ord_no = $("#ord_no").val();
		CenterOpenWindow('/ve/or/VEOR02/popup2?ord_no=' + ord_no,'open2','1000','720','scrollbars=yes, status=no');
	}



	function searchContentsData() {

		$("#costList").setGridParam({
			datatype: "json",
			page : 1,
			postData : $("#submitForm").serialize(),
		}).trigger("reloadGrid");
	}
			
			
	function fn_calc(){

		calcFlag = false;
		
		var selRows = $("#costList").getGridParam('data');

		var s_sum = 0;
		var r_sum = 0;
		
		$.each(selRows, function(i, d) {
			
			if(d.charge_vendor_no == send_no){
				s_sum += parseInt(fn_exchange(d.unit_cd, d.amt));
			} else if(d.charge_vendor_no == receive_no) {
				r_sum += parseInt(fn_exchange(d.unit_cd, d.amt));
			}
	
		});
		
		
		var s_charge_unit = $("#s_charge_unit").val();
		var r_charge_unit = $("#r_charge_unit").val();
		
		s_sum = fn_unexchange(s_charge_unit, s_sum);
		r_sum = fn_unexchange(r_charge_unit, r_sum);
		
		s_sum = parseInt(s_sum);
		r_sum = parseInt(r_sum);
		
		$("#s_sum_charge").val(gfn_comma(s_sum));
		$("#r_sum_charge").val(gfn_comma(r_sum));
				
	}			
			

	function fn_exchange(unit, amt){
		var retVal = 0;
		
		switch(unit){
			case '11701': retVal = cost_cny * amt / unit_cny;  break;
			case '11702': retVal = amt;  break;
			case '11703': retVal = cost_usd * amt / unit_usd;  break;
			case '11704': retVal = cost_jpy * amt / unit_jpy;  break;
		}
		
		return retVal;
	}			
			
	function fn_unexchange(unit, amt){
		var retVal = 0;
		
		switch(unit){
			case '11701': retVal = unit_cny * amt / cost_cny;  break;
			case '11702': retVal = amt;  break;
			case '11703': retVal = unit_usd  * amt / cost_usd;  break;
			case '11704': retVal = unit_jpy  * amt / cost_jpy;  break;
		}
		
		return retVal;
	}	
			
	