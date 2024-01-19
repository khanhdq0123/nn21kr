<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/common/include/header.jsp"%>
		
		<title>운임확정</title>
		<script>
		var unitTypeList = "<c:out escapeXml="false" value="${applicationScope['GRIDCODELIST']['11700']}"/>";	//화폐단위
		var chargeTypeList = "<c:out escapeXml="false" value="${applicationScope['GRIDCODELIST']['12700']}"/>";	//정산구분	
		var ord_no = '${ordInfo.ord_no}';
		var start_vendor_no = '${ordInfo.start_vendor_no}';
		var start_vendor_nm = '${ordInfo.start_vendor_nm}';
		var arrive_vendor_no = '${ordInfo.arrive_vendor_no}';
		var arrive_vendor_nm = '${ordInfo.arrive_vendor_nm}';
		var send_no = '${ordInfo.send_no}';
		var receive_no = '${ordInfo.receive_no}';		
		var send_nm = '${ordInfo.send_nm}';
		var receive_nm = '${ordInfo.receive_nm}';	
		
		var compList = send_no + ":" + send_nm + ";" + receive_no + ":" + receive_nm;
		
		</script>
		<script type="text/javascript" src="/js/ve/or/VEOR02P2.js?123"></script>
	</head>

<body class="sky">

<div class="layerpop_inner" id="#">
<form id="submitForm" name="submitForm" method="post" action="#">
		<input type="hidden" id="ord_no" name="ord_no" value="${ordInfo.ord_no}" />
		<input type="hidden" id="send_no" name="send_no" value="${ordInfo.send_no}" />
		<input type="hidden" id="receive_no" name="receive_no" value="${ordInfo.receive_no}" />
		<input type="hidden" id="hdnGridData1" name="costList" />
		
	<h1 class="ly_header">운송비용</h1>
	
	<div class="ly_body">
		<div class="refer bullet6">
			<div class="refer_bt">
				<div class="min_btn mini">
					<input type="button" class="btn btn-primary btn-sm" value="운임확정" id="btnSave">
					<input type="button" class="btn btn-close btn-sm" value="닫기" id="btnClose">
				</div>
			</div>
		</div>
	</div>

	<div class="layer_contents">
	
		<div class="tagCover">
			<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
				<div class="tbl_wrap">
					<dl class="section">
						<dt>비용청구</dt>
						
						<dd class="cols">

							<div class="radio-group">
				                <div class="option"><input type="radio" id="rd_ord_typ2" name="charge_target_typ" value="10901"><label class="radio-container" for="rd_ord_typ2">EXW</label></div>
				                <div class="option"><input type="radio" id="rd_ord_typ3" name="charge_target_typ" value="10902"><label class="radio-container" for="rd_ord_typ3">DDP</label></div>
				                <div class="option"><input type="radio" id="rd_ord_typ4" name="charge_target_typ" value="10903"><label class="radio-container" for="rd_ord_typ4">CNF</label></div>
				                <div class="option"><input type="radio" id="rd_ord_typ5" name="charge_target_typ" value="10904" checked=""><label class="radio-container" for="rd_ord_typ5">FOB </label></div>
				                <div class="option"><input type="radio" id="rd_ord_typ6" name="charge_target_typ" value=""><label class="radio-container" for="rd_ord_typ6">ETC </label></div>
				            </div>

						</dd>

					</dl>
				</div>
			</div>
		</div>	
	
		<div class="tagCover">
			<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
				<div class="tbl_wrap">
					<dl class="section">
						<dt>단가표지정</dt>
						
						<dd class="cols">

							<select  id="route_no" name="route_no">
								<option value="">단가표선택</option>
						        <c:forEach var="entity" items="${plList}">
						           <option value="<c:out value="${entity.route_no}"/>"><c:out value="${entity.route_nm}"/></option>
						        </c:forEach>   
							</select>

						</dd>

					</dl>
				</div>
			</div>
		</div>
		
		
		
		

		<!-- 단가항목 -->
		<div class="tagCover">
			<div class="report" style="padding:10px 0 10px 0; !important; ">
				<div class="min_btn">
					<input type="button" class="btn btn-primary btn-xs" id="btnAddRow" value="항목추가">
				</div>
			</div>

			<div class="grid">
				<table id="costList"></table>
			</div>
		
		</div>
		
		<div class="tagCover">
		
			<div class="report" style="padding:10px 0 10px 0; !important; ">
				<div class="min_btn">
					<input type="button" class="btn btn-primary btn-xs" id="btnCalc" value="calc">
				</div>
			</div>
		
		
			<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;">
				<table cellspacing="0" cellpadding="0" class="layer_tbl" style="margin-top:0;">
					<caption>합계</caption>
						<colgroup>
							<col width="300px" />
							<col width="140px" />
							<col width="/" />
						</colgroup>
						<tbody>
							<tr>
								<th>청구회사</th>
								<th>단위</th>
								<th>금액</th>
							</tr>
							<tr>
								<td scope="row">${ordInfo.send_nm} [${ordInfo.send_no}]</td>
								<td>
									<select style="width:90%" id="s_charge_unit" name="s_charge_unit">
	                                    <c:forEach var="entity" items="${applicationScope['CODE']['11700']}">
	                                       <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
	                                    </c:forEach>   
									</select>
								</td>			
								<td>
									<input type="text" id="s_sum_charge" name="s_sum_charge" value="0" style="text-align:right" class="readonly" readonly />
								</td>				
							</tr>
							<tr>
								<td scope="row">${ordInfo.receive_nm} [${ordInfo.receive_no}]</td>
								<td>
									<select style="width:90%" id="r_charge_unit" name="r_charge_unit">
	                                    <c:forEach var="entity" items="${applicationScope['CODE']['11700']}">
	                                       <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
	                                    </c:forEach>   
									</select>
								</td>			
								<td>
									<input type="text" id="r_sum_charge" name="r_sum_charge" value="0" style="text-align:right" class="readonly" readonly />
								</td>		
							</tr>
						</tbody>
					</table>
			</div>
			
			
			
			
			
			
		</div>
		
		
	</div>



</form>
</div>



<div id="toast"></div></body>
</html>