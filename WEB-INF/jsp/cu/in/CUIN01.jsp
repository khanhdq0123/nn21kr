<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript" src="/js<%=jsUrl%>.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header"></h3>
			<div class="btn-wrap">
				<input type="button" class="btn btn-primary btn-sm" value="저장[F10]" 	id="btnSave">		
			</div>
		</div>



	    
<form method="post" id="partnerForm" >
	<input type="hidden" id="vendor_no" 	name="vendor_no" 		value="${info.vendor_no}" />
	<input type="hidden" id="charge_yn" 	name="charge_yn" 		value="${info.charge_yn}" />
	<input type="hidden" id="vendor_typ" 	name="vendor_typ" 		value="3" />
	<input type="hidden" id="staff_sns_seq" 	name="staff_sns_seq" 		value="" />
	
	
	
	<fieldset>
	    
	    <div class="tapcont-wrap">
	    	<div class="tapcont">

			
				<div class="inb_con active mt5">
						
							<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl" style="border-top: 0px;">
							<caption>${pTitle} 정보</caption>
								<colgroup>
									<col width="16%" />
									<col width="34%" />
									<col width="16%" />
									<col width="34%" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><label>고객번호</label></th>
										<td scope="row" colspan="3" class="b" >${info.vendor_cd}</td>
									</tr>
									<tr>
										<th scope="row"><label>상호명(영문)</label></th>
										<td><input type="text" id="vendor_nm_eng" name="vendor_nm_eng" value="${info.vendor_nm_eng}" style="width:80%" maxlength="50" required /></td>
										<th scope="row"><label>전화</label></th>
										<td><input type="text" id="tel_txt" name="tel_txt" value="${info.tel_txt}" style="width:80%" maxlength="30" required /></td>
									</tr>
									<tr>
										<th scope="row"><label>상호명</label></th>
										<td><input type="text" id="vendor_nm" name="vendor_nm" value="${info.vendor_nm}" style="width:80%" maxlength="30" required /></td>
										<th scope="row"><label>팩스</label></th>
										<td><input type="text" id="fax_txt" name="fax_txt" value="${info.fax_txt}" style="width:80%" maxlength="30" required /></td>
									</tr>
									<tr>
										<th scope="row"><label>홈페이지</label></th>
										<td><input type="text" id="homepage_url" name="homepage_url" value="${info.homepage_url}" style="width:80%" maxlength="30" required /></td>
										<th scope="row"><label>메일</label></th>
										<td><input type="text" id="email_txt" name="email_txt" value="${info.email_txt}" style="width:80%" maxlength="30" required /></td>
									</tr>
	
									<tr>
										<th scope="row"><span class="starMark"> 필수입력 항목입니다.</span><label for="desc_addr_txt">사업장주소(영문)</label></th>
										<td colspan="2">				
											<input type="text" id="basadd_txt" name="basadd_txt" value="${info.basadd_txt}" onclick="fnSelectRegionPop(1);" class="readonly" style="width:98%;" placeholder="여기를 눌러 선택하세요." readonly/> <br />
										</td>
										<td>
											<input type="text" id="dtladd_txt" name="dtladd_txt" value="${info.dtladd_txt}" style="width:92%; margin-top:2px;" maxlength="150" placeholder="여기에 상세주소를 입력하세요." required />
										
										</td>
									</tr>
									
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="desc_addr_txt">사업장주소(자국어)</label></th>
										<td colspan="2">	
											<input type="button" class="btn btn-primary btn-sm" value="주소검색" id="btnSearchAddr" onclick="fnSearchPost()">	
											<input type="text" id="road_basadd_txt" name="road_basadd_txt" value="${info.road_basadd_txt}" onclick="fnSelectRegionPop(2);" class="readonly" style="width:84%;" placeholder="여기를 눌러 선택하세요." readonly/> <br />
										</td>
										<td>
											<input type="text" id="road_dtladd_txt" name="road_dtladd_txt" value="${info.road_dtladd_txt}" style="width:92%; margin-top:2px;" maxlength="150" placeholder="여기에 상세주소를 입력하세요." required />
										</td>
									</tr>
	
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="business_type_txt">업태</label></th>
										<td colspan="3"><input type="text" id="business_type_txt" name="business_type_txt" value="${info.business_type_txt}" style="width:80%" maxlength="30" /></td>
<%-- 										<td colspan="3"><input type="text" id="business_type_txt" name="business_type_txt" value="${info.business_type_txt}" class="readonly" onclick="fnViewBusinessTypeLayer();" style="width:80%" maxlength="30" required readonly /></td> --%>
									</tr>
									
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="business_txt">업종</label></th>
										<td colspan="3"><input type="text" id="business_txt" name="business_txt" value="${info.business_txt}" style="width:80%" maxlength="30" /></td>
<%-- 										<td colspan="3"><input type="text" id="business_txt" name="business_txt" value="${info.business_txt}" class="readonly" onclick="fnViewBusinessTypeLayer();" style="width:80%" maxlength="30" required readonly /></td> --%>
									</tr>
	
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="business_txt">품목</label></th>
										<td colspan="3"><input type="text" id="item_txt" name="item_txt" value="${info.item_txt}" style="width:80%;" maxlength="30" /></td>
<%-- 										<td colspan="3"><input type="text" id="item_txt" name="item_txt" value="${info.item_txt}" onclick="fnViewItemLayer();" style="width:80%;" class="readonly" maxlength="30" required readonly /></td> --%>
									</tr>

								</tbody>
							</table>
	
					
									
				</div>
	    	</div>
	    </div>
	    
	</fieldset>
</form>







	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>