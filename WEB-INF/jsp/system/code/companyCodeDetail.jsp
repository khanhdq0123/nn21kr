<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/common/include/header.jsp"%>
		
		<title>제조사 코드 등록 팝업</title>
		
		<script type="text/javascript">
										
			$(document).ready(function() {
				
				
// 				$("#btnSave").click(function() {
// 					$("#gForm").submit();
// 				});
				
				$("#gForm").validate({
					debug : true,
					rules : {
						maker_nm:{required:true, maxlength:50},
						comment_txt:{maxlength:2000}
					},
					messages: {
						maker_nm:{
							required:"제조사명을 입력하세요.",
							maxlength:jQuery.format("제조사명은 최대 50자 이하로 입력하세요.")
						},
						comment_txt:{maxlength:jQuery.format("비고는 최대 2000자 이하로 입력하세요.")}
					},
					onfocusout:false,
					invalidHandler: function(form, validator) {
						showValidationError(form, validator);               
		            },
					errorPlacement: function(error, element) {},
					submitHandler: function(form) {
						$.ajax({
							type: "POST",
							url: "/system/code/insertCompanyCodeDetail.do",
							data: $(form).serialize(),
							dataType: 'json',
							contentType: 'application/x-www-form-urlencoded; charset=utf-8',
							success: function(data) {
								if(data.code == '0') {
									toast(data.msg);
									window.opener.jsRefresh();
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

<body class="sky" style="overflow:hidden;">

<div class="layerpop_inner" id="#">

	<h1 class="ly_header">제조사 코드 등록</h1>
	<!-- .ly_body -->
	<div class="ly_body">
		<div class="refer bullet6">
			<div class="refer_bt">
				<div class="min_btn">
					<button class="sky" id="btnSave">저장</button>
					<button class="gray" id="btnClose">닫기</button>
				</div>
			</div>
		</div>
		<form method="post" id="gForm" name="gForm" action="#">
		<input type="hidden" id="maker_no" name="maker_no" value="<c:out value='${_DATA.maker_no}'/>" />
			<fieldset>
			<legend>제조사 코드 등록 페이지</legend>
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>제조사 코드 등록 페이지</caption>
					<colgroup>
						<col width="30%" />
						<col width="70%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">제조사 코드 :</th>
							<td><c:out value='${_DATA.maker_no}'/></td>							
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>제조사명</th>
							<td><input id="maker_nm" name="maker_nm" type="text" style="width:98%" maxlength="50" /></td>
						</tr>
						<tr class="division">
							<th scope="row">비고</th>
							<td>
								<textarea rows="5" id="comment_txt" name="comment_txt" style="width:96%" ></textarea>
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