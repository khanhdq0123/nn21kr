<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/common/include/header.jsp"%>
		
		<title>시스템 코드 등록</title>
		
		<script type="text/javascript">
										
			$(document).ready(function() {
				
// 				$("#btnSave").click(function() {
// 					$("#gForm").submit();
// 					window.opener.jsRefresh();
// 				});
				
				
				$("#gForm").validate({
					debug : true,
					rules : {
						code_nm:{required:true, maxlength:100},
						sort_seq:{required:true, number:true, max:32767},
						comment_txt:{maxlength:4000},
						inside_txt:{maxlength:20},
						tmpfield1_txt:{maxlength:20},
						tmpfield2_txt:{maxlength:20}
					}, 		
					messages: {
						code_nm:{required:"코드명을 입력하세요.",
							maxlength:jQuery.format("코드명은 최대 {0} 글자 이하로 입력하세요.")
						},
						sort_seq:{
							required:"정렬순서를 입력하세요",
							number:"정렬순서는 숫자로 입력하셔야합니다.",
							max:jQuery.format("정렬순서는 최대 {0} 이하로 입력하세요.")
						},
						comment_txt:{maxlength:jQuery.format("코드설명은 최대 {0} 글자 이하로 입력하세요.")},
						inside_txt:{maxlength:jQuery.format("내부연동코드는 최대 {0} 글자 이하로 입력하세요.")},
						tmpfield1_txt:{maxlength:jQuery.format("임시필드1는 최대 {0} 글자 이하로 입력하세요.")},
						tmpfield2_txt:{maxlength:jQuery.format("임시필드2는 최대 {0} 글자 이하로 입력하세요.")}
					},
					onfocusout:false,
					invalidHandler: function(form, validator) {
						showValidationError(form, validator);               
		            },
					errorPlacement: function(error, element) {},
					submitHandler: function(form) {
						$.ajax({
							type: "POST",
							url: "/system/code/insertSystemCodeDetail.do",
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
				window.opener.jsRefresh();
			}
			
			
		</script>
	</head>

<body class="sky">

<div class="layerpop_inner" id="#">

	<h1 class="ly_header">시스템 코드 등록</h1>
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
		<form id="gForm" name="gForm" method="post" >
<%-- 		<input type="text" id="upcode_cd" name="upcode_cd" value="<c:out value='${_DATA.upcode_cd}'/>" /> --%>
			<fieldset>
			<legend>시스템 코드 등록 상세 페이지</legend>
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl">
					<caption>시스템 코드 등록 상세 정보</caption>
					<colgroup>
						<col width="20%" />
						<col width="30%"/>
						<col width="20%" />
						<col width="30%"/>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><label for="upcode_nm">상위코드명 :</label></th>
							<td>
								<c:if test="${ _DATA.upcode_cd eq '00000' }">
									<input type="text" id="upcode_nm" name="upcode_nm" value="<c:out value='${_DATA.code_nm}'/>" />
									<input type="text" style="border:none" readonly="readonly" />
								</c:if>
								<c:if test="${ _DATA.upcode_cd ne '00000' }">
									<input type="text" id="upcode_nm" name="upcode_nm" value="<c:out value='${_DATA.code_nm}'/>" style="border:none" readonly="readonly" />
								</c:if>
							</td>
							<th scope="row"><label for="upcode_cd">상위코드ID :</label></th>
							<td>
								<c:if test="${ _DATA.upcode_cd eq '00000' }">
									<input type="text" id="upcode_cd" name="upcode_cd" value="<c:out value='${_DATA.code_cd}'/>"  />
									<input type="text" readonly="readonly" style="border:none" readonly="readonly" />
								</c:if>
								<c:if test="${ _DATA.upcode_cd ne '00000' }">
									<input type="text" id="upcode_cd" name="upcode_cd" value="<c:out value='${_DATA.code_cd}'/>" style="border:none" readonly="readonly" />
								</c:if>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="code_nm">코드명 :</label></th>
							<td>
								<input type="text" id="code_nm" name="code_nm" style="width:98%;" maxlength="100" />
							</td>
							<th scope="row"><label for="code_cd">코드ID :</label></th>
							<td></td>
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="sort_seq">정렬순서 :</label></th>
							<td>
								<input type="text" id="sort_seq" name="sort_seq" value="<c:out value='${_DATA.sort_seq}'/>" style="width:98%;" maxlength="5" />
							</td>										
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>사용여부</th>
							<td>
								<input type="radio" id="use_yn1" name="use_yn" value="Y" checked="checked" /><label class="int_space" for="use_yn1">사용</label>
								<input type="radio" id="use_yn2" name="use_yn" value="N" /><label class="int_space" for="use_yn2">미사용</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="comment_txt">코드설명 :</label></th>
							<td colspan="3">
								<input type="text" id="comment_txt" name="comment_txt" style="width:98%;" maxlength="4000" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="inside_txt">내부연동코드 :</label></th>
							<td>
								<input type="text" id="inside_txt" name="inside_txt" style="width:98%;" maxlength="20" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="tmpfield1_txt">임시필드1 :</label></th>
							<td>
								<input type="text" id="tmpfield1_txt" name="tmpfield1_txt" style="width:98%;" maxlength="20" />
							</td>
							<th scope="row"><label for="tmpfield2_txt">임시필드2 :</label></th>
							<td>
								<input type="text" id="tmpfield2_txt" name="tmpfield2_txt" style="width:98%;" maxlength="20" />
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