<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript">
	
	var stsFmt = function (rowId, tv, rowObject, cm, rdata){

		switch(rowObject.stats_typ_cd) {
		    case "11201":
		    	return ' style="color:green;"';
		        break;
		    case "11202":
		    	return ' style="color:blue;"';
		        break;
		    default:
		    	return ' style="color:gray;"';
		    break;
		}
		
		return ' style="color:gray;"' ;
	}
	
		$(document).ready(function() {
						
			jQuery("#list1").jqGrid({
				url:'/partner/customerList4systemJson',
//				datatype: "json",				   
				datatype: "local",				   
				colNames:['지사코드','담당지사', '고객사코드', '고객사', '주소', '연락처', '업체상태','등록일시','vendor_no','rel_vendor_no'],
				colModel:[
					{name:'upvendor_cd',	index:'upvendor_cd',	width:40,	align:"center",	sortable:true}, //지사 코드
					{name:'upvendor_nm_eng',	index:'upvendor_nm_eng',	width:150,	sortable:true, formatter:partnerLinkFormatter1}, //지사 코드
// 					{name:'rel_vendor_no',	index:'rel_vendor_no',	width:80,	align:"center",	sortable:true}, //지사 코드
					{name:'vendor_cd',		index:'vendor_cd',		width:70,	align:"center",	sortable:true}, //지사 코드
					{name:'vendor_nm_eng',		index:'vendor_nm_eng',		width:150,	align:"left",	sortable:true, formatter:partnerLinkFormatter2}, //지사 명
					{name:'road_basadd_txt',index:'road_basadd_txt',width:220,	align:"left",	sortable:true}, //주소(도로명)
					{name:'tel_txt',		index:'tel_txt',		width:70,	align:"center",	sortable:true}, //전화번호
					{name:'stats_typ_cd',	index:'stats_typ_cd',	width:60,	align:"center",	sortable:true, cellattr: stsFmt, formatter:"select", edittype:"select", editoptions:{value:"<c:out escapeXml="false" value="${applicationScope['GRIDCODELIST']['11200']}"/>"}},  //업체 상태	
					{name:'reg_dt',			index:'reg_dt',			width:50,	align:"center",	sortable:true},
					{name:'vendor_no',		index:'vendor_no',hidden:true},
					{name:'rel_vendor_no',	index:'rel_vendor_no',hidden:true}
				],
				mtype:"post",
				autowidth: true,	// 부모 객체의 width를 따른다
				rowNum:500,	   	
// 				rowList:[20,50,100],
				height: 500,
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

			///BTN_ConnectionVendor
			$("#BTN_ConnectionVendor").click(function (){
				
				var rel_vendor_no = $("#rel_vendor_no").val();

				if(rel_vendor_no == ''){
					toast('고객사와 연결할 지사를 선택하세요.');
					return false;
				}
				
				var selRows = $("#list1").getGridParam('selarrrow');
				if(selRows.length==0) {
					toast('연결할 고객사를 선택하세요.');
					return false;
				}
				
				for(var i=selRows.length-1; i>=0; i--) {
					
// 					$('#list1').jqGrid('setCell', rowid, cellname, data, properties);
					$('#list1').jqGrid('setCell', selRows[i], 'rel_vendor_no', rel_vendor_no);
				}

				saveGridSelected("list1", 'selected', 'save', "/partner/saveVendorRelationJson");
			});
			
			
		});	
		
		// Link 처리(지사)
		function partnerLinkFormatter1(cellVal, options, rowObj) {
			var linkURL = '<a href="javascript:CenterOpenWindow(\'/partner/partnerListPop.do?vendor_no=' + rowObj['rel_vendor_no'] + '\', \'open\', \'1200\', \'800\', \'scrollbars=yes, status=no\');">'+rowObj['upvendor_nm_eng'] + ' / ' + rowObj['upvendor_nm']+'</a>';										
			return linkURL;
		}
		
		// Link 처리(고객사)
		function partnerLinkFormatter2(cellVal, options, rowObj) {
			var linkURL = '<a href="javascript:CenterOpenWindow(\'/partner/partnerListPop.do?vendor_no=' + rowObj['vendor_no'] + '\', \'open\', \'1200\', \'800\', \'scrollbars=yes, status=no\');">'+rowObj['vendor_nm_eng'] + ' / ' + rowObj['vendor_nm'] +'</a>';										
			return linkURL;
		}
		
		function fn_f3(){
			$("#searchForm").submit();
		}
		

		
	</script>
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">

			<h3 class="header">신청현황</h3>
			
			<span class="bullet6">회원 관리 &gt; 신청현황</span>
			
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<form method="post" id="searchForm" action="#">
			<!-- product_form -->
			<div class="product_form">

				
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
													<dt><label for="a1">업체명</label></dt>
													<dd>
														<input type="text" name="vendor_nm" id="vendor_nm" style="width:50%;" maxlength="20" />
																					
							
														
														
													</dd>
													<dt><label for="a5">전화번호</label></dt>
													<dd>
														<input type="text" name="tel_txt" id="tel_txt" style="width:50%;" maxlength="20" />
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
			</div>
					
			<div class="product_bt">
				<button class="search" id="btnSearch" type="button"><span>검색</span></button>
				<button class="reset" id="btnReset" type="button"><span>초기화</span></button>
			</div>
			<div class="report">
				<div class="min_btn">
					<select  id="rel_vendor_no" name="rel_vendor_no">
						<option value="">고객사와 연결할 지사를 선택하세요.</option>
	                   <c:forEach var="entity" items="${vendorList}">
	                      <option value="<c:out value="${entity.vendor_no}"/>"><c:out value="${entity.vendor_nm_eng}  /  ${entity.vendor_nm}"/></option>
	                   </c:forEach>   
					</select>
					<input type="button" class="btn btn-danger btn-sm" value="담당지사연결" id="BTN_ConnectionVendor">

				</div>
			</div>
			</form>
			
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