<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>TMS 관리</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-control" content="No-cache" />
<meta http-equiv="Pragma" content="No-cache" />
<meta name="Description" content="" />
<meta name="Keywords" content="" />

<%@include file="/common/include/header.jsp"%>

<style>

.red {color:red;}
.blue {color:blue;}
.black {color:black;}
.gray {color:gray;}

.tms-tbl {}
.tms-tbl th{border-right:1px solid #999; border-bottom:1px solid #999; border-top:1px solid #999; text-align:center;}
.tms-tbl td{border-right:1px solid #999; border-bottom:1px solid #999; }
.tms-tbl td span:hover{text-decoration: underline; color:blue;}
.tms-tbl tr th:first-child{border-left:1px solid #999; }
.tms-tbl tr td:first-child{ }
.tms-tbl tr:hover{background-color:yellow;}
.tms-tbl tr td.first{border-left:1px solid #999; }

</style>

<script type="text/javascript">

	$(document).ready(function() {


		
	});
	


	
</script>	
</head>

<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">

		<!-- product_admin -->
		<div class="product_admin">


			<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl tms-tbl" style="border-top: 0px;">
				<caption>고객사 상세 정보</caption>
					<colgroup>
						<col width="60px" />
						<col width="100px" />
						<col />
						<col width="300px" />
						<col width="300px" />
						<col width="90px" />
						<col width="90px" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">구분</th>
							<th scope="row">메뉴</th>
							<th scope="row">프로그램명</th>
							<th scope="row">최근comment</th>
							<th scope="row">기획서</th>
							<th scope="row">진행상태</th>
							<th scope="row">완료예정일</th>
						</tr>
						<c:set var="part1" value = "" />
						<c:set var="part2" value = "" />
						<c:forEach var="list" items="${tmsList1}">
						<tr>
							<c:if test="${part1 == ''}">
							<td class="ac first" rowspan="${list.cnt1}">${list.part1}</td>
							</c:if>
							<c:if test="${part2 != list.part2}">
							<td rowspan="${list.cnt2}">${list.part2}</td>
							</c:if>
							<td><span onclick="CenterOpenWindow('/system/tms/tmsDetailView?tms_no=${list.tms_no}', 'open', '850', '620', 'scrollbars=yes, status=no');"> ${list.title}</span></td>
							<td><span onclick="CenterOpenWindow('/system/tms/tmsDetailView?tms_no=${list.tms_no}', 'open', '850', '620', 'scrollbars=yes, status=no');">${list.comment_txt}</span></td>
							<td><span onclick="CenterOpenWindow('/system/tms/tmsDetailView?tms_no=${list.tms_no}', 'open', '850', '620', 'scrollbars=yes, status=no');">${list.filename_txt}</span></td>
							<td class="ac ${list.css_nm}">${list.sts_nm}</td>
							<td class="ac">${list.due_dt}</td>
						</tr>
						<c:set var="part1" value = "${list.part1}" />
						<c:set var="part2" value = "${list.part2}" />
						</c:forEach>
					</tbody>
				</table>

			<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl tms-tbl mt20" style="border-top: 0px;">
				<caption>고객사 상세 정보</caption>
					<colgroup>
						<col width="60px" />
						<col width="100px" />
						<col />
						<col width="300px" />
						<col width="300px" />
						<col width="90px" />
						<col width="90px" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">구분</th>
							<th scope="row">메뉴</th>
							<th scope="row">프로그램명</th>
							<th scope="row">최근comment</th>
							<th scope="row">기획서</th>
							<th scope="row">진행상태</th>
							<th scope="row">완료예정일</th>
						</tr>
						
						<c:set var="part1" value = "" />
						<c:set var="part2" value = "" />
						
						<c:forEach var="list" items="${tmsList2}">
						<tr>
							<c:if test="${part1 == ''}">
							<td class="ac first" rowspan="${list.cnt1}">${list.part1}</td>
							</c:if>
							<c:if test="${part2 != list.part2}">
							<td rowspan="${list.cnt2}">${list.part2}</td>
							</c:if>
							<td><span onclick="CenterOpenWindow('/system/tms/tmsDetailView?tms_no=${list.tms_no}', 'open', '850', '620', 'scrollbars=yes, status=no');"> ${list.title}</span></td>
							<td><span onclick="CenterOpenWindow('/system/tms/tmsDetailView?tms_no=${list.tms_no}', 'open', '850', '620', 'scrollbars=yes, status=no');">${list.comment_txt}</span></td>
							<td><span onclick="CenterOpenWindow('/system/tms/tmsDetailView?tms_no=${list.tms_no}', 'open', '850', '620', 'scrollbars=yes, status=no');">${list.filename_txt}</span></td>
							<td class="ac ${list.css_nm}">${list.sts_nm}</td>
							<td class="ac">${list.due_dt}</td>
						</tr>
						<c:set var="part1" value = "${list.part1}" />
						<c:set var="part2" value = "${list.part2}" />
						</c:forEach>
					</tbody>
				</table>

			<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl tms-tbl mt20" style="border-top: 0px;">
				<caption>고객사 상세 정보</caption>
					<colgroup>
						<col width="60px" />
						<col width="100px" />
						<col />
						<col width="300px" />
						<col width="300px" />
						<col width="90px" />
						<col width="90px" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">구분</th>
							<th scope="row">메뉴</th>
							<th scope="row">프로그램명</th>
							<th scope="row">최근comment</th>
							<th scope="row">기획서</th>
							<th scope="row">진행상태</th>
							<th scope="row">완료예정일</th>
						</tr>
						<c:set var="part1" value = "" />
						<c:set var="part2" value = "" />
						<c:forEach var="list" items="${tmsList3}">
						<tr>
							<c:if test="${part1 == ''}">
							<td class="ac first" rowspan="${list.cnt1}">${list.part1}</td>
							</c:if>
							<c:if test="${part2 != list.part2}">
							<td rowspan="${list.cnt2}">${list.part2}</td>
							</c:if>
							<td><span onclick="CenterOpenWindow('/system/tms/tmsDetailView?tms_no=${list.tms_no}', 'open', '850', '620', 'scrollbars=yes, status=no');"> ${list.title}</span></td>
							<td><span onclick="CenterOpenWindow('/system/tms/tmsDetailView?tms_no=${list.tms_no}', 'open', '850', '620', 'scrollbars=yes, status=no');">${list.comment_txt}</span></td>
							<td><span onclick="CenterOpenWindow('/system/tms/tmsDetailView?tms_no=${list.tms_no}', 'open', '850', '620', 'scrollbars=yes, status=no');">${list.filename_txt}</span></td>
							<td class="ac ${list.css_nm}">${list.sts_nm}</td>
							<td class="ac">${list.due_dt}</td>
						</tr>
						<c:set var="part1" value = "${list.part1}" />
						<c:set var="part2" value = "${list.part2}" />
						</c:forEach>
					</tbody>
				</table>
			
		</div>
		<!-- //product_admin -->
	</div>
	
	<div class="layer-mask" style="display:none;"></div>

	<!-- 회주선택 -->
	<div class="lypopWrap" style="width:380px; max-height:400px; overflow-y:auto; display:none; " id="tmsInfoLayerPop" >
		<!-- header -->
		<div class="header">
			<h3 class="tit">[프로그램명]</h3>
			<p class="btnR">
				<input type="button" class="btn btn-close btn-xs" onclick="fnCloseLayer('tmsInfoLayerPop');" value="닫기">
			</p>
		</div>
		<!-- //header -->
		<!-- contents -->
		<div class="contents select-layer1">
			<ul>
				<c:forEach var="entity" items="${customerList}">
					<li cd="<c:out value="${entity.vendor_no}"/>" nm="<c:out value="${entity.vendor_nm}"/>"><c:out value="${entity.vendor_nm}"/></li>
				</c:forEach>   
			</ul>
		</div>
		<!-- //contents -->
	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>
