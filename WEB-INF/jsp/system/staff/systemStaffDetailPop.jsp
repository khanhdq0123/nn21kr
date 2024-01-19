<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="/common/include/header.jsp"%>
	
	<title>아이디 중복 검사</title>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
			mobil_substr();
			
			var submitUrl = "/system/staff/insertStaffDetail";
			if("${_TYP}" == "modify") {
				submitUrl = "/system/staff/updateStaffDetail";

			} 
			
			var  privacy_read_yn= "${_DATA.privacy_read_yn}";
/* 			if(privacy_read_yn == 'N'){
				$('input:radio[name="excel_down_yn"]').prop('disabled', true);
			}
 */
/* 			$("input[name='privacy_read_yn']").click(function() {
				var chkValue = $('input:radio[name="privacy_read_yn"]:checked').val();
				if(chkValue == 'N'){
					$('input:radio[name=excel_down_yn]').prop('disabled', true);
					
					$('input:radio[name=excel_down_yn]:input[value=N]').prop("checked", true);

				}else{
					$('input:radio[name="excel_down_yn"]').prop('disabled', false);
				}
			}); */
			
			$.validator.addMethod(
					"passpattern1"
					, function(value,element){
						  if(value.length<8) return false;
						
						  var charCnt = 0;
						  
						  if(value.match(/[A-Z]/)){charCnt++;}
						  if(value.match(/[a-z]/)){charCnt++;}
						  if(value.match(/[0-9]/)){charCnt++;}
						  if(value.match(/[!@#$%&()_]/)){charCnt++;}
						  
						  if(value.length<10 && charCnt<3) return false;
						  else if(charCnt<2) return false;
						  					  
						  return true;
					  }
					, "비밀번호는 알파벳 대문자, 소문자, 숫자\n, 특수문자(!@#$%&()_) 중 \n세가지 이상 포함된  8자 이상이거나 \n두가지 이상 포함된  10자 이상이어야 합니다."
			);
					
			$.validator.addMethod(
					"passpattern2"
					, function(value,element){
						  var loginId = '<c:out escapeXml="false" value="${sessionScope['STAFFINFORMATION']['login_id']}" />';
						  if(value.indexOf(loginId)>=0) return false;
						  return true;
					  }
					, "비밀번호에 아이디는 포함될 수 없습니다."
			);
			
			$("#btnSave").click(function() {
				
// 				if($("#login_id").val() != $("#dup_check").val()){
// 					toast("ID중복확인을 해주세요.");
// 					return false;
// 				}

// 				if("${_TYP}" == "add") {
// 					$("#passwd_txt").rules("add", {passpattern1: true});				
// 					$("#passwd_txt").rules("add", {passpattern2: true});
// 				}
				
// 				$("#gForm").submit();
			});			
			
			$("#gForm").validate({
				debug : true,
				rules : {
					login_id: {required:true, rangelength:[3, 20]},					
					staff_nm: {required:true, maxlength:30},
					mobile_txt1: {required:true, number:true, rangelength:[3, 3]},
					mobile_txt2: {required:true, number:true, rangelength:[3, 4]},
					mobile_txt3: {required:true, number:true, rangelength:[4, 4]},
					vendor_nm: {
							required:function(element) {
								//console.log($(":input:radio[name=ipcheck_yn]:checked"));
								return ($(":input:radio[name=staff_typ]:checked").val()=='2') ? true:false;
							}
					},
					conn_ip_txt:{
							required:function(element) {
									//console.log($(":input:radio[name=ipcheck_yn]:checked"));
								return ($(":input:radio[name=ipcheck_yn]:checked").val()=='Y') ? true:false;
							}
							, maxlength:20},
					email_txt: {required:true, email:true, maxlength:50},
					comment_txt:{maxlength:4000}
				}, 		
				messages: {
					login_id:{
						required:"로그인ID를 입력하세요.",
						rangelength:jQuery.format("로그인ID는 최소 {0}글자 이상 {1}글자 이하로 입력하세요.")
					},
					passwd_txt: {
						required:"패스워드를 입력하세요.",
						rangelength:jQuery.format("패스워드 확인은 최소 {0}글자 이상 {1}글자 이하로 입력하세요.")
					},
					staff_nm:{
						required:"운영자명을 입력하세요",
						maxlength:jQuery.format("운영자명은 최대 {0} 이하로 입력하세요.")
					},
					vendor_nm:{
						required:"업체명을 입력하세요"
					},
					mobile_txt1: {
						required:"핸드폰번호 앞자리를 입력하세요.",
						number:"핸드폰번호 앞자리는 숫자로 입력하셔야합니다.",
						rangelength:jQuery.format("핸드폰번호 앞자리는 {0}자리수로 입력하세요.")
					},
					mobile_txt2: {
						required:"핸드폰번호 가운데 자리를 입력하세요.",
						number:"핸드폰번호 가운데 자리는 숫자로 입력하셔야합니다.",
						rangelength:jQuery.format("핸드폰번호 가운데 자리는 최소 {0}글자 이상 {1}글자 이하로 입력하세요.")
					},
					mobile_txt3: {
						required:"핸드폰번호 뒷자리를 입력하세요.",
						number:"핸드폰번호 뒷자리는 숫자로 입력하셔야합니다.",
						rangelength:jQuery.format("핸드폰번호 뒷자리는 {0}자리수로 입력하세요.")
					},
					conn_ip_txt: {
						required:"운영자IP를 입력하세요.",
						maxlength:jQuery.format("운영자IP는 최대 {0} 이하로 입력하세요.")
					},
					email_txt:{
						required:"이메일 주소를 입력하세요.",
						email:"올바른 이메일 주소가 아닙니다.",
						maxlength:jQuery.format("로그인ID는 최대 {0}자 이하로 입력하세요.")
					},
					comment_txt:{						
						maxlength:jQuery.format("비고는 최대 {0}자 이하로 입력하세요.")
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
								toast(data.msg);
								window.opener.fnReload();
								window.close();
							}	
						},
						error: function(jqXHR, textStatus, errorThrown) {
							toast(jqXHR.status);						
						}
					});
				}
			});
			
			
			$("#btnDup").click(function(event) {
				if($("#login_id").val() == '') {
					toast("로그인ID를 입력 후 중복확인을 해주세요.");
					return false;
				}
				CenterOpenWindow('/system/staff/loginIdDupPop?loginId='+$("#login_id").val(), '중복확인', '480','220', 'scrollbars=yes, status=yes');
				event.preventDefault(); 
			});
			
			$("#btnSearchVender").click( function() {
				if($(":input:radio[name=staff_typ]:checked").val()=='1'){
					toast("내부운영자는 업체를 등록할 수 없습니다.");
					$("#vendor_nm").val("");
					$("#vendor_no").val("");
					return false;
				}
				openPop(1, '');
				$("input[name=board_staff_yn]").val(['N']);
				return false;
			});
			
			$("#btnPassReset").click( function(event) {
				//var reset = confirm('비밀번호를 초기화 하시겠습니까?');
				if(confirm('비밀번호를 초기화 하시겠습니까?')==true) {
					
					$.ajax({
						type: "POST",
						url: "/system/staff/updatePasswdReset",
						data: $('#gForm').serialize(),
						dataType: 'json',
						contentType: 'application/x-www-form-urlencoded; charset=utf-8',
						success: function(data) {
							toast(data.msg);
						},
						error: function(jqXHR, textStatus, errorThrown) {
							toast(jqXHR.status);
						}
					});
					
				} else {
					toast("취소하였습니다.");
					return false;
				}
				event.preventDefault(); 
			});
			
			$('[name="staff_typ"]').on('click', function () {
				
				var comp_id = $(this).attr('id');
				if(comp_id == 'staff_typ1') {
					$("#vendor_nm").val("");
					$("#vendor_no").val("");
					$("input[name=board_staff_yn]").val(['N']);		// 내부 운영자로 선택할 경우, 1:1 문의 담당자 여부는 'N'으로 세팅
					$("#board_staff_yn").hide();
				}else{
					$("#board_staff_yn").show();
				}
				
				$.ajax({
					type: "POST",
					url: "/system/staff/groupAuthJson",
					data: $('#gForm').serialize(),
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						
						// 기존의 option 정보 삭제
					 	$("#groupauth_nm").empty();
					 	
					 	for(var i=0; i < data.groupAuthList.length; i++) {
					 		$('#groupauth_nm').append('<option value="'+ data.groupAuthList[i].groupauth_id +'">' +data.groupAuthList[i].groupauth_nm + '</option>');
					 	}
						
					},
					error: function(jqXHR, textStatus, errorThrown) {
						toast(jqXHR.status);
					}
				});
				
			});
			

			
		});
		
		//공급사 검색 결과 처리
		function setVendorData(dataList) {
			$('#vendor_nm').val(dataList[0].vendor_nm);
			$('#vendor_no').val(dataList[0].vendor_no);
		}
		
		function setLoginId(data) {
			
			$("#dup_check").val(data);
			$('#login_id').val(data);
		}
		
		function mobil_substr(){
			var a = $("#mobile_txt").val();
			var b = a.replace(/-/g, "");
			var c = b.length;
			
			var mobil1 = "";
			var mobil2 = "";
			var mobil3 = "";
			
			if(c == 11){
				mobil1 = b.substr(0,3);
				mobil2 = b.substr(3,4);
				mobil3 = b.substr(7,4);
				
				$("#mobile_txt1").val(mobil1);
				$("#mobile_txt2").val(mobil2);
				$("#mobile_txt3").val(mobil3);
				
			}else if(c == 10){
				mobil1 = b.substr(0,3);
				mobil2 = b.substr(3,3);
				mobil3 = b.substr(6,4);
				
				$("#mobile_txt1").val(mobil1);
				$("#mobile_txt2").val(mobil2);
				$("#mobile_txt3").val(mobil3);
			}
		}
		

		function fn_f10(){
			if($("#login_id").val() != $("#dup_check").val()){
				toast("ID중복확인을 해주세요.");
				return false;
			}

			if("${_TYP}" == "add") {
				$("#passwd_txt").rules("add", {passpattern1: true});				
				$("#passwd_txt").rules("add", {passpattern2: true});
			}
			
			$("#gForm").submit();
		}

	</script>
</head>
	
<body class="sky">

<div class="layerpop_inner" id="#">

	<h1 class="ly_header" onclick="fnTest();">시스템운영자 등록 상세</h1>
	<!-- .ly_body -->
	<div class="ly_body">
		<div class="refer bullet6">
			<div class="refer_bt">
				<div class="min_btn mini">
<c:if test="${IsMaster eq 'Y'}">				
					<button id="btnSave" type="button" class="sky" >저장</button>
</c:if>					
					<button id="btnClose" type="button" class="gray" >닫기</button>
				</div>
			</div>
		</div>
		<form id="gForm" name="gForm" method="post" action="#">
		<input type="hidden" id="vendor_no" name="vendor_no" value="10000" /> <!-- 업체번호 저장시 사용 -->
		<input type="hidden" id="dup_check" name="dup_check" value="${_DATA.login_id}" />  <!-- 중복체크시 사용 -->
		<input type="hidden" id="staff_typ" name="staff_typ" value="1" />

		
		
			<fieldset>
			<legend>시스템운영자 등록 상세 페이지</legend>
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>시스템운영자 등록 상세 페이지</caption>
					<colgroup>
						<col width="20%" />
						<col width="30%" />
						<col width="20%" />
						<col width="30%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>직급</th>
							<td>
								<select  id="job_cd" name="job_cd">
									<option value="">전체</option>
                                    <c:forEach var="entity" items="${applicationScope['CODE']['11400']}">
                                       <option value="<c:out value="${entity.code_cd}"/>"  <c:if test ="${_DATA.job_cd eq entity.code_cd}">selected="selected"</c:if>><c:out value="${entity.code_nm}"/></option>
                                    </c:forEach>   
								</select>
							</td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>직무</th>
							<td>
								<select  id="position_cd" name="position_cd">
									<option value="">전체</option>
                                    <c:forEach var="entity" items="${applicationScope['CODE']['11300']}">
                                       <option value="<c:out value="${entity.code_cd}"/>"   <c:if test ="${_DATA.position_cd eq entity.code_cd}">selected="selected"</c:if>><c:out value="${entity.code_nm}"/></option>
                                    </c:forEach>   
								</select>
							</td>							
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>영문</th>
							<td>
								<input type="text" id="staff_enm" name="staff_enm" value="<c:out value='${_DATA.staff_enm}'/>" style="width:90%" maxlength="30" />
							</td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>핸드폰</th>
							<td>
								<input type="text" id="mobile_txt" name="mobile_txt" value="<c:out value='${_DATA.mobile_txt}'/>" style="width:90%" maxlength="30" />
							</td>							
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>한글</th>
							<td>
								<input type="text" id="staff_nm" name="staff_nm" value="<c:out value='${_DATA.staff_nm}'/>" style="width:90%" maxlength="30" />
							</td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>이메일</th>
							<td>
								<input type="text" id="email_txt" name="email_txt" value="<c:out value='${_DATA.email_txt}'/>" style="width:90%" maxlength="30" />
							</td>							
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>아이디</th>
							<td>
								<c:if test="${empty _DATA.login_id}">
								<input type="text" id="login_id" name="login_id" value="<c:out value='${_DATA.login_id}'/>" style="width:150px;" maxlength="30"/>
								<button type="button" class="sky add03" id="btnDup">중복확인</button>
								</c:if>
								<c:if test="${!empty _DATA.login_id}">
								<input type="hidden" id="login_id" name="login_id" value="<c:out value='${_DATA.login_id}'/>" style="width:150px;" maxlength="30"/>
								${_DATA.login_id} 
								</c:if>
							</td>
							<th scope="row"></th>
							<td>
							</td>							
						</tr>
						<c:if test="${empty _DATA.login_id}">
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>비번</th>
							<td>
								<input type="password" id="passwd_txt" name="passwd_txt" value="" style="width:90%" maxlength="30"/>
							</td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>비번확인</th>
							<td>
								<input type="password" id="passwd_txt2" name="passwd_txt2" value="" style="width:90%" maxlength="30"/>
							</td>							
						</tr>
						</c:if>		
						<tr>
							<th scope="row"><label for="a5"><span class="starMark">필수입력 항목입니다.</span>소속(업체명)</label></th>
							<td>
								<input type="text" id="vendor_nm" name="vendor_nm" value="${_DATA.vendor_nm}" readonly="readonly" style="width:90%;background:#eee;" />
							</td>
							<c:if test="${ IsMaster eq  'Y'}">
								<th scope="row"><span class="starMark">필수입력 항목입니다.</span>권한그룹</th>
								<td>
									<select id="groupauth_id" name="groupauth_id" style="width:150;" >
										<c:if test="${!empty _AUTH}">
											<c:forEach var="entity" items="${_AUTH}">
												<option value="<c:out value="${entity.groupauth_id}"/>" <c:if test="${entity.groupauth_id eq _DATA.groupauth_id}">selected="selected"</c:if> > 
												<c:out value="${entity.groupauth_nm}" /></option>
											</c:forEach>
										</c:if>
									</select>
								</td>
							</c:if>
						</tr>
						
						
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>계정 사용여부</th>
							<td>
								<input type="radio" id="use_yn1" name="use_yn" value="Y" ${_DATA.use_yn == "Y" || empty _DATA.use_yn ? "checked='checked'" : "" } />
								<label class="int_space" for="use_yn1">사용</label>
								<input type="radio" id="use_yn2" name="use_yn" value="N" ${_DATA.use_yn == "N" ? "checked='checked'" : "" } />
								<label class="int_space" for="use_yn2">미사용</label>
							</td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>로그인시 휴대폰인증 여부</th>
							<td>
								<input type="radio" id="authentication_yn1" name="authentication_yn" value="Y" ${_DATA.authentication_yn == "Y" || empty _DATA.authentication_yn ? "checked='checked'" : "" } />
								<label class="int_space" for="authentication_yn1">사용</label>
								<input type="radio" id="authentication_yn2" name="authentication_yn" value="N" ${_DATA.authentication_yn == "N" ? "checked='checked'" : "" } />
								<label class="int_space" for="authentication_yn2">미사용</label>
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