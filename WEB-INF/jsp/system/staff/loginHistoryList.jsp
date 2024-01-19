<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>로그인 기록관리</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-control" content="No-cache" />
<meta http-equiv="Pragma" content="No-cache" />
<meta name="Description" content="" />
<meta name="Keywords" content="" />

<%@include file="/common/include/header.jsp"%>

<script type="text/javascript">
								
	$(document).ready(function() {
		
		jQuery("#loginGrid").jqGrid({
			url:'/system/staff/loginHistoryListJson.do', 		  
			datatype: "local",				   
			colNames:['번호', '접속 ID', '접속자 이름','접속일자', '접속시간', '접속지 IP', '성공/실패 여부'],
			colModel:[
				{name:'rownum'   		, index:'rownum'   		  , width:120, align:"center", sortable:true, editable:false},
				{name:'login_id'  		, index:'login_id' 		  , width:150, align:"left"  , sortable:true, editable:false},
				{name:'staff_nm'  		, index:'staff_nm' 		  , width:150, align:"left"  , sortable:true, editable:false},
				{name:'login_dt' 		, index:'login_dt'  	  , width:180, align:"center", sortable:true, editable:false},
				{name:'login_tm'  		, index:'login_tm' 		  , width:170, align:"center", sortable:true, editable:false},
				{name:'login_ip' 		, index:'login_ip' 		  , width:200, align:"center", sortable:true, editable:false},
				{name:'login_success_yn', index:'login_success_yn', width:170, align:"center", sortable:true, editable:false, formatter:"select", edittype:"select", editoptions:{value:"Y:성공;N:실패"}}
			],
			mtype:"post",
			autowidth:true,
			rowNum:500,	   	
// 			rowList:[20,50,100],
			height: 500,			
		    viewrecords: true,
		    sortname: 'rownum',
		    //sortorder: "desc",		
		    //shrinkToFit:false, 
			cellsubmit : 'clientArray',
			gridview: true,
			pager: '#pager1',
			// 서버에러시 처리
			loadError : function(xhr,st,err) {
				girdLoadError();
		    },
			// 데이터 로드 완료 후 처리 
		    loadComplete: function(data) {
		    	setSortingGridData(this, data);
		    },
		    onPaging: function(btn) {
		    	if($('#'+btn).hasClass('ui-state-disabled')) {
		    		return 'stop';
		    	} else { 
		    		$("#loginGrid").jqGrid('setGridParam',{datatype:'json'});
		    		return true;
		    	}
		    },
		    // 그리드 부가 파라미터 정보
		    postData : serializeObject($('#searchForm'))
		});
		
		jQuery("#loginGrid").jqGrid('navGrid','#pager1',{search:false,edit:false,add:false,del:false,refresh:true});
		
		// 접속ID/접속IP 입력폼에서 엔터입력 시 검색
		$('#login_id, #login_ip').keydown(13, function(event) {
			if (event.keyCode == 13) {
				$("#btnSearch").click();
			}
		});
		
// 		$("#btnSearch").click( function(){
			
// 			if(checkTermSearch("login_dt_s", "login_dt_e", "접속일자")){
// 				$("#searchForm").submit();
// 			}
			
// 		});
		
		// jQuery validation
		$("#searchForm").validate({
			rules: {
				login_id: {maxlength: 20},
				login_ip: {maxlength: 20},
				login_dt_s: {dpDate: true},
				login_dt_e: {dpDate: true, dpCompareDate:{notBefore: '#login_dt_s'}}
			},
			messages: {
				login_id: {maxlength: jQuery.format("접속ID는 최대 {0} 글자 이하로 입력하세요.")},
				login_ip: {maxlength: jQuery.format("접속지IP는 최대 {0} 글자 이하로 입력하세요.")},
				login_dt_s: {dpDate: "접속일 시작일자는 yyyy-mm-dd 형식으로 입력하세요."},
				login_dt_e: {dpDate: "접속일 종료일자는 yyyy-mm-dd 형식으로 입력하세요.",
						dpCompareDate: "접속일자 검색 종료일은 시작일과 같거나 이후 일자를 선택하세요."}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
			},
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {
				$("#loginGrid").setGridParam({
					page : 1,
					postData : serializeObject($('#searchForm'))
				});
				$("#loginGrid").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
				//$("#loginGrid").trigger("reloadGrid");
			}
		});
		
		$("#btnExcelDownload").click( function(){	
			var downUrl = "/system/staff/loginHistoryListExcel.do?"
				+ $("#searchForm").serialize()
				+ "&page=" + $('#list1').getGridParam('page')
				+ "&rows=" + $('#list1').getGridParam('rowNum');
			
			$.fileDownload(downUrl)
		 		.done(function() { toast('파일 다운로드에 성공하였습니다.')})
		 		.fail(function() { toast('파일 다운로드에 실패하였습니다.')});
		});
		
		// 초기화
		$("#btnReset").click( function() {	
			$("#searchForm")[0].reset();
			/*방법2 - 문서에 있는 모든 form을 리셋
			$("form".each(function(){
				this.reset();
			});*/
		});
		
		// 오늘
		$("#btnToday").click(function(event) {
			setSearchDate("login_dt_s", "login_dt_e", "today");
			event.preventDefault();
		});
		
		// 1주일
		$("#btnWeek").click(function(event) {
			setSearchDate("login_dt_s", "login_dt_e", "weekago");
			event.preventDefault();
		});
		
		// 1개월
		$("#btnMonth").click(function(event) {
			setSearchDate("login_dt_s", "login_dt_e", "monthago");
			event.preventDefault();
		});
		
	});
	
	function fn_f3(){
		if(checkTermSearch("login_dt_s", "login_dt_e", "접속일자")){
			$("#searchForm").submit();
		}
	}
</script>	
</head>

<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">로그인 기록 관리</h3>
			
			<span class="bullet6">시스템관리 &gt; 운영자 관리 &gt; 로그인 기록 관리</span>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form id="searchForm" name="searchForm" method="post" action="#">
					<fieldset>
					<legend>로그인 기록 관리 추가 정보</legend>
						<div class="product_tbl">
							<table cellspacing="0" cellpadding="0" class="tbl_type2 tbl_cell">
							<caption>로그인 기록 관리 추가 정보</caption>
								<colgroup>
									<col width="100%" />
								</colgroup>
								<tbody>
									<tr>
										<td>
											<div class="tbl_wrap">
												<dl class="section">
													<dt><label for="login_id">접속 ID :</label></dt>
													<dd>
														<input type="text" id="login_id" name="login_id" style="width:90%;" maxlength="20" />
													</dd>
													<dt><label for="login_ip">접속지 IP :</label></dt>
													<dd>
														<input type="text" id="login_ip" name="login_ip" style="width:90%;" maxlength="20" />
													</dd>
												</dl>
												<dl class="section">
													<dt><label for="login_success_yn">성공/실패 여부 :</label></dt>
													<dd>
														<select id="login_success_yn" name="login_success_yn" style="width:90%" >
															<option value="">전체</option>
															<option value="Y">성공</option>
															<option value="N">실패</option>
														</select>
													</dd>
												</dl>
												<dl class="section">
													<dt><label for="a7">접속 일자 :</label></dt>
													<dd class="cols">
														<span class="calendar" id="a7">
															<input type="text" id="login_dt_s" name="login_dt_s" class="datepicker" />
														</span>
															~
														<span class="calendar">
															<input type="text" id="login_dt_e" name="login_dt_e" class="datepicker" />
														</span>
														<button class="btn_c6" id="btnToday">오늘</button>
														<button class="btn_c6" id="btnWeek">1주일</button>
														<button class="btn_c6" id="btnMonth">1개월</button>
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
				<button id="btnSearch" class="search"><span>검색</span></button>
				<button id="btnReset" class="reset"><span>초기화</span></button>
			</div>
			<c:if test="${(sessionScope['STAFFINFORMATION']['excel_down_yn'] eq 'Y' && sessionScope['STAFFINFORMATION']['staff_typ'] eq 1) || sessionScope['STAFFINFORMATION']['groupauth_id'] eq '10004' || sessionScope['STAFFINFORMATION']['staff_typ'] ne 1}">			
				<div class="report">
					<div class="min_btn">
						<button id="btnExcelDownload" class="sky" type="button">엑셀 다운로드</button>
					</div>
				</div>
			</c:if>	
			<div class="grid">
				<table id="loginGrid"></table>
				<div id="pager1"></div>
			</div>
		</div>
		<!-- //product_admin -->
	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>
