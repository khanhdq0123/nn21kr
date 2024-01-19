<%--
	작성자 : 이형근(fixalot@exint.co.kr)
	백오피스 > 게시판관리 > 관리자 공지사항 리스트
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
			url: "/board/notice/adminNoticeListJson.do",
			datatype: "local",
		   	colNames: [
	            '시스템 구분', '공지번호','제목', '등록자 ID', '등록 일시', 
	            '중요 여부', '팝업 여부', '게시 여부', '조회 수', '다운로드 수', '전시 순서'
		   	],
			colModel: [
	            { 
	            	name: 'notice_typ', index: 'notice_typ', align: 'center', sortable: true, width: '90', 
	            	formatter:"select", editoptions:{value:"0:전체;1:내부관리자;2:지사;3:고객사"}
	            },
	            { name: 'noticebbs_no', index: 'noticebbs_no', align: 'center', key: true, sortable: true, width: '60' },
				{ 
	            	name: 'title_txt', index: 'title_txt', align: 'left', formatter : linkFormatter, 
	            	unformat : linkUnFormatter, sortable: true, width: '220'
				}, 
				{ name: 'regstaff_id', index: 'regstaff_id', align: 'center', sortable: true, width: '80' }, 
				{ name: 'reg_dt', index: 'reg_dt', align: 'center', sortable: true, width: '100' }, 
				{ name: 'imp_yn', index: 'imp_yn', align: 'center', sortable: true, width: '60' },
				{ name: 'pop_yn', index: 'pop_yn', align: 'center', sortable: true, width: '60' },
				{ name: 'use_yn', index: 'use_yn', align: 'center', sortable: true, width: '60' },
				{ name: 'view_cnt', index: 'view_cnt', align: 'center', sortable: true, width: '60' },
				{ name: 'download_cnt', index: 'download_cnt', align: 'center', sortable: true, width: '60' },
				{ name: 'disp_seq', index: 'disp_seq', align: 'center', sortable: true, width: '60' }
			],
			autowidth: true,
			height: 500,
			pager: '#pager1',
			rowNum: 500,
// 			rowList: [20, 50, 100],
	// 		shrinkToFit: false,
	// 		multiselect: true,
			mtype:"post",
			viewrecords: true,
			loadComplete: function(data) {
				setSortingGridData(this, data);
			}, 
			onPaging: function(btn) {
				if($('#'+btn).hasClass('ui-state-disabled')) {
					return 'stop';
				} else { 
					$("#list1").jqGrid("clearGridData").jqGrid('setGridParam',{ datatype:'json' });
					return true;
				}
			},
			loadError : function(xhr,st,err) {
				girdLoadError();
		    },
		    postData: serializeObject($("#searchForm"))  
		});
		
		// jqGrid linkFormatter
		function linkFormatter(cellVal, options, rowObj) {
			var params = "?mode=amend"
			var linkURL = '<a href="javascript:CenterOpenWindow(\'/board/notice/adminNoticeDetail' + params + '&id='
					+ rowObj['noticebbs_no']
					+ '\', \'open\', \'1000\', \'800\', \'scrollbars=yes, status=no\');">'
					+ cellVal + '</a>';
			return linkURL;
		}
		
		// 신규등록 팝업
		$("#btnNewPost").click(function() {
			var width=1000, height=800;
			var params = "?mode=new"
			CenterOpenWindow("/board/notice/adminNoticeDetail" + params, "_blank", width, height, "scrollbars=yes, status=no");
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
			<h3 class="header">관리자 공지사항</h3>
			
			<span class="bullet6">게시판관리 &gt; 관리자 공지사항</span>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form method="get" action="#" id="searchForm">
					<fieldset>
						<legend>관리자 공지사항</legend>
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
													<dt>등록자 ID</dt>
													<dd>
														<input type="text" style="width: 50%;" id="regstaff_id" name="regstaff_id" maxlength="20"/>
													</dd>
												</dl>
												<dl class="section">
													<dt>게시여부</dt>
													<dd>
														<select name="use_yn" style="width: 50%">
															<option value="" selected="selected">전체</option>
															<option value="y">Y</option>
															<option value="n">N</option>
														</select>
													</dd>
													<dt>시스템구분</dt>
													<dd>
														<select name="notice_typ" style="width: 50%">
															<option value="0" selected="selected">전체</option>
															<option value="1">내부관리자</option>
															<option value="2">지사</option>
															<option value="3">고객사</option>
														</select>
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
												<dl class="section">	
													<dt>게시일</dt>										
													<dd class="cols">
														<span class="calendar">
															<input type="text" maxlength="10" class="datepicker" id="disp_dt_from" name="disp_dt_from"/>
														</span>
														&nbsp;~&nbsp; 
														<span class="calendar">
															<input type="text" maxlength="10" class="datepicker" id="disp_dt_to" name="disp_dt_to"/>
														</span>
														
														<span id="spnSetDisp">
															<button type="button" class="btn_c6" id="btnDispSetToday">오늘</button>
															<button type="button" class="btn_c6" id="btnDispSetWeekago">1주일</button>
															<button type="button" class="btn_c6" id="btnDispSetMonthago">1개월</button>
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
					<button type="button" class="sky" id="btnNewPost">신규등록</button>
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