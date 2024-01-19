<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<c:set var="staff_typ" value="${sessionScope['STAFFINFORMATION']['staff_typ']}" />
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="/js/partnerListPop.js"></script>
	<script>
	var vendor_no = '${info.vendor_no}';
	var vendor_nm = '${info.vendor_nm}';
	var idCheckFlag = 1;
	var selectedItem = '';		//선택된 품목
	var selectedBusiness = '';	//선택된 업종
	var staff_typ = "${sessionScope['STAFFINFORMATION']['staff_typ']}";
	</script>
	<script type="text/javascript" src="/js<%=jsUrl%>.js"></script>
	<style>

	.on {background-color:#fcf340; font-weight:bold;}
	
	#selectItemLayerPop th {text-align:center !important; height:40px;}
	#selectItemLayerPop td {text-align:center; height:40px; border-right:1px dotted #e5e5e5; cursor:pointer;}
	#selectItemLayerPop td:hover {background-color:#fcf340; font-weight:bold; font-size:12px;}
	
	
	#selectBusinessTypeLayerPop th {background-color:#ffffff;}
	#selectBusinessTypeLayerPop td {background-color:#ffffff;}
	#div_business_type_txt{overflow:auto;}
	#div_business_type_txt li {background-color:#ffffff; line-height:25px; text-align:left; border-bottom:1px dotted #e5e5e5; cursor:pointer;}
	#div_business_type_txt li:hover {background-color:#fcf340;}
	
	#div_business_txt {overflow:auto;}
	#div_business_txt li {line-height:25px; text-align:left; border-bottom:1px dotted #e5e5e5; cursor:pointer;}
	#div_business_txt li:hover {background-color:#fcf340;}
	
	#div_business_type_txt li.on {background-color:#fcf340;}
	</style>
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header"></h3>
			<div class="btn-wrap">
				
				
				<input type="button" class="btn btn-primary btn-sm" value="Business Note" 	id="btnXxx1">	
				<input type="button" class="btn btn-primary btn-sm" value="회사정보" id="btnCompModify">	
				<input type="button" class="btn btn-primary btn-sm" value="거래내역 보기" id="btnXxx2">	
				<input type="button" class="btn btn-primary btn-sm" value="상담내역" id="btnXxx1">
				<input type="button" class="btn btn-primary btn-sm" value="다중 댓글" id="btnXxx1">
<!-- 					<input type="button" class="btn btn-primary btn-sm" value="한중FTA" id="btnXxx1"> -->
			</div>
		</div>
		<!-- product_admin -->
		<div class="product_admin">

			<!-- 본문 -->
		<div class="ly_body">
			<div class="refer bullet6">
				<ul>
					<input type="button" class="btn btn-success btn-sm" value="고객현황" 	id="btnBack">
				</ul>
				<div class="refer_bt" >
					<div class="min_btn mini">	


					<input type="button" class="btn btn-primary btn-sm" value="무역송금" id="btnXxx1">
					<input type="button" class="btn btn-primary btn-sm" value="파일업로드" id="btnXxx1">
					<input type="button" class="btn btn-primary btn-sm" value="ClearanceDoc" id="btnXxx1">				
					
					<input type="button" class="btn btn-warning btn-sm" value="거래처 연결하기" 	id="btnConnection">	
					<input type="button" class="btn btn-info btn-sm" value="접수하기" 	id="btnOrdReg">			
					</div>
				</div>
			</div>
			
			
			<div class="tagCover mt20">
					<form method="post" id="partnerForm" name="partnerForm">
						<input type="hidden" id="vendor_no" 	name="vendor_no" 		value="${info.vendor_no}" />
						<input type="hidden" id="charge_yn" 	name="charge_yn" 		value="${info.charge_yn}" />
						<input type="hidden"	id="vendor_cd"	name="vendor_cd"	value="" />
						<input type="hidden" id="vendor_typ" 	name="vendor_typ" 		value="3" />
					</form>

				<div class="typeleft qnaWlist">
				
					<h3 class="mb5">코멘트</h3>
					<div class="grid" min="450" style="padding-left:0px;">
						<table id="commentList"></table>					
					</div>
				
					<h3 class="mb5">최근 요청</h3>
					<div class="grid" min="450" style="padding-left:0px;">
						<table id="orderList"></table>					
					</div>
					
					<h3 class="mb5">FileList</h3>
					<div class="grid" min="450" style="padding-left:0px;">
						<table id="fileList"></table>					
					</div>
					
					<h3 class="mb5">ClearanceDocList</h3>
					<div class="grid" min="450" style="padding-left:0px;">
						<table id="clearanceDocList"></table>					
					</div>
	
					<h3 class="mt20 mb5">관련 회사</h3>
					<div class="grid" min="450" style="padding-left:0px;">
						<table id="partnerList"></table>					
					</div>
					

					

					
				</div>
				
				
				
				
				<div class="typeright qnaWlist">
				
					<h3 class="styleH3">회사 정보</h3>
	
					<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl" style="border-top: 0px;">
					<caption>${pTitle} 정보</caption>
						<colgroup>
							<col width="100px" />
							<col width="150px" />
							<col width="100px" />
							<col width="150px" />
						</colgroup>
						<tbody>							
							<tr>
								<th scope="row"><label>고객번호</label></th>
								<td colspan="3" class="b">${info.vendor_cd}</td>
							</tr>
							
							<tr>
								<th scope="row">상호명(영문)</th>
								<td>${info.vendor_nm_eng}</td>
								<th scope="row"><label>전화</label></th>
								<td>${info.tel_txt}</td>
							</tr>
							<tr>
								<th scope="row"><label>상호명(자국어)</label></th>
								<td>${info.vendor_nm}</td>
								<th scope="row"><label>팩스</label></th>
								<td>${info.fax_txt}</td>
							</tr>
							<tr>
								<th scope="row"><label>홈페이지</label></th>
								<td>${info.homepage_url}</td>
								<th scope="row"><label>메일</label></th>
								<td>${info.email_txt}</td>
							</tr>

							<tr>
								<th scope="row"><label for="desc_addr_txt">사업장주소(영문)</label></th>
								<td colspan="3">				
									${info.basadd_txt} ${info.dtladd_txt}
								</td>
							</tr>
							
							<tr>
								<th scope="row"><label for="desc_addr_txt">사업장주소(자국어)</label></th>
								<td colspan="3">	
									${info.road_basadd_txt} ${info.road_dtladd_txt}
								</td>
							</tr>


							<tr>
								<th scope="row"><label for="business_type_txt">업태</label></th>
								<td colspan="3">${info.business_type_txt}</td>
							</tr>
							
							<tr>
								<th scope="row"><label for="business_txt">업종</label></th>
								<td colspan="3">${info.business_txt}</td>
							</tr>

							<tr>
								<th scope="row"><label for="business_txt">품목</label></th>
								<td colspan="3">${info.item_txt}</td>
							</tr>
							
							



							<tr class="division" style="height:50px;vertical-align:bottom;">
								<td colspan="4"><h3>직원정보</h3>
									<div class="min_btn" style="float:right;margin-top:-25px;padding-right:20px;">
										
<!-- 										<input type="button" class="btn btn-primary btn-xs" id="addUserBtn" value="사용자 추가"> -->
<!-- 										<input type="button" class="btn btn-danger btn-xs" id="delUserBtn" value="삭제"> -->

									</div>
								</td>
							</tr>
							<tr>
								<td colspan="4">
								<div class="grid" min="450" style="padding-left:0px;">
									<table id="memberList"></table>					
								</div>
								</td>
							</tr>
							



							
						</tbody>
					</table>
					
					
					
					<h3 class="mt20 mb5">창고</h3>
					<div class="grid" min="450" style="padding-left:0px;">
						<table id="customerList5"></table>					
					</div>
					
				</div>
			</div>					
			

		</div>
			<!-- //본문 -->


			<div class="grid">
				<table id="list1"></table>
			</div>
		</div>
		<!-- //product_admin -->
	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>