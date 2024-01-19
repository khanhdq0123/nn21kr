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
				<input type="button" class="btn btn-primary btn-sm" value="배송완료[F10]" id="btnUpdate">
				<input type="button" class="btn btn-success btn-sm" value="검색[F3]" id="btnSearch">
			</div>
		</div>
		<div class="product_admin">
<!-- 			<section> -->
<!-- 				<div class="radio-group ml20"> -->
<!-- 	                <div class="option"><input type="radio" id="rd_inout_typ1" name="s_inout_typ" value="1" checked=""><label class="radio-container" for="rd_inout_typ1">수입</label></div> -->
<!-- 	                <div class="option"><input type="radio" id="rd_inout_typ2" name="s_inout_typ" value="2"><label class="radio-container" for="rd_inout_typ2">수출</label></div> -->
<!-- 	            </div> -->
<!-- 			</section> -->
			<div class="grid">
				<table id="list1"></table>
			</div>
		</div>
	</div>
	
</form>
<div id="toast"></div></body>
</html>