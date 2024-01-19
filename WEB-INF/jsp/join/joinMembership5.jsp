<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript">

	var vendor_no = '${info.vendor_no}';
	var vendor_nm = '${info.vendor_nm}';
	var idCheckFlag = 3;

	$(document).ready(function(){

		$("#BTN_SetSave").on("click",function(){
			toast('회원가입신청이 완료되었습니다.');
			self.close();
		});
		
		
		$("#chkSame2").click(function(event) {
			var chkSame2 = $("#chkSame2:checked").val();

			
			if(chkSame2 == 1){
				$("#charge_yn").val("Y");
			} else {
				$("#charge_yn").val("N");
			}
		});
		
	});
	
	</script>
	
		<c:set var="staff_typ" value="${sessionScope['STAFFINFORMATION']['staff_typ']}" />
	
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="/js/partnerListPop.js"></script>

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

	<div class="layerpop_inner"  id="partnerPop">
	

		<!-- .ly_body -->
		<div class="ly_body">
			<div class="refer bullet6">
				<h1 class="fl fs16">물류플랫폼 회원등록</h1>
				<div class="refer_bt" >
					<div class="min_btn mini">
						<input type="button" class="btn btn-close btn-sm" value="close" id="btnClose">
					</div>
				</div>
			</div>
			<div class="layer_contents">

				<div class="inb_con active">
					<form method="post" id="joinForm" >
						<input type="hidden" id="vendor_no" name="vendor_no" 	value="${info.vendor_no}" />
						<input type="hidden" id="job_cd" 	name="job_cd" 		value="11405" />
						<input type="hidden" id="charge_yn" name="charge_yn" 	value="N" />

						<fieldset>
						<legend>${pTitle} 정보</legend>
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
										<td colspan="4"><h3>회사기본자료등록</h3></td>
									</tr>
									<tr>
										<th scope="row"><label>상호명(영문)</label></th>
										<td>${info.vendor_nm_eng}</td>
										<th scope="row"><label>전화</label></th>
										<td>${info.tel_txt}</td>
									</tr>
									<tr>
										<th scope="row"><label>상호명</label></th>
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
										<th scope="row"><span class="starMark"> 필수입력 항목입니다.</span><label for="desc_addr_txt">사업장주소(영문)</label></th>
										<td colspan="3">				
											${info.basadd_txt} ${info.dtladd_txt}
										</td>
									</tr>
									
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="desc_addr_txt">사업장주소(자국어)</label></th>
										<td colspan="3">	
											${info.road_basadd_txt}	${info.road_dtladd_txt}
										</td>
									</tr>
	
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="business_type_txt">업태</label></th>
										<td colspan="3">${info.business_type_txt}</td>
									</tr>
									
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="business_txt">업종</label></th>
										<td colspan="3">${info.business_txt}</td>
									</tr>
	
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="business_txt">품목</label></th>
										<td colspan="3">${info.item_txt}</td>
									</tr>
									
									
									<tr class="division" style="height:50px;vertical-align:bottom;">
										<td colspan="4"><h3>대표자 정보</h3>

										</td>
									</tr>
									
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>영문</th>
										<td>${staffInfo1.staff_enm}</td>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>핸드폰</th>
										<td>${staffInfo1.mobile_txt}</td>							
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>한글</th>
										<td>${staffInfo1.staff_nm}</td>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>이메일</th>
										<td>${staffInfo1.email_txt}</td>							
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>아이디</th>
										<td>${staffInfo1.login_id}</td>
										<th scope="row"></th>
										<td></td>							
									</tr>

									<tr class="division" style="height:50px;vertical-align:bottom;">
										<td colspan="4">
											<c:if test="${!empty staffInfo2}">
											<h3>등록인 정보</h3>
											</c:if>
											<c:if test="${empty staffInfo2}">
											<h3>등록인 정보 (대표자와 동일)</h3>
											</c:if>
										</td>
									</tr>

									<c:if test="${!empty staffInfo2}">
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>영문</th>
										<td>${staffInfo2.staff_enm}</td>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>핸드폰</th>
										<td>${staffInfo2.mobile_txt}</td>							
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>한글</th>
										<td>${staffInfo2.staff_nm}</td>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>이메일</th>
										<td>${staffInfo2.email_txt}</td>							
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>아이디</th>
										<td>${staffInfo2.login_id}</td>
										<th scope="row"></th>
										<td></td>							
									</tr>
									</c:if>

									<tr class="division" style="height:50px;vertical-align:bottom;">
										<td colspan="4"><h3>직원정보</h3>
											<div class="min_btn" style="float:right;margin-top:-25px;padding-right:20px;">
<!-- 												<input type="button" class="btn btn-primary btn-xs" value="추가"> -->
<!-- 												<input type="button" class="btn btn-close btn-xs" value="삭제"> -->
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
									
									<tr class="division" style="height:50px;vertical-align:bottom;">
										<td colspan="4"><h3>sns정보</h3>
											<div class="min_btn" style="float:right;margin-top:-25px;padding-right:20px;">
<!-- 												<input type="button" class="btn btn-primary btn-xs" value="추가"> -->
<!-- 												<input type="button" class="btn btn-close btn-xs" value="삭제"> -->
											</div>
										</td>
									</tr>
									<tr>
										<td colspan="4">
										<div class="grid" min="450" style="padding-left:0px;">
											<table id="snsList"></table>					
										</div>
										</td>
									</tr>


								</tbody>
							</table>
							

				
				
							
						</fieldset>
					</form>
									
					<form id="rForm" name="rForm" method="post" action="#">
					<input type="hidden" id="code" name="code" />
					</form>
					
				</div>
			</div>
		</div>
		<!-- // .ly_body -->
	
		<div class="ac">
			<input type="button" class="btn btn-primary btn-lg w180" value="확인" id="BTN_SetSave">
		</div>
	
		<br /><br />
	
	</div>




 <div id="toast"></div></body>

</html>