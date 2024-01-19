<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript">
	

	
		$(document).ready(function() {
						
			jQuery("#list1").jqGrid({
				url:'/partner/partnerListJson',
//				datatype: "json",				   
				datatype: "local",				   
				colNames:['출발','도착','title', '관할지사', '운송방법', '부킹비','문건비','검역료','통관비','문건비','THC','DOC','CCF','관세사비','검역비','보관료','하역료','H/C','배송비','포장비','관세사비','검역비'],
				colModel:[
					{name:'a1',	index:'a1',	width:90,	align:"center",	frozen:true },
					{name:'a2',	index:'a2',	width:90,	align:"center",	frozen:true },
					{name:'a3',	index:'a3',	width:90,	align:"center",	frozen:true },
					{name:'a4',	index:'a4',	width:90,	align:"center",	frozen:true },
					{name:'a5',	index:'a5',	width:90,	align:"center",	frozen:true },
					{name:'a11',	index:'a11',	width:90,	align:"right"},
					{name:'a12',	index:'a12',	width:90,	align:"right"},
					{name:'a13',	index:'a13',	width:90,	align:"right"},
					{name:'vendor_no',	index:'vendor_no',	width:90,	align:"right"},
					{name:'b11',	index:'b11',	width:90,	align:"right"},
					{name:'b12',	index:'b12',	width:90,	align:"right"},
					{name:'b13',	index:'b13',	width:90,	align:"right"},
					{name:'b14',	index:'b14',	width:90,	align:"right"},
					{name:'c11',	index:'c11',	width:90,	align:"right"},
					{name:'c12',	index:'c12',	width:90,	align:"right"},
					{name:'c13',	index:'c13',	width:90,	align:"right"},
					{name:'c14',	index:'c14',	width:90,	align:"right"},
					{name:'d11',	index:'d11',	width:90,	align:"right"},
					{name:'d12',	index:'d12',	width:90,	align:"right"},
					{name:'d13',	index:'d13',	width:90,	align:"right"},
					{name:'d14',	index:'d14',	width:90,	align:"right"},
					{name:'d15',	index:'d15',	width:90,	align:"right"},

				],
				mtype:"post",
				//autowidth: true,	// 부모 객체의 width를 따른다
				rowNum:500,	   	
				//rowList:[20,50,100],
				height: 500,
				// pager: '#pager1',
				pager: '',
			    //viewrecords: true,	
// 			    multiselect : true,
			    shrinkToFit: false,
// 			    cellEdit : true,
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
// 			    onPaging: function(btn) {
// 			    	if($('#'+btn).hasClass('ui-state-disabled')) {
// 			    		return 'stop';
// 			    	} else { 
// 			    		$("#list1").jqGrid('setGridParam',{datatype:'json'});
// 			    		return true;
// 			    	}
// 			    },
			    // 그리드 부가 파라미터 정보
			    postData : serializeObject($('#searchForm')),
			 	// cell이 변경되었을 경우 처리
			    afterSaveCell : function(id, name, val, iRow, iCol) {
			    	checkWhenColumnUpdated("list1", id);
			    }		
			});
			
			

			
			var title1 = "기본항목";
			var title2 = "수출비용";
			var title3 = "해운비";
			var title4 = "수입비용";
			var title5 = "세금";
			
			$("#list1").jqGrid('setGroupHeaders', {

				useColSpanStyle: true,

				  groupHeaders:[

					{ startColumnName: 'a1', numberOfColumns: 5, titleText: title1},
					{ startColumnName: 'a11', numberOfColumns: 4, titleText: title2 },
					{ startColumnName: 'b11', numberOfColumns: 4, titleText: title3 },
					{ startColumnName: 'c11', numberOfColumns: 4, titleText: title4 },
					{ startColumnName: 'd11', numberOfColumns: 5, titleText: title5 }

				  ]

		    });
			
			
			
// 			$("#list1").jqGrid('setGroupHeaders', {

// 				useColSpanStyle: true,

// 				  groupHeaders:[

// 					{ startColumnName: 'a1', numberOfColumns: 2, titleText: "노선" },
// 					{ startColumnName: 'a3', numberOfColumns: 3, titleText: "항목" },
// 					{ startColumnName: 'a11', numberOfColumns: 2, titleText: "포딩비용" },
// 					{ startColumnName: 'a13', numberOfColumns: 2, titleText: "창고비용" },
// 					{ startColumnName: 'b11', numberOfColumns: 2, titleText: "통관비용" },
// 					{ startColumnName: 'b13', numberOfColumns: 2, titleText: "부두비용" },
// 					{ startColumnName: 'c11', numberOfColumns: 2, titleText: "선사비용" },
// 					{ startColumnName: 'c13', numberOfColumns: 2, titleText: "해운사비용" },
// 					{ startColumnName: 'd11', numberOfColumns: 2, titleText: "픽업비용" },
// 					{ startColumnName: 'd13', numberOfColumns: 3, titleText: "통관비용" }

// 				  ]

// 		    });
			

			
			$("#list1").jqGrid("setFrozenColumns");

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
// 			$("#btnSearch").click( function(){
// 				$('#list1').clearGridData();
// 				$("#searchForm").submit();
// 			});
			
			//search reset
			$("#btnReset").click(function (){
				$("form")[0].reset(); 
			});
			
			//새로등록
			$('#btnAdd').click(function (){
				CenterOpenWindow('/partner/joinMembership2', 'open', '1200', '720', 'scrollbars=yes, status=no');
			});

			// Link 처리
			function partnerLinkFormatter(cellVal, options, rowObj) {
				var linkURL = '<a href="javascript:CenterOpenWindow(\'/partner/partnerListPop.do?vendor_no=' + rowObj['vendor_no'] + '\', \'open\', \'1200\', \'800\', \'scrollbars=yes, status=no\');">'+cellVal+'</a>';										
				return linkURL;
			}

		});	
		
		function fn_f3(){
			$("#searchForm").submit();
		}
	</script>
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">

			<h3 class="header">단가등록 현황new</h3>

			<span class="bullet6">단가 관리 &gt; 단가등록 현황</span>
	

			
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form method="post" id="searchForm" action="#">
				

				
					<fieldset>
					<legend>추가 검색조건</legend>
						<div class="product_tbl">
							<table cellspacing="0" cellpadding="0" class="tbl_type2 tbl_cell">
							<caption>추가 검색조건 정보</caption>
								<colgroup>
									<col width="100%" />
								</colgroup>
								<tbody>
									<tr>
										<td>
											<div class="tbl_wrap">
												<dl class="section">
													<dt><label for="a1">관할지사</label></dt>
													<dd>
														<input type="text" name="vendor_nm" id="vendor_nm" style="width:50%;" maxlength="30" />
													</dd>
			
												</dl>
												<dl class="section">
													<dt><label for="a11">등록일</label></dt>
													<dd class="cols">
														<span class="calendar">
															<input type="text" class="datepicker2" id="regdt_from" name="regdt_from" />
														</span>
															~
														<span class="calendar">
															<input type="text" class="datepicker2" id="regdt_to" name="regdt_to" />
														</span>
														<button class="btn_c6 btnDate" val="today" type="button">오늘</button>
														<button class="btn_c6 btnDate" val="weekago" type="button">1주일</button>
														<button class="btn_c6 btnDate" val="monthago" type="button">1개월</button>
													</dd>
												</dl>
											</div>
										</td>
									</tr>
								</tbody>
								<!--  //추가 검색조건 열기 -->
							</table>
						</div>
					</fieldset>
				</form>
			</div>
					
			<div class="product_bt">
				<button class="search" id="btnSearch" type="button"><span>검색</span></button>
				<button class="reset" id="btnReset" type="button"><span>초기화</span></button>
			</div>
			<div class="report">
				<div class="min_btn">
					<button class="sky" id="btnAdd" type="button">신규등록</button>
				</div>
			</div>
			<div class="grid">
				<table id="list1"></table>
				<div id="pager1"></div>
			</div>
		</div>
		<!-- //product_admin -->
	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>