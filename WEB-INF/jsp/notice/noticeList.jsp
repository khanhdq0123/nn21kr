<%--
	작성자 : 이형근(fixalot@exint.co.kr)
	백오피스 > 게시판관리 > 공지사항 리스트
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<%@include file="/common/include/header.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		// 그리드 
		jQuery("#list1").jqGrid({
			url: "/notice/noticeListJson",
			datatype: "local",
		   	colNames: ['제목','등록인','등록 일시'],
			colModel: [
				{ name: 'title_txt', index: 'title_txt', align: 'left', formatter : linkFormatter, unformat : linkUnFormatter, sortable: true, width: '220'}, 
				{ name: 'staff_nm', index: 'staff_nm', align: 'center', sortable: true, width: '80' }, 
				{ name: 'reg_dt', index: 'reg_dt', align: 'center', sortable: true, width: '100' }
			],
			autowidth: true,
			height: 500,
// 			pager: '#pager1',
			rowNum: 500,
// 			rowList: [20, 50, 100],
	// 		shrinkToFit: false,
	// 		multiselect: true,
			mtype:"post",
			viewrecords: true,
			loadComplete: function(data) {
				setSortingGridData(this, data);
			}, 
// 			onPaging: function(btn) {
// 				if($('#'+btn).hasClass('ui-state-disabled')) {
// 					return 'stop';
// 				} else { 
// 					$("#list1").jqGrid("clearGridData").jqGrid('setGridParam',{ datatype:'json' });
// 					return true;
// 				}
// 			},
			loadError : function(xhr,st,err) {
				girdLoadError();
		    },
		    postData: serializeObject($("#searchForm"))  
		});
		
		// jqGrid linkFormatter
		function linkFormatter(cellVal, options, rowObj) {
			var linkURL = '<a href="javascript:CenterOpenWindow(\'/notice/noticeDetailView?id='
					+ rowObj['notice_no']
					+ '\', \'open\', \'1000\', \'800\', \'scrollbars=yes, status=no\');">'
					+ cellVal + '</a>';
			return linkURL;
		}
		
		// 신규등록 팝업
		$("#btnNewPost").click(function() {
			var width=1000, height=800;
			var params = "?mode=new"
			CenterOpenWindow("/notice/noticeDetail" + params, "_blank", width, height, "scrollbars=yes, status=no");
		});
			
		// 검색 날짜 채우기
		$("#spnSetReg button, #spnSetDisp button").click(function() {
			switch (this.id) {
			case 'btnRegSetToday': setSearchDate("reg_dt_from", "reg_dt_to", "today"); break;
			case 'btnRegSetWeekago': setSearchDate("reg_dt_from", "reg_dt_to", "weekago"); break;
			case 'btnRegSetMonthago': setSearchDate("reg_dt_from", "reg_dt_to", "monthago"); break;
			case 'btnDispSetToday': setSearchDate("disp_dt_from", "disp_dt_to", "today"); break;
			case 'btnDispSetWeekago': setSearchDate("disp_dt_from", "disp_dt_to", "weekago"); break;
			case 'btnDispSetMonthago': setSearchDate("disp_dt_from", "disp_dt_to", "monthago"); break;
			}
		});
		
		// grid 검색
// 		jQuery("#btnSearch").click(function() {
// 			$("#searchForm").submit();
// 		});
		
		// 초기화 버튼
		$('#btnReset').click(function() {
			$('#searchForm')[0].reset();
		});
		
		// jQuery validation
		$("#searchForm").validate({
			rules: {
				title_txt: { maxlength: 100 },
				regstaff_id: { maxlength: 20 },
				reg_dt_from: { dpDate: true },
				reg_dt_to: { dpDate: true, dpCompareDate:{notBefore: '#reg_dt_from'} },
				disp_dt_from: { dpDate: true },
				disp_dt_to: { dpDate: true, dpCompareDate:{notBefore: '#disp_dt_from'} }
			},
			messages: {
				title_txt: { maxlength: jQuery.format("제목은 최대 {0} 글자 이하로 입력하세요.") },
				regstaff_id: { maxlength: jQuery.format("등록자 ID는 최대 {0} 글자 이하로 입력하세요.") },
				reg_dt_from: { dpDate: "등록일 검색 시작일자는 yyyy-mm-dd 형식으로 입력하세요." },
				reg_dt_to: {
					dpDate: "등록일 검색 종료일자는 yyyy-mm-dd 형식으로 입력하세요.",
					dpCompareDate: "등록일 검색 종료일은 시작일보다 같거나 이후 일자를 선택하세요."
				},
				disp_dt_from: { dpDate: "게시일 검색 시작일자는 yyyy-mm-dd 형식으로 입력하세요." },
				disp_dt_to: {
					dpDate: "게시일 검색 종료일자는 yyyy-mm-dd 형식으로 입력하세요.",
					dpCompareDate: "게시일 검색 종료일은 시작일보다 같거나 이후 일자를 선택하세요."
				}
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
	
	function fn_f3(){
		$("#searchForm").submit();
	}
</script>

</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">공지사항</h3>
			
			<span class="bullet6">문서관리 &gt; 공지사항</span>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form method="get" action="#" id="searchForm">
					<fieldset>
						<legend>공지사항</legend>
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
														<input type="text" style="width: 50%;" id="title_txt" name="title_txt" maxlength="100"/>
													</dd>
													<dt>내용</dt>
													<dd>
														<input type="text" style="width: 50%;" id="regstaff_id" name="regstaff_id" maxlength="20"/>
													</dd>
												</dl>

												<dl class="section">
													<dt>등록일</dt>
													<dd class="cols">
														<span class="calendar">
															<input type="text" maxlength="10" class="datepicker" id="reg_dt_from" name="reg_dt_from"/>
														</span>
														&nbsp;~&nbsp; 
														<span class="calendar">
															<input type="text" maxlength="10" class="datepicker" id="reg_dt_to" name="reg_dt_to"/>
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
					<input type="button" class="btn btn-primary btn-sm" value="등록" id="btnNewPost">
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
