<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="/common/include/header.jsp"%>
	
	<title>SNS 등록</title>
	
	<script type="text/javascript">
		$(document).ready(function() {

			$("#staff_id").val('${staff_id}');

			var submitUrl = "/system/staff/insertStaffSns";
			if("${_TYP}" == "modify") {
				submitUrl = "/system/staff/updateStaffSns";
			} 

			$("#gForm").validate({
				debug : true,
				rules : {
					staff_id: {required:true, maxlength:30},		
					sns_typ: {required:true, maxlength:30},		
					sns_id: {required:true, maxlength:30}
				}, 		
				messages: {
					staff_id:{
						required:"직원을 선택하세요."
					},
					sns_typ: {
						required:"SNS종류를 선택하세요."
					},
					sns_id:{
						required:"SNS계정을 입력하세요"
					}
	
				},
				onfocusout:false,
				invalidHandler: function(form, validator) {
					showValidationError(form, validator);               
	            },
				errorPlacement: function(error, element) {
					// nothing
				},
				submitHandler: function(form) {							
					$.ajax({
						type: "POST",
						url: submitUrl,
						data: $(form).serialize(),
						dataType: 'json',
						contentType: 'application/x-www-form-urlencoded; charset=utf-8',
						success: function(data) {
							
							if(data.code == '0') {
								window.opener.location.reload();
								window.close();
							}	
						},
						error: function(jqXHR, textStatus, errorThrown) {
							toast(jqXHR.status);						
						}
					});
				}
			});

		});

		function fn_f10(){
			$("#gForm").submit();
		}		
	</script>
</head>
	
<body class="sky">

<div class="layerpop_inner" id="#">

	<h1 class="ly_header" onclick="fnTest();">SNS 등록</h1>
	<!-- .ly_body -->
	<div class="ly_body">
		<div class="refer bullet6">
			<div class="refer_bt">
				<div class="min_btn mini">
					
					<input type="button" class="btn btn-primary btn-xs" value="저장[F10]" id="btnSave">
					<input type="button" class="btn btn-close btn-xs" value="닫기" id="btnClose">
					
				</div>
			</div>
		</div>
		<form id="gForm" name="gForm" method="post" action="#">
		<input type="hidden" id="vendor_no" name="vendor_no" value="${vendor_info.vendor_no}" /> <!-- 업체번호 저장시 사용 -->
		<input type="hidden" id="staff_id" name="staff_id" value="${staff_info.staff_id}" />  <!-- 중복체크시 사용 -->
		
			<fieldset>
			<legend>운영자 등록 상세 페이지</legend>
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>운영자 등록 상세 페이지</caption>
					<colgroup>
						<col width="20%" />
						<col width="38%" />
						<col width="20%" />
						<col width="20%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><label for="a5"><span class="starMark">필수입력 항목입니다.</span>소속(업체명)</label></th>
							<td>
								<input type="text" id="vendor_nm" name="vendor_nm" value="${vendor_info.vendor_nm}" readonly="readonly" class="readonly" style="width:98%;" />
							</td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>사용자명</th>
							<td>
								<input type="text" id="staff_nm" name="staff_nm" value="${staff_info.staff_nm}" readonly="readonly" class="readonly" style="width:98%;"  />
							</td>
						</tr>
						
						<tr>

							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>SNS구분</th>
							<td>
								<select  id="sns_typ" name="sns_typ">
									<option value="">SNS종류를 선택하세요.</option>
                                    <c:forEach var="entity" items="${applicationScope['CODE']['11100']}">
                                       <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
                                    </c:forEach>   
								</select>
							</td>
						</tr>
					
						<tr>
							
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>SNS계정</th>
							<td colspan="3">
								<input type="text" id="sns_id" name="sns_id" value="<c:out value='${_DATA.sns_id}'/>" style="width:90%" maxlength="30" />
							</td>							
						</tr>

					</tbody>
				</table>
			</div>
		</fieldset>
	</form>
	</div>
	<!-- // .ly_body -->

</div>

<div id="toast"></div></body>	

</html>