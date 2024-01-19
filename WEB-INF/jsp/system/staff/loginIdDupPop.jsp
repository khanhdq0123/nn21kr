<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="/common/include/header.jsp"%>
	
	<title>운영자 등록</title>
	
	<script type="text/javascript">
									
		$(document).ready(function() {

			var useAbleYn = '${_DATA.useAbleYn}';


			<c:if test="${_DATA.useAbleYn eq 'N'}">
			$('#useN').show();
			$('#useY').hide();
			</c:if>
			<c:if test="${_DATA.useAbleYn eq 'Y'}">
			$('#useN').hide();
			$('#useY').show();
			</c:if>
							
			$("#btnUse").click(function(data) {
				opener.setLoginId($('#login_id').val());
				self.close();
			});
			
// 			$("#btnSearch").click(function(event) {
// 				event.preventDefault();
				
// 				$("#gForm").submit();
				
// 			});
			
		
		$("#gForm").validate({
			debug : true,
			rules : {
				loginId:{
					required: true
				}
			},
			messages: {
				loginId:{
					required:"아이디를 입력해 주세요."
				}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
	        },
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {
				$.ajax({
					type: "POST",
					url: "/system/staff/loginIdDupPopJson2",
					data: $(gForm).serialize(),
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						
						var idd = $('#loginId').val(); 
						$('#use_id').val(idd);
						$('#use_nid').val(idd);
						$('#login_id').val(idd);

						if(data.useAbleYn == 'Y') {
							
							$('#useN').hide();
							$('#useY').show();
							
						}else if(data.useAbleYn == "N"){
							
							$('#useY').hide();
							$('#useN').show();
							
						}
					},
					error: function(jqXHR, textStatus, errorThrown) {
						toast("오류가 발생했습니다" );						
					}
				});
			}
		});		
		
	});
		
		function fn_f3(){
			$("#gForm").submit();
		}
	</script>
</head>

<body class="sky">

	<div class="layerpop_inner"  id="#">
		
		<div class="report">
			<h3>아이디 중복 검사
				<div class="min_btn">
					<button class="gray" id="btnClose" >닫기</button>
				</div>
			</h3>
		</div>
		
		<div class="ly_body">
		<form method="post" id="gForm" name="gForm" >
		<input type="hidden" id="login_id" name="login_id" value="<c:out value='${_DATA.login_id}'/>" />
			<fieldset>
			<legend>아이디 중복 검사 페이지</legend>
			<div class="layer_contents">
				
				<div id="useN" >
					<table cellspacing="0" cellpadding="0" class="layer_tbl">
					<caption>아이디 중복 검사 페이지</caption>
						<colgroup>
							<col width="33%" />
							<col width="34%" />						
							<col width="33%" />						
						</colgroup>
						<tbody>
							<tr>
								<td colspan="3" >
									<div id="getId"></div>
									<input type="text" id="use_nid" name="use_nid" value="<c:out value='${_DATA.login_id}'/>" style="border:none;text-align:right;font-weight:bold" readonly="readonly" />은/는
									<br/><center>사용할 수 없는 아이디입니다.</center>
								</td>
							</tr>							
							<tr>							
								<td colspan="3">
									<br/><strong>다른 아이디 사용하기</strong><br />
								</td>							
							</tr>
							<tr>
								<th>아이디 입력</th>
								<td>
									<input type="text" id="loginId" name="loginId" />
								</td>
								<td>
									<button class="sky" id="btnSearch">중복확인</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div id="useY" >
					<table cellspacing="0" cellpadding="0" class="layer_tbl">
					<caption>아이디 중복 검사 페이지</caption>
						<colgroup>
							<col width="33%" />
							<col width="34%" />						
							<col width="33%" />	
						</colgroup>
						<tbody>
							<tr>
								<td colspan="3">
									<input type="text" id="use_id" name="use_id" value="<c:out value='${_DATA.login_id}'/>" style="border:none;text-align:right;font-weight:bold" readonly="readonly" />은/는
									<br/><center>사용할 수 있는 아이디입니다.</center>
									<br/><center><button class="sky" id="btnUse">사용하기</button></center>									
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				
			</div>
			</fieldset>
		</form>
		</div>
	</div>	
	
 <div id="toast"></div></body>
</html>