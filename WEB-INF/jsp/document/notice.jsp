<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>공지안내</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-control" content="No-cache" />
<meta http-equiv="Pragma" content="No-cache" />
<meta name="Description" content="" />
<meta name="Keywords" content="" />

<%@include file="/common/include/header.jsp"%>


<script type="text/javascript">
	$(document).ready(function() {
		
		
		var sStatus = "2:진행중;3:완료";	
		
		
		$("#spnSetReg button").click(function() {
			var when = '';
			if (this.id == 'btnRegSetToday') when = 'today';
			if (this.id == 'btnRegSetWeekago') when = 'weekago';
			if (this.id == 'btnRegSetMonthago') when = 'monthago';
			setSearchDate('search_start_dt', 'search_end_dt', when);
		});
		
		
		// Title	BLNO	Date	Area	Warehouse	 	Status	excel
		
		// 그리드 - 프로토타입 
		jQuery('#list1').jqGrid({
			url: '/transport/inbound/inputListJson',
			datatype: 'local',
		   	colNames: ['No', 'Header', 'Title', 'ID', 'Registerd','Hit'],
			colModel: [
	            { name: 'No', 	index: 'No', 	align: 'center', sortable: true, width: '50' },
	            { name: 'Header', 	index: 'Header', 	align: 'center', sortable: true, width: '150' },
				{ name: 'Title', 		index: 'Title', 		align: 'center', sortable: true, width: '500' , editable:true},
				{ name: 'ID', 		index: 'ID', 			align: 'center', sortable: true, width: '300' },
				{ name: 'Registerd', 		index: 'Registerd', 			align: 'center', sortable: true, width: '150' },
				{ name: 'Hit', 	index: 'Hit', 	align: 'center', sortable: true, width: '80' }
			],
			mtype:"post",
			autowidth:true,
			rowNum:500,	   	
// 			rowList:[20,50,100],
			height: 500,
			editable:true,
			pager: '#pager1',
			sortname: 'maker_no',
		    viewrecords: true,
		    sortorder: "desc",
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
		    postData: serializeObject($('#searchForm')),
		    // cell이 변경되었을 경우 처리
		    afterSaveCell : function(id, name, val, iRow, iCol) {
		    	checkWhenColumnUpdated("codeGrid", id);
		    }
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
		

		
		// jQuery validation
		$("#searchForm").validate({
			rules: {

			},
			messages: {

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
			<h3 class="header">공지안내</h3>
			
			<span class="bullet6">문서관리 &gt; 공지안내</span>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form method="get" id="searchForm">
					<fieldset>
						<legend>도착입고</legend>
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
													<dt>Header</dt>
													<dd>
														<select id="st_RegionCode" class="form-control text-sm">
														<option value="All">ALL</option>
														<option value="G">안내</option>
														<option value="7">공지</option>
														<option value="8">불만</option>
														</select>
													</dd>
													<dt>Contents</dt>
													<dd>
														<input type="text" id="user_name" name="user_name" style="width: 50%" maxlength="30"/>
													</dd>
													
												</dl>
												<dl class="section">
													<dt>Title</dt>
													<dd>
														<input type="text" id="gl_user_id" name="gl_user_id" style="width: 50%" maxlength="20"/>
													</dd>
													<dt>ID</dt>
													<dd>
														<input type="text" id="user_name" name="user_name" style="width: 50%" maxlength="30"/>
													</dd>
												</dl>
												<dl class="section">
													<dt>Registerd</dt>
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
