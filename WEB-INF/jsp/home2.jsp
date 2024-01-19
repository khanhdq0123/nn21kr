<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
    <script type="text/javascript">   

    $(document).ready(function() {
    	currentTime();

    	fn_getCustomsExchangeRate($("#customsExchangeRate option:selected").val());
    	
    	$("#customsExchangeRate").on("change",function(){
    		fn_getCustomsExchangeRate($(this).val());
    	});
    	

  
    	
    	setTimeout(function(){

	    	$(".receiveDocCnt").text('123');    		
    	}, 1000);
    	
    });
    
	
	   function currentTime() {           
	       var t = setTimeout(currentTime, 1000); /* setting timer */
	
	       var date = new Date();
	       var m1 = "AM";        
	       var m2 = "AM";        
	       var m3 = "AM";        
	       var m4 = "AM";        
	       var m5 = "AM";        
	       var hour = date.getUTCHours();
	       var min = date.getUTCMinutes();
	       var sec = date.getUTCSeconds();
	
	       var c1 = hour + 9;
	       var c2 = hour + 8;
	       var c3 = hour + 7;
	       var c4 = hour - 4;
	       var c5 = hour - 7;
	
	       if (c1 < 0) { c1 = c1 + 24 };
	       if (c2 < 0) { c2 = c2 + 24 };
	       if (c3 < 0) { c3 = c3 + 24 };
	       if (c4 < 0) { c4 = c4 + 24 };
	       if (c5 < 0) { c5 = c5 + 24 };
	
	       m1 = (c1 >= 12) ? "PM" : "AM"; 
	       m2 = (c2 >= 12) ? "PM" : "AM"; 
	       m3 = (c3 >= 12) ? "PM" : "AM"; 
	       m4 = (c4 >= 12) ? "PM" : "AM"; 
	       m5 = (c5 >= 12) ? "PM" : "AM"; 
	
	       c1 = (c1 == 0) ? 12 : ((c1 > 12) ? (c1 - 12) : c1);
	       c2 = (c2 == 0) ? 12 : ((c2 > 12) ? (c2 - 12) : c2);
	       c3 = (c3 == 0) ? 12 : ((c3 > 12) ? (c3 - 12) : c3);
	       c4 = (c4 == 0) ? 12 : ((c4 > 12) ? (c4 - 12) : c4);
	       c5 = (c5 == 0) ? 12 : ((c5 > 12) ? (c5 - 12) : c5);
	
	       if (c1 < 10) { c1 = "0" + c1 };
	       if (c2 < 10) { c2 = "0" + c2 };
	       if (c3 < 10) { c3 = "0" + c3 };
	       if (c4 < 10) { c4 = "0" + c4 };
	       if (c5 < 10) { c5 = "0" + c5 };
	       if (min < 10) { min = "0" + min };
	       if (sec < 10) { sec = "0" + sec };
	       
	
	       document.getElementById("clock1").innerText = m1 + " " + c1 + " : " + min + " : " + sec;
	       document.getElementById("clock2").innerText = m2 + " " + c2 + " : " + min + " : " + sec;
	       document.getElementById("clock3").innerText = m3 + " " + c3 + " : " + min + " : " + sec;
	       document.getElementById("clock4").innerText = m4 + " " + c4 + " : " + min + " : " + sec;
	       document.getElementById("clock5").innerText = m5 + " " + c5 + " : " + min + " : " + sec;
	   }
	
	   function updateTime(k) { /* appending 0 before time elements if less than 10 */
	       if (k < 10) {
	           return "0" + k;
	       }
	       else {
	           return k;
	       }
	   }
   
   
	function fn_getCustomsExchangeRate(customs_exch_no){

		$.ajax({
			type: "POST",
			url: "/common/getCustomsExchangeRate",
			data: {customs_exch_no:customs_exch_no},
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
	
				if(data.info == null){
					toast('등록된 환율데이터가 없습니다.');
					return false;
				}
				
				$("#cost_usd").html(data.info.cost_usd);
				$("#cost_cny").html(data.info.cost_cny);
				$("#cost_usd2").html(data.info.cost_usd);
				$("#cost_cny2").html(data.info.cost_cny);

			}
		});
		
	}        
   
</script>
    
    <style>
    .clock-wrap{
    
    }
    
    .clock-wrap th{
    	padding:5px 30px 5px 30px !important;
    }
    
    .clock-tit{
    	padding:10px;
    	font-size:12px;
    	display:inline-block;
    }
    
    .clock{
    	padding:10px;
    	font-size:12px;
    }
    </style>
       
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">

		<div class="tagCover">


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
			
			
			
			
			
				<h3 class="styleH3"><s:message code="tit01" /></h3>
				<ul>
				<c:if test="${fn:length(amdNoticeList) == 0 }">
					<li>
						<span class="titSpan"><a href="#">등록된 리스트가 없습니다.</a></span>
						<span class="dateSpan">&nbsp;</span>
					</li>
				</c:if>
				
                <c:forEach var="list" items="${amdNoticeList}">
					<li>
						<fmt:parseDate value="${list.reg_dt}" var="reg_dt1" pattern="yyyy-MM-dd" />
						<span class="dateSpan"><fmt:formatDate value="${reg_dt1}" pattern="yyyy-MM-dd" /></span>						
						<span class="titSpan"><a href="javascript:CenterOpenWindow('/notice/admNoticeDetailView?id=${list.adm_notice_no}', 'open', '850', '555', 'scrollbars=yes, status=no');">${list.title_txt}</a></span>
					</li>
				</c:forEach>
				</ul>
				<span class="qnaMore"><button type="button">더보기</button></span>
				
				
				<h3 class="styleH3"><s:message code="tit03" /></h3>
				<ul>

				
				<select class="ml5" id="customsExchangeRate">
					<c:forEach var="list" items="${customsExchangeRateList}">
					<option value="${list.customs_exch_no}">${list.app_st_dt} ~ ${list.app_ed_dt}</option>
					</c:forEach>
				</select>
				
				
	
				

				<table border="0" cellpadding="0" cellspacing="1" style="width: 98%; height: 116px; margin-left: 5px; margin-top:10px; background-color: #AAAAAA; border-spacing:1px;">
                     <tbody>
	                     <tr>
	                         <td align="center" style="background-color: #FFFFFF; width: 70px;">국가명</td>
	                         <td align="center" style="background-color: #FFFFFF; width: 70px;">통화부호</td>
	                         <td align="center" style="background-color: #FFFFFF; width: 170px; ">수출</td>
	                         <td align="center" style="background-color: #FFFFFF; width: 170px; ">수입(과세)</td>
	                     </tr>
	                     <tr>
	                         <td align="center" style="background-color: #FFFFFF;">중국</td>
	                         <td align="center" style="background-color: #FFFFFF;">CNY</td>
	                         <td align="center" style="background-color: #FFFFFF;"><span id="cost_cny">187.0700</span></td>
	                         <td align="center" style="background-color: #FFFFFF;"><span id="cost_cny2">187.0700</span></td>
	                     </tr>
	                     <tr>
	                         <td align="center" style="background-color: #FFFFFF;">미국</td>
	                         <td align="center" style="background-color: #FFFFFF;">USD</td>
	                         <td align="center" style="background-color: #FFFFFF;"><span id="cost_usd">1320.5200</span></td>
	                         <td align="center" style="background-color: #FFFFFF;"><span id="cost_usd2">1320.5200</span></td>
	                     </tr>
                 	</tbody>
                 </table>

				</ul>
				
		
				
			</div>
			<!-- //사내계시판 -->
			

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
			
				<!-- 최근거래내역 -->
				<h3 class="styleH3"><s:message code="tit02" /></h3>
				<ul>
				<c:if test="${fn:length(noticeList) == 0 }">
					<li>
						<span class="titSpan"><a href="#">등록된 리스트가 없습니다.</a></span>
					</li>
				</c:if>
                <c:forEach var="list" items="${noticeList}">
					<li>
						<fmt:parseDate value="${list.reg_dt}" var="reg_dt2" pattern="yyyy-MM-dd" />
						<span class="dateSpan"><fmt:formatDate value="${reg_dt2}" pattern="yyyy-MM-dd" /></span>						
						<span class="titSpan"><a href="javascript:CenterOpenWindow('/notice/noticeDetailView?id=${list.notice_no}', 'open', '850', '555', 'scrollbars=yes, status=no');">${list.title_txt}</a></span>
					</li>
				</c:forEach>
				</ul>
				<span class="qnaMore"><button type="button">더보기</button></span>
				<!-- //최근거래내역 -->


				<!-- 주요국가 시간 -->


				<h3 class="styleH3"><s:message code="tit04" /></h3>
				
				<ul>
				
				
				
					<table border="0" cellpadding="0" cellspacing="1" style="width: 98%; height: 116px; margin-left: 5px; margin-top:10px; background-color: #AAAAAA; border-spacing:1px;">
					<caption>검색조건 정보</caption>
						<colgroup>
							<col width="30%" />
							<col width="70%" />
						</colgroup>
						<tbody>
							<tr>
								<th style="background-color: #FFFFFF;"><span class="clock-tit">한국</span></th>
								<td style="background-color: #FFFFFF;"><div id="clock1" class="clock"></div></td>
							</tr>
							<tr>
								<th style="background-color: #FFFFFF;"><span class="clock-tit">중국</span></th>
								<td style="background-color: #FFFFFF;"><div id="clock2" class="clock"></div></td>
							</tr>
							<tr>
								<th style="background-color: #FFFFFF;"><span class="clock-tit">베트남</span></th>
								<td style="background-color: #FFFFFF;"><div id="clock3" class="clock"></div></td>
							</tr>
							<tr>
								<th style="background-color: #FFFFFF;"><span class="clock-tit">미국(NY)</span></th>
								<td style="background-color: #FFFFFF;"><div id="clock4" class="clock"></div></td>
							</tr>
							<tr>
								<th style="background-color: #FFFFFF;"><span class="clock-tit">미국(LA)</span></th>
								<td style="background-color: #FFFFFF;"><div id="clock5" class="clock"></div></td>
							</tr>
						</tbody>
						<!--  //추가 검색조건 열기 -->
					</table>

				</ul>
			</div>
		</div>


	</div>
	<!-- //content_wrap -->
 <div id="toast"></div></body>
</html>
		