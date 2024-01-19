<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript">

	var vendor_no = '${info.vendor_no}';
	var vendor_nm = '${info.vendor_nm}';
	var idCheckFlag = 1;
	var selectedItem = '';		//선택된 품목
	var selectedBusiness = '';	//선택된 업종
	var staff_typ = "${sessionScope['STAFFINFORMATION']['staff_typ']}";

	
	$(document).ready(function(){
		$(".ctn-tabmenu-wrap .ctn-tabmenu_list").on("click",function(){
			var i = $(this).index();  		
			$(this).addClass("active").siblings().removeClass("active");
			$(".tapcont-wrap .tapcont").hide();
			$(".tapcont-wrap .tapcont").eq(i).show();
		});
	});
	
	var fnDelSns = function(staff_sns_seq){
		
		$("#staff_sns_seq").val(staff_sns_seq);
		
		$.ajax({
			type: "POST",
			url: "/system/staff/deleteStaffSns",
			data: $("#partnerForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code == '0') {
					toast(data.msg);
					//window.opener.fnReload();
					//window.close();
				}	
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast( textStatus.msg);						
			}
		});
		
	}
	
	
	</script>
	
		<c:set var="staff_typ" value="${sessionScope['STAFFINFORMATION']['staff_typ']}" />
	
	<style>
	
		.on {background-color:#fcf340; font-weight:bold;}
		
		#selectItemLayerPop th {text-align:center !important; height:40px;}
		#selectItemLayerPop td {text-align:center; height:40px; border-right:1px dotted #e5e5e5; cursor:pointer;}
		#selectItemLayerPop td:hover {background-color:#fcf340; font-weight:bold; font-size:12px;}
		
		
		#selectBusinessTypeLayerPop th {background-color:#ffffff;}
		#selectBusinessTypeLayerPop td {background-color:#ffffff;}
		#div_business_type_txt{overflow:auto;}
		#div_business_type_txt li {background-color:#ffffff; line-height:25px; text-align:left; border-bottom:1px dotted #e5e5e5; cursor:pointer;}
		#div_business_type_txt li:hover {background-color:#fcf340;}
		
		#div_business_txt {overflow:auto;}
		#div_business_txt li {line-height:25px; text-align:left; border-bottom:1px dotted #e5e5e5; cursor:pointer;}
		#div_business_txt li:hover {background-color:#fcf340;}
		
		#div_business_type_txt li.on {background-color:#fcf340;}
	</style>
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
					<input type="button" class="btn btn-primary btn-sm" value="저장" id="btnSave">
					<input type="button" class="btn btn-close btn-sm" value="닫기" id="btnClose">
				</div>
			</div>
		</div>

		<div class="ctn-tabmenu-wrap mt20">
	        <ul class="ctn-tabmenu">
	            <li class="ctn-tabmenu_list active" id="tab1"><span>회사정보</span></li>
	            <li class="ctn-tabmenu_list" id="tab2"><span>대표자정보</span></li>
	            <li class="ctn-tabmenu_list " id="tab3"><span>등록인정보</span></li>
	            <li class="ctn-tabmenu_list " id="tab4"><span>직원정보</span></li>
	        </ul>
	    </div>
	    
<!-- 		<div class="refer bullet6 mt10"> -->
<!-- 				<ul class="type1"> -->
<!-- 					<li>정보를 입력 하시고 반드시 저장버튼을 클릭하셔야 정상 등록 됩니다.</li> -->
<!-- 				</ul> -->
<!-- 			<div class="refer_bt" > -->
<!-- 				<div class="min_btn mini"> -->
<!-- 						<input type="button" class="btn btn-primary btn-sm" value="SAVE" id="btnSave"> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
	    
<form method="post" id="partnerForm" >
	<input type="hidden" id="vendor_no" 	name="vendor_no" 		value="${info.vendor_no}" />
	<input type="hidden" id="charge_yn" 	name="charge_yn" 		value="${info.charge_yn}" />
	<input type="hidden" id="vendor_typ" 	name="vendor_typ" 		value="3" />
	<input type="hidden" id="staff_sns_seq" 	name="staff_sns_seq" 		value="" />
	
	
	
	<fieldset>
	    

	    
	    <div class="tapcont-wrap">
	    	<div class="tapcont">

			
				<div class="inb_con active">
						
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
										<th scope="row"><span class="starMark"> 필수입력 항목입니다.</span><label>상호명(영문)</label></th>
										<td><input type="text" id="vendor_nm_eng" name="vendor_nm_eng" value="${info.vendor_nm_eng}" style="width:80%" maxlength="50" required /></td>
										<th scope="row"><label>전화</label></th>
										<td><input type="text" id="tel_txt" name="tel_txt" value="${info.tel_txt}" style="width:80%" maxlength="30"  /></td>
									</tr>
									<tr>
										<th scope="row"><span class="starMark"> 필수입력 항목입니다.</span><label>상호명</label></th>
										<td><input type="text" id="vendor_nm" name="vendor_nm" value="${info.vendor_nm}" style="width:80%" maxlength="30" required /></td>
										<th scope="row"><label>팩스</label></th>
										<td><input type="text" id="fax_txt" name="fax_txt" value="${info.fax_txt}" style="width:80%" maxlength="30"  /></td>
									</tr>
									<tr>
										<th scope="row"><label>홈페이지</label></th>
										<td><input type="text" id="homepage_url" name="homepage_url" value="${info.homepage_url}" style="width:80%" maxlength="30" /></td>
										<th scope="row"><label>메일</label></th>
										<td><input type="text" id="email_txt" name="email_txt" value="${info.email_txt}" style="width:80%" maxlength="30" /></td>
									</tr>
	
									<tr>
										<th scope="row"><span class="starMark"> 필수입력 항목입니다.</span><label for="desc_addr_txt">사업장주소(영문)</label></th>
										<td colspan="3">				
											<input type="text" id="basadd_txt" name="basadd_txt" value="${info.basadd_txt}" onclick="fnSelectRegionPop(1);" class="readonly" style="width:92%;" placeholder="여기를 눌러 선택하세요." readonly/> <br />
											<input type="text" id="dtladd_txt" name="dtladd_txt" value="${info.dtladd_txt}" style="width:92%; margin-top:2px;" maxlength="150" placeholder="여기에 상세주소를 입력하세요." required />
										</td>
									</tr>
									
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="desc_addr_txt">사업장주소(자국어)</label></th>
										<td colspan="3">	
											<input type="button" class="btn btn-primary btn-sm" value="주소검색" id="btnSearchAddr" onclick="fnSearchPost()">	
											<input type="text" id="road_basadd_txt" name="road_basadd_txt" value="${info.road_basadd_txt}" onclick="fnSelectRegionPop(2);" class="readonly" style="width:78%;" placeholder="여기를 눌러 선택하세요." readonly/> <br />
											<input type="text" id="road_dtladd_txt" name="road_dtladd_txt" value="${info.road_dtladd_txt}" style="width:92%; margin-top:2px;" maxlength="150" placeholder="여기에 상세주소를 입력하세요." required />
										</td>
									</tr>
	
									<tr>
										<th scope="row"><label for="business_type_txt">업태</label></th>
										<td colspan="3"><input type="text" id="business_type_txt" name="business_type_txt" value="${info.business_type_txt}" class="readonly" onclick="fnViewBusinessTypeLayer();" style="width:80%" readonly /></td>
									</tr>
									
									<tr>
										<th scope="row"><label for="business_txt">업종</label></th>
										<td colspan="3"><input type="text" id="business_txt" name="business_txt" value="${info.business_txt}" class="readonly" onclick="fnViewBusinessTypeLayer();" style="width:80%" readonly /></td>
									</tr>
	
									<tr>
										<th scope="row"><label for="business_txt">품목</label></th>
										<td colspan="3"><input type="text" id="item_txt" name="item_txt" value="${info.item_txt}" onclick="fnViewItemLayer();" style="width:80%;" class="readonly" readonly /></td>
									</tr>

								</tbody>
							</table>
	
					
									
				</div>




	    	</div>
	    	<!-- 대표자정보 -->
	    	<div class="tapcont dpn">
				<div class="inb_con active">

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
											<input type="text" id="staff_enm1" name="staff_enm1" value="<c:out value='${staffInfo1.staff_enm}'/>" style="width:90%" maxlength="30" />
										</td>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>핸드폰</th>
										<td>
											<input type="text" id="mobile_txt1" name="mobile_txt1" value="<c:out value='${staffInfo1.mobile_txt}'/>" style="width:90%" maxlength="30" />
										</td>							
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>한글</th>
										<td>
											<input type="text" id="staff_nm1" name="staff_nm1" value="<c:out value='${staffInfo1.staff_nm}'/>" style="width:90%" maxlength="30" />
										</td>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>이메일</th>
										<td>
											<input type="text" id="email_txt1" name="email_txt1" value="<c:out value='${staffInfo1.email_txt}'/>" style="width:90%" maxlength="30" />
										</td>							
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>아이디</th>
										<td>
											<input type="text" id="login_id1" name="login_id1" value="<c:out value='${staffInfo1.login_id}'/>" style="width:150px;" maxlength="30"/>
											<input type="button" class="btn btn-success btn-xs" id="btnDup1" value="중복확인">
										</td>
										<th scope="row"></th>
										<td>
										</td>							
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>비번</th>
										<td>
											<input type="password" id="passwd_txt1" name="passwd_txt1" value="" style="width:90%" maxlength="30"/>
										</td>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>비번확인</th>
										<td>
											<input type="password" id="passwd_txt12" name="passwd_txt12" value="" style="width:90%" maxlength="30"/>
										</td>							
									</tr>
								</tbody>
							</table>
							
							
	
									
				</div>
	    	

	    	
	    	</div>
	    	<!-- 등록인정보 -->
	    	<div class="tapcont dpn">
						
				<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl" style="border-top: 0px;">
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
								<input type="text" id="staff_enm2" name="staff_enm2" value="<c:out value='${staffInfo2.staff_enm}'/>" style="width:90%" maxlength="30" />
							</td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>핸드폰</th>
							<td>
								<input type="text" id="mobile_txt2" name="mobile_txt2" value="<c:out value='${staffInfo2.mobile_txt}'/>" style="width:90%" maxlength="30" />
							</td>							
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>한글</th>
							<td>
								<input type="text" id="staff_nm2" name="staff_nm2" value="<c:out value='${staffInfo2.staff_nm}'/>" style="width:90%" maxlength="30" />
							</td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>이메일</th>
							<td>
								<input type="text" id="email_txt2" name="email_txt2" value="<c:out value='${staffInfo2.email_txt}'/>" style="width:90%" maxlength="30" />
							</td>							
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>아이디</th>
							<td>
								<input type="text" id="login_id2" name="login_id2" value="<c:out value='${staffInfo2.login_id}'/>" style="width:150px;" maxlength="30"/>
								<input type="button" class="btn btn-success btn-xs" id="btnDup2" value="중복확인">
							</td>
							<th scope="row"></th>
							<td>
							</td>							
						</tr>
						<tr>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>비번</th>
							<td>
								<input type="password" id="passwd_txt2" name="passwd_txt2" value="" style="width:90%" maxlength="30"/>
							</td>
							<th scope="row"><span class="starMark">필수입력 항목입니다.</span>비번확인</th>
							<td>
								<input type="password" id="passwd_txt22" name="passwd_txt22" value="" style="width:90%" maxlength="30"/>
							</td>							
						</tr>

					</tbody>
				</table>


					
	    	</div>
	    	
	    	<!-- 직원정보 -->
	    	<div class="tapcont dpn">
								
	
			
							<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl mb20" style="border-bottom: 30px;">
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
											<input type="text" id="staff_enm2" name="staff_enm2" value="<c:out value='${staff.staff_enm}'/>" style="width:90%" maxlength="30" />
										</td>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>핸드폰</th>
										<td>
											<input type="text" id="mobile_txt2" name="mobile_txt2" value="<c:out value='${staff.mobile_txt}'/>" style="width:90%" maxlength="30" />
										</td>							
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>한글</th>
										<td>
											<input type="text" id="staff_nm2" name="staff_nm2" value="<c:out value='${staff.staff_nm}'/>" style="width:90%" maxlength="30" />
										</td>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>이메일</th>
										<td>
											<input type="text" id="email_txt2" name="email_txt2" value="<c:out value='${staff.email_txt}'/>" style="width:90%" maxlength="30" />
										</td>							
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>아이디</th>
										<td>
											<input type="text" id="login_id2" name="login_id2" value="<c:out value='${staff.login_id}'/>" style="width:150px;" maxlength="30"/>
											<input type="button" class="btn btn-success btn-xs" id="btnDup2" value="중복확인">
										</td>
										<th scope="row"></th>
										<td>
										</td>							
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>비번</th>
										<td>
											<input type="password" id="passwd_txt2" name="passwd_txt2" value="" style="width:90%" maxlength="30"/>
										</td>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>비번확인</th>
										<td>
											<input type="password" id="passwd_txt22" name="passwd_txt22" value="" style="width:90%" maxlength="30"/>
										</td>							
									</tr>
								</tbody>
							</table>
							
		
							
							
	    	
	    	</div>
	    </div>
	    

	</fieldset>
</form>




	<div class="lypopWrap" style="width:92%; display:none;" id="selectBusinessTypeLayerPop" >
		<!-- header -->
		<div class="header">
			<h3>업태/업종 선택</h3>
			<p class="btnR">
				<a href="#" class="sky" onclick="fnSelectedBusiness();">선택완료</a>
				<a href="#" class="gray" onclick="$('#selectBusinessTypeLayerPop').hide();">닫기</a>
			</p>
		</div>

		<div class="contents">
			<!-- 본문 -->
			<form method="post" action="" id="select_item_form">
				<fieldset>
					<legend>업태/업종 선택</legend>
					<div class="lypop_tbl_wrap infoadd">

					<table cellspacing="0" cellpadding="0" summary="" class="lypop_tbl">
					<caption>업태/업종 선택</caption>
						<colgroup>
							<col width="35%" />
							<col width="65%" />
						</colgroup>
						<tbody>
							<tr>
								<th class="skyblue">업태선택</th>
								<td class="skyblue b">업종선택</td>
							</tr>
							<tr>
								<th>
									<div id="div_business_type_txt" style="height:480px;">
										<ul>
										<c:forEach var="info" items="${businessKindList}">
											<li code="<c:out value="${info.code}"/>"><c:out value="${info.code_nm}"/></li>
										</c:forEach>
										</ul>
									</div>
								</th>
								<td>
									<div id="div_business_txt" style="height:480px;">
										<ul>
										</ul>
									</div>
								</td>
							</tr>
						</tbody>
					</table>

					
					</div>
				</fieldset>
			</form>
			<!-- //본문 -->
		</div>


	</div>

	<div class="lypopWrap" style="width:92%; display:none;" id="selectItemLayerPop" >
		<!-- header -->
		<div class="header">
			<h3>품목 선택</h3>
			<p class="btnR">
				<a href="#" class="sky" onclick="fnSelectedItem();">선택완료</a>
				<a href="#" class="gray" onclick="$('#selectItemLayerPop').hide();">닫기</a>
			</p>
		</div>
		<!-- //header -->
		<!-- contents -->
		<div class="contents">
			<!-- 본문 -->
			<form method="post" action="" id="select_item_form">
				<fieldset>
					<legend>품목선택</legend>
					<div class="lypop_tbl_wrap infoadd">

					
					<table cellspacing="0" cellpadding="0" summary="" class="lypop_tbl">
					<caption>품목선택</caption>
						<colgroup>
							<col width="10%" />
							<col width="9%" />
							<col width="9%" />
							<col width="9%" />
							<col width="9%" />
							<col width="9%" />
							<col width="9%" />
							<col width="9%" />
							<col width="9%" />
							<col width="9%" />
							<col width="9%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">&nbsp;</th>
								<th>0</th>
								<th>1</th>
								<th>2</th>
								<th>3</th>
								<th>4</th>
								<th>5</th>
								<th>6</th>
								<th>7</th>
								<th>8</th>
								<th>9</th>
							</tr>
							<tr>
								<th scope="row">0</th>
								<td></td>
								<td>산 동물</td>
								<td>육과 식용설육</td>
								<td>어류</td>
								<td>낙동품</td>
								<td>기타 동물성 생산품</td>
								<td>산 수목및 절화</td>
								<td>채소</td>
								<td>과실/견과류</td>
								<td>커피/향신료</td>
							</tr>
							<tr>
								<th scope="row">10</th>
								<td>곡물</td>
								<td>제분공업 생산품</td>
								<td>채유용종자</td>
								<td>식물성 수액과 액스</td>
								<td>기타 식물성 유지</td>
								<td>동/실물성 유지</td>
								<td>유/어류 조제품</td>
								<td>당류 설탕과자</td>
								<td>코코아</td>
								<td>곡물/곡분의 조제품</td>
							</tr>
							<tr>
								<th scope="row">20</th>
								<td>채소/과실의 조제품</td>
								<td>각종의 조제 식료품</td>
								<td>음료/알코올 식초</td>
								<td>사료</td>
								<td>담배</td>
								<td>암석광물</td>
								<td>금속광물</td>
								<td>광물성 연료 에너지</td>
								<td>무기화학품</td>
								<td>유기화학품</td>
							</tr>
							<tr>
								<th scope="row">30</th>
								<td>의료용품</td>
								<td>비료</td>
								<td>유연/착색제</td>
								<td>향료/화장품</td>
								<td>비누/왁스</td>
								<td>단백질계 물질</td>
								<td>화약류/성냥</td>
								<td>사진/영화용 재료</td>
								<td>각종 화학공엄생산품</td>
								<td>플라스틱</td>
							</tr>
							<tr>
								<th scope="row">40</th>
								<td>고무</td>
								<td>원피</td>
								<td>가죽제품</td>
								<td>모피</td>
								<td>목재 및 목탄</td>
								<td>코르크</td>
								<td>조물재료의 제품</td>
								<td>펄프</td>
								<td>지와 지제품</td>
								<td>인쇄서적/신문/회화</td>
							</tr>
							<tr>
								<th scope="row">50</th>
								<td>견</td>
								<td>모</td>
								<td>면</td>
								<td>기타 식물성 방직용 섬유</td>
								<td>인조 필라멘트</td>
								<td>인조스테이플 섬유</td>
								<td>워딩/펄프/부직포</td>
								<td>양탄자류</td>
								<td>특수직물</td>
								<td>침투/도포 직물</td>
							</tr>
							<tr>
								<th scope="row">60</th>
								<td>편물</td>
								<td>편물제 의류</td>
								<td>비편물제 의류</td>
								<td>기타 방직용 섬유제품</td>
								<td>신발류</td>
								<td>모자류</td>
								<td>산류/지팡이</td>
								<td>조제 우모/조화/인모제품</td>
								<td>석/시멘트 제품</td>
								<td>도자 제품</td>
							</tr>
							<tr>
								<th scope="row">70</th>
								<td>유리와 유리제품</td>
								<td>진주/귀석 귀금속</td>
								<td>철강</td>
								<td>철강제품</td>
								<td>동</td>
								<td>니켈</td>
								<td>알루미늄</td>
								<td>유보</td>
								<td>연</td>
								<td>아연</td>
							</tr>
							<tr>
								<th scope="row">80</th>
								<td>주석</td>
								<td>기타 비금속</td>
								<td>비금속에의 공구</td>
								<td>비금속제의 각종 제품</td>
								<td>기계류</td>
								<td>전기기기</td>
								<td>철도차량</td>
								<td>자동차</td>
								<td>항공기</td>
								<td>선박</td>
							</tr>
							<tr>
								<th scope="row">90</th>
								<td>광학/정밀의료기기</td>
								<td>시계</td>
								<td>악기</td>
								<td>무기</td>
								<td>가구/침구 조립식건축</td>
								<td>완구/운동용구</td>
								<td>잡품</td>
								<td>예술품/수집과 골동품</td>
								<td></td>
								<td></td>
							</tr>	

						</tbody>
					</table>
					

					</div>
				</fieldset>
			</form>
			<!-- //본문 -->
		</div>
		<!-- //contents -->
	</div>
	
	
	

 <div id="toast"></div></body>

</html>