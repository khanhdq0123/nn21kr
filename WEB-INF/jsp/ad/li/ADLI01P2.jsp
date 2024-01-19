<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/common/include/header.jsp"%>
		
		<title>노선 등록</title>
		<style>
		.st_port_wrap input {background-color:#eee;}
		.ar_port_wrap input {background-color:#eee;}
		</style>
		
		<script type="text/javascript" src="/js/ad/li/ADLI01P2.js"></script>
	</head>

<body class="sky">

<div class="layerpop_inner" id="#">

	<h1 class="ly_header">노선 등록</h1>
	<!-- .ly_body -->
	<div class="ly_body">
		<div class="refer bullet6">
			<div class="refer_bt">
				<div class="min_btn mini">
					<input type="button" class="btn btn-primary btn-sm" value="저장[F10]" 	id="btnSave">
					<input type="button" class="btn btn-danger btn-sm" 	value="삭제[F11]" 	id="btnDel">
					<input type="button" class="btn btn-close btn-sm" 	value="닫기" 			id="btnClose">
				</div>
			</div>
		</div>
		<form id="gForm" name="gForm" method="post" action="#">
		<input type="hidden" id="route_no" name="route_no" value="${info.route_no}" />
		<input type="hidden" id="use_yn" name="use_yn" value="${info.use_yn}" />
		
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
							<th><span class="starMark">필수입력 항목입니다.</span>운송구분</th>
							<td>
								<select style="width:90%" id="trans_typ" name="trans_typ" required>
									<option value="">전체</option>
                                           <c:forEach var="entity" items="${applicationScope['CODE']['10200']}">
                                              <option value="<c:out value="${entity.code_cd}"/>" <c:if test ="${info.trans_typ eq entity.code_cd}">selected="selected"</c:if> >
                                              <c:out value="${entity.code_nm}"/></option>
                                           </c:forEach>   
								</select>
							</td>
							<th><span class="starMark">필수입력 항목입니다.</span>운송방법</th>
							<td>
								<select style="width:90%" id="trans_way" name="trans_way" required>
									<option value="${info.trans_way}">${info.trans_way_nm}</option>
<%--                                            <c:forEach var="entity" items="${applicationScope['CODE']['10800']}"> --%>
<%--                                               <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option> --%>
<%--                                            </c:forEach>    --%>
								</select>
							</td>						
						</tr>
						
						<tr>
							<th><span class="starMark">필수입력 항목입니다.</span>출발지</th>
							<td colspan="3" class="st_port_wrap">
								<input type="text" id="st_port_no" name="st_port_no" style="width:80px;" value="${info.st_port_no}" readonly required />
								<input type="text" name="st_port_nm" id="st_port_nm" value="${info.st_port_nm}" style="width:420px;" onclick="fnSelectView(1);" required />
							</td>
						</tr>
						
						<tr>
							<th><span class="starMark">필수입력 항목입니다.</span>도착지</th>
							<td colspan="3"  class="ar_port_wrap">
								<input type="text" id="ar_port_no" name="ar_port_no" style="width:80px;" value="${info.ar_port_no}" readonly required />
								<input type="text" name="ar_port_nm" id="ar_port_nm" value="${info.ar_port_nm}" style="width:420px;" onclick="fnSelectView(2);" required />
							</td>
						</tr>
						<tr>
							<th><span class="starMark">필수입력 항목입니다.</span>관할지사</th>
							<td colspan="3"  class="ar_port_wrap">
								<select id="vendor_no" name="vendor_no" required>
									<option value="">전체</option>
                                           <c:forEach var="entity" items="${vendorList}">
                                              <option value="<c:out value="${entity.vendor_no}"/>" <c:if test ="${info.vendor_no eq entity.vendor_no}">selected="selected"</c:if> > 
                                              [<c:out value="${entity.vendor_no}"/>] <c:out value="${entity.vendor_nm}"/></option>
                                           </c:forEach>   
								</select>
							</td>
						</tr>
						<tr>
							<th><span class="starMark">필수입력 항목입니다.</span>컨테이너 규격</th>
							<td colspan="3">
								<select id="ct_size" name="ct_size" required>
									<option value="">전체</option>
                                           <c:forEach var="entity" items="${applicationScope['CODE']['12300']}">
                                              <option value="<c:out value="${entity.code_cd}"/>" <c:if test ="${info.ct_size eq entity.code_cd}">selected="selected"</c:if> >
                                              <c:out value="${entity.code_nm}"/></option>
                                           </c:forEach>   
								</select>
							</td>
						</tr>
						<tr>
							<th><span class="starMark">필수입력 항목입니다.</span>TITLE</th>
							<td colspan="3">
								<input type="text" name="route_nm" id="route_nm" value="${info.route_nm}" style="width: 90%;" required />
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