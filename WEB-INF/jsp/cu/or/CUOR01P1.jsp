<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/common/include/header.jsp"%>
		
		<title>접수 등록</title>
		<script type="text/javascript" src="/js/cu/or/CUOR01P1.js?123"></script>
		

		<script>
		
		var unitTypeList7 = "<c:out escapeXml="false" value="${applicationScope['GRIDCODELIST']['11700']}"/>";	//화폐단위
		var unitTypeList8 = "<c:out escapeXml="false" value="${applicationScope['GRIDCODELIST']['11800']}"/>";	//수량단위
		var unitTypeList9 = "<c:out escapeXml="false" value="${applicationScope['GRIDCODELIST']['11900']}"/>";	//포장단위
		
		
		

		var vendor_no = "${vendor_no}";
		var vendor_cd = "${vendor_cd}";
		var vendor_nm = "${vendor_nm}";
		var ord_no = "${ord_no}";
		
		$(document).ready(function() {
// 			if(inout_typ == '2'){
// 				$("#start_vendor_nm").val(vendor_nm);
// 				$("#start_vendor_no").val(vendor_no);
// 				$("#start_vendor_nm").attr("disabled", true); 

// 			} else {
// 				$("#arrive_vendor_nm").val(vendor_nm);
// 				$("#arrive_vendor_no").val(vendor_no);
// 				$("#arrive_vendor_nm").attr("disabled", true); 
// 			}

			
			$("#shipment_dt").val('${info.start_dt}');
			$("#shipment_dt").val('${info.arrive_dt}');
			$("#shipment_dt").val('${info.shipment_dt}');
			
			
			
		});
		</script>
	</head>

<body class="sky">

<form id="searchForm" name="searchForm" method="post" action="#">
<input type="hidden" name="ord_no" id="ord_no" value="${ord_no}" />
</form>

<div class="layerpop_inner" id="#">

	<h1 class="ly_header">
		<c:if test="${ord_typ eq '1'}">운송접수</c:if>
		<c:if test="${ord_typ eq '2'}">보관접수</c:if>
		<c:if test="${ord_typ eq '3'}">견적접수</c:if>
		<c:if test="${ord_typ eq '4'}">원산지접수</c:if>
		<c:if test="${ord_typ eq '5'}">통관접수</c:if>

		<c:if test="${empty ord_no}"> 등록</c:if>	
		<c:if test="${!empty ord_no}"> 수정</c:if>
		
		 (${vendor_no }&nbsp;${vendor_nm })
	</h1>
	<!-- .ly_body -->
	<div class="ly_body">
		<div class="refer bullet6">
			<div class="refer_bt">
				<div class="min_btn mini">
					<input type="button" class="btn btn-primary btn-sm" value="SAVE" id="btnSave">
					<input type="button" class="btn btn-close btn-sm" value="CLOSE" id="btnClose">
				</div>
			</div>
		</div>
		
		<form action="#" id="submitForm" enctype="multipart/form-data" onSubmit="return false;" >
			<input type="hidden" id="hdnGridData1" name="itemList" />
			<input type="hidden" name="ord_no" value="${ord_no}" />
		<c:if test="${empty ord_no}">
			<input type="hidden" id="ord_typ"					name="ord_typ" 				value="1" />
			<input type="hidden" id="stat_cd"					name="stat_cd" 				value="11601" />
		</c:if>	
		<c:if test="${!empty ord_no}">
			<input type="hidden" id="ord_typ"					name="ord_typ" 				value="${info.ord_typ}" />
			<input type="hidden" id="stat_cd"					name="stat_cd" 				value="${info.stat_cd}" />
		</c:if>
			<input type="hidden" id="shipping_region_no"		name="shipping_region_no" 	value="${info.shipping_region_no}" />
			<input type="hidden" id="send_region_no" 			name="send_region_no" 		value="${info.send_region_no}" />
			<input type="hidden" id="receive_region_no" 		name="receive_region_no" 	value="${info.receive_region_no}" />
			<input type="hidden" id="start_vendor_no" 			name="start_vendor_no" 		value="${info.start_vendor_no}" />
			<input type="hidden" id="arrive_vendor_no" 			name="arrive_vendor_no" 	value="${info.arrive_vendor_no}" />
			<input type="hidden" id="transfer_vendor_no" 		name="transfer_vendor_no" 	value="${info.transfer_vendor_no}" />
			<input type="hidden" id="send_no" 					name="send_no" 				value="${info.send_no}" />
			<input type="hidden" id="send_trade_comp_no" 		name="send_trade_comp_no" 	value="${info.send_trade_comp_no}" />
			<input type="hidden" id="send_cc_comp_no" 			name="send_cc_comp_no" 		value="${info.send_cc_comp_no}" />
			<input type="hidden" id="receive_no" 				name="receive_no" 			value="${info.receive_no}" />
			<input type="hidden" id="receive_trade_comp_no" 	name="receive_trade_comp_no" value="${info.receive_trade_comp_no}" />
			<input type="hidden" id="receive_cc_comp_no" 		name="receive_cc_comp_no" 	value="${info.receive_cc_comp_no}" />
		<fieldset>
		
		<legend>접수 등록 상세 페이지</legend>
		<div class="layer_contents">
		
		
			
			<div class="tagCover">
				<h1 class="styleH3">일정</h1>
				<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
				
					<div class="tbl_wrap">
	
						<dl class="section">
							<dt>선적지점</dt>
							<dd class="cols" style="width:278px;">
								<input type="text" id="shipping_region_nm" name="shipping_region_nm" value="${info.shipping_region_nm}" class="readonly" placeholder="선적지점선택" style="width:97%;"  onclick="fnSelectRegionPop(1);" readonly />
							</dd>
							<dt>출발지점</dt>
							<dd class="cols" style="width:278px;">
								<input type="text" id="send_region_nm" name="send_region_nm" class="readonly" value="${info.send_region_nm}" placeholder="출발지점선택" style="width:97%;" onclick="fnSelectRegionPop(2);" readonly />
							</dd>
							<dt>도착지점</dt>
							<dd class="cols" style="width:278px;">
								<input type="text" id="receive_region_nm" name="receive_region_nm" class="readonly" value="${info.receive_region_nm}" placeholder="도착지점선택" style="width:97%;" onclick="fnSelectRegionPop(3);" readonly />
							</dd>
						</dl>
	
						<dl class="section">
							<dt>선적일자</dt>
							<dd class="cols" style="width:278px;">
								<span class="calendar">
									<input type="text" maxlength="10" class="datepicker" id="shipment_dt" name="shipment_dt" <c:out value="${info.shipment_dt}"/>  />
								</span>
							</dd>
							<dt>출발일자</dt>
							<dd class="cols" style="width:278px;">
								<span class="calendar">
									<input type="text" maxlength="10" class="datepicker" id="start_dt" name="start_dt" value="${info.start_dt}" />
								</span>
							</dd>
							<dt>도착일자</dt>
							<dd class="cols" style="width:278px;">
								<span class="calendar">
									<input type="text" maxlength="10" class="datepicker" id="arrive_dt" name="arrive_dt" value="${info.arrive_dt}" />
								</span>
							</dd>
						</dl>
						<dl class="section">
							<dt>운송구분</dt>
							<dd style="width:300px;">						
								<select  id="transport_way" name="transport_way">
									<option value="">전체</option>
	                                          <c:forEach var="entity" items="${applicationScope['CODE']['10800']}">
	                                             <option value="<c:out value="${entity.code_cd}"/>"    <c:if test="${entity.code_cd eq info.transport_way}"> selected</c:if>    ><c:out value="${entity.code_nm}"/></option>
	                                          </c:forEach>   
								</select>
							</dd>
						</dl>
					</div>
				</div>
			</div>
			

<!-- 			<div class="tagCover"> -->
<!-- 				<h1 class="styleH3">지사선택</h1> -->
<!-- 				<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;"> -->
				
<!-- 					<div class="tbl_wrap"> -->
	
<!-- 						<dl class="section"> -->
<!-- 							<dt>출발지사</dt> -->
<!-- 							<dd class="cols" style="width:280px;"> -->
<%-- 								<input type="text" id="start_vendor_nm" name="start_vendor_nm" value="${info.start_vendor_nm}"  class="readonly" placeholder="출발지사선택" onclick="fnSelectLayer('출발지사 선택','selectVendorLayerPop','start_vendor_no','start_vendor_nm'); " style="width:98%;" readonly /> --%>
<!-- 							</dd> -->
<!-- 							<dt>도착지사</dt> -->
<!-- 							<dd class="cols" style="width:280px;"> -->
<%-- 								<input type="text" id="arrive_vendor_nm" name="arrive_vendor_nm" value="${info.arrive_vendor_nm}"  class="readonly" placeholder="도착지사선택" onclick="fnSelectLayer('도착지사 선택','selectVendorLayerPop','arrive_vendor_no','arrive_vendor_nm');" style="width:98%;" readonly /> --%>
<!-- 							</dd> -->
<!-- 							<dt>경유지사</dt> -->
<!-- 							<dd class="cols" style="width:280px;"> -->
<%-- 								<input type="text" id="transfer_vendor_nm" name="transfer_vendor_nm" value="${info.transfer_vendor_nm}"  class="readonly" placeholder="경유지사선택" onclick="fnSelectLayer('경유지사 선택','selectVendorLayerPop','transfer_vendor_no','transfer_vendor_nm');" style="width:98%;" readonly /> --%>
<!-- 							</dd> -->
<!-- 						</dl> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
			


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
									<input type="text" id="send_nm" name="send_nm" value="${info.send_nm}"  class="readonly" placeholder="Shipper" onclick="fnSelectLayer1('발송화주 선택','selectCustomerLayerPop','send_no','send_nm'); " style="width:68%;" readonly />
									<input type="button" class="btn btn-primary btn-xs" value="new" id="btnCompReg1" onclick="cfPartnerReg(3);">
								</td>							
							</tr>
							<tr>
								<th scope="row">수출회사</th>
								<td>
									<input type="text" id="send_trade_comp_nm" name="send_trade_comp_nm" value="${info.send_trade_comp_nm}"  class="readonly" placeholder="수출회사선택" onclick="fnSelectLayer2('수출회사 선택','selectTradeCompLayerPop','send_trade_comp_no','send_trade_comp_nm'); " style="width:68%;" readonly />
									<input type="button" class="btn btn-primary btn-xs" value="new" id="btnCompReg2" onclick="cfCoopCompReg(7);">
								</td>							
							</tr>
<!-- 							<tr> -->
<!-- 								<th scope="row">수출통관</th> -->
<!-- 								<td> -->
<%-- 									<input type="text" id="send_cc_comp_nm" name="send_cc_comp_nm" value="${info.send_cc_comp_nm}"  class="readonly" placeholder="수출통관회사선택" onclick="fnSelectLayer('수출통관회사 선택','selectCCCompLayerPop','send_cc_comp_no','send_cc_comp_nm'); " style="width:68%;" readonly /> --%>
<!-- 									<input type="button" class="btn btn-primary btn-xs" value="new" id="btnCompReg3" onclick="cfCoopCompReg(8);"> -->
<!-- 								</td>							 -->
<!-- 							</tr> -->
							<tr>
								<th scope="row">등록문서 <input type="button" class="btn btn-success btn-xs" value="+" id="btnItemAdd" onclick="fnShipperFileAdd();"></th>
								<td id="tdShipperFile">
<!-- 									<input type="file" class="file_1" id="inptFile" name="attachFile" title="파일첨부" style="width: 40%; margin-top: 10px;"/> -->
									<input type="file" class="mb4" id="attachShipperFile0" name="attachShipperFile0">
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
									<input type="text" id="receive_nm" name="receive_nm" value="${info.receive_nm}"  class="readonly" placeholder="Consignee" onclick="fnSelectLayer1('수화화주 선택','selectCustomerLayerPop','receive_no','receive_nm'); " style="width:68%;" readonly />
									<input type="button" class="btn btn-primary btn-xs" value="new" id="btnCompReg4" onclick="cfPartnerReg(3);">
								</td>							
							</tr>
							<tr>
								<th scope="row">수입회사</th>
								<td>
									<input type="text" id="receive_trade_comp_nm" name="receive_trade_comp_nm" value="${info.receive_trade_comp_nm}"  class="readonly" placeholder="수입회사선택" onclick="fnSelectLayer2('수입회사 선택','selectTradeCompLayerPop','receive_trade_comp_no','receive_trade_comp_nm'); " style="width:68%;" readonly />
									<input type="button" class="btn btn-primary btn-xs" value="new" id="btnCompReg5" onclick="cfCoopCompReg(7);">
								</td>							
							</tr>
<!-- 							<tr> -->
<!-- 								<th scope="row">수입통관</th> -->
<!-- 								<td> -->
<%-- 									<input type="text" id="receive_cc_comp_nm" name="receive_cc_comp_nm" value="${info.receive_cc_comp_nm}"  class="readonly" placeholder="수입통관회사선택" onclick="fnSelectLayer('수입통관회사 선택','selectCCCompLayerPop','receive_cc_comp_no','receive_cc_comp_nm'); " style="width:68%;" readonly /> --%>
<!-- 									<input type="button" class="btn btn-primary btn-xs" value="new" id="btnCompReg5" onclick="cfCoopCompReg(8);"> -->
<!-- 								</td>							 -->
<!-- 							</tr> -->
							<tr>
								<th scope="row">등록문서 <input type="button" class="btn btn-success btn-xs" value="+" id="btnItemAdd" onclick="fnConsigneeFileAdd();"></th>
								<td id="tdConsigneeFile">
								<c:forEach var="list" items="${attachListIm}">
									<div onclick="fnFileDownloadIm('${list.filename_txt}','${list.attachfile_txt}');">
										${list.filename_txt}
									</div>
								</c:forEach>								
									<input type="file" class="mb4" id="attachConsigneeFile0" name="attachConsigneeFile0"  />
									
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
						<dt style="height:123px !important; line-height:123px !important;">비용청구</dt>
						<dd style="width:35%; line-height:24px;">

						    <c:forEach var="entity" items="${applicationScope['CODE']['10900']}" varStatus="status">
						    <input type="radio" name="charge_target_typ" id="charge_target_typ${status.index}" value="${entity.code_cd}" ${entity.code_cd == info.charge_target_typ ? "checked='checked'" : "" } />
						    <label class="int_space" for="charge_target_typ${status.index}">${entity.code_nm} : ${entity.comment_txt}</label>	<br />
                            </c:forEach>   

						</dd>
						<dt>비용상세</dt>
						<dd class="cols" style="width:35%;">
							<input type="text" id="charge_memo" name="charge_memo" value="${info.charge_memo}"  class="" placeholder="" style="width:98%;"  />
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
							<textarea id="customer_memo" name="customer_memo" style="overflow: hidden;" rows="4" cols="46" onfocus="this.select();">${info.customer_memo}</textarea>
						</dd>
						<dt style="height:64px;">업무전달사항</dt>
						<dd class="cols" style="width:35%;">
							<textarea id="business_memo" name="business_memo" style="overflow: hidden;" rows="4" cols="46" onfocus="this.select();">${info.business_memo}</textarea>
						</dd>
					</dl>

				</div>
		
			</div>
		</div>
		
		<div class="tagCover">
			<div class="report" style="padding:10px 0 0 0; !important; ">
				<h1 class="styleH3" style="float:left;" >화물</h1>
				<div class="min_btn">
				
				
					<select style="width:100px" id="sel_qty_unit" name="sel_qty_unit">
						<option value="">수량단위</option>
                        <c:forEach var="entity" items="${applicationScope['CODE']['11800']}">
                           <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
                        </c:forEach>   
					</select>
					<select style="width:100px" id="sel_amt_unit" name="sel_amt_unit">
						<option value="">화폐단위</option>
                        <c:forEach var="entity" items="${applicationScope['CODE']['11700']}">
                           <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
                        </c:forEach>   
					</select>
					<select style="width:100px" id="sel_box_qty_unit" name="sel_box_qty_unit">
						<option value="">포장단위</option>
                        <c:forEach var="entity" items="${applicationScope['CODE']['11900']}">
                           <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
                        </c:forEach>   
					</select>
				
					<input type="button" class="btn btn-success btn-xs" value="추가" id="btnItemAdd" onclick="fnItemAdd();">
					<input type="button" class="btn btn-danger btn-xs" value="삭제" id="btnItemDelete" onclick="fnItemDelete();">
				</div>
			</div>
			<div class="grid">
				<table id="itemList"></table>
			</div>
		</div>


				
			</div>
		</fieldset>
	</form>
	</div>

</div>

<div class="layer-mask" style="display:none;"></div>

	<!-- 회주선택 -->
	<div class="lypopWrap" style="width:780px; max-height:400px; overflow-y:auto; display:none; " id="selectCustomerLayerPop" >
		<div class="header">
			<h3 class="tit">화주선택</h3>
			<p class="btnR">
				<input type="button" class="btn btn-close btn-xs" onclick="fnCloseLayer('selectCustomerLayerPop');" value="닫기">
			</p>
		</div>
		<div class="contents select-layer1">
			<ul>
			
				<li cd="${vendor_no}" nm="[${vendor_cd}] ${vendor_nm}"  style="border-bottom:1px solid #000;"> <b>[${vendor_cd}] ${vendor_nm} </b> </li>
			
				<c:forEach var="entity" items="${customerList}">
					<li cd="<c:out value="${entity.vendor_no}"/>" nm="<c:out value="${entity.vendor_nm}"/>"><b>${entity.vendor_nm}</b> : ${entity.basadd_txt}</li>
				</c:forEach>   
			</ul>
		</div>
	</div>
	
	<!-- 수출입회사 선택 -->
	<div class="lypopWrap" style="width:780px; max-height:400px; overflow-y:auto; display:none; " id="selectTradeCompLayerPop" >
		<div class="header">
			<h3 class="tit">수/출입회사 선택</h3>
			<p class="btnR">
				<input type="button" class="btn btn-close btn-xs" onclick="fnCloseLayer('selectTradeCompLayerPop');" value="닫기">
			</p>
		</div>
		<div class="contents select-layer1">
		
			<ul style="border-bottom:1px solid #000;">
				<c:forEach var="entity" items="${vendorCoopCompList7}">
					<li cd="<c:out value="${entity.vendor_no}"/>" nm="<c:out value="${entity.vendor_nm}"/>">
						<b>[무역대행]  ${entity.vendor_nm}</b> : ${entity.basadd_txt} <br />
						<span style="margin-left:60px;">CompanyNo : ${entity.biz_num_txt}</span>
					</li>
				</c:forEach>   
			</ul>
		
			<ul>
				<c:forEach var="entity" items="${coopCompList7}">
					<li cd="<c:out value="${entity.vendor_no}"/>" nm="<c:out value="${entity.vendor_nm}"/>">
						<b>${entity.vendor_nm}</b> : ${entity.basadd_txt} <br />
						<span style="margin-left:60px;">CompanyNo : ${entity.biz_num_txt}</span>
					</li>
				</c:forEach>   
			</ul>
		</div>
	</div>

<div id="toast"></div></body>
</html>