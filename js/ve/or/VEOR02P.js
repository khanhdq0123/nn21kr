		
		
	var startPortFlag = 1;
								
	$(document).ready(function() {
		
		fnEvenBind();
		
		// 그리드 - 프로토타입 
		jQuery('#itemList').jqGrid({
			url: '/common/getOrderItemList',
			datatype: 'json',
		   	colNames: [	'No', '품명', '스타일번호', '재질', '수량', '단가','총금액','포장수량','체적', '중량'
			],
			colModel: [
				{ name: 'item_no_txt', 		index: 'item_no_txt', 	align: 'center', sortable: true, width: '40', editable:true},
	            { name: 'item_nm', 			index: 'item_nm', 		align: 'center', width: '80', sortable: false, editable:true},
	            { name: 'item_sty_no', 		index: 'tiem_sty_no', 	align: 'center', sortable: true, width: '300', editable:true},
	            { name: 'item_material', 	index: 'item_material', align: 'left', sortable: true, width: '90', editable:true},
	            { name: 'qty', 				index: 'qty', 			align: 'right', sortable: true, width: '70', editable:true, formatter:'integer', formatoptions : { defaultValue: '', thousandsSeparator : ','}},
	            { name: 'amt', 				index: 'amt', 			align: 'right', sortable: true, width: '70', editable:true, formatter:'integer', formatoptions : { defaultValue: '', thousandsSeparator : ','}},
	            { name: 'tot_amt', 			index: 'tot_amt', 		align: 'right', sortable: true, width: '70', editable:true, formatter:'integer', formatoptions : { defaultValue: '', thousandsSeparator : ','} },
	            { name: 'box_qty', 			index: 'box_qty', 		align: 'right', sortable: true, width: '70', editable:true},
	            { name: 'kg', 				index: 'kg', 			align: 'right', sortable: true, width: '70', editable:true},
	            { name: 'cbm', 				index: 'cbm', 			align: 'right', sortable: true, width: '70', editable:true}
			],
			autowidth: true,
			height: 120,
			cellsubmit : 'clientArray',
			cellEdit : false,
			gridview:true,
			editable:false,
			multiselect: false,
			postData: { 
				ord_no : $("#ord_no").val()
			},
			gridComplete: function() {  // 그리드 생성 후 호출되는 이벤트
//				console.log(35);
		  	}
		});


		//$("#itemList").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
		
		//$("#itemList").trigger("reloadGrid");
		
	});

	function fnSetSelectPortInfo(_country, _city, _region1, _region2, _countryNo, _cityNo, _region1No, _region2No){

		if(startPortFlag == 1){
			
			$("#st_region2_nm").val(_country);
			$("#st_region4_nm").val(_city);
			$("#st_region5_nm").val(_region1);
			$("#st_region6_nm").val(_region2);
			
			$("#st_region2").val(_countryNo);
			$("#st_region4").val(_cityNo);
			$("#st_region5").val(_region1No);
			$("#st_region6").val(_region2No);
		} else {
			$("#ar_region2_nm").val(_country);
			$("#ar_region4_nm").val(_city);
			$("#ar_region5_nm").val(_region1);
			$("#ar_region6_nm").val(_region2);
			
			$("#ar_region2").val(_countryNo);
			$("#ar_region4").val(_cityNo);
			$("#ar_region5").val(_region1No);
			$("#ar_region6").val(_region2No);
		}
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
		

		
		//픽업등록
		$("#btnRegPickup").on("click", function(){
			fnSelectLayer('픽업등록','pickupRegLayerPop','','');
		});
		
		//배송등록
		$("#btnRegDelivery").on("click", function(){
			fnSelectLayer('배송등록','deliveryRegLayerPop','','');
		});
		
		//픽업등록 저장
		$("#btnSave1").on("click", function(){		
			$("#gForm1").submit();
		});
		
		//배송등록 저장
		$("#btnSave2").on("click", function(){
			$("#gForm2").submit();
		});
		
		$("input:text").focus(function(){
			this.select();
		});

		//픽업등록 저장
		$("#gForm1").validate({
			debug : true,
			rules : {
				from_dt:{	required: true	},
				to_dt:{		required: true	}
			},
			messages: {
				from_dt:{	required:"출발일을 선택하세요"},
				to_dt:{	required:"도착예정일을 선택하세요"}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
	        },
			errorPlacement: function(error, element) {
				// nothing
			},
			submitHandler: function(form) {
	
	
				$.ajax({
					type: "POST",
					url: "/ve/or/VEOR02/insertOrdPickup",
					data: $(form).serialize(),
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						if(data.code != 0){
							
							toast('저장되었습니다.');
							
	
						} else {
							toast('저장이 실패되었습니다.');
						}
						fnCloseLayer('pickupRegLayerPop');
					},
					error: function(jqXHR, textStatus, errorThrown) {
						toast(textStatus.msg);						
					}
				});
				
			}
		});
		
		//배송등록 저장
		$("#gForm2").validate({
			debug : true,
			rules : {
				from_dt:{	required: true	},
				to_dt:{		required: true	}
			},
			messages: {
				from_dt:{	required:"출발일을 선택하세요"},
				to_dt:{	required:"도착예정일을 선택하세요"}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
	        },
			errorPlacement: function(error, element) {
				// nothing
			},
			submitHandler: function(form) {
	
	
				$.ajax({
					type: "POST",
					url: "/ve/or/VEOR02/insertOrdDelivery",
					data: $(form).serialize(),
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						if(data.code != 0){
							
							toast('저장되었습니다.');
							
	
						} else {
							toast('저장이 실패되었습니다.');
						}
						fnCloseLayer('pickupRegLayerPop');
					},
					error: function(jqXHR, textStatus, errorThrown) {
						toast(textStatus.msg);						
					}
				});
				
			}
		});
		
	}
	
	

	function fn_f10(){
				
		if($("#wh_no").val() == ''){
			toast('창고를 선택하세요');	return false;
		}
		if($("#stored_dt").val() == '' || $("#stored_dt_hh").val() == '' || $("#stored_dt_mi").val() == ''){
			toast('입고일시을 선택하세요');	return false;
		}
		if($("#box_cnt").val() == ''){
			toast('수량을 입력하세요');	return false;
		}
		if($("#weight").val() == ''){
			toast('weight 를 입력하세요');	return false;
		}
		if($("#cbm").val() == ''){
			toast('CBM 을 입력하세요');	return false;
		}

		$.ajax({
			type: "POST",
			url: "/ve/or/VEOR01/insertOrdWh",
			data: $("#gForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code != 0){
					toast('저장되었습니다.');
				} else {
					toast('저장이 실패되었습니다.');
				}
				fnCloseLayer('selectStoreInLayerPop');
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);	
				fnCloseLayer('selectStoreInLayerPop');					
			}
		});
					
	}	
	
	function fn_f11(){
		
		if(confirm('삭제하시겠습니까?')==true) {
		
			$.ajax({
				type: "POST",
				url: "/ve/or/VEOR01/deleteOrder",
				data: $('#gForm').serialize(),
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




			
			
			
			
			
			
			
			
			