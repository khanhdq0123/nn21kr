		
		
	var startPortFlag = 1;
								
	$(document).ready(function() {
		
		fnEvenBind();
		
		// 그리드 - 프로토타입 
				jQuery('#itemList').jqGrid({
					url: '/order/selectOrdItemList',
					datatype: 'local',
				   	colNames: [	'No', '품명', '스타일번호', '재질', '수량','단위', '단가','총금액','단위','포장수량','단위', '중량(Kg)','체적(CBM)'
					],
					colModel: [
						{ name: 'item_no_txt', 		index: 'item_no_txt', 	align: 'center', sortable: true, width: '80', editable:true},
			            { name: 'item_nm', 			index: 'item_nm', 		align: 'center', width: '80', sortable: false, editable:true},
			            { name: 'item_sty_no', 		index: 'tiem_sty_no', 	align: 'center', sortable: true, width: '300', editable:true},
			            { name: 'item_material', 	index: 'item_material', align: 'left', sortable: true, width: '90', editable:true},
			            { name: 'qty', 				index: 'qty', 			align: 'right', sortable: true, width: '50', editable:true,  formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}
			            	,editoptions : {
								dataEvents : [ {
									type : 'keyup',
									fn : function(e) {
										var rowId = e.target.parentElement.parentElement.rowIndex;
										var selRowData = $("#itemList").getRowData(rowId);
										var amt = parseInt(selRowData.amt);
										var qty = parseInt($(this).val());
										var tot_amt = qty * amt;
										$('#itemList').jqGrid('setCell', rowId, 'tot_amt', tot_amt);
					                	fnCalcItem();
									}
								}]
							}			            
			            },
			            { name: 'qty_unit',			index: 'qty_unit',		align: 'center',sortable: true, width: '40', editable:true, formatter:"select", edittype:"select", editoptions:{value:unitTypeList8}},
			            { name: 'amt', 				index: 'amt', 			align: 'right', sortable: true, width: '70', editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}, summaryType:'sum', summaryTpl: 'Totals1 :'
			            	,editoptions : {
								dataEvents : [ {
									type : 'keyup',
									fn : function(e) {
										var rowId = e.target.parentElement.parentElement.rowIndex;
										var selRowData = $("#itemList").getRowData(rowId);
										var amt = parseInt($(this).val());
										var qty = parseInt(selRowData.qty);
										var tot_amt = qty * amt;
										$('#itemList').jqGrid('setCell', rowId, 'tot_amt', tot_amt);
					                	fnCalcItem();
									}
								}]
							}
			            },
			            { name: 'tot_amt', 			index: 'tot_amt', 		align: 'right', sortable: true, width: '70', editable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}, summaryType:'sum', summaryTpl: 'Totals :'},
			            { name: 'amt_unit',			index: 'amt_unit',		align: 'center',sortable: true, width: '50', editable:false, formatter:"select", edittype:"select", editoptions:{value:unitTypeList7}},
			            { name: 'box_qty', 			index: 'box_qty', 		align: 'right', sortable: true, width: '70', editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}},
			            { name: 'box_qty_unit',		index: 'box_qty_unit',	align: 'center',sortable: true, width: '50', editable:true, formatter:"select", edittype:"select", editoptions:{value:unitTypeList9}},
			            { name: 'kg', 				index: 'kg', 			align: 'right', sortable: true, width: '70', editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}
			            	,editoptions : {dataEvents : [ {type : 'keyup', fn : function(e) {
//								var rowId = e.target.parentElement.parentElement.rowIndex;
//								var selRowData = $("#itemList").getRowData(rowId);
//								var kg = parseInt($(this).val());
//								$('#itemList').jqGrid('setCell', rowId, 'kg', "2");
								fnCalcItem();
							}}]}
			            },
			            { name: 'cbm', 				index: 'cbm', 			align: 'right', sortable: true, width: '70', editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}
			            	,editoptions : {dataEvents : [ {type : 'keyup', fn : function(e) {fnCalcItem();} }]}
			            },
					],
					autowidth: true,
					height: 120,
					cellsubmit : 'clientArray',
					cellEdit : true,
					gridview:true,
					editable:true,
					multiselect: true,
					footerrow: true, 	//합계표시하기
					userDataOnFooter : true,
					loadComplete: function(data) {
//						$('table.ui-jqgrid-ftable td:eq(3)').html('<input type="button" class="btn btn-primary btn-xs" value="calc" id="btnCalcItem" onclick="fnCalcItem();">').css("text-align", "right");
		                $('table.ui-jqgrid-ftable tr:first').children("td").css("background-color", "#dfeffc");
		                $('table.ui-jqgrid-ftable td:lt(4)').css("background-color", "#fff").css("border", "0px");
		                $('table.ui-jqgrid-ftable td:eq(4)').css("text-align", "center").css("border-left", "1px solid #a6c9e2").text("합계");
		                $('table.ui-jqgrid-ftable td:eq(6)').text("PCS");
		                $('table.ui-jqgrid-ftable td:eq(9)').text("$");
		                $('table.ui-jqgrid-ftable td:eq(11)').text("CT");
		                fnCalcItem();
					}, 
					afterEditCell:function(rowid, cellname, value, iRow, iCol){

					    $("#" + rowid + "_" + cellname).blur(function(){
					        $("#itemList").jqGrid("saveCell",iRow,iCol);
					    });

					    //fnCalcItem();
					},

				});

				$("#itemList").jqGrid('setGroupHeaders', {
	
					useColSpanStyle: true,
	
					  groupHeaders:[
	
						{ startColumnName: 'qty', 		numberOfColumns: 2, titleText: '수량/단위'},
						{ startColumnName: 'amt', 		numberOfColumns: 3, titleText: '단가/총금액/단위'},
						{ startColumnName: 'box_qty', 	numberOfColumns: 2, titleText: '포장수량/단위' },
	
					  ]
	
			    });


				$("#itemList").setGridParam({
					postData : serializeObject($('#searchForm'))
				});
				$("#itemList").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");


		//$("#itemList").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
		
		//$("#itemList").trigger("reloadGrid");
		
	});

	//화물 금액 계산		
	function fnCalcItem(){

		var qty =  $('#itemList').jqGrid('getCol', 'qty', false, 'sum').toLocaleString();
		var tot_amt =  $('#itemList').jqGrid('getCol', 'tot_amt', false, 'sum').toLocaleString();
		var box_qty =  $('#itemList').jqGrid('getCol', 'box_qty', false, 'sum').toLocaleString();
		var kg =  $('#itemList').jqGrid('getCol', 'kg', false, 'sum').toLocaleString();
		var cbm =  $('#itemList').jqGrid('getCol', 'cbm', false, 'sum').toLocaleString();

		if(qty != 'NaN') $('table.ui-jqgrid-ftable td:eq(5)').text(gfn_comma(qty));
		if(tot_amt != 'NaN') $('table.ui-jqgrid-ftable td:eq(8)').text(gfn_comma(tot_amt));
		if(box_qty != 'NaN') $('table.ui-jqgrid-ftable td:eq(10)').text(gfn_comma(box_qty));
		if(kg != 'NaN') $('table.ui-jqgrid-ftable td:eq(12)').text(gfn_comma(kg));
		if(cbm != 'NaN') $('table.ui-jqgrid-ftable td:eq(13)').text(gfn_comma(cbm));

	}

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
		
		$("#btnWarehousing").on("click", function(){
			
			
			var box_qty =  $('#itemList').jqGrid('getCol', 'box_qty', false, 'sum').toLocaleString();
			var kg =  $('#itemList').jqGrid('getCol', 'kg', false, 'sum').toLocaleString();
			var cbm =  $('#itemList').jqGrid('getCol', 'cbm', false, 'sum').toLocaleString();
				
				
			$("#box_cnt").val(box_qty);
			$("#weight").val(kg);
			$("#cbm").val(cbm);
			//unitTypeList7
			
			var selRowData = $("#itemList").getRowData(1);
			$("#packing_unit").val(selRowData['box_qty_unit']);
			
			fnSelectLayer('Store In','selectStoreInLayerPop','start_vendor_no','start_vendor_nm');
		});
		
		$("#btnSave2").on("click", function(){
			fn_f10();
		});
				
	}

	function fn_f10(){
				
		if($("#wh_no").val() == ''){
			toast('창고를 선택하세요');	return false;
		}
		if($("#stored_dt").val() == ''){
			toast('입고일자을 선택하세요');	return false;
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



		

			
			
			
			
			
			
			
			