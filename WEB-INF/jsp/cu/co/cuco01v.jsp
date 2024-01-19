<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="/js/partnerReg4Customer.js"></script>
</head>
<body class="sky">
	
    	<div class="refer bullet6">
			<ul class="type1">
				<li>정보를 입력 하시고 반드시 저장버튼을 클릭하셔야 정상 등록 됩니다.</li>
			</ul>
			<div class="refer_bt" >
				<div class="min_btn mini">
					<input type="button" class="btn btn-close btn-sm" value="닫기" id="btnClose">
				</div>
			</div>
		</div>

	    <div class="tapcont-wrap">
	    
	    <h2 style="padding:20px 0 5px 5px;">회사정보</h2>
	    	<div class="tapcont">
				<div class="inb_con active">
							<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl" style="border-top: 0px;">
							<caption>${pTitle} 정보</caption>
								<colgroup>
									<col width="14%" />
									<col width="36%" />
									<col width="14%" />
									<col width="36%" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><label>상호명(영문)</label></th>
										<td>${info.vendor_nm_eng}</td>
										<th scope="row"><label>전화</label></th>
										<td>${info.tel_txt}</td>
									</tr>
									<tr>
										<th scope="row"><label>상호명</label></th>
										<td>${info.vendor_nm}</td>
										<th scope="row"><label>팩스</label></th>
										<td>${info.fax_txt}</td>
									</tr>
									<tr>
										<th scope="row"><label>홈페이지</label></th>
										<td>${info.homepage_url}</td>
										<th scope="row"><label>메일</label></th>
										<td>${info.email_txt}</td>
									</tr>
	
									<tr>
										<th scope="row"><label for="desc_addr_txt">사업장주소(영문)</label></th>
										<td colspan="3">${info.basadd_txt} ${info.dtladd_txt}</td>
									</tr>
									
									<tr>
										<th scope="row"><label for="desc_addr_txt">사업장주소(자국어)</label></th>
										<td colspan="3">${info.road_basadd_txt} ${info.road_dtladd_txt}</td>
									</tr>
	
									<tr>
										<th scope="row"><label for="business_type_txt">업태</label></th>
										<td colspan="3">${info.business_type_txt}</td>
									</tr>
									
									<tr>
										<th scope="row"><label for="business_txt">업종</label></th>
										<td colspan="3">${info.business_txt}</td>
									</tr>
	
									<tr>
										<th scope="row"><label for="business_txt">품목</label></th>
										<td colspan="3">${info.item_txt}</td>
									</tr>

								</tbody>
							</table>
				</div>
	    	</div>
	    	
	    	
	    	<h2 style="padding:20px 0 5px 5px;">대표자정보</h2>
	    	<!-- 대표자정보 -->
	    	<div class="tapcont">
				<div class="inb_con active">

							<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl" style="border-top: 0px;">
							<caption>${pTitle} 정보</caption>
								<colgroup>
									<col width="14%" />
									<col width="36%" />
									<col width="14%" />
									<col width="36%" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row">영문</th>
										<td>${staffInfo1.staff_enm}</td>
										<th scope="row">핸드폰</th>
										<td>${staffInfo1.mobile_txt}</td>							
									</tr>
									<tr>
										<th scope="row">한글</th>
										<td>${staffInfo1.staff_nm}</td>
										<th scope="row">이메일</th>
										<td>${staffInfo1.email_txt}</td>							
									</tr>
									<tr>
										<th scope="row">아이디</th>
										<td>${staffInfo1.login_id}</td>
										<th scope="row"></th>
										<td></td>							
									</tr>
									<tr>
										<th scope="row">SNS</th>
										<td colspan="3">
										<c:forEach var="sns" items="${staffInfo1.snsList}">
											<span class="mr20">${sns.sns_typ_nm} : ${sns.sns_id}</span> 
										</c:forEach>
										
										</td>
									</tr>
								</tbody>
							</table>
				</div>
	    	

	    	
	    	</div>
	    	
	    	<!-- 등록인정보 -->
	    	<h2 style="padding:20px 0 5px 5px;">등록인정보</h2>
	    	<div class="tapcont">
						
				<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl" style="border-top: 0px;">
					<colgroup>
						<col width="14%" />
						<col width="36%" />
						<col width="14%" />
						<col width="36%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">영문</th>
							<td>${staffInfo2.staff_enm}</td>
							<th scope="row">핸드폰</th>
							<td>${staffInfo2.mobile_txt}</td>							
						</tr>
						<tr>
							<th scope="row">한글</th>
							<td>${staffInfo2.staff_nm}</td>
							<th scope="row">이메일</th>
							<td>${staffInfo2.email_txt}</td>							
						</tr>
						<tr>
							<th scope="row">아이디</th>
							<td>${staffInfo2.login_id}</td>
							<th scope="row"></th>
							<td></td>							
						</tr>
						<tr>
							<th scope="row">SNS</th>
							<td colspan="3">
							<c:forEach var="sns" items="${staffInfo2.snsList}">
								<span class="mr20">${sns.sns_typ_nm} : ${sns.sns_id}</span> 
							</c:forEach>
							</td>
						</tr>	
					</tbody>
				</table>


					
	    	</div>
	    	
	    	<!-- 직원정보 -->
	    	<h2 style="padding:20px 0 5px 5px;">직원정보</h2>
	    	<div class="tapcont">
								
			<c:forEach var="staff" items="${staffList}">
				<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl mb20" style="border-bottom: 30px;">
					<colgroup>
						<col width="14%" />
						<col width="36%" />
						<col width="14%" />
						<col width="36%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">영문</th>
							<td>${staff.staff_enm}</td>
							<th scope="row">핸드폰</th>
							<td>${staff.mobile_txt}</td>							
						</tr>
						<tr>
							<th scope="row">한글</th>
							<td>${staff.staff_nm}</td>
							<th scope="row">이메일</th>
							<td>${staff.email_txt}</td>							
						</tr>
						<tr>
							<th scope="row">아이디</th>
							<td>${staff.login_id}</td>
							<th scope="row"></th>
							<td></td>							
						</tr>
						<tr>
							<th scope="row">SNS</th>
							<td colspan="3">
							<c:forEach var="sns" items="${staff.snsList}">
								<span class="mr20">${sns.sns_typ_nm} : ${sns.sns_id}</span> 
							</c:forEach>
							</td>
						</tr>
					</tbody>
				</table>
			</c:forEach>
			
	    	</div>
	    </div>


 <div id="toast"></div></body>
</html>