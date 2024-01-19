<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
	<head>
		<%@include file="/common/include/header.jsp"%>
		<script type="text/javascript" src="/js/ad/ex/ADEX01P.js"></script>
		
	<title>환율등록</title>
	<script type="text/javascript">
	//스크립트 를 작성
	</script>
	<style>
		.st_port_wrap input {background-color:#eee;}
		.ar_port_wrap input {background-color:#eee;}
	</style>
	</head>
<body class="sky">

<div class="layerpop_inner" id="#">

	<h1 class="ly_header">환율 등록</h1>
	<!-- .ly_body -->
	<div class="ly_body">
		<div class="refer bullet6">
			<div class="refer_bt">
				<div class="min_btn mini">
					<button class="sky" id="btnSave">저장</button>
					<button class="gray" id="btnClose">닫기</button>
				</div>
			</div>
		</div>
		<form id="gForm" name="gForm" method="post" action="#">
		<input type="hidden" id="route_typ" name="route_typ" value="1" />
		<input type="hidden" id="use_yn" name="use_yn" value="Y" />		
		 
			<fieldset>
			<legend>환율 등록 상세 페이지</legend>
			<div class="layer_contents">
				<table cellspacing="0" cellpadding="0" class="layer_tbl">
				<caption>환율 등록 상세 페이지</caption>
					<colgroup>
						<col width="15%" />
						<col width="30%" />
						<col width="15%" />
						<col width="40%" />
					</colgroup>
					<tbody>
						<tr>
							<th>국가코드</th>
							<td>
								<select style="width:90%" id="exch_cd" name="exch_cd">
									<option value="">--선택하세요--</option>
                                           <c:forEach var="entity" items="${applicationScope['CODE']['12000']}">
                                              <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
                                           </c:forEach>   
								</select>
							</td>
							<th>타입</th>
							<td>								
								<select style="width:90%" id="type" name="type">
									<option value="">--선택하세요--</option>
                                           <c:forEach var="entity" items="${applicationScope['CODE']['12100']}">
                                              <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
                                           </c:forEach>   
								</select>
							</td>
						</tr>
						<tr>
							<th>시작일</th>
							<td>
								<span class="calendar">
									<input type="text" style="width:96%" class="datepicker2" id="start_dt" name="start_dt" />
								</span>
							</td>		
							<th>종료일</th>
							<td>
								<span class="calendar">
									<input type="text" class="datepicker2" id="end_dt" name="end_dt" />
								</span>
							</td>	
							<%-- 
							<td class="st_port_wrap">
								<select style="width:90%" id="ex_typ1" name="ex_typ1">
									<option value="">--선택하세요--</option>
                                          <c:forEach var="entity" items="${applicationScope['CODE']['12100']}">
                                             <option value="<c:out value="${entity.code_cd}"/>"><c:out value="${entity.code_nm}"/></option>
                                          </c:forEach>   
								</select>
							</td>			 --%>				 
						</tr>
						<tr>							 
							<th>외화비용</th>
							<td>
								<input type="text" name="foreign_cost" id="foreign_cost" value=""  />
							</td>
							<th>환전비용</th>
							<td>
								<input type="text" name="local_curr_exh_cost" id="local_curr_exh_cost" value=""/>
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