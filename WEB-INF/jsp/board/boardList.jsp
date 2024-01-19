<%-- 
	작성자 : 이형근(fixalot@exint.co.kr)
	백오피스 > 게시판관리 > 1:1문의 리스트보기
--%>
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
		
		// 그리드 - 프로토타입 
		jQuery('#list1').jqGrid({
			url: '/board/oneOnone/oneOnoneListJson.do',
			datatype: 'local',
		   	colNames: [
				'문의번호', '문의유형', '주문번호', '상품코드', '제목', '문의자ID',
				'문의자명', '문의일시', '상태', '답변담당자', '답변자', '답변일시', '지연일'
			],
			colModel: [
	            { name: 'voc_id', index: 'voc_id', align: 'center', sortable: true, width: '50' },
				{ name: 'upper_voc_type_nm', index: 'upper_voc_type_nm', align: 'center', sortable: true, width: '70' },
				{ name: 'order_no', index: 'order_no', align: 'center', sortable: true, width: '50' },
				{ name: 'good_no', index: 'good_no', align: 'center', sortable: true, width: '50' },
				{ 
					name: 'voc_title_nm', index: 'voc_title_nm', align: 'left', 
					formatter: linkFormatter, unformat: linkUnFormatter, sortable: true, width: '210'
				},
				{ name: 'gl_user_id', index: 'gl_user_id', align: 'center', sortable: true, width: '70' },
				{ name: 'user_name', index: 'user_name', align: 'center', sortable: true, width: '60' },
				{ name: 'reg_date', index: 'reg_date', align: 'center', sortable: true, width: '70' },
				{ name: 'process_status_name', index: 'process_status_name', align: 'center', sortable: true, width: '60' },
				{ name: 'answerer_id', index: 'answerer_id', align: 'center', sortable: true, width: '70' },
				{ name: 'register_id', index: 'register_id', align: 'center', sortable: true, width: '70' },
				{ name: 'reply_date', index: 'reply_date', align: 'center', sortable: true, width: '70' },
				{ name: 'delay_time', index: 'delay_time', align: 'center', sortable: true, width: '40' }
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
		
		// jqGrid Navigator
		jQuery('#list1').jqGrid('navGrid','#pager1',{search:false, edit:false, 
				add:false, del:false, refresh:false});
	
		// Link 처리
		function linkFormatter(cellVal, options, rowObj) {
			var linkURL = '<a href="javascript:CenterOpenWindow(\'/board/oneOnone/oneOnoneDetail.do' 
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
		
		// 1:1 문의유형 불러오기
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
			<h3 class="header">1:1 문의 관리</h3>
			
			<span class="bullet6">게시판관리 &gt; 1:1 문의 관리</span>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form method="get" id="searchForm">
					<fieldset>
						<legend>1:1 문의 관리</legend>
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
													<dt>제목</dt>
													<dd>
														<input type="text" id="voc_title_nm" name="voc_title_nm" style="width: 50%" maxlength="200"/>
													</dd>
													<dt>문의유형</dt>
													<dd>
														<select id="upper_voc_type_id" name="upper_voc_type_id" style="width : 25%">
															<option value="" selected="selected">전체</option>
														</select>
														<select id="voc_type_id" name="voc_type_id" style="width : 25%" disabled="disabled">
															<option></option>
														</select>
													</dd>
												</dl>
												<dl class="section">
													<dt>지연일</dt>
													<dd>
														<input type="text" id="delay_time" name="delay_time" style="width: 50%" maxlength="5"/>
													</dd>
													<dt>상태</dt>
													<dd>
														<select name="process_status_code" style="width: 50%">
															<option value="" selected="selected">전체</option>
															<option value="1">접수중</option>
															<option value="2">담당자이관</option>
															<option value="3">임시저장</option>
															<option value="5">답변완료</option>
															<option value="7">추가답변</option>
														</select>
													</dd>
													
												</dl>
												<dl class="section">
													<dt>문의자 ID</dt>
													<dd>
														<input type="text" id="gl_user_id" name="gl_user_id" style="width: 50%" maxlength="20"/>
													</dd>
													<dt>문의자명</dt>
													<dd>
														<input type="text" id="user_name" name="user_name" style="width: 50%" maxlength="30"/>
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
