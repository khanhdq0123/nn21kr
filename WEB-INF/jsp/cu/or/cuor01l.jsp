<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<%@include file="/common/include/header.jsp"%>

</head>
<body class="sky">


    
<form method="get" id="searchForm">

	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">접수현황</h3>
			<h3 class="screen-id">cuor01l</h3>
			<span class="bullet6">거래 관리 &gt; 접수현황</span>
		</div>

		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<section>
				<div class="radio-group">
	                <div class="option"><input type="radio" id="rd_ord_typ"  name="s_ord_typ" value=""><label class="radio-container" for="rd_ord_typ">전체</label></div>
	                <div class="option"><input type="radio" id="rd_ord_typ1" name="s_ord_typ" value="1" checked="checked"><label class="radio-container" for="rd_ord_typ1">운송</label></div>
	                <div class="option"><input type="radio" id="rd_ord_typ2" name="s_ord_typ" value="2"><label class="radio-container" for="rd_ord_typ2">보관</label></div>
	                <div class="option"><input type="radio" id="rd_ord_typ3" name="s_ord_typ" value="3"><label class="radio-container" for="rd_ord_typ3">견적</label></div>
	                <div class="option"><input type="radio" id="rd_ord_typ4" name="s_ord_typ" value="4"><label class="radio-container" for="rd_ord_typ4">원산지</label></div>
	                <div class="option"><input type="radio" id="rd_ord_typ5" name="s_ord_typ" value="5"><label class="radio-container" for="rd_ord_typ5">통관</label></div>
	            </div>
	
				<div class="radio-group ml20">
	                <div class="option"><input type="radio" id="rd_inout_typ1" name="s_inout_typ" value="1" checked=""><label class="radio-container" for="rd_inout_typ1">수입</label></div>
	                <div class="option"><input type="radio" id="rd_inout_typ2" name="s_inout_typ" value="2"><label class="radio-container" for="rd_inout_typ2">수출</label></div>
	            </div>
			
			</section>
			
			<div class="report">
				<div class="bullet6"></div>
				<div class="min_btn">
					<select style="width:100px;" id="ord_typ" name="ord_typ">
						<option value="1">운송접수</option>
	                    <option value="2">보관접수</option>
	                    <option value="3">견적접수</option>
	                    <option value="4">원산지접수</option>
	                    <option value="5">통관접수</option>
                    </select>
                    <select style="width:100px; margin-right:10px;" id="inout_typ" name="inout_typ">
						<option value="1">수출</option>
	                    <option value="2">수입</option>
                    </select>
					<input type="button" class="btn btn-primary btn-sm" value="접수신청" id="btnNew">
					<input type="button" class="btn btn-success btn-sm" value="엑셀 다운로드" id="btnExcelDownload">
				</div>
			</div>
		

		
			<!-- grid -->
			<div class="grid">
				<table id="list1"></table>
			</div>
			<!-- grid end -->	


		</div>
		<!-- //product_admin -->
	</div>
	<!-- //content_wrap -->
	
</form>
<script type="text/javascript" src="/js/cu/or/cuor01l.js?1"></script>
<div id="toast"></div></body>
</html>
