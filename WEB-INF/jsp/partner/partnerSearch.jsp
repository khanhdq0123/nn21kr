<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript">
								
		$(document).ready(function() {
//			$('#vendor_no').val('${params.vendor_no}');
//			$('#vendor_nm').val('${params.vendor_nm}');
//			$('#charge_name_nm').val('${params.charge_name_nm}');
//			$('#biz_num_txt').val('${params.biz_num_txt}');

			var isMultiSelect = "${params.isMultiSelect}";
		    
			jQuery("#list1").jqGrid({
				url:'/partner/partnerListJson.do',
				datatype: "local", 
				colNames:['지사 코드', '지사 명', '사업자번호', '담당자명'],
				colModel:[
					{name:'vendor_no',		index:'vendor_no',		width:60,	align:"center",	sortable:true}, //지사 코드
					{name:'vendor_nm',		index:'vendor_nm',		width:150,	align:"left",	sortable:true, formatter:partnerLinkFormatter, unformat:partnerLinkUnFormatter}, //지사 명
					{name:'biz_num_txt',	index:'biz_num_txt',	width:100,	align:"center",	sortable:true}, //사업자번호
					{name:'charge_name_nm',	index:'charge_name_nm',	width:100,	align:"center",	sortable:true} //담당자명
				],
				mtype:"post",
				autowidth: true,	// 부모 객체의 width를 따른다
				rowNum:500,	   	
// 				rowList:[20,50,100],
				height: 460,
				pager: '#pager1',
			    viewrecords: true,	
			    multiselect : true,
			    cellEdit : true,
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
			    onPaging: function(btn) {
			    	if($('#'+btn).hasClass('ui-state-disabled')) {
			    		return 'stop';
			    	} else { 
			    		$("#list1").jqGrid('setGridParam',{datatype:'json'});
			    		return true;
			    	}
			    },
			 	// 그리드 부가 파라미터 정보
			    postData : serializeObject($('#searchForm')),
			 	// cell이 변경되었을 경우 처리
			    afterSaveCell : function(id, name, val, iRow, iCol) {
			    	checkWhenColumnUpdated("list1", id);
			    }		
			});

			// grid 검색
// 			$("#btnSearch").click( function(){
// 				$("#list1").setGridParam({
// 					page : 1,
// 					postData : serializeObject($('#searchForm'))
// 				});
// 				$("#list1").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
// 			});
			
			//search reset
			$("#btnReset").click(function (){
				$("form")[0].reset(); 
			});

			//선택
			$('#btnSelect').click(function() {
				var selRows = $("#list1").getGridParam('selarrrow');
				if(selRows.length==0) {
					toast("선택된 건이 없습니다.");
					return;
				} else if(isMultiSelect != 'Y' && selRows.length > 1){
					toast("한 건만 선택해주세요.");
					return;
				} else {
					var colModel = $("#list1").getGridParam('colModel');
					var gridData = [];
					for(var i=0; i<selRows.length; i++) {
						var rowData = $("#list1").getRowData(selRows[i]);
						gridData.push(rowData);
					}
					
					opener.setVendorData(gridData);
					self.close();
					
				}
			});
		});	

		// Link 처리
		function partnerLinkFormatter(cellVal, options, rowObj) {
			var linkURL = '<a href="javascript:openPop(9,\'vendor_no='+rowObj['vendor_no']+'\');">'+cellVal+'</a>';
			return linkURL;
		}	
		
		// Link 처리 unformatter
		function partnerLinkUnFormatter(cellVal, options, cell) {
			return $('a', cell).text();
		}
		
		function fn_f3(){
			$("#searchForm").submit();
		}
	</script>
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="tit_area mt20">
			<h3 class="header">업체 검색</h3>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form method="post" id="searchForm" action="#">
					<input type="hidden" id="popup_yn" name="popup_yn" value="Y" />
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
													<dt><label for="a1">지사 코드</label></dt>
													<dd>
													<c:if test="${sessionScope['STAFFINFORMATION']['staff_typ'] eq '1'}">
														<input type="text" name="vendor_no" id="vendor_no" style="width:50%;" maxlength="9" />
													</c:if>
													<c:if test="${sessionScope['STAFFINFORMATION']['staff_typ'] ne '1'}">
														<input type="text" name="vendor_no" id="vendor_no"  disabled="disabled"  value="${sessionScope['STAFFINFORMATION']['vendor_no']}" style="width:50%;" maxlength="9" />
													</c:if>
													</dd>
													<dt><label for="a1">지사 명</label></dt>
													<dd>
													<c:if test="${sessionScope['STAFFINFORMATION']['staff_typ'] eq '1'}">													
														<input type="text" name="vendor_nm" id="vendor_nm" style="width:50%;" maxlength="30" />
													</c:if>														
													<c:if test="${sessionScope['STAFFINFORMATION']['staff_typ'] ne '1'}">
														<input type="text" name="vendor_nm" id="vendor_nm" style="width:50%;" disabled="disabled" maxlength="30"  value="${sessionScope['STAFFINFORMATION']['vendor_nm']}" />
													</c:if>
													</dd>
												</dl>
												<dl class="section">
													<dt><label for="a5">담당자 명</label></dt>
													<dd>
														<input type="text" name="charge_name_nm" id="charge_name_nm" style="width:50%;" maxlength="30" />
													</dd>
													<dt><label for="a1">사업자 번호</label></dt>
													<dd>
														<input type="text" name="biz_num_txt" id="biz_num_txt" style="width:50%;" maxlength="20" />
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
			<div class="report"><!-- 
				<div style="float:left;">
					<p>※ 브랜드를 체크하고 우측 선택 버튼 클릭 시 해당 브랜드를 적용할 수 있습니다.</p>
					<p>※ 리스트상에서 브랜드명 클릭 시 해당 브랜드의 상세 정보를 팝업으로 확인할 수 있습니다.</p>
				</div> -->
				<div class="min_btn" style="float:right;">
					<button class="sky" id="btnSelect" type="button">선택</button>
				</div>
			</div>
			<div class="grid" min="750">
				<table id="list1"></table>
				<div id="pager1"></div>
			</div>
		</div>
		<!-- //product_admin -->
	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>