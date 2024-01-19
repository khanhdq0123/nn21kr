


		$(document).ready(function() {
						
			jQuery("#list1").jqGrid({
				url:'/partner/customerListJson',
//				datatype: "json",				   
				datatype: "local",				   
				colNames:['vendor_no', '지사명', '주소', '연락처','등록일시'],
				colModel:[
					{name:'vendor_no',		index:'vendor_no',		hidden:true},
					{name:'vendor_nm',		index:'vendor_nm',		width:200,	align:"left", formatter:partnerLinkFormatter}, //지사 명
					{name:'road_basadd_txt',	index:'road_basadd_txt',	width:420,	align:"left"}, //주소(도로명)
					{name:'tel_txt',		index:'tel_txt',		width:140,	align:"center"}, //전화번호
					{name:'reg_dt',			index:'reg_dt',			width:100,	align:"center"}, 
//					{name:'vendor_no',			index:'vendor_no',			width:100,	align:"center"}, 
//					{name:'stats_typ_cd',	index:'stats_typ_cd',	width:380,	align:"center", formatter:"select", edittype:"select", editoptions:{value:statsTypList}},  //업체 상태	
				],
				mtype:"post",
				//autowidth: true,	// 부모 객체의 width를 따른다
				rowNum:500,	   	
				height: 400,
				pager: '',
			    multiselect : true,
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
			    // 그리드 부가 파라미터 정보
			    postData : serializeObject($('#searchForm')),
			 	// cell이 변경되었을 경우 처리
			    afterSaveCell : function(id, name, val, iRow, iCol) {
			    	checkWhenColumnUpdated("list1", id);
			    }		
			});


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

			//지사간 연결
			$('#btnConnectionVendor').click(function (){
				var selRows = $("#list1").getGridParam('selarrrow');
				if(selRows.length==0) {
					toast('연결할 지사를 선택하세요.');
					return false;
				}
				
				if(selRows.length!=2) {
					toast('연결할 지사 2개를 선택하세요.');
					return false;
				}

					var selRowData1 = $("#list1").getRowData(selRows[0]);
					var selRowData2 = $("#list1").getRowData(selRows[1]);
					
					var vendor_no1 = selRowData1.vendor_no;
					var vendor_no2 = selRowData2.vendor_no;

					var data ={};
			      	data.vendor_no = vendor_no1;
			      	data.rel_vendor_no = vendor_no2;

					$.ajax({
						type: "POST",
						url: '/partner/saveVendorRelation',
						data: data,
						dataType: 'json',
						contentType: 'application/x-www-form-urlencoded; charset=utf-8',
						success: function(data) {
							if(data.code == '0') {
								toast(data.msg);
						
									$("#btnSearch", opener.document).trigger("click");
									self.close();

							} else {
								toast(data.msg);
							}
						},
						error: function(jqXHR, textStatus, errorThrown) {
							toast(jqXHR.status);						
						}
					});


			});
			



			// Link 처리
			function partnerLinkFormatter(cellVal, options, rowObj) {
				var linkURL = '<a href="javascript:CenterOpenWindow(\'/partner/partnerListPop.do?vendor_no=' + rowObj['vendor_no'] + '\', \'open\', \'1200\', \'800\', \'scrollbars=yes, status=no\');">';
				linkURL += '<b>' + rowObj['vendor_cd'] +'</b> ' + rowObj['vendor_nm'] + '</a>';										
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
		
		function fnSetNation(_v){
			$("#nation_cd").val(_v);
			fn_f3();
		}
		
		
		
		