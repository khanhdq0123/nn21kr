<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript" src="/js<%=jsUrl%>.js"></script>
</head>
<body class="sky">
<form method="get" id="searchForm">
<input type="hidden" id="tp_no" name="tp_no" value="${tp_no}" />

	<div class="content_wrap">
		<div class="history">
			<h3 class="header"></h3>		
			<div class="btn-wrap">
			</div>
		</div>
		<div class="product_admin">
			
			<div class="refer bullet6">
				<ul>
<!-- 					<input type="button" class="btn btn-success btn-sm" value="고객현황" 	id="btnBack"> -->
				</ul>
				<div class="refer_bt" >
					<div class="min_btn mini">	


					<input type="button" class="btn btn-primary btn-sm" value="운송정보수정" id="btnXxx1">
					<input type="button" class="btn btn-primary btn-sm" value="컨테이너수정" id="btnXxx1">
					<input type="button" class="btn btn-primary btn-sm" value="파일업로드" id="btnXxx1">
	
					</div>
				</div>
			</div>
			
			<div class="tagCover mt20">

				<div class="typeleft qnaWlist">
				
					<h3 class="styleH3">배송정보</h3>
	
					<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl" style="border-top: 0px;">
					<caption>배송정보</caption>
						<colgroup>
							<col width="100px">
							<col width="150px">
							<col width="100px">
							<col width="150px">
						</colgroup>
						<tbody>							
							<tr>
								<th scope="row">선박 이름</th>
								<td>${info.comp_nm}</td>
								<th scope="row"><label>마스터 비엘 </label></th>
								<td>${info.master_bl}</td>
							</tr>
							<tr>
								<th scope="row"><label>선적항</label></th>
								<td>${info.send_region_nm}</td>
								<th scope="row"><label>출발예정일</label></th>
								<td>${info.start_dt}</td>
							</tr>
							<tr>
								<th scope="row"><label>도착항</label></th>
								<td>${info.receive_region_nm}</td>
								<th scope="row"><label>도착예정일</label></th>
								<td>${info.arrive_dt}</td>
							</tr>
							<tr>
								<th scope="row">출발지</th>
								<td>${info.send_region_nm}</td>
								<th scope="row"><label>도착지</label></th>
								<td>${info.receive_region_nm}</td>
							</tr>
							<tr>
								<th scope="row"><label>차번호</label></th>
								<td>${info.car_no}</td>
								<th scope="row"><label>항차</label></th>
								<td>${info.ship_shipping}</td>
							</tr>
							<tr>
								<th scope="row"><label>MRN</label></th>
								<td>
								<input type="text" id="mrn" name="mrn" style="width:80%;" value="${info.mrn}" />
								</td>
								<th scope="row"><label>MSN</label></th>
								<td>
									<input type="text" id="msn" name="msn" style="width:70%;" value="${info.msn}" />
									<input type="button" class="btn btn-primary btn-xs" value="입력" id="btnTpMsn" >
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				
				
				
				<div class="typeright qnaWlist">
				
					<h3 class="styleH3">&nbsp;</h3>
	
					<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl" style="border-top: 0px;">
					<caption>배송정보</caption>
						<colgroup>
							<col width="100px">
							<col width="400px">
						</colgroup>
						<tbody>							
							<tr>
								<th scope="row">청구금액</th>
								<td></td>
							</tr>
							<tr>
								<th scope="row"><label>파일 목록</label></th>
								<td></td>
							</tr>
							<tr>
								<th scope="row"><label>코멘트</label></th>
								<td>
									<input type="text" id="tp_comment" name="tp_comment" style="width:70%;" value="" />
									<input type="button" class="btn btn-primary btn-xs" value="입력" id="btnInsertTpComment" >
								</td>
							</tr>
							<tr>
								<td colspan="2" id="tp_comment_wrap">
									<p><span>코멘트</span> <span class="ml10">ilic000</span><input type="button" class="btn btn-danger btn-xs ml10" value="삭제"></p>
								</td>
							</tr>
						</tbody>
					</table>
					

					
				</div>
			</div>
			
			<div class="grid mt20">
				<table id="list1"></table>
			</div>
		</div>
	</div>
	
</form>
<div id="toast"></div></body>
</html>