<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript" src="/js<%=jsUrl%>.js"></script>
</head>
<body class="sky">
<form method="get" id="searchForm" onSubmit="return false;">

	<div class="content_wrap">
		<div class="history">
			<h3 class="header"></h3>		
			<div class="btn-wrap">
				<select style="width:100px;" id="ord_typ" name="ord_typ">
					<option value="1">운송접수</option>
                    <option value="2">보관접수</option>
                    <option value="3">견적접수</option>
                    <option value="4">원산지접수</option>
                    <option value="5">통관접수</option>
                   </select>
                   <select style="width:100px; margin-right:10px;" id="inout_typ" name="inout_typ">
					<option value="2">Out Bound</option>
                    <option value="1">In Bound</option>
                   </select>				
				<input type="button" class="btn btn-primary btn-sm" value="신규등록[F9]" id="btnAdd">
				<input type="button" class="btn btn-success btn-sm" value="검색[F3]" id="btnSearch">
			</div>
		</div>
		<div class="product_admin">
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
	                <div class="option"><input type="radio" id="rd_inout_typ1" name="s_inout_typ" value="1" checked=""><label class="radio-container" for="rd_inout_typ1">In Bound</label></div>
	                <div class="option"><input type="radio" id="rd_inout_typ2" name="s_inout_typ" value="2"><label class="radio-container" for="rd_inout_typ2">Out Bound</label></div>
	            </div>
			</section>
			<div class="grid">
				<table id="list1"></table>
			</div>
		</div>
	</div>
	
</form>
<div id="toast"></div></body>
</html>