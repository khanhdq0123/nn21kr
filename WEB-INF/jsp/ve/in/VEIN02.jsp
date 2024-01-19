<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript" src="/js<%=jsUrl%>.js"></script>
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header"></h3>
			<div class="btn-wrap">
				<input type="button" class="btn btn-primary btn-sm" value="저장[F10]" 	id="btnSave">		
			</div>
		</div>



	    
<form method="post" id="partnerForm" >
	<input type="hidden" id="vendor_no" 	name="vendor_no" 		value="${vendor_no}" />
	<input type="hidden" id="staff_sns_seq" 	name="staff_sns_seq" 		value="" />
	
	<fieldset>
	    
	    <div class="tapcont-wrap">

	    	<!-- 대표자정보 -->
	    	<div class="tapcont">
				<div class="inb_con active mt5">

							<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl" style="border-top: 0px;">
							<caption>${pTitle} 정보</caption>
								<colgroup>
									<col width="16%" />
									<col width="34%" />
									<col width="16%" />
									<col width="34%" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>영문</th>
										<td>
											<input type="text" id="staff_enm" name="staff_enm" value="<c:out value='${staffInfo1.staff_enm}'/>" style="width:90%" maxlength="30" />
										</td>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>핸드폰</th>
										<td>
											<input type="text" id="mobile_txt" name="mobile_txt" value="<c:out value='${staffInfo1.mobile_txt}'/>" style="width:90%" maxlength="30" />
										</td>							
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>한글</th>
										<td>
											<input type="text" id="staff_nm" name="staff_nm" value="<c:out value='${staffInfo1.staff_nm}'/>" style="width:90%" maxlength="30" />
										</td>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>이메일</th>
										<td>
											<input type="text" id="email_txt" name="email_txt" value="<c:out value='${staffInfo1.email_txt}'/>" style="width:90%" maxlength="30" />
										</td>							
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>아이디</th>
										<td>
											<input type="text" id="login_id" name="login_id" value="<c:out value='${staffInfo1.login_id}'/>" class="readonly" readonly style="width:150px;" maxlength="30"/>
										</td>
										<th scope="row"></th>
										<td>
										</td>							
									</tr>									
									<tr>
										<th scope="row">SNS정보
											<input type="button" class="btn btn-primary btn-xs" onclick="fnAddSns('${staffInfo1.login_id}');" value="추가">
										</th>
										<td colspan="3">
											 <c:forEach var="sns1" items="${staff1SnsList}">
											 	<span>${sns1.sns_typ_nm} : ${sns1.sns_id}</span>
											 	<input type="button" class="btn btn-close btn-xs" onclick="fnDelSns('${sns1.staff_sns_seq}');" value="삭제"> 
											 </c:forEach>   
										</td>
									</tr>

								</tbody>
							</table>
			
				</div>

	    	</div>


	    </div>
	    
	</fieldset>
</form>







	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>