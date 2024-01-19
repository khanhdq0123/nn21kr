<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript" src="/js<%=jsUrl%>.js"></script>
	<style>
	.red {color:red;}
	.blue {color:blue;}
	.black {color:black;}
	.gray {color:gray;}
	</style>
	
	<script type="text/javascript">
	var apprCodeList = "<c:out escapeXml="false" value="${applicationScope['GRIDCODELIST']['10600']}"/>";
	var stsCodeList = "<c:out escapeXml="false" value="${applicationScope['GRIDCODELIST']['10700']}"/>";
	</script>	
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header"></h3>
			<div class="btn-wrap">
				<input type="button" class="btn btn-success btn-sm" value="검색[F3]" id="btnSearch">
				<input type="button" class="btn btn-info btn-sm" value="신규등록[F9]" id="btnAdd">		
				<input type="button" class="btn btn-primary btn-sm" value="저장[F10]" id="btnSaveTms">
				<input type="button" class="btn btn-danger btn-sm" value="삭제[F11]" id="btnDel">			
			</div>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->

			
			<div class="product_form">
				<form id="searchForm" name="searchForm" method="post" action="#">
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
													<dt><label for="login_id">프로그램명</label></dt>
													<dd>
														<input type="text" id="login_id" name="login_id" style="width:90%;" maxlength="20" />
													</dd>
													<dt><label for="staff_nm">구분1</label></dt>
													<dd>
														<select style="width:120px;" id="part1" name="part1">
															<option value="">전체</option>
															<option value="고객">고객</option>
															<option value="지사">지사</option>
															<option value="관리">관리</option>
														</select>
														
														
													</dd>
												</dl>
												<dl class="section">
													<dt><label for="groupauth_nm">승인상태</label></dt>
													<dd>
														<select style="width:90%" id="appr_cd" name="appr_cd">
															<option value="">전체</option>
				                                             <c:forEach var="entity" items="${applicationScope['CODE']['10600']}">
				                                                <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
				                                             </c:forEach>   
														</select>
													</dd>
													<dt><label for="use_yn">진행상태</label></dt>
													<dd>
														<select style="width:90%" id="sts_cd" name="sts_cd">
															<option value="">전체</option>
															<c:forEach var="entity" items="${applicationScope['CODE']['10700']}">
				                                                <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
				                                             </c:forEach>   
														</select>
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
				<table id="tmsGrid"></table>
			</div>

		</div>
		<!-- //product_admin -->
	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>