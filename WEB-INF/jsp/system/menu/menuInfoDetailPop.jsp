<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/common/include/header.jsp"%>
		
		<title>지역 등록</title>
		
		<script type="text/javascript">
										
			$(document).ready(function() {
				

				$("#gForm").validate({
					debug : true,
					rules : {
						menu_nm:{required:true, maxlength:50},
						menuurl_txt: {required:true, maxlength:200},
						sort_seq:{required:true, number:true, max:32767},
						comment_txt:{maxlength:2000}
					}, 		
					messages: {
						menu_nm:{
							required:"메뉴명을 입력하세요.",
							maxlength:jQuery.format("메뉴명은 최대 50자 이하로 입력하세요.")
						},
						menuurl_txt: {
							required:"프로그램 URL을 입력하세요.",
							maxlength:jQuery.format("프로그램 URL은 최대 200자 이하로 입력하세요.")
						},
						sort_seq:{
							required:"정렬순서를 입력하세요",
							number:"정렬순서는 숫자로 입력하셔야합니다.",
							maxlength:jQuery.format("정렬순서는 최대 32767 이하로 입력하세요.")
						},
						comment_txt:{						
							maxlength:jQuery.format("비고는 최대 2000자 이하로 입력하세요.")
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
							url: "/system/menu/insertMenuInfoDetailPop.do",
							data: $(form).serialize(),
							dataType: 'json',
							contentType: 'application/x-www-form-urlencoded; charset=utf-8',
							success: function(data) {
								if(data.code == '0') {
									toast(data.msg);
									window.opener.getTreeData();
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
			
			//저장
			function fn_f10(){
				$("#gForm").submit();
			}
			
		</script>
	</head>

<body class="sky">

<div class="layerpop_inner" id="#">

	<h1 class="ly_header">메뉴 등록</h1>
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
			<legend>메뉴 등록 상세 페이지</legend>
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>메뉴 등록 상세 페이지</caption>
					<colgroup>
						<col width="20%" />
						<col width="30%" />
						<col width="20%" />
						<col width="30%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">상위 메뉴명</th>
							<td><input type="text" id="upmenu_nm" name="upmenu_nm" readonly="readonly" value="<c:out value="${_DATA.upmenu_nm}"/>" style="border:none" /></td>							
							<th scope="row">상위 메뉴 ID</th>
							<td><input type="text" id="upmenu_id" name="upmenu_id" readonly="readonly" value="<c:out value="${_DATA.upmenu_id}"/>" style="border:none" /></td>							
						</tr>
				
						
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="menu_id">메뉴 ID</label></th>
							<td>
								<input type="text" id="menu_id" name="menu_id" style="border:none" readonly="readonly" />
							</td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="js_url">js url</label></th>
							<td>
								<input type="text" id="js_url" name="js_url" /> ex) /ad/ex/ADEX01
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="menu_id">화면 ID</label></th>
							<td>
								<input type="text" id="screen_id" name="screen_id" /> ex) ADEX01
							</td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="menu_nm">메뉴명</label></th>
							<td>
								<input type="text" id="menu_nm" name="menu_nm" style="width:98%;" />
							</td>
						</tr>
						
			
						
						
						<tr>
							<th scope="row" onclick="$('#menuurl_txt').val('/');"><span class="starMark">필수입력 항목입니다.</span>프로그램 URL</th>
							<td><input type="text" id="menuurl_txt" name="menuurl_txt" value="/blank.jsp" style="width:98%" /></td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>개인정보포함여부</th>
							<td>
								<input type="radio" id="person_inf_yn1" name="person_inf_yn" value="Y" checked="checked" /><label class="int_space" for="person_inf_yn1">사용</label>
								<input type="radio" id="person_inf_yn2" name="person_inf_yn" value="N" /><label class="int_space" for="person_inf_yn2">미사용</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>메뉴여부</th>
							<td>
								<input type="radio" id="menu_yn1" name="menu_yn" value="Y" checked="checked" /><label class="int_space" for="menu_yn1">사용</label>
								<input type="radio" id="menu_yn2" name="menu_yn" value="N" /><label class="int_space" for="menu_yn2">미사용</label>
							</td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>사용여부</th>
							<td>
								<input type="radio" id="use_yn1" name="use_yn" value="Y" checked="checked" /><label class="int_space" for="use_yn1">사용</label>
								<input type="radio" id="use_yn2" name="use_yn" value="N" /><label class="int_space" for="use_yn2">미사용</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>시스템 유형</th>
							<td>
								<select id="system_typ" name="system_typ" style="width:99%;" >
									<option value="1">내부운영자</option>
									<option value="2">지사</option>
									<option value="3">고객사</option>
								</select>
							</td>
							<th scope="row"><label for="a8"><span class="starMark">필수입력 항목입니다.</span>정렬순서</label></th>
							<td>
								<input type="text" id="sort_seq" name="sort_seq" value="<c:out value="${_DATA.sort_seq}"/>" style="width:98%;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="a8">비고</label></th>
							<td colspan="3">
								<textarea rows="3" id="comment_txt" name="comment_txt" style="width:98.5%" ></textarea>
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