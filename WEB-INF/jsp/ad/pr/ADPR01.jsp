<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script>
	var unitTypeList = "<c:out escapeXml="false" value="${applicationScope['GRIDCODELIST']['11700']}"/>";	//화폐단위
	//var chargeTypeList = "<c:out escapeXml="false" value="${applicationScope['GRIDCODELIST']['10900']}"/>";	//비용청구대상
	
	var typeList = null;
		<c:if test="${not empty typeList}">
			typeList = ${typeList};
		</c:if>
	</script>
	
	<script type="text/javascript" src="/js<%=jsUrl%>.js"></script>
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header"></h3>
			<div class="btn-wrap">
				<input type="button" class="btn btn-success btn-sm" value="검색[F3]" 		id="btnSearch">
				<input type="button" class="btn btn-primary btn-sm" value="저장[F10]" 	id="btnSave">
				<input type="button" class="btn btn-danger btn-sm" value="삭제[F11]" 	id="btnDel">	
			</div>
		</div>

		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form method="get" id="searchForm">
					<fieldset>
						<legend>노선관리 관리</legend>
						<div class="product_tbl">
							<table cellspacing="0" cellpadding="0" class="tbl_type2 tbl_cell">
								<colgroup>
									<col width="100%" />
								</colgroup>
								<tbody>
									<tr>
										<td>
											<div class="tbl_wrap">

												<dl class="section">
													<dt>운송구분1</dt>
													<dd>
														<select style="width:100px" id="appr_cd" name="appr_cd">
															<option value="">전체</option>
				                                             <c:forEach var="entity" items="${applicationScope['CODE']['10200']}">
				                                                <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
				                                             </c:forEach>   
														</select>
													</dd>
													<dt>운송구분2</dt>
													<dd>
														<select style="width:90%" id="appr_cd" name="appr_cd">
															<option value="">전체</option>
				                                             <c:forEach var="entity" items="${applicationScope['CODE']['10800']}">
				                                                <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
				                                             </c:forEach>   
														</select>
													</dd>
													
												</dl>

						
											</div>
											<div class="tbl_wrap active mark"></div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</fieldset>
				</form>
			</div>
			
			<div class="two-block-wrap">
				<div class="left" style="width:40%;">
					<div class="grid">
						<table id="list1"></table>
					</div>
				
				</div>
				<div class="right" style="width:59%;">
				
					<div class="two-block-wrap">
						<div class="left" style="width:70%;">
							TITLE : <span id="tit_route_nm" class="mr20" style="width:300px; font-weight:bold;"></span>
						</div>
						<div class="right ar" style="width:28%;">
							<input type="button" class="btn btn-primary btn-xs" id="btnAddRow" value="추가">
						</div>
					
					</div>
				
					<div class="grid">
						<table id="list2"></table>
					</div>
				</div>
			</div>
			


		</div>
		<!-- //product_admin -->


	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>