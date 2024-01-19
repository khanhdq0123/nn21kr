		
		
var startPortFlag = 1;
										
			$(document).ready(function() {
				
				fnEvenBind();
				
				// 그리드 - 프로토타입 
				jQuery('#itemList').jqGrid({
					url: '/region/routeListJson',
					datatype: 'local',
				   	colNames: [	'No', '품명', '스타일번호', '재질', '수량', '단가','총금액','포장수량','체적', '중량'
					],
					colModel: [
						{ name: 'item_no_txt', index: 'item_no_txt', align: 'center', sortable: true, width: '80', editable:true},
			            { name: 'item_nm', index: 'item_nm', align: 'center', width: '80', sortable: false, editable:true},
			            { name: 'item_sty_no', index: 'tiem_sty_no', align: 'center', sortable: true, width: '300', editable:true},
			            { name: 'item_material', index: 'item_material', align: 'left', sortable: true, width: '90', editable:true},
			            { name: 'qty', index: 'qty', align: 'left', sortable: true, width: '70', editable:true},
			            { name: 'amt', index: 'amt', align: 'left', sortable: true, width: '70', editable:true},
			            { name: 'tot_amt', index: 'tot_amt', align: 'left', sortable: true, width: '70', editable:true},
			            { name: 'box_qty', index: 'box_qty', align: 'left', sortable: true, width: '70', editable:true},
			            { name: 'kg', index: 'kg', align: 'left', sortable: true, width: '70', editable:true},
			            { name: 'cbm', index: 'cbm', align: 'left', sortable: true, width: '70', editable:true}
					],
					autowidth: true,
					height: 120,
					cellsubmit : 'clientArray',
					cellEdit : true,
					gridview:true,
					editable:true,
					multiselect: true
				});

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
//						trans_typ2:{
//							required:"운송구분2을 선택하세요.",
//							maxlength:jQuery.format("지역명은 최대 20자 이하로 입력하세요.")
//						},
//						st_region2:{
//							required:"지역을 선택하세요.",
//							maxlength:jQuery.format("지역명은 최대 20자 이하로 입력하세요.")
//						},
//						st_region4:{
//							required:"지역을 선택하세요.",
//							maxlength:jQuery.format("지역명은 최대 20자 이하로 입력하세요.")
//						}
					},
					onfocusout:false,
					invalidHandler: function(form, validator) {
						showValidationError(form, validator);               
		            },
					errorPlacement: function(error, element) {},
					submitHandler: function(form) {			
						
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
						form.action = '/order/insertOrder';
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
								$('#btnSave').click(function() {
									$("#submitForm").submit();
								});
							}
							else {
								$('#btnSave').click(function() {
									$("#submitForm").submit();
								});
								ajaxError();
							}
				        });
						
						
// 						$.ajax({
// 							type: "POST",
// 							url: "/order/insertOrder",
// 							data: $(form).serialize(),
// 							dataType: 'json',
// 							contentType: 'application/x-www-form-urlencoded; charset=utf-8',
// 							success: function(data) {

// 								if(data.code == '0') {
// 									toast(data.msg);
// 									//window.opener.getTreeData();
// 									//window.opener.fnReloadRegionGrid();
// 									window.close();
// 								}	
// 							},
// 							error: function(jqXHR, textStatus, errorThrown) {
// 								toast(jqXHR.status);						
// 							}
// 						});
					}
				});
				
			});
			
			function fnItemCheck(){
				
				var returnVal = true;
				
				var selRows = $("#itemList").getGridParam('selarrrow');
				if(selRows.length==0) {
					toast('화물을 입력하세요.');
					returnVal = false;
				}

				for(var i=selRows.length-1; i>=0; i--) {
					//$('#itemList').delRowData(selRows[i]);
				
					var selRowData = $("#itemList").getRowData(selRows[i]);
					
					if(selRowData.item_nm == ''){toast('품명을 입력하세요'); returnVal = false; return false;}
//					if(selRowData.item_material == ''){toast('재질를 입력하세요'); returnVal = false; return false;}
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
			
			var itemSeq = 1;
			
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
				
				
				var data = {
						item_no_txt : '',
						item_nm : '',
						tiem_sty_no : '',
						item_material : '',
						qty : '',
						amt : '',
						tot_amt : '',
						box_qty : '',
						kg : '',
						cbm : ''
					};
				
				$("#itemList").addRowData(itemSeq, data, "last");
				$("#itemList").jqGrid("setSelection", itemSeq);
				
				itemSeq++;
				
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
				
				
				console.log('region_flag',region_flag);
				
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

				
				//lastRegionNo = (_region4No != null && _region4No != '') ? _region4No : (_region3No != null && _region3No != '') ? _region3No : _region2No;

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
			
			
			
			
			
			
	function fnEvenBind(){
		$(".select-layer1 ul li").on("click", function(){
			var cd = $(this).attr("cd");
			var nm = $(this).attr("nm");
//			var id = $(this).parent().parent().parent().prop("id");

			$('#' + retCdId).val(cd);
			$('#' + retNmId).val(nm);
			
			fnCloseLayer(selectLayerId);
		});
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

		//$layer.find(".tit").html("############");
		
		$layer.find(".tit").text(_tit);
	}
	
	function fnCloseLayer(id){
		$(".layer-mask").hide();
		$('#' + selectLayerId).hide();	
	}

	function fn_f10(){
		$("#submitForm").submit();
	}
			
			
			
			
			
			
			
			
			