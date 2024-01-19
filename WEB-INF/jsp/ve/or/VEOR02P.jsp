<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/common/include/header.jsp"%>
		
		<title>접수 등록</title>
		<script type="text/javascript" src="/js/ve/or/VEOR02P.js?123"></script>
		<script>
		var  inout_typ="${inout_typ}";
		var  vendor_no="${vendor_no}";
		var  vendor_nm="${vendor_nm}";
		var	 ord_no = "${info.ord_no}";
		
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

			//btnEdit
			$("#btnEdit").on("click", function(){
				location.href="/ve/or/VEOR01/popup1?ord_no=" + ord_no + "&inout_typ" + inout_typ;
			});
			
		});
		</script>
	</head>

<body class="sky">



<div class="layerpop_inner" id="#">
<form id="gForm" name="gForm" method="post" action="#">
		<input type="hidden" id="ord_no" name="ord_no" value="${info.ord_no}" />
	<h1 class="ly_header">${info.ord_typ_nm}증</h1>
	<div class="ly_body">
		<div class="refer bullet6">
			<div class="refer_bt">
				<div class="min_btn mini">
					<input type="button" class="btn btn-success btn-sm" value="접수증수정" id="btnEdit">
					<input type="button" class="btn btn-primary btn-sm" value="운임확정" id="btnFixCharge">
					<input type="button" class="btn btn-primary btn-sm" value="픽업등록" id="btnRegPickup">
					<input type="button" class="btn btn-primary btn-sm" value="배송등록" id="btnRegDelivery">
					<input type="button" class="btn btn-danger btn-sm" value="삭제" id="btnDelete">
					<input type="button" class="btn btn-close btn-sm" value="닫기" id="btnClose">
				</div>
			</div>
		</div>

		
		<legend>접수 등록 상세 페이지</legend>
		<div class="layer_contents">
			<div class="tagCover">
				<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
					<div class="tbl_wrap">
						<dl class="section">
							<dt>선적지점</dt><dd class="cols" style="width:280px;">${info.shipping_region_nm}</dd>
							<dt>출발지점</dt><dd class="cols" style="width:280px;">${info.send_region_nm}</dd>
							<dt>도착지점</dt><dd class="cols" style="width:280px;">${info.receive_region_nm}</dd>
						</dl>
						<dl class="section">
							<dt>출발일자</dt><dd class="cols" style="width:280px;">${info.start_dt}</dd>
							<dt>도착일자</dt><dd class="cols" style="width:280px;">${info.arrive_dt}</dd>
							<dt>입고일자</dt><dd class="cols" style="width:280px;">${info.shipment_dt}</dd>
						</dl>
						<dl class="section">
							<dt>운송구분</dt><dd style="width:300px;">${info.transport_way_nm}</dd>
						</dl>
					</div>
				</div>
			</div>
			<div class="tagCover">
				<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
					<div class="tbl_wrap">
						<dl class="section">
							<dt>출발지사</dt><dd class="cols" style="width:280px;">${info.start_vendor_nm}</dd>
							<dt>도착지사</dt><dd class="cols" style="width:280px;">${info.arrive_vendor_nm}</dd>
							<dt>경유지사</dt><dd class="cols" style="width:280px;">${info.transfer_vendor_nm}</dd>
						</dl>
					</div>
				</div>
			</div>

		<div class="tagCover">
			<div style="width:49%; float:left; position:relative;">
<!-- 				<h1 class="styleH3">Shipper</h1> -->
				<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
					<table cellspacing="0" cellpadding="0" class="layer_tbl" style="margin-top:0;">
					<caption>Shipper</caption>
						<colgroup>
							<col width="140px" />
							<col width="/" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">발송화주</th><td>${info.send_nm}</td>							
							</tr>
							<tr>
								<th scope="row">수출회사</th><td>${info.send_trade_comp_nm}</td>							
							</tr>
							<tr>
								<th scope="row">수출통관</th><td>${info.send_cc_comp_nm}</td>							
							</tr>
							<tr>
								<th scope="row">등록문서</th><td id="tdShipperFile"></td>							
							</tr>
							<tr>
								<th scope="row">픽업예약</th><td></td>							
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		
			<div style="width:49%; float:right; position:relative;">
				<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
					<table cellspacing="0" cellpadding="0" class="layer_tbl" style="margin-top:0;">
					<caption>Consignee</caption>
						<colgroup>
							<col width="140px" />
							<col width="/" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">수화화주</th><td>${info.receive_nm}</td>							
							</tr>
							<tr>
								<th scope="row">수입회사</th><td>${info.receive_trade_comp_nm}</td>							
							</tr>
							<tr>
								<th scope="row">수입통관</th><td>${info.receive_cc_comp_nm}</td>							
							</tr>
							<tr>
								<th scope="row">등록문서</th><td id="tdConsigneeFile"></td>							
							</tr>
							<tr>
								<th scope="row">배송예약</th><td></td>							
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			
		</div>
		
		<div class="tagCover">
			<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
				<div class="tbl_wrap">
					<dl class="section">
						<dt>비용청구</dt><dd style="width:35%;">${info.charge_target_typ_nm}</dd>
						<dt>비용상세</dt><dd class="cols" style="width:35%;">${info.charge_memo}</dd>
					</dl>
				</div>
			</div>
		</div>
		<div class="tagCover">
			<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
				<div class="tbl_wrap">
					<dl class="section">
						<dt style="min-height:102px;">픽업</dt>
						<dd style="width:35%;">
							<table> 
							<colgroup>
								<col width="20%" />
								<col />
							</colgroup>
								<tr><td class="ar">수취인 직원:</td><td class="b"> ${pickupInfo.staff} ${pickupInfo.mobile}</td></tr>
								<tr><td class="ar">박스 수:</td><td class="b"> ${pickupInfo.pack_cnt}</td></tr>
								<tr><td class="ar">업태:</td><td class="b"> </td></tr>
								<tr><td class="ar">배송자:</td><td class="b"> ${pickupInfo.delivery_comp}</td></tr>
								<tr><td class="ar">주소:</td><td class="b"> ${pickupInfo.addr}</td></tr>
							</table>
						</dd>
						<dt style="min-height:102px;">배송</dt>
						<dd class="cols" style="width:35%;">
							<table> 
							<colgroup>
								<col width="20%" />
								<col />
							</colgroup>
								<tr><td class="ar">수취인 직원:</td><td class="b"> ${deliveryInfo.staff} ${pickupInfo.mobile}</td></tr>
								<tr><td class="ar">박스 수:</td><td class="b"> ${deliveryInfo.pack_cnt}</td></tr>
								<tr><td class="ar">업태:</td><td class="b"> </td></tr>
								<tr><td class="ar">배송자:</td><td class="b"> ${deliveryInfo.delivery_comp}</td></tr>
								<tr><td class="ar">주소:</td><td class="b"> ${deliveryInfo.addr}</td></tr>
							</table>
						</dd>
					</dl>
				</div>
			</div>
		</div>
		<div class="tagCover">
			<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
				<div class="tbl_wrap">
					<dl class="section">
						<dt style="height:64px;">고객주의사항</dt><dd style="width:35%;">${info.customer_memo}</dd>
						<dt style="height:64px;">업무전달사항</dt><dd class="cols" style="width:35%;">${info.business_memo}</dd>
					</dl>
				</div>
			</div>
		</div>
		<div class="tagCover">
			<div class="report" style="padding:10px 0 0 0; !important; ">
				<div class="min_btn"></div>
			</div>
			<div class="grid">
				<table id="itemList"></table>
			</div>
		
		</div>


				
			</div>

	</div>
	<!-- // .ly_body -->
</form>
</div>

<div class="layer-mask" style="display:none;"></div>

	<!-- 픽업 등록 -->
	<div class="lypopWrap" style="width:980px; max-height:400px; overflow-y:auto; display:none; " id="pickupRegLayerPop" >
		<div class="header">
			<h3 class="tit" >픽업 등록</h3>
			<p class="btnR" >
				<input type="button" class="btn btn-warning btn-xs" value="저장" id="btnSave1">
				<input type="button" class="btn btn-close btn-xs" onclick="fnCloseLayer('pickupRegLayerPop');" value="닫기">
			</p>
		</div>
		
		
		<form id="gForm1" name="gForm1" method="post" action="#">
		<input type="hidden" id="ord_no1" name="ord_no"  value="${info.ord_no}" />
		
		
			<fieldset>
			<legend>메뉴 등록 상세 페이지</legend>
			<div class="layer_contents">
			
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>메뉴 등록 상세 페이지</caption>
					<colgroup>
						<col width="12%" />
						<col width="21%" />
						<col width="12%" />
						<col width="21%" />
						<col width="12%" />
						<col width="22%" />
					</colgroup>
					<tbody>

						<tr>
							<th scope="row"><label for="pack_cnt">CT</label></th>
							<td>
								<input type="text" id="pack_cnt" name="pack_cnt" value="" style="width:60px;" />
							</td>
							<th scope="row"><label for="a8">출발예정일</label></th>
							<td>
								<span class="calendar">
									<input type="text" maxlength="10" class="datepicker" id="from_dt" name="from_dt"/>
								</span>
							</td>
							<th scope="row"><label for="a8">도착예정일</label></th>
							<td>
								<span class="calendar">
									<input type="text" maxlength="10" class="datepicker" id="to_dt" name="to_dt"/>
								</span>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="staff">담당자</label></th>
							<td>
								<input type="text" id="staff" name="staff" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="mobile">Mobile</label></th>
							<td>
								<input type="text" id="mobile" name="mobile" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="tel">Tel</label></th>
							<td>
								<input type="text" id="tel" name="tel" value="" style="width:98%;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="addr">주소</label></th>
							<td colspan="5">
								<input type="text" id="addr" name="addr" value="" style="width:98%;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="memo">메모</label></th>
							<td colspan="5">
								<input type="text" id="memo" name="memo" value="" style="width:98%;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="delivery_comp">운송사</label></th>
							<td>
								<input type="text" id="delivery_comp" name="delivery_comp" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="driver">기사성명</label></th>
							<td>
								<input type="text" id="driver" name="driver" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="car_size">Car Size</label></th>
							<td>
								<input type="text" id="car_size" name="car_size" value="" style="width:98%;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="delivery_comp_tel">운송사 TEL</label></th>
							<td>
								<input type="text" id="delivery_comp_tel" name="delivery_comp_tel" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="driver_mobile">기사 Mobile</label></th>
							<td>
								<input type="text" id="driver_mobile" name="driver_mobile" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="distance">거리</label></th>
							<td>
								<input type="text" id="distance" name="distance" value="" style="width:98%;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="pay_typ">결제방법</label></th>
							<td>
								<select id="pay_typ" name="pay_typ" style="width:120px;" >
									<option value="1">착불</option>
									<option value="2">현불</option>
								</select>
							</td>
							<th scope="row"><label for="delivery_charge">배송금액</label></th>
							<td>
								<input type="text" id="delivery_charge" name="delivery_charge" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="delivery_purchase">매입금액</label></th>
							<td>
								<input type="text" id="delivery_purchase" name="delivery_purchase" value="" style="width:98%;" />
							</td>
						</tr>

					</tbody>
				</table>
			</div>
		</fieldset>
	</form>

	</div>

	<!-- 배송 등록 -->
	<div class="lypopWrap" style="width:980px; max-height:400px; overflow-y:auto; display:none; " id="deliveryRegLayerPop" >
		<div class="header">
			<h3 class="tit" >배송 등록</h3>
			<p class="btnR" >
				<input type="button" class="btn btn-warning btn-xs" value="저장" id="btnSave2">
				<input type="button" class="btn btn-close btn-xs" onclick="fnCloseLayer('deliveryRegLayerPop');" value="닫기">
			</p>
		</div>
		
		
		<form id="gForm2" name="gForm2" method="post" action="#">
		<input type="hidden" id="ord_no2" name="ord_no"  value="${info.ord_no}" />
		
		
		
			<fieldset>
			<legend>메뉴 등록 상세 페이지</legend>
			<div class="layer_contents">
			
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>메뉴 등록 상세 페이지</caption>
					<colgroup>
						<col width="12%" />
						<col width="21%" />
						<col width="12%" />
						<col width="21%" />
						<col width="12%" />
						<col width="22%" />
					</colgroup>
					<tbody>

						<tr>
							<th scope="row"><label for="pack_cnt">CT</label></th>
							<td>
								<input type="text" id="pack_cnt" name="pack_cnt" value="" style="width:60px;" />
							</td>
							<th scope="row"><label for="a8">출발예정일</label></th>
							<td>
								<span class="calendar">
									<input type="text" maxlength="10" class="datepicker" id="from_dt" name="from_dt"/>
								</span>
							</td>
							<th scope="row"><label for="a8">도착예정일</label></th>
							<td>
								<span class="calendar">
									<input type="text" maxlength="10" class="datepicker" id="to_dt" name="to_dt"/>
								</span>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="staff">담당자</label></th>
							<td>
								<input type="text" id="staff" name="staff" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="mobile">Mobile</label></th>
							<td>
								<input type="text" id="mobile" name="mobile" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="tel">Tel</label></th>
							<td>
								<input type="text" id="tel" name="tel" value="" style="width:98%;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="addr">주소</label></th>
							<td colspan="5">
								<input type="text" id="addr" name="addr" value="" style="width:98%;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="memo">메모</label></th>
							<td colspan="5">
								<input type="text" id="memo" name="memo" value="" style="width:98%;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="delivery_comp">운송사</label></th>
							<td>
								<input type="text" id="delivery_comp" name="delivery_comp" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="driver">기사성명</label></th>
							<td>
								<input type="text" id="driver" name="driver" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="car_size">Car Size</label></th>
							<td>
								<input type="text" id="car_size" name="car_size" value="" style="width:98%;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="delivery_comp_tel">운송사 TEL</label></th>
							<td>
								<input type="text" id="delivery_comp_tel" name="delivery_comp_tel" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="driver_mobile">기사 Mobile</label></th>
							<td>
								<input type="text" id="driver_mobile" name="driver_mobile" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="distance">거리</label></th>
							<td>
								<input type="text" id="distance" name="distance" value="" style="width:98%;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="pay_typ">결제방법</label></th>
							<td>
								<select id="pay_typ" name="pay_typ" style="width:120px;" >
									<option value="1">착불</option>
									<option value="2">현불</option>
								</select>
							</td>
							<th scope="row"><label for="delivery_charge">배송금액</label></th>
							<td>
								<input type="text" id="delivery_charge" name="delivery_charge" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="delivery_purchase">매입금액</label></th>
							<td>
								<input type="text" id="delivery_purchase" name="delivery_purchase" value="" style="width:98%;" />
							</td>
						</tr>

					</tbody>
				</table>
			</div>
		</fieldset>
	</form>

	</div>


<div id="toast"></div></body>
</html>