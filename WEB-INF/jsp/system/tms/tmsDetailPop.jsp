<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/common/include/header.jsp"%>
		
		<title>TMS 등록</title>
		
		<script type="text/javascript">
										
			$(document).ready(function() {

				$("#gForm").validate({
					debug : true,
					rules : {
						region_nm:{required:true, maxlength:50},
						sort_seq:{required:true, number:true, max:32767}
					}, 		
					messages: {
						region_nm:{
							required:"TMS명을 입력하세요.",
							maxlength:jQuery.format("TMS명은 최대 50자 이하로 입력하세요.")
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
							url: "/system/tms/insertTms",
							data: $(form).serialize(),
							dataType: 'json',
							contentType: 'application/x-www-form-urlencoded; charset=utf-8',
							success: function(data) {
								if(data.code == '0') {
									toast(data.msg);
									window.opener.fnSearch();
									//window.close();
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

	<h1 class="ly_header">TMS 등록</h1>
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
			<legend>TMS 등록 상세 페이지</legend>
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>TMS 등록 상세 페이지</caption>
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">구분1</th>
							<td><input type="text" id="part1" name="part1" style="width:98%" /></td>				
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>구분2</th>
							<td><input type="text" id="part2" name="part2" style="width:98%" /></td>
						</tr>
						<tr>
							<th scope="row">TMS명</th>
							<td colspan="3"><input type="text" id="title" name="title" style="width:98%" /></td>				
						</tr>
						<tr>
							<th scope="row">프로그램URL</th>
							<td colspan="3"><input type="text" id="pg_url" name="pg_url" style="width:98%" /></td>				
						</tr>
						<tr>
							<th scope="row">comment</th>
							<td colspan="3"><input type="text" id="comment" name="comment" style="width:98%" /></td>				
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>승인상태</th>
							<td>
								<select style="width:90%" id="appr_cd" name="appr_cd">
									<option value="">전체</option>
                                           <c:forEach var="entity" items="${applicationScope['CODE']['10600']}">
                                              <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
                                           </c:forEach>   
								</select>
							</td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>진행상태</th>
							<td>
								<select style="width:90%" id="sts_cd" name="sts_cd">
									<option value="">전체</option>
                                           <c:forEach var="entity" items="${applicationScope['CODE']['10700']}">
                                              <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
                                           </c:forEach>   
								</select>
							</td>						
						</tr>
						<tr>
							<th scope="row">작업시작일</th>
							<td>
								<span class="calendar">
									<input type="text" class="datepicker2" id="start_dt" name="start_dt" />
								</span>
							</td>				
							<th scope="row">작업예정일</th>
							<td>
								<span class="calendar">
									<input type="text" class="datepicker2" id="due_dt" name="due_dt" />
								</span>
							</td>
						</tr>
						<tr>
							<th scope="row">등록일</th>
							<td><span></span></td>				
							<th scope="row">작업완료일</th>
							<td>
								<span class="calendar">
									<input type="text" class="datepicker2" id="finish_dt" name="finish_dt" />
								</span>
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