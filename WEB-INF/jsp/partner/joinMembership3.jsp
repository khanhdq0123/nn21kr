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
		$("#joinForm").validate({
			debug : true,
			rules : {},
			messages: {
				vendor_nm:{
					required: "상호명을 입력하세요"
				},
				vendor_enm:{
					required: "상호명(영문)을 입력하세요"
				},
				charge_tel_txt:{
					dashNum: "전화번호는 숫자 및 '-' 만 입력가능합니다"
				},
				charge_mobil_txt:{
					dashNum: "휴대폰은 숫자 및 '-' 만 입력가능합니다"
				},
				charge_email_txt:{
					email: "Email을 정확하게 입력해주세요"
				}

			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);
            },
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {

				if(!idDupCheck){
					toast('ID중복체크를 해주세요.');
					return false;
				}
				
				if($("#passwd_txt").val() != $("#passwd_txt2").val()){
					toast('비번과 비번확인이 틀림니다.');
					return false;
				}
				
				$.ajax({
					type: "POST",
					url: '/partner/insertStaffInfo',
					data: $(form).serialize(),
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						if(data.code == '0') {

								location.href = "/partner/joinMembership4?vendor_no=" + data.vendor_no;
								//self.close();

						} else {
							toast(data.msg);
						}
					},
					error: function(jqXHR, textStatus, errorThrown) {
						toast( textStatus.msg);						
					}
				});
			}
		});
		
		
		
		$("#BTN_SetSave").on("click",function(){
			$("#joinForm").submit();
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
				<h1 class="fl fs16">국제종합물류주식회사 회원등록</h1>
				<div class="refer_bt" >
					<div class="min_btn mini">
						<input type="button" class="btn btn-close btn-sm" value="close" id="btnClose">
					</div>
				</div>
			</div>
			<div class="layer_contents">

				<div class="inb_con active">
					<form method="post" id="joinForm" >
						<input type="hidden" id="vendor_no" 	name="vendor_no" 		value="${info.vendor_no}" />
						<input type="hidden" id="job_cd" 	name="job_cd" 		value="11401" />
						<input type="hidden" id="authentication_yn" 	name="authentication_yn" 		value="N" />
						
					<c:if test="${sessionScope['STAFFINFORMATION']['staff_typ'] eq '1'}">
						<input type="hidden" id="staff_typ" 	name="staff_typ" 		value="2" />
					</c:if>			
					<c:if test="${sessionScope['STAFFINFORMATION']['staff_typ'] eq '2'}">
						<input type="hidden" id="staff_typ" 	name="staff_typ" 		value="3" />
					</c:if>		
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
										<th scope="row">영문</th>
										<td>
											<input type="text" id="staff_enm" name="staff_enm" value="" style="width:90%" maxlength="30" />
										</td>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>핸드폰</th>
										<td>
											<input type="text" id="mobile_txt" name="mobile_txt" value="" style="width:90%" maxlength="30" required />
										</td>							
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>한글</th>
										<td>
											<input type="text" id="staff_nm" name="staff_nm" value="" style="width:90%" maxlength="30" required />
										</td>
										<th scope="row">이메일</th>
										<td>
											<input type="text" id="email_txt" name="email_txt" value="" style="width:90%" maxlength="30" />
										</td>							
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>아이디</th>
										<td>
											<input type="text" id="login_id" name="login_id" value="" style="width:150px;" maxlength="30" required  />
											<input type="button" class="btn btn-primary btn-sm" value="중복확인" id="btnDup">
										</td>
										<th scope="row"></th>
										<td>
										</td>							
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>비번</th>
										<td>
											<input type="password" id="passwd_txt" name="passwd_txt" value="" style="width:90%" maxlength="30" required  />
										</td>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>비번확인</th>
										<td>
											<input type="password" id="passwd_txt2" name="passwd_txt2" value="" style="width:90%" maxlength="30"  required />
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
			<input type="button" class="btn btn-primary btn-lg w180" value="다음" id="BTN_SetSave">
		</div>
	
	</div>




 <div id="toast"></div></body>

</html>