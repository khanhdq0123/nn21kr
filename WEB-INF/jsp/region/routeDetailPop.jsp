<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/common/include/header.jsp"%>
		
		<title>노선 등록</title>
		
		<script type="text/javascript">
		
		
		var startPortFlag = 1;
										
			$(document).ready(function() {
								
// 				$("#btnSave").click(function() {
// 					$("#gForm").submit();
// 				});
				

				
				$("#gForm").validate({
					debug : true,
					rules : {
						trans_typ1:{required:true, maxlength:20},
						trans_typ2:{required:true, maxlength:20},
						st_region2:{required:true, maxlength:20},
						st_region4:{required:true, maxlength:20}
					}, 		
					messages: {
						trans_typ1:{
							required:"운송구분1을 선택하세요.",
							maxlength:jQuery.format("지역명은 최대 20자 이하로 입력하세요.")
						},
						trans_typ2:{
							required:"운송구분2을 선택하세요.",
							maxlength:jQuery.format("지역명은 최대 20자 이하로 입력하세요.")
						},
						st_region2:{
							required:"지역을 선택하세요.",
							maxlength:jQuery.format("지역명은 최대 20자 이하로 입력하세요.")
						},
						st_region4:{
							required:"지역을 선택하세요.",
							maxlength:jQuery.format("지역명은 최대 20자 이하로 입력하세요.")
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
							url: "/region/insertRoute",
							data: $(form).serialize(),
							dataType: 'json',
							contentType: 'application/x-www-form-urlencoded; charset=utf-8',
							success: function(data) {
								if(data.code == '0') {
									toast(data.msg);
									//window.opener.getTreeData();
									//window.opener.fnReloadRegionGrid();
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
			
			
			
			
			function fnSelectView(flag){
				startPortFlag = flag;
				var trans_typ1 = $("#trans_typ1").val();
				
				if(trans_typ1 == ''){
// 					toast('먼저 운송구분1을 선택하세요.');
				}

				CenterOpenWindow('/region/selectPortPop?code=' + trans_typ1, '포트선택', '1000','560', 'scrollbars=no, status=yes');

			}
			
			function fnSetSelectPortInfo(_country, _city, _region1, _region2, _countryNo, _cityNo, _region1No, _region2No){

				if(startPortFlag == 1){
					
					$("#st_region2_nm").val(_country);
					$("#st_region4_nm").val(_city);
					$("#st_region5_nm").val(_region1);
					$("#st_region6_nm").val(_region2);
					
					$("#st_region2").val(_countryNo);
					$("#st_region4").val(_cityNo);
					$("#st_region5").val(_region1No);
					$("#st_region6").val(_region2No);
				} else {
					$("#ar_region2_nm").val(_country);
					$("#ar_region4_nm").val(_city);
					$("#ar_region5_nm").val(_region1);
					$("#ar_region6_nm").val(_region2);
					
					$("#ar_region2").val(_countryNo);
					$("#ar_region4").val(_cityNo);
					$("#ar_region5").val(_region1No);
					$("#ar_region6").val(_region2No);
				}
			}
			
			
			function fn_f10(){
				$("#gForm").submit();
			}			
		</script>
		
		<style>
		.st_port_wrap input {background-color:#eee;}
		.ar_port_wrap input {background-color:#eee;}
		</style>
		
	</head>

<body class="sky">

<div class="layerpop_inner" id="#">

	<h1 class="ly_header">노선 등록</h1>
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
		<input type="hidden" id="route_typ" name="route_typ" value="1" />
		<input type="hidden" id="use_yn" name="use_yn" value="Y" />
		
		
		<input type="hidden" id="st_region1" name="st_region1" value="" />
		<input type="hidden" id="st_region2" name="st_region2" value="" />
		<input type="hidden" id="st_region3" name="st_region3" value="" />
		<input type="hidden" id="st_region4" name="st_region4" value="" />
		<input type="hidden" id="st_region5" name="st_region5" value="" />
		<input type="hidden" id="st_region6" name="st_region6" value="" />
		<input type="hidden" id="ar_region1" name="ar_region1" value="" />
		<input type="hidden" id="ar_region2" name="ar_region2" value="" />
		<input type="hidden" id="ar_region3" name="ar_region3" value="" />
		<input type="hidden" id="ar_region4" name="ar_region4" value="" />
		<input type="hidden" id="ar_region5" name="ar_region5" value="" />
		<input type="hidden" id="ar_region6" name="ar_region6" value="" />
		
		
		
		
			<fieldset>
			<legend>노선 등록 상세 페이지</legend>
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>노선 등록 상세 페이지</caption>
					<colgroup>
						<col width="15%" />
						<col width="30%" />
						<col width="15%" />
						<col width="40%" />
					</colgroup>
					<tbody>
						<tr>
							<th>운송구분1</th>
							<td>
								<select style="width:90%" id="trans_typ1" name="trans_typ1">
									<option value="">전체</option>
                                           <c:forEach var="entity" items="${applicationScope['CODE']['10200']}">
                                              <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
                                           </c:forEach>   
								</select>
							</td>
							<th>운송구분2</th>
							<td>
								<select style="width:90%" id="trans_typ2" name="trans_typ2">
									<option value="">전체</option>
                                           <c:forEach var="entity" items="${applicationScope['CODE']['10800']}">
                                              <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
                                           </c:forEach>   
								</select>
							</td>						
						</tr>
						<tr>
							<th>출발지</th>
							<td colspan="3" class="st_port_wrap">
<!-- 								<input type="text" name="st_region1_nm" id="st_region1_nm" value="" onclick="fnSelectView();" /> -->
								<input type="text" name="st_region2_nm" id="st_region2_nm" value="" onclick="fnSelectView(1);" />
<!-- 								<input type="text" name="st_region3_nm" id="st_region3_nm" value="" /> -->
								<input type="text" name="st_region4_nm" id="st_region4_nm" value="" />
								<input type="text" name="st_region5_nm" id="st_region5_nm" value="" />
								<input type="text" name="st_region6_nm" id="st_region6_nm" value="" />
							</td>
						</tr>
						<tr>
							<th>도착지</th>
							<td colspan="3"  class="ar_port_wrap">
<!-- 								<input type="text" name="ar_region1_nm" id="ar_region1_nm" value="" onclick="fnSelectView();" /> -->
								<input type="text" name="ar_region2_nm" id="ar_region2_nm" value="" onclick="fnSelectView(0);" />
<!-- 								<input type="text" name="ar_region3_nm" id="ar_region3_nm" value="" /> -->
								<input type="text" name="ar_region4_nm" id="ar_region4_nm" value="" />
								<input type="text" name="ar_region5_nm" id="ar_region5_nm" value="" />
								<input type="text" name="ar_region6_nm" id="ar_region6_nm" value="" />
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