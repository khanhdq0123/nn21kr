<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript" src="/js<%=jsUrl%>.js"></script>
</head>
<body class="sky">
<form method="get" id="searchForm">
<input type="hidden" id="wh_no" name="wh_no" value="" />
<input type="hidden" id="tp_no" name="tp_no" value="" />
<input type="hidden" id="ct_no" name="ct_no" value="" />
<input type="hidden" id="tp_st_cd" name="tp_st_cd" value="12401" />


	<div class="content_wrap">
		<div class="history">
			<h3 class="header"></h3>		
			<div class="btn-wrap">
			
<!-- 				<input type="button" class="btn btn-primary btn-sm" value="운송예약" id="btnRegTransport"> -->
			</div>
		</div>
		
		<!-- 운송예약 ----------------------------------------------------------------------------------------------->
		<div class="grid">
			<div class="history" style="margin:10px 0 5px;">
				<h3 class="header2">운송예약</h3>		
				<div class="btn-wrap">
					<input type="button" class="btn btn-info btn-sm" 	value="운송예약" 		id="btnRegTransport">
					<input type="button" class="btn btn-success btn-sm" value="load Goods" 	id="btnToTransport">
					<input type="button" class="btn btn-warning btn-sm" value="예약OK" 		id="btnRegOkTransport">
<!-- 					<input type="button" class="btn btn-success btn-sm" value="Modity" 		id="btnModTransport"> -->
					<input type="button" class="btn btn-primary btn-sm" value="DownTo WareHouse" 	id="btnMoveToTransportItem">
					<input type="button" class="btn btn-danger btn-sm" 	value="Cancel" 		id="btnCancelTransport">			
				</div>
			</div>
		
			<div class="dp_category">
				<div style="float:left; width:40%;">
					<div class="grid">
						<table id="list2"></table>
					</div>
				</div>
				<div style="float:right; width:59%;">
					<div class="dp_category">
						<div style="float:left; width:50%;">
							<div class="grid">
								<table id="list3"></table>
							</div>
						</div>
						<div style="float:right; width:49%;">
							<div class="grid">
								<table id="list4"></table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="dp_category">
			<div style="float:left; width:20%;">
				<div class="grid">
					<div class="history" style="margin:10px 0 5px;">
						<h3 class="header2">STORAGE</h3>		
					</div>
					<table id="list1"></table>
				</div>
			</div>
			
			
			
			<div style="float:right; width:79%;">

				<!-- 컨테이너 ----------------------------------------------------------------------------------------------->
				<div class="grid">
					<div class="history" style="margin:10px 0 5px;">
						<h3 class="header2">컨테이너</h3>		
						<div class="btn-wrap">
							<input type="button" class="btn btn-info btn-sm" 	value="컨테이너생성" 	id="btnRegContainer">
							<input type="button" class="btn btn-success  btn-sm" value="ToContainer" id="btnToContainer">
<!-- 							<input type="button" class="btn btn-success btn-sm" value="Modity" 		id="btnModContainer"> -->
							<input type="button" class="btn btn-primary btn-sm" value="창고로 내리기" 	id="btnDropInfoWareHouse">
							<input type="button" class="btn btn-danger btn-sm" 	value="Return" 		id="btnReturnContainer">							
						</div>
					</div>
					
					<div class="dp_category">
						<div style="float:left; width:35%;">
							<div class="grid">
								<table id="list5"></table>
							</div>
						</div>
						<div style="float:right; width:63%;">
							<div class="grid">
								<table id="list6"></table>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 화물 ----------------------------------------------------------------------------------------------->
				<div class="grid">
					<div class="history" style="margin:10px 0 5px;">
						<h3 class="header2">화물</h3>		
						<div class="btn-wrap">
							<input type="button" class="btn btn-primary btn-sm" value="재고수정" id="btnModStock">
						</div>
					</div>
					<table id="list7"></table>
				</div>
				
			</div>
		</div>
		
		

	</div>
	
</form>



<div class="layer-mask" style="display:none;"></div>



	<!-- 운송예약 등록 -->
	<div class="lypopWrap" style="width:980px; max-height:400px; overflow-y:auto; display:none; " id="selectTransportRegLayerPop" >
		<div class="header">
			<h3 class="tit" >Store In</h3>
			<p class="btnR" >
				<input type="button" class="btn btn-warning btn-xs" value="저장" id="btnSave2">
				<input type="button" class="btn btn-close btn-xs" onclick="fnCloseLayer('selectTransportRegLayerPop');" value="닫기">
			</p>
		</div>
		
		
		<form id="gForm1" name="gForm1" method="post" action="#">
		<input type="hidden" id="master_bl" name="master_bl" value="" />
		<input type="hidden" id="send_region_no" name="send_region_no" value="" />
		<input type="hidden" id="receive_region_no" name="receive_region_no" value="" />
		
		
		
			<fieldset>
			<legend>메뉴 등록 상세 페이지</legend>
			<div class="layer_contents">
			
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>메뉴 등록 상세 페이지</caption>
					<colgroup>
						<col width="12%" />
						<col width="38%" />
						<col width="12%" />
						<col width="38%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">운송방법</th>
							<td colspan="3">
								<div class="radio-group">
					                <div class="option"><input type="radio" id="rd_ord_typ2" name="transport_way" value="10203"><label class="radio-container" for="rd_ord_typ2">Air</label></div>
					                <div class="option"><input type="radio" id="rd_ord_typ3" name="transport_way" value="10201"><label class="radio-container" for="rd_ord_typ3">Car</label></div>
					                <div class="option"><input type="radio" id="rd_ord_typ4" name="transport_way" value="10202" checked><label class="radio-container" for="rd_ord_typ4">Ship</label></div>
					                <div class="option"><input type="radio" id="rd_ord_typ5" name="transport_way" value="10205"><label class="radio-container" for="rd_ord_typ5">HandCarry</label></div>
					            </div>
							</td>
						</tr>
						
						<tr class="wrap-air dpn">
							<th scope="row"><label for="a8">항공명</label></th>
							<td>
								<input type="text" id="air_comp_nm" name="air_comp_nm" value="" style="width:98%;" class="readonly" readonly />
							</td>
							<th scope="row"><label for="a8">항차</label></th>
							<td>
								<input type="text" id="air_flight_no" name="air_flight_no" value="" style="width:98%;" />
							</td>
						</tr>
						<tr class="wrap-air dpn">
							<th scope="row"><label for="a8">MASTER B/L</label></th>
							<td>
								<input type="text" id="master_bl_air" name="master_bl_air" value="" style="width:98%;" />
							</td>
							<th scope="row"></th>
							<td>

							</td>
						</tr>						
						
						<tr class="wrap-car dpn">
							<th scope="row"><label for="car_comp_nm">차량 회사명</label></th>
							<td>
								<input type="text" id="car_comp_nm" name="car_comp_nm" value="" style="width:98%;" class="readonly" readonly />
							</td>
							<th scope="row"><label for="car_driver">차량</label></th>
							<td>
								<input type="text" id="car_driver" name="car_driver" value="" style="width:98%;" />
							</td>
						</tr>
						<tr class="wrap-car dpn">
							<th scope="row"><label for="car_driver_tel">차량 연락처</label></th>
							<td>
								<input type="text" id="car_driver_tel" name="car_driver_tel" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="car_no">차량번호</label></th>
							<td>
								<input type="text" id="car_no" name="car_no" value="" style="width:98%;" />
							</td>
						</tr>
						<tr class="wrap-car dpn">
							<th scope="row"><label for="car_size">차량규격</label></th>
							<td>
								<input type="text" id="car_size" name="car_size" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="master_bl_car">MASTER B/L</label></th>
							<td>
								<input type="text" id="master_bl_car" name="master_bl_car" value="" style="width:98%;" />
							</td>
						</tr>
						
						<tr class="wrap-ship">
							<th scope="row"><label for="ship_comp_nm">선박회사명</label></th>
							<td>
								<input type="text" id="ship_comp_nm" name="ship_comp_nm" value="" style="width:98%;" class="readonly" readonly />
							</td>
							<th scope="row"><label for="ship_vessel_nm">선박명</label></th>
							<td>
								<input type="text" id="ship_vessel_nm" name="ship_vessel_nm" value="" style="width:98%;" />
							</td>
						</tr>
						<tr class="wrap-ship">
							<th scope="row"><label for="ship_shipping">항차</label></th>
							<td>
								<input type="text" id="ship_shipping" name="ship_shipping" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="master_bl_ship">MASTER B/L</label></th>
							<td>
								<input type="text" id="master_bl_ship" name="master_bl_ship" value="" style="width:98%;" />
							</td>
						</tr>
						
						<tr class="wrap-sub dpn">
							<th scope="row"><label for="sub_comp_nm">Company</label></th>
							<td>
								<input type="text" id="sub_comp_nm" name="sub_comp_nm" value="" style="width:98%;" class="readonly" readonly />
							</td>
							<th scope="row"><label for="sub_from_tel">From TEL</label></th>
							<td>
								<input type="text" id="sub_from_tel" name="sub_from_tel" value="" style="width:98%;" />
							</td>
						</tr>
						<tr class="wrap-sub dpn">
							<th scope="row"><label for="sub_to_tel">To TEL</label></th>
							<td>
								<input type="text" id="sub_to_tel" name="sub_to_tel" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="master_bl_sub">MASTER B/L</label></th>
							<td>
								<input type="text" id="master_bl_sub" name="master_bl_sub" value="" style="width:98%;" />
							</td>
						</tr>
					

						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>출발지사</th>
							<td>								
								<select style="width:98%" id="start_vendor_no" name="start_vendor_no">
									<option value="">--선택하세요--</option>
										<c:forEach var="row" items="${partnerList}">
											<option value="${row.vendor_no}">${row.vendor_nm}</option>
										</c:forEach>
								</select>								
							</td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>도착지사</th>
							<td>								
								<select style="width:98%" id="arrive_vendor_no" name="arrive_vendor_no">
									<option value="">--선택하세요--</option>
										<c:forEach var="row" items="${partnerList}">
											<option value="${row.vendor_no}">${row.vendor_nm}</option>
										</c:forEach>
								</select>								
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="a8">출발지</label></th>
							<td>
								<input type="text" id="send_region_nm" name="send_region_nm" value="" onclick="fnSelectRegionPop(2);" class="readonly" style="width:98%;" readonly />
							</td>
							<th scope="row"><label for="a8">도착지</label></th>
							<td>
								<input type="text" id="receive_region_nm" name="receive_region_nm" value="" onclick="fnSelectRegionPop(3);" class="readonly" style="width:98%;" readonly />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="a8">출발예정일</label></th>
							<td>
								<span class="calendar">
									<input type="text" maxlength="10" class="datepicker" id="start_dt" name="start_dt"/>
								</span>
								<input type="text" id="start_dt_hh" name="start_dt_hh" value="00" onfocus="this.select();" style="width:40px;" maxlength="2" /> : 
								<input type="text" id="start_dt_mi" name="start_dt_mi" value="00" onfocus="this.select();" style="width:40px;" maxlength="2" />
							</td>
							<th scope="row"><label for="a8">도착예정일</label></th>
							<td>
								<span class="calendar">
									<input type="text" maxlength="10" class="datepicker" id="arrive_dt" name="arrive_dt"/>
								</span>
								<input type="text" id="arrive_dt_hh" name="arrive_dt_hh" value="00" onfocus="this.select();" style="width:40px;" maxlength="2" /> : 
								<input type="text" id="arrive_dt_mi" name="arrive_dt_mi" value="00" onfocus="this.select();" style="width:40px;" maxlength="2" />
							</td>
						</tr>

					</tbody>
				</table>
			</div>
		</fieldset>
	</form>

	</div>



	<!-- 컨테이너 등록 -->
	<div class="lypopWrap" style="width:620px; max-height:400px; overflow-y:auto; display:none; " id="selectContainerRegLayerPop" >
		<div class="header">
			<h3 class="tit" >Store In</h3>
			<p class="btnR" >
				<input type="button" class="btn btn-warning btn-xs" value="저장" id="btnSave3">
				<input type="button" class="btn btn-close btn-xs" onclick="fnCloseLayer('selectContainerRegLayerPop');" value="닫기">
			</p>
		</div>
		
		
		<form id="gForm2" name="gForm2" method="post" action="#">
		<input type="hidden" name="vendor_no" value="${info.vendor_no}" />
		<input type="hidden" name="ct_no" value="" />
		
			<fieldset>
			<legend>메뉴 등록 상세 페이지</legend>
			<div class="layer_contents">
			
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>메뉴 등록 상세 페이지</caption>
					<colgroup>
						<col width="20%" />
						<col width="30%" />
						<col width="20%" />
						<col width="30%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">지사</th>
							<td colspan="3">${info.vendor_nm}</td>
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>컨테이너 Type</th>
							<td>								
								<select style="width:90%" id="ct_typ" name="ct_typ">
								   <option value="">--선택하세요--</option>
	                                        <c:forEach var="entity" items="${applicationScope['CODE']['12200']}">
	                                           <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
	                                        </c:forEach>   
								</select>							
							</td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>컨테이너 규격</th>
							<td>								
								<select style="width:90%" id="ct_size" name="ct_size">
								   <option value="">--선택하세요--</option>
	                                        <c:forEach var="entity" items="${applicationScope['CODE']['12300']}">
	                                           <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
	                                        </c:forEach>   
								</select>								
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="a8">컨테이너 번호</label></th>
							<td>
								<input type="text" id="ct_num" name="ct_num" value="" style="width:98%;" />
							</td>
							<th scope="row"><label for="a8">SealNo</label></th>
							<td>
								<input type="text" id="seal_no" name="seal_no" value="" style="width:98%;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>창고</th>
							<td>								
								<select style="width:98%" id="wh_no2" name="wh_no">
									<option value="">--선택하세요--</option>
										<c:forEach var="row" items="${coopCompList5}">
											<option value="${row.vendor_no}">${row.vendor_nm}</option>
										</c:forEach>
								</select>								
							</td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>IsFCL</th>
							<td>								
								<input type="checkbox" name="fcl_yn" value="Y" /> 								
							</td>
						</tr>

					</tbody>
				</table>
			</div>
		</fieldset>
	</form>

	</div>




<div class="layer-mask2" style="display:none;"></div>




	<!-- 운송회사 선택(육상) -->
	<div class="lypopWrap" style="width:620px; max-height:400px; overflow-y:auto; display:none; " id="selectTransportCompLayerPop1" >
		<div class="header">
			<h3 class="tit" >Store In</h3>
			<p class="btnR" >
				<input type="button" class="btn btn-warning btn-xs" value="확인" id="btnSelect1">
				<input type="button" class="btn btn-close btn-xs" onclick="fnCloseLayer2('selectTransportCompLayerPop1');" value="닫기">
			</p>
		</div>
		
		
		<form id="gForm3" name="gForm3" method="post" action="#">
		<input type="hidden" name="vendor_no" value="${info.vendor_no}" />
		
			<fieldset>
			<legend>메뉴 등록 상세 페이지</legend>
			
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
					<caption>메뉴 등록 상세 페이지</caption>
						<colgroup>
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
						</colgroup>
						<tbody>
							<tr>
								<th>차량회사</th>
								<th>기사명</th>
								<th>기사전화번호</th>
								<th>차번호</th>
								<th>차사이즈</th>
							</tr>
						</tbody>
				</table>
			</div>
			
			
			
			
			<div class="layer_contents" style="height:200px; overflow:auto;">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>메뉴 등록 상세 페이지</caption>
					<colgroup>
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
					</colgroup>
					<tbody class="toggleBg" id="transportCompList1">
					<c:forEach var="list" items="${transportCompHst1}">
						<tr>
							<td class="car_comp_nm">${list.car_comp_nm}</td>
							<td class="car_driver">${list.car_driver}</td>
							<td class="car_driver_tel">${list.car_driver_tel}</td>
							<td class="car_no">${list.car_no}</td>
							<td class="car_size">${list.car_size}</td>
						</tr>	
					</c:forEach>					
					</tbody>
				</table>
			
			
			</div>
		
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
					<caption>메뉴 등록 상세 페이지</caption>
						<colgroup>
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
						</colgroup>
						<tbody>
							<tr>
								<td><input type="text" id="car_comp_nm2" 	name="car_comp_nm2" 	value="" style="width:97%;" /></td>
								<td><input type="text" id="car_driver2" 	name="car_driver2" 		value="" style="width:97%;" /></td>
								<td><input type="text" id="car_driver_tel2" name="car_driver_tel2" 	value="" style="width:97%;" /></td>
								<td><input type="text" id="car_no2" 		name="car_no2" 			value="" style="width:97%;" /></td>
								<td><input type="text" id="car_size2" 		name="car_size2" 		value="" style="width:97%;" /></td>
							</tr>
						</tbody>
				</table>
			</div>
		
		</fieldset>
	</form>

	</div>


	<!-- 운송회사 선택(해상) -->
	<div class="lypopWrap" style="width:620px; max-height:400px; overflow-y:auto; display:none; " id="selectTransportCompLayerPop2" >
		<div class="header">
			<h3 class="tit" >Store In</h3>
			<p class="btnR" >
				<input type="button" class="btn btn-warning btn-xs" value="확인" id="btnSelect2">
				<input type="button" class="btn btn-close btn-xs" onclick="fnCloseLayer2('selectTransportCompLayerPop2');" value="닫기">
			</p>
		</div>
		
		
		<form id="gForm3" name="gForm3" method="post" action="#">
		<input type="hidden" name="vendor_no" value="${info.vendor_no}" />
		
			<fieldset>
			<legend>메뉴 등록 상세 페이지</legend>
			
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
					<caption>메뉴 등록 상세 페이지</caption>
						<colgroup>
							<col width="50%" />
							<col width="50%" />
						</colgroup>
						<tbody>
							<tr>
								<th>선박회사</th>
								<th>배이름</th>
							</tr>
						</tbody>
				</table>
			</div>
			
			<div class="layer_contents" style="height:200px; overflow:auto;">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>메뉴 등록 상세 페이지</caption>
					<colgroup>
						<col width="50%" />
							<col width="50%" />
					</colgroup>
					<tbody class="toggleBg" id="transportCompList2">
					<c:forEach var="list" items="${transportCompHst2}">
						<tr>
							<td class="ship_comp_nm">${list.ship_comp_nm}</td>
							<td class="ship_vessel_nm">${list.ship_vessel_nm}</td>
						</tr>	
					</c:forEach>					
					</tbody>
				</table>
			</div>
		
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
					<caption>메뉴 등록 상세 페이지</caption>
						<colgroup>
							<col width="50%" />
							<col width="50%" />
						</colgroup>
						<tbody>
							<tr>
								<td><input type="text" id="ship_comp_nm2" 		name="ship_comp_nm2" 		value="" style="width:97%;" /></td>
								<td><input type="text" id="ship_vessel_nm2" 	name="ship_vessel_nm2" 		value="" style="width:97%;" /></td>
							</tr>
						</tbody>
				</table>
			</div>
		
		</fieldset>
	</form>

	</div>


	<!-- 운송회사 선택(항공) -->
	<div class="lypopWrap" style="width:620px; max-height:400px; overflow-y:auto; display:none; " id="selectTransportCompLayerPop3" >
		<div class="header">
			<h3 class="tit" >Store In</h3>
			<p class="btnR" >
				<input type="button" class="btn btn-warning btn-xs" value="확인" id="btnSelect3">
				<input type="button" class="btn btn-close btn-xs" onclick="fnCloseLayer2('selectTransportCompLayerPop3');" value="닫기">
			</p>
		</div>
		
		
		<form id="gForm5" name="gForm5" method="post" action="#">
		<input type="hidden" name="vendor_no" value="${info.vendor_no}" />
		
			<fieldset>
			<legend>메뉴 등록 상세 페이지</legend>
			
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
					<caption>메뉴 등록 상세 페이지</caption>
						<colgroup>
							<col width="100%" />
						</colgroup>
						<tbody>
							<tr>
								<th>항공명</th>
							</tr>
						</tbody>
				</table>
			</div>
			
			
			
			
			<div class="layer_contents" style="height:200px; overflow:auto;">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>메뉴 등록 상세 페이지</caption>
					<colgroup>
						<col width="100%" />
					</colgroup>
					<tbody class="toggleBg" id="transportCompList3">
					<c:forEach var="list" items="${transportCompHst3}">
						<tr>
							<td class="air_comp_nm">${list.air_comp_nm}</td>
						</tr>	
					</c:forEach>					
					</tbody>
				</table>
			
			
			</div>
		
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
					<caption>메뉴 등록 상세 페이지</caption>
						<colgroup>
							<col width="100%" />
						</colgroup>
						<tbody>
							<tr>
								<td><input type="text" id="air_comp_nm2" 	name="air_comp_nm2" 		value="" style="width:97%;" /></td>
							</tr>
						</tbody>
				</table>
			</div>
		
		</fieldset>
	</form>

	</div>


	<!-- 운송회사 선택(HandCarry) -->
	<div class="lypopWrap" style="width:620px; max-height:400px; overflow-y:auto; display:none; " id="selectTransportCompLayerPop5" >
		<div class="header">
			<h3 class="tit" >Store In</h3>
			<p class="btnR" >
				<input type="button" class="btn btn-warning btn-xs" value="확인" id="btnSelect5">
				<input type="button" class="btn btn-close btn-xs" onclick="fnCloseLayer2('selectTransportCompLayerPop5');" value="닫기">
			</p>
		</div>
		
		
		<form id="gForm6" name="gForm6" method="post" action="#">
		<input type="hidden" name="vendor_no" value="${info.vendor_no}" />
		
			<fieldset>
			<legend>메뉴 등록 상세 페이지</legend>
			
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
					<caption>메뉴 등록 상세 페이지</caption>
						<colgroup>
							<col width="40%" />
							<col width="30%" />
							<col width="30%" />
						</colgroup>
						<tbody>
							<tr>
								<th>업체명</th>
								<th>출발지연락처</th>
								<th>도착지연락처</th>
							</tr>
						</tbody>
				</table>
			</div>
			
			<div class="layer_contents" style="height:200px; overflow:auto;">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>메뉴 등록 상세 페이지</caption>
					<colgroup>
						<col width="40%" />
						<col width="30%" />
						<col width="30%" />
					</colgroup>
					<tbody class="toggleBg" id="transportCompList5">
					<c:forEach var="list" items="${transportCompHst5}">
						<tr>
							<td class="sub_comp_nm">${list.sub_comp_nm}</td>
							<td class="sub_from_tel">${list.sub_from_tel}</td>
							<td class="sub_to_tel">${list.sub_to_tel}</td>
						</tr>	
					</c:forEach>					
					</tbody>
				</table>
			</div>
		
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
					<caption>메뉴 등록 상세 페이지</caption>
					<colgroup>
						<col width="40%" />
						<col width="30%" />
						<col width="30%" />
					</colgroup>
						<tbody>
							<tr>
								<td><input type="text" id="sub_comp_nm2" 	name="sub_comp_nm2" 	value="" style="width:97%;" /></td>
								<td><input type="text" id="sub_from_tel2" 	name="sub_from_tel2" 	value="" style="width:97%;" /></td>
								<td><input type="text" id="sub_to_tel2" 	name="sub_to_tel2" 		value="" style="width:97%;" /></td>
							</tr>
						</tbody>
				</table>
			</div>
		
		</fieldset>
	</form>

	</div>


<div id="toast"></div></body>
</html>