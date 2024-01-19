<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="/common/include/header.jsp"%>
	
	<title>권한 그룹 등록</title>
	
	<script type="text/javascript">
	
	$(document).ready(function() {
		
// 		$("#btnSave").click(function() {
// 			$("#gForm").submit();
// 		});
		
		
		$("#gForm").validate({
			debug : true,
			rules : {
				groupauth_nm:{required:true,maxlength:30},
				sort_seq:{required:true,number:true,max:32767},
				comment_txt:{maxlength:4000}
			}, 		
			messages: {
				groupauth_nm:{
					required:"권한그룹 명을 입력하세요.",
					maxlength:jQuery.format("권한그룹 명은 최대 {0} 자 이하로 입력하세요.")
				},
				sort_seq:{
					required:"정렬순서를 입력하세요",
					number:"정렬순서는 숫자로 입력하셔야합니다.",
					max:jQuery.format("정렬순서는 최대 {0}이하로 입력하세요.")
				},
				comment_txt:{
					maxlength:jQuery.format("권한설명은 최대 {0} 글자 이하로 입력하세요.")
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
					url: "/system/auth/insertGroupAuthDetail",
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

	<h1 class="ly_header">권한 그룹 등록</h1>
	<!-- .ly_body -->
	<div class="ly_body">
		<div class="refer bullet6">
			<div class="refer_bt">
				<div class="min_btn mini">
					<button class="sky" id="btnSave">저장</button>
					<button class="gray" id="btnClose">닫기</button>
				</div>
			</div>
		</div>
		<form id="gForm" name="gForm" method="post" action="#">
			<fieldset>
			<legend>권한 그룹 등록 상세 페이지</legend>
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>권한 그룹 등록 상세 페이지</caption>
					<colgroup>
						<col width="23%" />
						<col width="27%" />
						<col width="23%" />
						<col width="27%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>권한그룹 명 :</th>
							<td>
								<input type="text" id="groupauth_nm" name="groupauth_nm" style="width:98%" />
							</td>							
							<th scope="row">권한 그룹 ID :</th>
							<td><input type="text" id="groupauth_id" name="groupauth_id" style="border:none" readonly="readonly" /></td>							
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>시스템 유형 :</th>
							<td>
								<select id="system_typ" name="system_typ" style="width:99%;" >
									<option value="1">내부운영자</option>
									<option value="2">지사</option>
									<option value="3">고객사</option>
								</select>
							</td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>정렬 순서 :</th>
							<td><input type="text" id="sort_seq" name="sort_seq" style="width:98%" /></td>
							
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>사용여부 :</th>
							<td colspan="3">
								<input type="radio" id="use_yn1" name="use_yn" value="Y" checked="checked" /><label class="int_space" for="use_yn1">사용</label>
								<input type="radio" id="use_yn2" name="use_yn" value="N" /><label class="int_space" for="use_yn2">미사용</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="a3">권한설명 :</label></th>
							<td colspan="3">
								<textarea id="comment_txt" name="comment_txt" style="width:98.5%" ></textarea>
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