<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
	<head>
		<%@include file="/common/include/header.jsp"%>
		<script type="text/javascript" src="/js/ad/ex/ADEX02P.js"></script>
		
	<title>환율등록</title>
	<script type="text/javascript">
	//스크립트 를 작성
	</script>
	<style>
		.st_port_wrap input {background-color:#eee;}
		.ar_port_wrap input {background-color:#eee;}
		.ar1 {text-align:right !important;}
		.mr5 {margin-right:5px;}
	</style>
	</head>
<body class="sky">

<div class="layerpop_inner" id="#">

	<h1 class="ly_header">환율 등록</h1>
	<!-- .ly_body -->
	<div class="ly_body">
		<div class="refer bullet6">
			<div class="refer_bt">
				<div class="min_btn mini">
					<input type="button" class="btn btn-primary btn-xs" value="저장[F10]" id="btnSave">
					<input type="button" class="btn btn-close btn-xs" value="닫기" id="btnClose">							
				</div>
			</div>
		</div>
		<form id="gForm" name="gForm" method="post" action="#">
		<input type="hidden" id="route_typ" name="route_typ" value="1" />
		<input type="hidden" id="use_yn" name="use_yn" value="Y" />		
		 
			<fieldset>
			<legend>환율 등록 상세 페이지</legend>
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>환율 등록 상세 페이지</caption>
					<colgroup>
						<col width="45%" />
						<col width="55%" />
					</colgroup>
					<tbody>
						<tr>
							<td colspan="2" style="text-align:center;">
								<span class="calendar">
									<input type="text" style="width:96%" class="datepicker2" id="app_st_dt" name="app_st_dt" />
								</span>
								~
								<span class="calendar">
									<input type="text" style="width:96%" class="datepicker2" id="app_ed_dt" name="app_ed_dt" />
								</span>
							</td>				 
						</tr>
						<tr>							 
							<td class="ar1"> $ <input type="text" name="unit_usd" id="unit_usd" value="1"  /></td>
							<td> = &nbsp;￦  &nbsp;<input type="text" name="cost_usd" id="cost_usd" value="1307.5" /></td>
						</tr>
						<tr>							 
							<td class="ar1"> ￥ <input type="text" name="unit_cny" id="unit_cny" value="1"  /></td>
							<td> = &nbsp;￦  &nbsp;<input type="text" name="cost_cny" id="cost_cny" value="183.59" /></td>
						</tr>
						<tr>							 
							<td class="ar1"> ₫ <input type="text" name="unit_vnd" id="unit_vnd" value="100"  /></td>
							<td> = &nbsp;￦  &nbsp;<input type="text" name="cost_vnd" id="cost_vnd" value="5.56" /></td>
						</tr>
						<tr>							 
							<td class="ar1"> Y <input type="text" name="unit_jpy" id="unit_jpy" value="100"  /></td>
							<td> = &nbsp;￦  &nbsp;<input type="text" name="cost_jpy" id="cost_jpy" value="937.91" /></td>
						</tr>
						<tr>							 
							<td class="ar1"> HK$ <input type="text" name="unit_hkd" id="unit_hkd" value="1"  /></td>
							<td> = &nbsp;￦  &nbsp;<input type="text" name="cost_hkd" id="cost_hkd" value="166.84" /></td>
						</tr>
						<tr>							 
							<td class="ar1"> € <input type="text" name="unit_eur" id="unit_eur" value="1"  /></td>
							<td> = &nbsp;￦  &nbsp;<input type="text" name="cost_eur" id="cost_eur" value="1405.41" /></td>
						</tr>
						<tr>							 
							<td class="ar1"> Rp <input type="text" name="unit_idr" id="unit_idr" value="100"  /></td>
							<td> = &nbsp;￦  &nbsp;<input type="text" name="cost_idr" id="cost_idr" value="8.81" /></td>
						</tr>
						<tr>							 
							<td class="ar1"> ₱ <input type="text" name="unit_php" id="unit_php" value="1"  /></td>
							<td> = &nbsp;￦  &nbsp;<input type="text" name="cost_php" id="cost_php" value="23.32" /></td>
						</tr>
						<tr>							 
							<td class="ar1"> ฿ <input type="text" name="unit_thb" id="unit_thb" value="1"  /></td>
							<td> = &nbsp;￦  &nbsp;<input type="text" name="cost_thb" id="cost_thb" value="37.79" /></td>
						</tr>
					 
					</tbody>
				</table>
			</div>
		</fieldset>
	</form>
	</div>
	<!-- // .ly_body -->

</div>
<div id="toast"></div></body>
</html>