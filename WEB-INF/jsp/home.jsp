<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
		<%@include file="/common/include/header.jsp"%>
<script type="text/javascript">
 <!--
 //레이어 팝업 열기
 function openLayer(IdName, tpos, lpos){
  var pop = document.getElementById(IdName);
  pop.style.display = "block";
  pop.style.top = tpos + "px";
  pop.style.left = lpos + "px";
 }
 //레이어 팝업 닫기
 function closeLayer(IdName){
  var pop = document.getElementById(IdName);
  pop.style.display = "none";
 }
   //-->
 </script>

</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">

		<div class="tagCover">
			<!-- 사내계시판 -->
			<div class="typeleft qnaWlist">
			
				<!-- 받은문서 -->
				<h3 class="styleH3">받은문서</h3>

				<ul>
				<c:if test="${fn:length(receiveDocList) == 0 }">
					<li>
						<span class="titSpan"><a href="#">등록된 리스트가 없습니다.</a></span>
						<span class="idSpan">&nbsp;</span>
						<span class="dateSpan">&nbsp;</span>
					</li>
				</c:if>
				
                <c:forEach var="list" items="${receiveDocList}">
					<li>
						<span class="titSpan"><a href="javascript:CenterOpenWindow('/document/docDetailView?id=${list.doc_no}', 'open', '850', '555', 'scrollbars=yes, status=no');">${list.title_txt}</a></span>
						<span class="idSpan">${list.reg_id}</span>
						<span class="dateSpan">${list.reg_dt}</span>
					</li>
				</c:forEach>
				</ul>
				<span class="qnaMore"><button type="button">더보기</button></span>
				<!-- //받은문서 -->				
			
				<h3 class="styleH3">사내공지</h3>
				<ul>
				<c:if test="${fn:length(noticeList) == 0 }">
					<li>
						<span class="titSpan"><a href="#">등록된 리스트가 없습니다.</a></span>
						<span class="idSpan">&nbsp;</span>
						<span class="dateSpan">&nbsp;</span>
					</li>
				</c:if>
				
                <c:forEach var="list" items="${noticeList}">
					<li>
						<span class="titSpan"><a href="javascript:CenterOpenWindow('/notice/noticeDetailView?id=${list.notice_no}', 'open', '850', '555', 'scrollbars=yes, status=no');">${list.title_txt}</a></span>
						<span class="idSpan">${list.reg_id}</span>
						<span class="dateSpan">${list.reg_dt}</span>
					</li>
				</c:forEach>
				</ul>
				<span class="qnaMore"><button type="button">더보기</button></span>
				
				
				<h3 class="styleH3">회원공지</h3>
				<ul>
				<c:if test="${fn:length(adminNoticeList) == 0 }">
					<li>
						<span class="titSpan"><a href="#">등록된 리스트가 없습니다.</a></span>
						<span class="idSpan">&nbsp;</span>
						<span class="dateSpan">&nbsp;</span>
					</li>
				</c:if>
				
                <c:forEach var="list" items="${adminNoticeList}">
					<li>
						<span class="titSpan"><a href="javascript:CenterOpenWindow('/notice/admNoticeDetailView?id=${list.adm_notice_no}', 'open', '850', '555', 'scrollbars=yes, status=no');">${list.title_txt}</a></span>
						<span class="idSpan">${list.reg_id}</span>
						<span class="dateSpan">${list.reg_dt}</span>
					</li>
				</c:forEach>
				</ul>
				<span class="qnaMore"><button type="button">더보기</button></span>
				
			</div>
			<!-- //사내계시판 -->




			<!-- 상품문의 답변 대기 리스트 -->
			<div class="typeright qnaWlist">
			
			
			
				<!-- 보낸문서 -->
				<h3 class="styleH3">보낸문서</h3>

				<ul>
				<c:if test="${fn:length(sendDocList) == 0 }">
					<li>
						<span class="titSpan"><a href="#">등록된 리스트가 없습니다.</a></span>
						<span class="idSpan">&nbsp;</span>
						<span class="dateSpan">&nbsp;</span>
					</li>
				</c:if>
				
                <c:forEach var="list" items="${sendDocList}">
					<li>
						<span class="titSpan"><a href="javascript:CenterOpenWindow('/document/docDetailView?id=${list.doc_no}', 'open', '850', '555', 'scrollbars=yes, status=no');">${list.title_txt}</a></span>
						<span class="idSpan">${list.reg_id}</span>
						<span class="dateSpan">${list.reg_dt}</span>
					</li>
				</c:forEach>
				</ul>
				<span class="qnaMore"><button type="button">더보기</button></span>
				<!-- //보낸문서 -->		
			
			
				<c:if test="${sessionScope['STAFFINFORMATION']['staff_typ'] eq '1'}">
			
					<h3 class="styleH3">시스템 게시판</h3>
					<ul>
					<c:if test="${fn:length(sysBoardList) == 0 }">
						<li>
							<span class="titSpan"><a href="#">등록된 리스트가 없습니다.</a></span>
							<span class="idSpan">&nbsp;</span>
							<span class="dateSpan">&nbsp;</span>
						</li>
					</c:if>
					
	                <c:forEach var="list" items="${sysBoardList}">
						<li>
							<span class="titSpan"><a href="javascript:CenterOpenWindow('/system/board/sysBoardDetailView?id=${list.board_no}', 'open', '850', '555', 'scrollbars=yes, status=no');">${list.title_txt}</a></span>
							<span class="dateSpan">${list.reg_dt}</span>
						</li>
					</c:forEach>
					</ul>
					<span class="qnaMore"><button type="button">더보기</button></span>
					
				</c:if>	

				
				
			</div>
			<!-- //상품문의 답변 대기 리스트 -->
		</div>

	</div>
	<!-- //content_wrap -->
 <div id="toast"></div></body>
</html>
		