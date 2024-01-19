<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/common/include/header.jsp"%>

<title>지역 등록</title>

<script type="text/javascript">


var levels = '${levels}';

								
	$(document).ready(function() {
				
// 		$("#btnSave").click(function() {
// 			$("#gForm").submit();
// 		});
		
		
		$("#gForm").validate({
			debug : true,
			rules : {
				region_enm:{required:true, maxlength:50},
				sort_seq:{required:true, number:true, max:32767}
			}, 		
			messages: {
				region_enm:{
					required:"지역명을 입력하세요.",
					maxlength:jQuery.format("지역명은 최대 50자 이하로 입력하세요.")
				},
				sort_seq:{
					required:"정렬순서를 입력하세요",
					number:"정렬순서는 숫자로 입력하셔야합니다.",
					maxlength:jQuery.format("정렬순서는 최대 32767 이하로 입력하세요.")
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
					url: "/region/insertRegion",
					data: $(form).serialize(),
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						if(data.code == '0') {
							//toast(data.msg);
							//window.opener.getTreeData();
							window.opener.fnCallbackRegionUpdate(levels);
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

	<h1 class="ly_header">지역 등록</h1>
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
		<input type="hidden" id="upcode" name="upcode" value="<c:out value="${_DATA.code}"/>" />
		
			<fieldset>
			<legend>지역 등록 상세 페이지</legend>
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>지역 등록 상세 페이지</caption>
					<colgroup>
						<col width="25%" />
						<col width="20%" />
						<col width="15%" />
						<col width="40%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">상위 지역명</th>
							<td colspan="3"><input type="text" id="upregion_nm" name="upregion_nm" readonly="readonly" value="<c:out value="${_DATA.region_nm}"/>" style="border:none" /></td>												
						</tr>
						<tr>					
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>지역명(영어)</th>
							<td colspan="3"><input type="text" id="region_enm" name="region_enm" style="width:98%" /></td>							
						</tr>
						<tr>					
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>지역명(자국어)</th>
							<td colspan="3"><input type="text" id="region_nm" name="region_nm" style="width:98%" /></td>							
						</tr>
						<tr>
							<th scope="row"><label for="a8"><span class="starMark">필수입력 항목입니다.</span>정렬순서</label></th>
							<td>
								<input type="text" id="sort_seq" name="sort_seq" value="<c:out value="${_DATA.next_sort_seq}"/>" style="width:98%;" />
							</td>							
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>사용여부</th>
							<td>
								<input type="radio" id="use_yn1" name="use_yn" value="Y" checked="checked" /><label class="int_space" for="use_yn1">사용</label>
								<input type="radio" id="use_yn2" name="use_yn" value="N" /><label class="int_space" for="use_yn2">미사용</label>
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