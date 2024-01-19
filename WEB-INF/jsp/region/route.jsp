<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<%@include file="/common/include/header.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$("#spnSetReg button").click(function() {
			var when = '';
			if (this.id == 'btnRegSetToday') when = 'today';
			if (this.id == 'btnRegSetWeekago') when = 'weekago';
			if (this.id == 'btnRegSetMonthago') when = 'monthago';
			setSearchDate('search_start_dt', 'search_end_dt', when);
		});
		
		
		$("#btnNew").click( function() {
			CenterOpenWindow('/region/routeDetailPop?code=1111', '노선등록', '1000','480', 'scrollbars=no, status=yes');
		});
		
		
		
		// 그리드 - 프로토타입 
		jQuery('#list1').jqGrid({
			url: '/region/routeListJson',
			datatype: 'local',
		   	colNames: ['route_no','구분',	'운송구분1', '운송구분2', '출발대륙', '출발국가', '출발권역', '출발지점1','출발지점2','출발지점3',
				                     '도착대륙', '도착국가', '도착권역', '도착지점1', '도착지점2', '도착지점3', '등록자', '등록일시'
			],
			colModel: [
	            { name: 'route_no', index: 'route_no', align: 'center', sortable: true, width: '50' ,hidden:true},
	            { name: 'route_typ', index: 'route_typ', align: 'center', sortable: true, width: '50' ,hidden:true},
	            { name: 'trans_typ1_nm', index: 'trans_typ1_nm', align: 'center', sortable: true, width: '80'},
	            { name: 'trans_typ2_nm', index: 'trans_typ2_nm', align: 'center', sortable: true, width: '100'},
	            { name: 'st_region1_nm', index: 'st_region1_nm', align: 'left', sortable: true, width: '70',hidden:true},
	            { name: 'st_region2_nm', index: 'st_region2_nm', align: 'left', sortable: true, width: '70'},
	            { name: 'st_region3_nm', index: 'st_region3_nm', align: 'left', sortable: true, width: '70',hidden:true},
	            { name: 'st_region4_nm', index: 'st_region4_nm', align: 'left', sortable: true, width: '70'},
	            { name: 'st_region5_nm', index: 'st_region5_nm', align: 'left', sortable: true, width: '70'},
	            { name: 'st_region6_nm', index: 'st_region6_nm', align: 'left', sortable: true, width: '70'},
	            { name: 'ar_region1_nm', index: 'ar_region1_nm', align: 'left', sortable: true, width: '70',hidden:true},
	            { name: 'ar_region2_nm', index: 'ar_region2_nm', align: 'left', sortable: true, width: '70'},
	            { name: 'ar_region3_nm', index: 'ar_region3_nm', align: 'left', sortable: true, width: '70',hidden:true},
	            { name: 'ar_region4_nm', index: 'ar_region4_nm', align: 'left', sortable: true, width: '70'},
	            { name: 'ar_region5_nm', index: 'ar_region5_nm', align: 'left', sortable: true, width: '70'},
	            { name: 'ar_region6_nm', index: 'ar_region6_nm', align: 'left', sortable: true, width: '70'},
				{ name: 'reg_id', index: 'reg_id', align: 'center', sortable: true, width: '40' },
				{ name: 'reg_dt', index: 'reg_dt', align: 'center', sortable: true, width: '70' }
			],
			autowidth: true,
			height: 500,
			pager: '#pager1',
			rowNum: 500,
// 			rowList: [20, 50, 100, 1000],
			mtype: 'post',
			viewrecords: true,
			loadComplete: function(data) {
				setSortingGridData(this, data);
			}, 
			onPaging: function(btn) {
				if($('#'+btn).hasClass('ui-state-disabled')) {
					return 'stop';
				} else { 
					$('#list1').jqGrid('clearGridData').jqGrid('setGridParam',{ datatype:'json' });
					return true;
				}
			},
			loadError: function(xhr,st,err) {
				girdLoadError();
		    },
		    postData: serializeObject($('#searchForm'))
		});
		
		
		
	    function catMerge(rowId, cellvalue, rowObject, cm, rdata){
	        var coltwo = rowObject.user_name;
// 	        if(coltwo == 1){
	        	return 'colspan=2;';
// 	        }
	    }
		
		// jqGrid Navigator
		jQuery('#list1').jqGrid('navGrid','#pager1',{search:false, edit:false, add:false, del:false, refresh:false});
	
		// Link 처리
		function linkFormatter(cellVal, options, rowObj) {
			var linkURL = '<a href="javascript:CenterOpenWindow(\'/region/regionInfo' 
					+ '?id=' + rowObj['voc_id']
					+ '\', \'open\', \'800\', \'600\', \'scrollbars=yes, status=no\');">'
					+ cellVal + '</a>';
			return linkURL;
		}
		
		// 검색 날짜 자동 채우기
		$('#spnSetReg button').click(function() {
			if (this.id == 'btnRegSetToday')
				setSearchDate('search_start_dt', 'search_end_dt', 'today');
			if (this.id == 'btnRegSetWeekago')
				setSearchDate('search_start_dt', 'search_end_dt', 'weekago');
			if (this.id == 'btnRegSetMonthago')
				setSearchDate('search_start_dt', 'search_end_dt', 'monthago');
		});
		
		// grid 검색
		$('#btnSearch').click(function() {
			$('#searchForm').submit();
		});
		
		// 초기화 버튼
		$('#btnReset').click(function() {
			$('#searchForm')[0].reset();
		});
		
		// 노선관리유형 불러오기
		<c:if test="${not empty typeList}">
			var typeList = ${typeList};
			
			for (var loop = 0; loop < typeList.length; loop++) {
				var ele = typeList[loop];
				if (ele.parent_type_id == '0') {
					$('#upper_voc_type_id').append($('<option>', {
						value: ele.voc_type_id
					}).text(ele.voc_type_nm));
				}
			}
			
			$('#upper_voc_type_id').change(function() {
				$('#voc_type_id').empty();
				var upperTypeId = $(this).val();
				
				if (upperTypeId == '') {
					// 폼 데이터 초기화 문제가 발생하는 부분. 컨트롤러에서 처리한다.
					$('#voc_type_id').prop('disabled', true);
				} else {
					$('#voc_type_id').prop('disabled', false);
					$('#voc_type_id').append($('<option value="" selected="selected">').text('전체'));
					for (var loop = 0; loop < typeList.length; loop++) {
						var ele = typeList[loop];
						if (ele.parent_type_id == upperTypeId) {
							$('#voc_type_id').append($('<option>', {
								value: ele.voc_type_id
							}).text(ele.voc_type_nm));	
						}
					}
				}
				
			});
		</c:if>
		
		// jQuery validation
		$("#searchForm").validate({
			rules: {
				title_txt: {maxlength: 100},
				delay_time: {number: true},
				gl_user_id: {maxlength: 20},
				user_name: {maxlength: 30},
				search_start_dt: {dpDate: true},
				search_end_dt: {dpDate: true, dpCompareDate:{notBefore: '#search_start_dt'}}
			},
			messages: {
				title_txt: {maxlength: jQuery.format("제목은 최대 {0} 글자 이하로 입력하세요.")},
				delay_time: {number: '지연일은 숫자만 입력하세요.'},
				gl_user_id: {maxlength: jQuery.format('문의자 ID는 최대 {0} 글자 이하로 입력하세요.')},
				user_name: {maxlength: jQuery.format('문의자명은 최대 {0} 글자 이하로 입력하세요.')},
				search_start_dt: {dpDate: "등록일 검색 시작일자는 yyyy-mm-dd 형식으로 입력하세요."},
				search_end_dt: {dpDate: "등록일 검색 종료일자는 yyyy-mm-dd 형식으로 입력하세요.",
						dpCompareDate: "등록일 검색 종료일은 시작일보다 같거나 이후 일자를 선택하세요."}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
			},
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {
				$("#list1").setGridParam({
					page : 1,
					postData : serializeObject($('#searchForm')),
					datatype: 'json'
				});
				
				$("#list1").trigger("reloadGrid");
			}
		});
	});
</script>

</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">노선 관리</h3>
			
			<span class="bullet6">노선관리 &gt; 노선관리</span>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form method="get" id="searchForm">
					<fieldset>
						<legend>노선관리 관리</legend>
						<div class="product_tbl">
							<table cellspacing="0" cellpadding="0" class="tbl_type2 tbl_cell">
								<colgroup>
									<col width="100%" />
								</colgroup>
								<tbody>
									<tr>
										<td>
											<div class="tbl_wrap">

												<dl class="section">
													<dt>운송구분1</dt>
													<dd>
														<select style="width:90%" id="appr_cd" name="appr_cd">
															<option value="">전체</option>
				                                             <c:forEach var="entity" items="${applicationScope['CODE']['10200']}">
				                                                <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
				                                             </c:forEach>   
														</select>
													</dd>
													<dt>운송구분2</dt>
													<dd>
														<select style="width:90%" id="appr_cd" name="appr_cd">
															<option value="">전체</option>
				                                             <c:forEach var="entity" items="${applicationScope['CODE']['10800']}">
				                                                <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
				                                             </c:forEach>   
														</select>
													</dd>
													
												</dl>

												<dl class="section">
													<dt>등록일</dt>
													<dd class="cols">
														<span class="calendar">
															<input type="text" maxlength="10" class="datepicker" id="search_start_dt" name="search_start_dt"/>
														</span>
														&nbsp;~&nbsp; 
														<span class="calendar">
															<input type="text" maxlength="10" class="datepicker" id="search_end_dt" name="search_end_dt"/>
														</span>
														
														<span id="spnSetReg">
															<button type="button" class="btn_c6" id="btnRegSetToday">오늘</button>
															<button type="button" class="btn_c6" id="btnRegSetWeekago">1주일</button>
															<button type="button" class="btn_c6" id="btnRegSetMonthago">1개월</button>
														</span>
													</dd>
												</dl>
											</div>
											<div class="tbl_wrap active mark"></div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</fieldset>
				</form>
			</div>
			

			<div class="product_bt">
				<button type="button" class="search" id="btnSearch">
					<span>검색</span>
				</button>
				<button type="button" class="reset" id="btnReset">
					<span>초기화</span>
				</button>
			</div>
			<div class="report">
				<div class="min_btn">
					<button type="button" class="sky" id="btnNew">노선추가</button>
					<button type="button" class="gray" id="btnDel">삭제</button>
				</div>
			</div>
			<!-- grid -->
			<div class="grid">
				<table id="list1"></table>
				<div id="pager1"></div>			
			</div>
			<!-- grid end -->			

		</div>
		<!-- //product_admin -->
	</div>
	<!-- //content_wrap -->
<div id="toast"></div></body>
</html>
