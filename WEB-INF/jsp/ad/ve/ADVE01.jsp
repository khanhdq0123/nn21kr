<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
	<script type="text/javascript">
		var statsTypList = "<c:out escapeXml="false" value="${applicationScope['GRIDCODELIST']['11200']}"/>";
	</script>
	<script type="text/javascript" src="/js<%=jsUrl%>.js"></script>
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header"></h3>
			<div class="btn-wrap">
				<input type="button" class="btn btn-success btn-sm" value="검색[F3]" id="btnSearch">
				<input type="button" class="btn btn-primary btn-sm" value="신규등록[F9]" id="btnAdd">
<!-- 				<input type="button" class="btn btn-danger btn-sm" value="지사간 연결" id="btnConnectionVendor"> -->
			</div>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form method="post" id="searchForm" name="searchForm" action="#">
				<input type="hidden" id="nation_cd" 	name="nation_cd" 		value="" />
					<fieldset>
					<legend>검색조건</legend>
						<div class="product_tbl">
							<table cellspacing="0" cellpadding="0" class="tbl_type2 tbl_cell">
							<caption>검색조건 정보</caption>
								<colgroup>
									<col width="100%" />
								</colgroup>
								<tbody>
									<tr>
										<td>
											<div class="tbl_wrap">
												<dl class="section">
													<dt><label for="a1">업체명</label></dt>
													<dd>
														<input type="text" name="vendor_nm" id="vendor_nm" style="width:50%;" maxlength="30" />
													</dd>
												</dl>
												<dl class="section">
													<dd>
														<c:forEach var="entity" items="${regionVendorList}">
														<input type="button" class="btn btn-primary btn-xs" onclick="fnSetNation('${entity.nation_cd}');" value="&nbsp;  ${entity.nation_nm}  (${entity.cnt})  &nbsp;" id="btn${entity.nation_nm}">
														</c:forEach>
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


			<div class="grid">
				<table id="list1"></table>
			</div>
		</div>
		<!-- //product_admin -->
	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>