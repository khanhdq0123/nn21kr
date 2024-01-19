<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript">
	

	
		$(document).ready(function() {
						
			jQuery("#list1").jqGrid({
				url:'/partner/customerListJson',
//				datatype: "json",				   
				datatype: "local",				   
				colNames:['고객번호', '상호', '주소', '연락처', '업체상태','등록일시'],
				colModel:[
					{name:'vendor_cd',		index:'vendor_cd',		width:80,	align:"center"}, //지사 코드
					{name:'vendor_nm',		index:'vendor_nm',		width:300,	align:"left", formatter:partnerLinkFormatter}, //지사 명
					{name:'road_basadd_txt',	index:'road_basadd_txt',	width:420,	align:"left"}, //주소(도로명)
					{name:'tel_txt',		index:'tel_txt',		width:120,	align:"center"}, //전화번호
					{name:'stats_typ_cd',	index:'stats_typ_cd',	width:60,	align:"center", formatter:"select", edittype:"select", editoptions:{value:"<c:out escapeXml="false" value="${applicationScope['GRIDCODELIST']['11200']}"/>"}},  //업체 상태	
					{name:'reg_dt',			index:'reg_dt',			width:120,	align:"center"}, //지사 코드
				],
				mtype:"post",
				//autowidth: true,	// 부모 객체의 width를 따른다
				rowNum:500,	   	
				//rowList:[20,50,100],
				height: 400,
				// pager: '#pager1',
				pager: '',
			    //viewrecords: true,	
			    multiselect : true,
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

			if('' != '${search_str}'){
				fn_f3();
			}	

		});	
		
// 		function partnerLinkFormatter(cellVal, options, rowObj) {
// 			var linkURL = '<a href="javascript:CenterOpenWindow(\'/partner/partnerListPop.do?vendor_no=' + rowObj['vendor_no'] + '\', \'open\', \'1200\', \'800\', \'scrollbars=yes, status=no\');">'+cellVal+'</a>';										
// 			return linkURL;
// 		}
		
		function partnerLinkFormatter(cellVal, options, rowObj) {
			//var linkURL = '<a href="javascript:CenterOpenWindow(\'/partner/customerDetailPop.do?vendor_no=' + rowObj['vendor_no'] + '\', \'open\', \'1230\', \'800\', \'scrollbars=yes, status=no\');">'+cellVal+'</a>';		
			var linkURL = '<a href="/ve/cu/VECU03/page?menu_id=10343&screen_id=VECU03&menu_nm=고객사상세&js_url=/ve/cu/VECU03&vendor_no=' + rowObj['vendor_no'] + '" target="mainframe">'+cellVal+'</a>';	
			return linkURL;
		}
		
		function fn_f3(){
			$('#list1').clearGridData();
			$("#searchForm").submit();
			
		}
		
		//신규등록
		function fn_f9(){
			CenterOpenWindow('/partner/customerRegPop1.do', 'open', '980', '600', 'scrollbars=yes, status=no');
		}
		
		function fnSetNation(_v){
			$("#nation_cd").val(_v);
			fn_f3();
		}
		
	</script>
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header"></h3>
			<div class="btn-wrap">
				<input type="button" class="btn btn-success btn-sm" value="검색[F3]" id="btnSearch">
				<input type="button" class="btn btn-primary btn-sm" value="신규등록[F9]" id="btnAdd">
			</div>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form method="post" id="searchForm" action="#">
				<input type="hidden" name="stats_typ_cd" id="stats_typ_cd" value="11202" />
				<input type="hidden" name="nation_cd" id="nation_cd" value="" />

				
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
													<dt style="width:200px;"><label for="a1">고객번호/상호/전화번호</label></dt>
													<dd>
														<input type="text" name="search_str" id="search_str" value="${search_str}" style="width:90%;" maxlength="30" />
													</dd>
												</dl>
												<dl class="section">
													<dd style="width:100% !important;">
														<c:forEach var="entity" items="${regionVendorList}">
														<input type="button" class="btn btn-primary btn-xs" onclick="fnSetNation('${entity.nation_cd}');" value="&nbsp;  ${entity.nation_nm}  (${entity.cnt})  &nbsp;" id="btn${entity.nation_nm}">
														</c:forEach>
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
					

			<div class="grid">
				<table id="list1"></table>
			</div>
		</div>
		<!-- //product_admin -->
	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>