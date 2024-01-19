<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript">
	
	var codeList11200 = "<c:out escapeXml="false" value="${applicationScope['GRIDCODELIST']['11200']}"/>";	//업체상태

	</script>
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">거래처등록현황</h3>
			<h3 class="screen-id">cuco01l</h3>
			<span class="bullet6">협력 관리 &gt; 거래처등록현황</span>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form method="post" id="searchForm" action="#">
				

				
					<fieldset>
					<legend>추가 검색조건</legend>
						<div class="product_tbl">
							<table cellspacing="0" cellpadding="0" class="tbl_type2 tbl_cell">
							<caption>추가 검색조건 정보</caption>
								<colgroup>
									<col width="100%" />
								</colgroup>
								<tbody>
									<tr>
										<td>
											<div class="tbl_wrap">
												<dl class="section">
													<dt><label for="a1">업체명 명</label></dt>
													<dd>
														<input type="text" name="vendor_nm" id="vendor_nm" style="width:50%;" maxlength="30" />
													</dd>
													<dt><label for="a5">전화번호</label></dt>
													<dd>
														<input type="text" name="tel_txt" id="tel_txt" style="width:50%;" maxlength="20" />
													</dd>
												</dl>
											</div>
										</td>
									</tr>
								</tbody>
								<!--  //추가 검색조건 열기 -->
							</table>
						</div>
					</fieldset>
				</form>
			</div>
					
			<div class="product_bt">
				<input type="button" class="btn btn-primary btn-sm" value="검색" id="btnSearch">
				<input type="button" class="btn btn-close btn-sm" value="초기화" id="btnReset">
			</div>
			<div class="report">
				<div class="min_btn">
					<input type="button" class="btn btn-primary btn-sm" value="신규등록" id="btnAdd">
				</div>
			</div>
			<div class="grid">
				<table id="list1"></table>
				<div id="pager1"></div>
			</div>
		</div>
		<!-- //product_admin -->
	</div>
	
	<!-- //content_wrap -->
	<script type="text/javascript" src="/js/cu/co/cuco01l.js"></script>
 <div id="toast"></div></body>
</html>