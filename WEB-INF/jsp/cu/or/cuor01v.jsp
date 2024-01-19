<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/common/include/header.jsp"%>
		
		<title>접수 등록</title>
		<script type="text/javascript" src="/js/orderRegForm.js?123"></script>
		
		<style>
		.st_port_wrap input {background-color:#eee;}
		.ar_port_wrap input {background-color:#eee;}
		
		label.on {font-weight:bold; color:blue;}
		</style>
		<script>
		var  inout_typ="${inout_typ}";
		var  vendor_no="${vendor_no}";
		var  vendor_nm="${vendor_nm}";
		
		
		$(document).ready(function() {
			if(inout_typ == '1'){
				$("#send_nm").val(vendor_nm);
				$("#send_no").val(vendor_no);
				$("#send_nm").attr("disabled", true); 

			} else {
				$("#receive_nm").val(vendor_nm);
				$("#receive_no").val(vendor_no);
				$("#receive_nm").attr("disabled", true); 
			}

		});
		</script>
	</head>

<body class="sky">

<form id="searchForm" name="searchForm" method="post" action="#">
</form>

<div class="layerpop_inner" id="#">

	<h1 class="ly_header">${info.ord_typ_nm}증</h1>
	<!-- .ly_body -->
	<div class="ly_body">

			
		<div class="refer bullet6">
			<div class="refer_bt">
			
			
				<div class="min_btn mini">
					<input type="button" class="btn btn-success btn-sm" value="접수증수정" id="btnEdit">
					<input type="button" class="btn btn-primary btn-sm" value="입고완료" id="btnWarehousing">
					<input type="button" class="btn btn-danger btn-sm" value="삭제" id="btnDelete">
					<input type="button" class="btn btn-close btn-sm" value="닫기" id="btnClose">
				</div>
			</div>
		</div>
		
		
		
		
		<form action="#" id="submitForm" enctype="multipart/form-data">
			<input type="hidden" id="hdnGridData1" name="itemList" />
		<fieldset>
		
		<legend>접수 등록 상세 페이지</legend>
		<div class="layer_contents">
		
		
			
			<div class="tagCover">
				<h1 class="styleH3">일정</h1>
				<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
				
					<div class="tbl_wrap">
	
						<dl class="section">
							<dt>선적지점</dt>
							<dd class="cols" style="width:280px;">${info.shipping_region_nm}</dd>
							<dt>출발지점</dt>
							<dd class="cols" style="width:280px;">${info.send_region_nm}</dd>
							<dt>도착지점</dt>
							<dd class="cols" style="width:280px;">${info.receive_region_nm}</dd>
						</dl>
	
						<dl class="section">
							<dt>출발일자</dt>
							<dd class="cols" style="width:280px;"></dd>
							<dt>도착일자</dt>
							<dd class="cols" style="width:280px;"></dd>
							<dt>입고일자</dt>
							<dd class="cols" style="width:280px;"></dd>
						</dl>
						<dl class="section">
							<dt>운송구분</dt>
							<dd style="width:300px;">${info.transport_way_nm}</dd>
						</dl>
					</div>
				</div>
			</div>
			

			<div class="tagCover">
				<h1 class="styleH3">지사선택</h1>
				<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
				
					<div class="tbl_wrap">
	
						<dl class="section">
							<dt>출발지사</dt>
							<dd class="cols" style="width:280px;"></dd>
							<dt>도착지사</dt>
							<dd class="cols" style="width:280px;"></dd>
							<dt>경유지사</dt>
							<dd class="cols" style="width:280px;"></dd>
						</dl>
					</div>
				</div>
			</div>
			


		<div class="tagCover">
			<div style="width:49%; float:left; position:relative;">
				<h1 class="styleH3">Shipper</h1>
				<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
					<table cellspacing="0" cellpadding="0" class="layer_tbl" style="margin-top:0;">
					<caption>Shipper</caption>
						<colgroup>
							<col width="140px" />
							<col width="/" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">발송화주</th>
								<td>${info.send_nm}</td>							
							</tr>
							<tr>
								<th scope="row">수출회사</th>
								<td></td>							
							</tr>
							<tr>
								<th scope="row">수출통관</th>
								<td></td>							
							</tr>
							<tr>
								<th scope="row">등록문서</th>
								<td id="tdShipperFile"></td>							
							</tr>
							<tr>
								<th scope="row">픽업예약</th>
								<td></td>							
							</tr>

						</tbody>
					</table>
				</div>
			</div>
		
			<div style="width:49%; float:right; position:relative;">
				<h1 class="styleH3">Consignee</h1>
				<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
					<table cellspacing="0" cellpadding="0" class="layer_tbl" style="margin-top:0;">
					<caption>Consignee</caption>
						<colgroup>
							<col width="140px" />
							<col width="/" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">수화화주</th>
								<td>${info.receive_nm}</td>							
							</tr>
							<tr>
								<th scope="row">수입회사</th>
								<td></td>							
							</tr>
							<tr>
								<th scope="row">수입통관</th>
								<td></td>							
							</tr>
							<tr>
								<th scope="row">등록문서</th>
								<td id="tdConsigneeFile"></td>							
							</tr>
							<tr>
								<th scope="row">배송예약</th>
								<td></td>							
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			
		</div>
		
		<div class="tagCover">
			<h1 class="styleH3">비용</h1>
			<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
			
				<div class="tbl_wrap">

					<dl class="section">
						<dt>비용청구</dt>
						<dd style="width:35%;"></dd>
						<dt>비용상세</dt>
						<dd class="cols" style="width:35%;"></dd>
					</dl>

				</div>
		
			</div>
		</div>
		
		<div class="tagCover">
			<h1 class="styleH3">메모</h1>
			<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
			
				<div class="tbl_wrap">

					<dl class="section">
						<dt style="height:64px;">고객주의사항</dt>
						<dd style="width:35%;"></dd>
						<dt style="height:64px;">업무전달사항</dt>
						<dd class="cols" style="width:35%;"></dd>
					</dl>

				</div>
		
			</div>
		</div>
		
		<!-- item start -->
		<div class="tagCover">
			
			<div class="report" style="padding:10px 0 0 0; !important; ">
				<h1 class="styleH3" style="float:left;" >화물</h1>
				<div class="min_btn"></div>
			</div>
			
			<!-- grid -->
			<div class="grid">
				<table id="itemList"></table>
			</div>
			<!-- grid end -->	
		
		</div>
		<!-- item end -->


				
			</div>
		</fieldset>
	</form>
	</div>
	<!-- // .ly_body -->

</div>






<script type="text/javascript" src="/js/cu/or/cuor01v.js?1"></script>
<div id="toast"></div></body>
</html>