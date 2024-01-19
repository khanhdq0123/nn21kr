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

	<h1 class="ly_header">보관접수 등록</h1>
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
			
			<input type="hidden" id="ord_typ"				name="ord_typ" 				value="2" />
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
			<input type="hidden" id="upvendor_no" 			name="upvendor_no" 			value="" />
		<fieldset>
		
		<legend>접수 등록 상세 페이지</legend>
		<div class="layer_contents">
		
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


			<div class="tagCover">
				<h1 class="styleH3">지사선택</h1>
				<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
				
					<div class="tbl_wrap">
	
						<dl class="section">
							<dt>화주</dt>
							<dd class="cols" style="width:280px;">
								<input type="text" id="send_nm" name="send_nm" class="readonly" placeholder="발송화주선택" onclick="fnSelectLayer('발송화주 선택','selectCustomerLayerPop','send_no','send_nm'); " style="width:98%;" readonly />
							</dd>
							<dt>관리지사</dt>
							<dd class="cols" style="width:280px;">
								<input type="text" id="upvendor_nm" name="upvendor_nm" class="readonly" placeholder="관리지사선택" onclick="fnSelectLayer('관리지사 선택','selectVendorLayerPop','arrive_vendor_no','arrive_vendor_nm');" style="width:98%;" readonly />
							</dd>

						</dl>
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
		
		<div class="tagCover">
			<h1 class="styleH3">메모</h1>
			<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
			
				<div class="tbl_wrap">

					<dl class="section">
						<dt style="height:64px;">고객주의사항</dt>
						<dd style="width:35%;">
							<textarea id="customer_memo" name="customer_memo" style="overflow: hidden;" rows="4" cols="46" onfocus="this.select();"></textarea>
						</dd>
						<dt style="height:64px;">업무전달사항</dt>
						<dd class="cols" style="width:35%;">
							<textarea id="business_memo" name="business_memo" style="overflow: hidden;" rows="4" cols="46" onfocus="this.select();"></textarea>
						</dd>
					</dl>

				</div>
		
			</div>
		</div>
		



				
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