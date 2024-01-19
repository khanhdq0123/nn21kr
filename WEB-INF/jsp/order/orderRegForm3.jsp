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

	<h1 class="ly_header">견적접수 등록</h1>
	<!-- .ly_body -->
	<div class="ly_body">

			
		<div class="refer bullet6">
			<div class="refer_bt">
			
			
				<div class="min_btn mini">
					<input type="button" class="btn btn-primary btn-sm" value="SAVE" id="btnSave">
					<input type="button" class="btn btn-close btn-sm" value="DELETE" id="btnClose">
				</div>
			</div>
		</div>
		
		
		
		
		<form action="#" id="submitForm" enctype="multipart/form-data">
			<input type="hidden" id="hdnGridData1" name="itemList" />
			
			<input type="hidden" id="ord_typ"				name="ord_typ" 				value="3" />
			<input type="hidden" id="stat_cd"				name="stat_cd" 				value="11601" />
			<input type="hidden" id="shipping_region_no"	name="shipping_region_no" 	value="" />
			<input type="hidden" id="send_region_no" 		name="send_region_no" 		value="" />
			<input type="hidden" id="receive_region_no" 	name="receive_region_no" 	value="" />
			<input type="hidden" id="start_vendor_no" 		name="start_vendor_no" 		value="" />
			<input type="hidden" id="arrive_vendor_no" 		name="arrive_vendor_no" 	value="" />
			<input type="hidden" id="transfer_vendor_no" 	name="transfer_vendor_no" 	value="" />
			<input type="hidden" id="send_no" 				name="send_no" 				value="" />
			<input type="hidden" id="send_trade_comp_no" 	name="send_trade_comp_no" 	value="" />
			<input type="hidden" id="send_cc_comp_no" 		name="send_cc_comp_no" 		value="" />
			<input type="hidden" id="receive_no" 			name="receive_no" 			value="" />
			<input type="hidden" id="receive_trade_omp_no" 	name="receive_trade_omp_no" value="" />
			<input type="hidden" id="receive_cc_comp_no" 	name="receive_cc_comp_no" 	value="" />
		<fieldset>
		
		<legend>접수 등록 상세 페이지</legend>
		<div class="layer_contents">
		
		
			
			<div class="tagCover">
				<h1 class="styleH3">일정</h1>
				<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
				
					<div class="tbl_wrap">
	
						<dl class="section">
							<dt>선적지점</dt>
							<dd class="cols" style="width:280px;">
								<input type="text" id="shipping_region_nm" name="shipping_region_nm" class="readonly" placeholder="선적지점선택" style="width:98%;"  onclick="fnSelectRegionPop(1);" readonly />
							</dd>
							<dt>출발지점</dt>
							<dd class="cols" style="width:280px;">
								<input type="text" id="send_region_nm" name="send_region_nm" class="readonly" placeholder="출발지점선택" style="width:98%;" onclick="fnSelectRegionPop(2);" readonly />
							</dd>
							<dt>도착지점</dt>
							<dd class="cols" style="width:280px;">
								<input type="text" id="receive_region_nm" name="receive_region_nm" class="readonly" placeholder="도착지점선택" style="width:98%;" onclick="fnSelectRegionPop(3);" readonly />
							</dd>
						</dl>
	
						<dl class="section">
							<dt>출발일자</dt>
							<dd class="cols" style="width:280px;">
								<span class="calendar">
									<input type="text" maxlength="10" class="datepicker" id="start_dt" name="start_dt"/>
								</span>
							</dd>
							<dt>도착일자</dt>
							<dd class="cols" style="width:280px;">
								<span class="calendar">
									<input type="text" maxlength="10" class="datepicker" id="arrive_dt" name="arrive_dt"/>
								</span>
							</dd>
							<dt>입고일자</dt>
							<dd class="cols" style="width:280px;">
								<span class="calendar">
									<input type="text" maxlength="10" class="datepicker" id="shipment_dt" name="shipment_dt"/>
								</span>
							</dd>
						</dl>
						<dl class="section">
							<dt>운송구분</dt>
							<dd style="width:300px;">
								<select  id="transport_way" name="transport_way">
									<option value="">전체</option>
	                                          <c:forEach var="entity" items="${applicationScope['CODE']['10800']}">
	                                             <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
	                                          </c:forEach>   
								</select>
							</dd>
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
								<td>
									<input type="text" id="send_nm" name="send_nm" class="readonly" placeholder="발송화주선택" onclick="fnSelectLayer('발송화주 선택','selectCustomerLayerPop','send_no','send_nm'); " style="width:98%;" readonly />
								</td>							
							</tr>
							<tr>
								<th scope="row">수출회사</th>
								<td>
									<input type="text" id="send_trade_comp_nm" name="send_trade_comp_nm" class="readonly" placeholder="수출회사선택" onclick="fnSelectLayer('수출회사 선택','selectTradeCompLayerPop','send_trade_comp_no','send_trade_comp_nm'); " style="width:98%;" readonly />
								</td>							
							</tr>
							<tr>
								<th scope="row">수출통관</th>
								<td>
									<input type="text" id="send_cc_comp_nm" name="send_cc_comp_nm" class="readonly" placeholder="통관회사선택" onclick="fnSelectLayer('통관회사 선택','selectCCCompLayerPop','send_cc_comp_no','send_cc_comp_nm'); " style="width:98%;" readonly />
								</td>							
							</tr>
							<tr>
								<th scope="row">등록문서 <input type="button" class="btn btn-success btn-xs" value="+" id="btnItemAdd" onclick="fnShipperFileAdd();"></th>
								<td id="tdShipperFile">
<!-- 									<input type="file" class="file_1" id="inptFile" name="attachFile" title="파일첨부" style="width: 40%; margin-top: 10px;"/> -->
									<input type="file" class="mb4" id="attachShipperFile0" name="attachShipperFile0">
								</td>							
							</tr>
							<tr>
								<th scope="row">픽업예약</th>
								<td>
									<input type="text" id="region_nm" name="region_nm" class="" placeholder="" style="width:98%;" />
								</td>							
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
								<td>
									<input type="text" id="receive_nm" name="receive_nm" class="readonly" placeholder="발송화주선택" onclick="fnSelectLayer('수화화주 선택','selectCustomerLayerPop','receive_no','receive_nm'); " style="width:98%;" readonly />
								</td>							
							</tr>
							<tr>
								<th scope="row">수입회사</th>
								<td>
									<input type="text" id="receive_trade_omp_nm" name="receive_trade_omp_nm" class="readonly" placeholder="수입회사선택" onclick="fnSelectLayer('수입회사 선택','selectTradeCompLayerPop','receive_trade_omp_no','receive_trade_omp_nm'); " style="width:98%;" readonly />
								</td>							
							</tr>
							<tr>
								<th scope="row">수입통관</th>
								<td>
									<input type="text" id="receive_cc_comp_nm" name="receive_cc_comp_nm" class="readonly" placeholder="통관회사선택" onclick="fnSelectLayer('통관회사 선택','selectCCCompLayerPop','receive_cc_comp_no','receive_cc_comp_nm'); " style="width:98%;" readonly />
								</td>							
							</tr>
							<tr>
								<th scope="row">등록문서 <input type="button" class="btn btn-success btn-xs" value="+" id="btnItemAdd" onclick="fnConsigneeFileAdd();"></th>
								<td id="tdConsigneeFile">
									<input type="file" class="mb4" id="attachConsigneeFile0" name="attachConsigneeFile0"  />
									
								</td>							
							</tr>
							<tr>
								<th scope="row">배송예약</th>
								<td>
									<input type="text" id="region_nm" name="region_nm" class="" placeholder="" style="width:98%;" />
								</td>							
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
						<dd style="width:35%;">
							<select  id="charge_target_typ" name="charge_target_typ">
								<option value="">전체</option>
                                          <c:forEach var="entity" items="${applicationScope['CODE']['10900']}">
                                             <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
                                          </c:forEach>   
							</select>
						</dd>
						<dt>비용상세</dt>
						<dd class="cols" style="width:35%;">
							<input type="text" id="charge_memo" name="charge_memo" class="" placeholder="" style="width:98%;"  />
						</dd>
					</dl>

				</div>
		
			</div>
		</div>

		
		<!-- item start -->
		<div class="tagCover">
			
			<div class="report" style="padding:10px 0 0 0; !important; ">
				<h1 class="styleH3" style="float:left;" >화물</h1>
				<div class="min_btn">
					<input type="button" class="btn btn-success btn-xs" value="추가" id="btnItemAdd" onclick="fnItemAdd();">
					<input type="button" class="btn btn-danger btn-xs" value="삭제" id="btnItemDelete" onclick="fnItemDelete();">
				</div>
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

<div class="layer-mask" style="display:none;"></div>

	<!-- 회주선택 -->
	<div class="lypopWrap" style="width:380px; max-height:400px; overflow-y:auto; display:none; " id="selectCustomerLayerPop" >
		<!-- header -->
		<div class="header">
			<h3 class="tit">화주선택</h3>
			<p class="btnR">
				<input type="button" class="btn btn-close btn-xs" onclick="fnCloseLayer('selectCustomerLayerPop');" value="닫기">
			</p>
		</div>
		<!-- //header -->
		<!-- contents -->
		<div class="contents select-layer1">
			<ul>
				<c:forEach var="entity" items="${customerList}">
					<li cd="<c:out value="${entity.vendor_no}"/>" nm="<c:out value="${entity.vendor_nm}"/>"><c:out value="${entity.vendor_nm}"/></li>
				</c:forEach>   
			</ul>
		</div>
		<!-- //contents -->
	</div>
	
	<!-- 수출입회사 선택 -->
	<div class="lypopWrap" style="width:380px; max-height:400px; overflow-y:auto; display:none; " id="selectTradeCompLayerPop" >
		<!-- header -->
		<div class="header">
			<h3 class="tit">수/출입회사 선택</h3>
			<p class="btnR">
				<input type="button" class="btn btn-close btn-xs" onclick="fnCloseLayer('selectTradeCompLayerPop');" value="닫기">
			</p>
		</div>
		<!-- //header -->
		<!-- contents -->
		<div class="contents select-layer1">
			<ul>
				<c:forEach var="entity" items="${coopCompList7}">
					<li cd="<c:out value="${entity.vendor_no}"/>" nm="<c:out value="${entity.vendor_nm}"/>"><c:out value="${entity.vendor_nm}"/></li>
				</c:forEach>   
			</ul>
		</div>
		<!-- //contents -->
	</div>
	
	<!-- 통관회사 선택 -->
	<div class="lypopWrap" style="width:380px; max-height:400px; overflow-y:auto; display:none; " id="selectCCCompLayerPop" >
		<!-- header -->
		<div class="header">
			<h3 class="tit">통관회사 선택</h3>
			<p class="btnR">
				<input type="button" class="btn btn-close btn-xs" onclick="fnCloseLayer('selectCCCompLayerPop');" value="닫기">
			</p>
		</div>
		<!-- //header -->
		<!-- contents -->
		<div class="contents select-layer1">
			<ul>
				<c:forEach var="entity" items="${coopCompList8}">
					<li cd="<c:out value="${entity.vendor_no}"/>" nm="<c:out value="${entity.vendor_nm}"/>"><c:out value="${entity.vendor_nm}"/></li>
				</c:forEach>   
			</ul>
		</div>
		<!-- //contents -->
	</div>

	<!-- 지사선택 -->
	<div class="lypopWrap" style="width:380px; max-height:400px; overflow-y:auto; display:none; " id="selectVendorLayerPop" >
		<!-- header -->
		<div class="header">
			<h3 class="tit">지사선택</h3>
			<p class="btnR">
				<input type="button" class="btn btn-close btn-xs" onclick="fnCloseLayer('selectVendorLayerPop');" value="닫기">
			</p>
		</div>
		<!-- //header -->
		<!-- contents -->
		<div class="contents select-layer1">
			<ul>
				<c:forEach var="entity" items="${partnerList}">
					<li cd="<c:out value="${entity.vendor_no}"/>" nm="<c:out value="${entity.vendor_nm}"/>"><c:out value="${entity.vendor_nm}"/></li>
				</c:forEach>   
			</ul>
		</div>
		<!-- //contents -->
	</div>


<div id="toast"></div></body>
</html>