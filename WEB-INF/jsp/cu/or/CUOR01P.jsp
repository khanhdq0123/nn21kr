<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/common/include/header.jsp"%>
		
		<title>접수 등록</title>
		<script type="text/javascript" src="/js/cu/or/CUOR01P.js?123"></script>
		<script>
		
		var unitTypeList7 = "<c:out escapeXml="false" value="${applicationScope['GRIDCODELIST']['11700']}"/>";	//화폐단위
		var unitTypeList8 = "<c:out escapeXml="false" value="${applicationScope['GRIDCODELIST']['11800']}"/>";	//수량단위
		var unitTypeList9 = "<c:out escapeXml="false" value="${applicationScope['GRIDCODELIST']['11900']}"/>";	//포장단위
		
		
		
		var inout_typ = "${inout_typ}";
		var vendor_no = "${vendor_no}";
		var vendor_nm = "${vendor_nm}";
		var ord_no = "${info.ord_no}";
		
		
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
				
				
				
				location.href="/cu/or/CUOR01/popup1?ord_no=" + ord_no + "&vendor_no=" + vendor_no;
			});
			
		});
		
		var fnFileDownloadEx = function(filename_txt,attachfile_txt){
			
			$("#filename_txt").val(filename_txt);
			$("#attachfile_txt").val(attachfile_txt);
			
			var fileDownloadPath = '${fileDownloadPathEx}';
			var downloadLink = document.createElement("a");
			downloadLink.href = fileDownloadPath + '/' + attachfile_txt;
			downloadLink.download = filename_txt;
			
			document.body.appendChild(downloadLink);
			downloadLink.click();
			document.body.removeChild(downloadLink);
		}
		
		var fnFileDownloadIm = function(filename_txt,attachfile_txt){
			
			$("#filename_txt").val(filename_txt);
			$("#attachfile_txt").val(attachfile_txt);
			
			var fileDownloadPath = '${fileDownloadPathIm}';
			var downloadLink = document.createElement("a");
			downloadLink.href = fileDownloadPath + '/' + attachfile_txt;
			downloadLink.download = filename_txt;
			
			document.body.appendChild(downloadLink);
			downloadLink.click();
			document.body.removeChild(downloadLink);
		}
		
		

		</script>
		

	</head>

<body class="sky">
<form id="searchForm" name="searchForm" method="post" action="#">
<input type="hidden" name="ord_no" id="ord_no" value="${ord_no}" />
</form>


<div class="layerpop_inner" id="#">

	<h1 class="ly_header">${info.ord_typ_nm}증</h1>
	<div class="ly_body">
		<div class="refer bullet6">
			<div class="refer_bt">
				<div class="min_btn mini">
					<input type="button" class="btn btn-success btn-sm" value="접수증수정" id="btnEdit">
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
<!-- 			<div class="tagCover"> -->
<!-- 				<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;"> -->
<!-- 					<div class="tbl_wrap"> -->
<!-- 						<dl class="section"> -->
<%-- 							<dt>출발지사</dt><dd class="cols" style="width:280px;">${info.start_vendor_nm}</dd> --%>
<%-- 							<dt>도착지사</dt><dd class="cols" style="width:280px;">${info.arrive_vendor_nm}</dd> --%>
<%-- 							<dt>경유지사</dt><dd class="cols" style="width:280px;">${info.transfer_vendor_nm}</dd> --%>
<!-- 						</dl> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->

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
								<th scope="row">등록문서</th><td id="tdShipperFile" class="addD2">
								<c:forEach var="list" items="${attachListEx}">
									<div onclick="fnFileDownloadEx('${list.filename_txt}','${list.attachfile_txt}');">
										${list.filename_txt}
									</div>
								</c:forEach>
								</td>							
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
								<th scope="row">등록문서</th><td id="tdConsigneeFile"  class="addD2">
								<c:forEach var="list" items="${attachListIm}">
									<div onclick="fnFileDownloadIm('${list.filename_txt}','${list.attachfile_txt}');">
										${list.filename_txt}
									</div>
								</c:forEach>
								</td>							
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

</div>

<div class="layer-mask" style="display:none;"></div>


	<!-- 지사선택 -->
	<div class="lypopWrap" style="width:620px; max-height:400px; overflow-y:auto; display:none; " id="selectStoreInLayerPop" >
		<div class="header">
			<h3 class="tit" >Store In</h3>
			<p class="btnR" >
				<input type="button" class="btn btn-warning btn-xs" value="저장" id="btnSave2">
				<input type="button" class="btn btn-close btn-xs" onclick="fnCloseLayer('selectStoreInLayerPop');" value="닫기">
			</p>
		</div>
		
		
		<form id="gForm" name="gForm" method="post" action="#">
		<input type="hidden" id="ord_no" name="ord_no" value="${info.ord_no}" />
			<fieldset>
			<legend>메뉴 등록 상세 페이지</legend>
			<div class="layer_contents">
			
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>메뉴 등록 상세 페이지</caption>
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tbody>
						<tr>
							<th><span class="starMark">필수입력 항목입니다.</span>Stored time</th>
							<td>
								<span class="calendar">
									<input type="text" maxlength="10" class="datepicker" id="stored_dt" name="stored_dt"/>
								</span>
								<input type="text" id="stored_dt_hh" name="stored_dt_hh" value="" style="width:40px;" maxlength="2" /> : 
								<input type="text" id="stored_dt_mi" name="stored_dt_mi" value="" style="width:40px;" maxlength="2" />
							</td>
						</tr>
						<tr>
							<th><span class="starMark">필수입력 항목입니다.</span>Box Count</th>
							<td>
								<input type="text" id="box_cnt" name="box_cnt" value="" style="width:40px;" />
								<select id="packing_unit" name="packing_unit" style="width:120px;" >
									<option value="CT">CT</option>
									<option value="RO">RO</option>
									<option value="PA">PA</option>
								</select>
								<input type="text" id="weight" name="weight" value="" style="width:100px;" /> K
								<input type="text" id="cbm" name="cbm" value="" style="width:100px;" /> CBM
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>warehouse</th>
							<td>								
								<select style="width:98%" id="wh_no" name="wh_no">
									<option value="">--선택하세요--</option>
										<c:forEach var="row" items="${coopCompList5}">
											<option value="${row.vendor_no}">${row.vendor_nm}</option>
										</c:forEach>
								</select>								
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="a8">Comment</label></th>
							<td>
								<input type="text" id="comment" name="comment" value="" style="width:98%;" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</fieldset>
	</form>

	</div>

<form id="dForm" name="dForm">
	<input type="hidden" name="filename_txt" id="filename_txt" value="" />
	<input type="hidden" name="attachfile_txt" id="attachfile_txt" value="" />
</form>

<div id="toast"></div></body>
</html>