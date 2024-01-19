		
		
var startPortFlag = 1;
var itemSeq = 0;

			$(document).ready(function() {
				
				fnEvenBind();
				
				// 그리드 - 프로토타입 
				jQuery('#itemList').jqGrid({
					url: '/order/selectOrdItemList',
					datatype: 'local',
				   	colNames: [	'No', '품명', '스타일번호', '재질', '수량','단위', '단가','총금액','단위','포장수량','단위', '중량(Kg)','체적(CBM)','c_qty','c_kg','c_cbm','c_box_qty'
					],
					colModel: [
						{ name: 'item_no_txt', 		index: 'item_no_txt', 	align: 'center', sortable: true, width: '80', editable:true
							,editoptions : {
								dataEvents : [ {
									type : 'keyup',
									fn : function(e) {
										var v = $(this).val();
										var box_qty = v.split('-')[1];
										var rowId = e.target.parentElement.parentElement.rowIndex;
										$('#itemList').jqGrid('setCell', rowId, 'box_qty', box_qty);
					                	fnCalcItem();
									}
								}]
							}
						},
			            { name: 'item_nm', 			index: 'item_nm', 		align: 'center', width: '250', sortable: false, editable:true},
			            { name: 'item_sty_no', 		index: 'tiem_sty_no', 	align: 'center', sortable: true, width: '100', editable:true},
			            { name: 'item_material', 	index: 'item_material', align: 'left', sortable: true, width: '90', editable:true},
			            { name: 'qty', 				index: 'qty', 			align: 'right', sortable: true, width: '50', editable:true,  formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}
			            	,editoptions : {
								dataEvents : [ {
									type : 'keyup',
									fn : function(e) {
										var rowId = e.target.parentElement.parentElement.rowIndex;
										var selRowData = $("#itemList").getRowData(rowId);
										var amt = selRowData.amt;
										var v = $(this).val();
										var tot_amt = v * amt;
										
										$('#itemList').jqGrid('setCell', rowId, 'c_qty', v);
										
										
										$('#itemList').jqGrid('setCell', rowId, 'tot_amt', tot_amt);
					                	fnCalcItem();
									}
								},{ type : 'click', fn : function(e) { $(this).val('');}}]
							}			            
			            },
			            { name: 'qty_unit',			index: 'qty_unit',		align: 'center',sortable: true, width: '40', editable:true, formatter:"select", edittype:"select", editoptions:{value:unitTypeList8}},
			            { name: 'amt', 				index: 'amt', 			align: 'right', sortable: true, width: '70', editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 3}, summaryType:'sum', summaryTpl: 'Totals1 :'
			            	,editoptions : {
								dataEvents : [ {
									type : 'keyup',
									fn : function(e) {
										var rowId = e.target.parentElement.parentElement.rowIndex;
										var selRowData = $("#itemList").getRowData(rowId);
										var amt = $(this).val();
										var qty = selRowData.qty;
										var tot_amt = qty * amt;
										$('#itemList').jqGrid('setCell', rowId, 'tot_amt', tot_amt);
					                	fnCalcItem();
									}
								},{ type : 'click', fn : function(e) { $(this).val('');}}]
							}
			            },
			            { name: 'tot_amt', 			index: 'tot_amt', 		align: 'right', sortable: true, width: '70', editable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2}, summaryType:'sum', summaryTpl: 'Totals :'},
			            { name: 'amt_unit',			index: 'amt_unit',		align: 'center',sortable: true, width: '50', editable:false, formatter:"select", edittype:"select", editoptions:{value:unitTypeList7}},
			            { name: 'box_qty', 			index: 'box_qty', 		align: 'right', sortable: true, width: '70', editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2}
			            	,editoptions : {
								dataEvents : [ {
									type : 'keyup',
									fn : function(e) {
										var v = $(this).val();
										var rowId = e.target.parentElement.parentElement.rowIndex;
										$('#itemList').jqGrid('setCell', rowId, 'c_box_qty', v);
					                	fnCalcItem();
									}
								},{ type : 'click', fn : function(e) { $(this).val('');}}]
							}
			            },
			            { name: 'box_qty_unit',		index: 'box_qty_unit',	align: 'center',sortable: true, width: '50', editable:true, formatter:"select", edittype:"select", editoptions:{value:unitTypeList9}},
			            { name: 'kg', 				index: 'kg', 			align: 'right', sortable: true, width: '70', editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2}
			            	,editoptions : {
								dataEvents : [ {
									type : 'keyup',
									fn : function(e) {
										var v = $(this).val();
										var rowId = e.target.parentElement.parentElement.rowIndex;
										$('#itemList').jqGrid('setCell', rowId, 'c_kg', v);
					                	fnCalcItem();
									}
								},{ type : 'click', fn : function(e) { $(this).val('');}}]
							}
			            },
			            { name: 'cbm', 				index: 'cbm', 			align: 'right', sortable: true, width: '70', editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2}
			            	,editoptions : {
								dataEvents : [ {
									type : 'keyup',
									fn : function(e) {
										var v = $(this).val();
										var rowId = e.target.parentElement.parentElement.rowIndex;
										$('#itemList').jqGrid('setCell', rowId, 'c_cbm', v);
					                	fnCalcItem();
									}
								},{ type : 'click', fn : function(e) { $(this).val('');}}]
							}
			            },
			            { name: 'c_qty',		index: 'c_qty',		hidden:true},
			            { name: 'c_kg',			index: 'c_kg',		hidden:true},
			            { name: 'c_cbm',		index: 'c_cbm',		hidden:true},
			            { name: 'c_box_qty',	index: 'c_box_qty',	hidden:true},
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
						$('table.ui-jqgrid-ftable td:eq(3)').html('<input type="button" class="btn btn-primary btn-xs" value="calc" id="btnCalcItem" onclick="fnCalcItem();">').css("text-align", "right");
		                $('table.ui-jqgrid-ftable tr:first').children("td").css("background-color", "#dfeffc");
		                $('table.ui-jqgrid-ftable td:lt(4)').css("background-color", "#fff").css("border", "0px");
		                $('table.ui-jqgrid-ftable td:eq(4)').css("text-align", "center").css("border-left", "1px solid #a6c9e2").text("합계");
		                $('table.ui-jqgrid-ftable td:eq(6)').text("PCS");
		                $('table.ui-jqgrid-ftable td:eq(9)').text("$");
		                $('table.ui-jqgrid-ftable td:eq(11)').text("CT");
		                fnCalcItem();
		                
		                itemSeq = $("#itemList").getRowData().length;
		                
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

				$("#submitForm").validate({
					debug : true,
					rules : {
//						trans_typ1:{required:true, maxlength:20},
//						trans_typ2:{required:true, maxlength:20},
//						st_region2:{required:true, maxlength:20},
//						st_region4:{required:true, maxlength:20}
					}, 		
					messages: {
//						trans_typ1:{
//							required:"운송구분1을 선택하세요.",
//							maxlength:jQuery.format("지역명은 최대 20자 이하로 입력하세요.")
//						},
					},
					onfocusout:false,
					invalidHandler: function(form, validator) {
						showValidationError(form, validator);               
		            },
					errorPlacement: function(error, element) {},
					submitHandler: function(form) {			

						if($("#send_region_no").val()==''){
							toast('출발지점을 선택하세요.'); return false;
						}
						
						if($("#receive_region_no").val()==''){
							toast('도착지점을 선택하세요.'); return false;
						}
						
						if($("#send_no").val()==''){
							toast('발송화주를 선택하세요.'); return false;
						}
						
						if($("#receive_no").val()==''){
							toast('수입화주를 선택하세요.'); return false;
						}
						
						if($("#start_dt").val()==''){
							toast('출발일자를 선택하세요.'); return false;
						}
						
						if(ord_no == '' && gfn_is_past_date($("#start_dt").val())){
							toast('출발일자는 현재일자보다 빠를 수 없습니다.'); return false;
						}
						
						if($("#arrive_dt").val()==''){
							toast('도착일자를 선택하세요.'); return false;
						}
						
						if(ord_no == '' && gfn_is_past_date($("#arrive_dt").val())){
							toast('도착일자는 현재일자보다 빠를 수 없습니다.'); return false;
						}
						
						if($("#shipment_dt").val()==''){
							toast('선적일자를 선택하세요.'); return false;
						}
						
						if(ord_no == '' && gfn_is_past_date($("#shipment_dt").val())){
							toast('선적일자는 현재일자보다 빠를 수 없습니다.'); return false;
						}
						
						if(gfn_compare_date($("#start_dt").val(), $("#arrive_dt").val())){
							toast('도착일자는 출발일자보다 빠를 수 없습니다.'); return false;
						}
						
						if(gfn_compare_date($("#shipment_dt").val(), $("#start_dt").val())){
							toast('출발일자는 선적일자보다 빠를 수 없습니다.'); return false;
						}
							
						if(gfn_compare_date($("#start_dt").val(), $("#arrive_dt").val())){
							toast('도착일자는 출발일자보다 빠를 수 없습니다.'); return false;
						}

						if($("#transport_way").val()==''){
							toast('운송구분을 선택하세요.'); return false;
						}

						
						if(!fnItemCheck()){
							return false;
						}
		
						var returnValue = getGridDataToString('itemList', 'all');
						$("#hdnGridData1").val(returnValue);

						// turnOffSaveButton
						$('#btnSave').off('click');
						
						var iframeId = 'unique' + (new Date().getTime());  //generate a random id
						var iframe = $('<iframe src="javascript:false;" name="'+iframeId+'"/>');  //create an empty iframe
						iframe.hide();  //hide it
						$('#submitForm').attr('target',iframeId);  //set form target to iframe			
						
						iframe.appendTo('body');  //Add iframe to body					
						form.action = ($("#ord_no").val() != '') ? '/order/updateOrder' : '/order/insertOrder';
						form.method = 'post';
						form.submit();
						
						iframe.load(function(e) {
							
				            var doc = getDoc(iframe[0]);
				            var docRoot = doc.body ? doc.body : doc.documentElement;
				            var data = docRoot.innerHTML;
				            //data is returned from server.
				            $(window.opener.document).find("#btnSearch").trigger("click");
				            
							if (data == "0") {
								toast("등록하였습니다.");
								self.close();
							}else if (data == "-1") {
								toast("등록하신 첨부파일은 업로드 가능한 파일 확장자가 아닙니다");
//								$('#btnSave').click(function() {
//									$("#submitForm").submit();
//								});
							}
							else {
//								$('#btnSave').click(function() {
//									$("#submitForm").submit();
//								});
								ajaxError();
							}
				        });
											

					}
				});
				

			});

	//이베트 바인딩
	function fnEvenBind(){
		$(".select-layer1 ul li").on("click", function(){
			var cd = $(this).attr("cd");
			var nm = $(this).attr("nm");
			$('#' + retCdId).val(cd);
			$('#' + retNmId).val(nm);
			fnCloseLayer(selectLayerId);


			var _send_no = $("#send_no").val();
			var _receive_no = $("#receive_no").val();
			
			if(vendor_no != _send_no){
				$("#send_trade_comp_no").val("");
				$("#send_trade_comp_nm").val("");
			}
			
			if(vendor_no != _receive_no){
				$("#receive_trade_comp_no").val("");
				$("#receive_trade_comp_nm").val("");
			}	
			
		});
		
		//수량단위 콤보 변경
		$("#sel_qty_unit").on("change",function(){
			gfn_gridSetCell('itemList','qty_unit',$(this).val());
			var text = $(this).find("option:selected").text();
			$('table.ui-jqgrid-ftable td:eq(6)').text(text);
		});
		
		//화폐단위 콤보 변경
		$("#sel_amt_unit").on("change",function(){
			gfn_gridSetCell('itemList','amt_unit',$(this).val());
			var text = $(this).find("option:selected").text();
			$('table.ui-jqgrid-ftable td:eq(9)').text(text);
		});
		
		//포장단위 콤보 변경
		$("#sel_box_qty_unit").on("change",function(){
			//gfn_gridSetCell('itemList','box_qty_unit',$(this).val());
			
			var text = $(this).find("option:selected").text();
			
			$('table.ui-jqgrid-ftable td:eq(11)').text(text);
		});
		

		
	}
			
	//화물 금액 계산		
	function fnCalcItem(){

		var qty =  $('#itemList').jqGrid('getCol', 'c_qty', false, 'sum').toLocaleString();
		var tot_amt =  $('#itemList').jqGrid('getCol', 'tot_amt', false, 'sum').toLocaleString();
		var box_qty =  $('#itemList').jqGrid('getCol', 'c_box_qty', false, 'sum').toLocaleString();
		var kg =  $('#itemList').jqGrid('getCol', 'c_kg', false, 'sum').toLocaleString();
		var cbm =  $('#itemList').jqGrid('getCol', 'c_cbm', false, 'sum').toLocaleString();

		if(qty != 'NaN') $('table.ui-jqgrid-ftable td:eq(5)').text(gfn_comma(qty));
		if(tot_amt != 'NaN') $('table.ui-jqgrid-ftable td:eq(8)').text(gfn_comma(tot_amt));
		if(box_qty != 'NaN') $('table.ui-jqgrid-ftable td:eq(10)').text(gfn_comma(box_qty));
		if(kg != 'NaN') $('table.ui-jqgrid-ftable td:eq(12)').text(gfn_comma(kg));
		if(cbm != 'NaN') $('table.ui-jqgrid-ftable td:eq(13)').text(gfn_comma(cbm));

	}

	function fnItemCheck(){
		
		var returnVal = true;
		
		var selRows = $("#itemList").getGridParam('selarrrow');
		if($("#itemList").getRowData().length < 1) {
			toast('화물을 입력하세요.');
			returnVal = false;
		}

		for(var i=selRows.length-1; i>=0; i--) {
			//$('#itemList').delRowData(selRows[i]);
		
			var selRowData = $("#itemList").getRowData(selRows[i]);
			
			if(selRowData.item_nm == ''){toast('품명을 입력하세요'); returnVal = false; return false;}
//			if(selRowData.item_material == ''){toast('재질를 입력하세요'); returnVal = false; return false;}
			if(selRowData.qty == ''){toast('수량을 입력하세요'); returnVal = false; return false;}
			if(selRowData.amt == ''){toast('단가를 입력하세요'); returnVal = false; return false;}
			if(selRowData.tot_amt == ''){toast('총금액을 입력하세요'); returnVal = false; return false;}
			if(selRowData.box_qty == ''){toast('포장수량을 입력하세요'); returnVal = false; return false;}
			if(selRowData.cbm == ''){toast('체적을 입력하세요'); returnVal = false; return false;}
			if(selRowData.kg == ''){toast('중량을 입력하세요'); returnVal = false; return false;}

		}
		
		
		
		return returnVal;
	}
			
			
			function fnSelectView(flag){
				startPortFlag = flag;
				var trans_typ1 = $("#trans_typ1").val();
				
				if(trans_typ1 == ''){
// 					toast('먼저 운송구분1을 선택하세요.');
				}

				CenterOpenWindow('/region/selectPortPop?code=' + trans_typ1, '포트선택', '1000','560', 'scrollbars=no, status=yes');

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
			
			
			
			function fnItemAdd(){
				//itemList
				
				/*
				item_no_txt
				item_nm
				tiem_sty_no
				item_material
				qty
				amt
				tot_amt
				box_qty
				kg
				cbm
				*/
				
				var sel_qty_unit = $("#sel_qty_unit").val();
				var sel_amt_unit = $("#sel_amt_unit").val();
				var sel_box_qty_unit = $("#sel_box_qty_unit").val();
				
				if(sel_qty_unit == '') sel_qty_unit = "11801";
				if(sel_amt_unit == '') sel_amt_unit = "11703";
				if(sel_box_qty_unit == '') sel_box_qty_unit = "11901";
				
				
				
				var data = {
						item_no_txt : '',
						item_nm : '',
						tiem_sty_no : '',
						item_material : '',
						qty : 0,
						qty_unit : sel_qty_unit,
						amt : 0.00,
						tot_amt : 0.00,
						amt_unit : sel_amt_unit,
						box_qty : 0,
						box_qty_unit : sel_box_qty_unit,
						kg : 0.00,
						cbm : 0.00
					};
				
				itemSeq++;
				$("#itemList").addRowData(itemSeq, data, "last");
				$("#itemList").jqGrid("setSelection", itemSeq);
				
				
			}
			
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
			
			function fnShipperFileAdd(){
				if(shipperFileSeq > 4){
					toast('5개 까지만 등록이 가능합니다.');
					return false;
				}
				var _file = "<input type='file' class='mb4 file file_1' id='attachShipperFile" + shipperFileSeq + "' name='attachShipperFile" + shipperFileSeq + "'  />";
				$("#tdShipperFile").append(_file);
				shipperFileSeq++;
			}
			
			function fnConsigneeFileAdd(){
				if(consigneeFileSeq > 4){
					toast('5개 까지만 등록이 가능합니다.');
					return false;
				}
				var _file = "<input type='file' class='mb4 file file_1' id='attachConsigneeFile" + consigneeFileSeq + "' name='attachConsigneeFile" + consigneeFileSeq + "'  />";
				$("#tdConsigneeFile").append(_file);
				consigneeFileSeq++;
			}

			
			function fnSelectRegionPop(regionFlag){
				region_flag = regionFlag;
				var _url = '/region/selectRegionPop?code=10000&engFlag=1';
				CenterOpenWindow(_url, '지역선택', '1200','560', 'scrollbars=no, status=yes');
			}
			
			var region_flag = 1;
			
			function fnSetSelectRegionInfo( _country, _city, _region1, _region2, _region3, _region4,_countryEng, _cityEng, _region1Eng, _region2Eng, _region3Eng, _region4Eng, _countryNo, _cityNo, _region1No, _region2No, _region3No, _region4No,_engFlag){
				
				
				var targetRegionNo = "";
				var targetRegionNm = "";
				var lastRegionNo = "";

				if(region_flag == 1){
					targetRegionNo = "shipping_region_no";
					targetRegionNm = "shipping_region_nm";
				} else if(region_flag == 2){
					targetRegionNo = "send_region_no";
					targetRegionNm = "send_region_nm";
				} else if(region_flag == 3){
					targetRegionNo = "receive_region_no";
					targetRegionNm = "receive_region_nm";
				}

				
				//lastRegionNo = (_region4No != null && _region4No != '') ? _region4No : (_region3No != null && _region3No != '') ? _region3No : (_region3No != null && _region3No != '') ? _region2No;

				if(_region4No != null && _region4No != ''){
					
					lastRegionNo = _region4No;
					
				} else if(_region3No != null && _region3No != ''){
					
					lastRegionNo = _region3No;
					
				} else if(_region2No != null && _region2No != ''){
					
					lastRegionNo = _region2No;
					
				} else if(_region1No != null && _region1No != ''){
					
					lastRegionNo = _region1No;
					
				} else if(_cityNo != null && _cityNo != ''){
					
					lastRegionNo = _cityNo;
					
				} else if(_countryNo != null && _countryNo != ''){
					
					lastRegionNo = _countryNo;
					
				}

				$("#" + targetRegionNo).val(lastRegionNo);
				
				if(_engFlag == 1){
					$("#" + targetRegionNm).val(_region4Eng  + ' ' + _region3Eng  + ' ' + _region2Eng  + ' ' + _region1Eng  + ' ' + _cityEng + ' ' + _countryEng);
				} else {
					$("#" + targetRegionNm).val(_country + ' ' + _city + ' ' + _region1 + ' ' + _region2 + ' ' + _region3 + ' ' + _region4);
				}
				
			}
			
			
			
			
			
			



	
	/* 레이어팝업 */
	var retCdId = '';
	var retNmId = '';
	var selectLayerId = '';
	
	function fnSelectLayer1(_tit, _layerId, _retCdId, _retNmId){
	
		selectLayerId = _layerId;
		retCdId = _retCdId;
		retNmId = _retNmId;
		$(".layer-mask").show();
		var $layer = $('#' + _layerId);
		$layer.center();
		$layer.show();
		$layer.find(".tit").text(_tit);
		
		
		
	}
	
	function fnSelectLayer2(_tit, _layerId, _retCdId, _retNmId){
		
		var _send_no = $("#send_no").val();
		var _receive_no = $("#receive_no").val();
		
		if(_send_no == '' && _receive_no == ''){
			toast('화주를 먼저 선택 하세요.');
			return false;
		}

		if( (vendor_no == _send_no && _retCdId == 'send_trade_comp_no')
			|| (vendor_no == _receive_no && _retCdId == 'receive_trade_comp_no')
			){
			
			selectLayerId = _layerId;
			retCdId = _retCdId;
			retNmId = _retNmId;
			$(".layer-mask").show();
			var $layer = $('#' + _layerId);
			$layer.center();
			$layer.show();
			$layer.find(".tit").text(_tit);
		}

	}
	
	function fnCloseLayer(id){
		$(".layer-mask").hide();
		$('#' + selectLayerId).hide();	
	}

			
	function fn_f10(){
		$("#submitForm").submit();
	}
	
	//협력사 신규추가시 선택목록에 추가
	function fnAddCoopComp(_typ,_html){
		
		if(_typ == '3') {
			$("#selectCustomerLayerPop .contents ul").append(_html);
		}
		
		if(_typ == '7') {
			$("#selectTradeCompLayerPop .contents ul").append(_html);
		}
		
		if(_typ == '8') {
			$("#selectCCCompLayerPop .contents ul").append(_html);
		}
		
		$(".select-layer1 ul li").on("click", function(){
			var cd = $(this).attr("cd");
			var nm = $(this).attr("nm");
			$('#' + retCdId).val(cd);
			$('#' + retNmId).val(nm);
			fnCloseLayer(selectLayerId);
		});
	}
	
			
			
			
			
			
			
			
			