<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>운영자 기록 관리</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-control" content="No-cache" />
<meta http-equiv="Pragma" content="No-cache" />
<meta name="Description" content="" />
<meta name="Keywords" content="" />

<%@include file="/common/include/header.jsp"%>

<script type="text/javascript">
								
	$(document).ready(function() {
		
		jQuery("#staffGrid").jqGrid({
			url:'/system/staff/staffHistoryListJson.do', 		  
			datatype: "local",				   
			colNames:['번호', '구분', '권한그룹', '개인정보권한여부', '비밀번호 변경여부', '처리자 ID', '처리자 이름','대상 ID', '대상 이름', '처리일자', '처리시간'],
			colModel:[
				{name:'rownum' 	   		, index:'rownum'     	, width:120, align:"center" , sortable:true, editable:false},
				{name:'admin_typ'  		, index:'admin_typ'  	, width:180, align:"center" , sortable:true, editable:false, formatter:"select", edittype:"select", editoptions:{value:"1:신규;2:변경;3:삭제"}},
				{name:'groupauth_id' 	, index:'groupauth_id' 	, width:250, align:"center" , sortable:true, editable:false},
				{name:'excel_down_yn' 	, index:'excel_down_yn' , width:250, align:"center" , sortable:true, editable:false},
				{name:'pwd_ch_yn' 		, index:'pwd_ch_yn' 	, width:250, align:"center" , sortable:true, editable:false, formatter:"select", edittype:"select", editoptions:{value:"0:초기화;1:변경;"}},
				{name:'p_login_id' 		, index:'p_login_id' 	, width:250, align:"left"   , sortable:true, editable:false},
				{name:'staff_nm' 		, index:'staff_nm' 	, width:250, align:"left"   , sortable:true, editable:false},				
				{name:'t_login_id' 		, index:'t_login_id' 	, width:250, align:"left"   , sortable:true, editable:false},
				{name:'t_login_nm' 		, index:'t_login_nm' 	, width:250, align:"left"   , sortable:true, editable:false},
				{name:'process_dt' 		, index:'process_dt' 	, width:170, align:"center" , sortable:true, editable:false},
				{name:'process_tm' 		, index:'process_tm' 	, width:170, align:"center" , sortable:true, editable:false}
			],
			mtype:"post",
			autowidth:true,
			rowNum:500,	   	
// 			rowList:[20,50,100],
			height: 500,			
		    viewrecords: true,
		    sortorder: "desc",		
		   // shrinkToFit:false, 
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
		    		$("#staffGrid").jqGrid('setGridParam',{datatype:'json'});
		    		return true;
		    	}
		    },
		    // 그리드 부가 파라미터 정보
		    postData : serializeObject($('#searchForm'))
		});
		
		jQuery("#staffGrid").jqGrid('navGrid','#pager1',{search:false,edit:false,add:false,del:false,refresh:true});
		
		// 처리자ID/대상ID 입력폼에서 엔터입력 시 검색
		$('#p_login_id, #t_login_id').keydown(13, function(event) {
			if (event.keyCode == 13) {
				$("#btnSearch").click();
			}
		});
		
// 		$("#btnSearch").click( function(){
// 			if(checkTermSearch("process_dt_s", "process_dt_e", "처리일자")){
// 				$("#searchForm").submit();
// 			}
// 		});
		
		$("#searchForm").validate({
			rules: {
				p_login_id: {maxlength: 20},
				t_login_id: {maxlength: 20},
				process_dt_s: {dpDate: true},
				process_dt_e: {dpDate: true, dpCompareDate:{notBefore: '#process_dt_s'}}
			},
			messages: {
				p_login_id: {maxlength: jQuery.format("처리자ID는 최대 {0} 글자 이하로 입력하세요.")},
				t_login_id: {maxlength: jQuery.format("대상ID는 최대 {0} 글자 이하로 입력하세요.")},
				process_dt_s: {dpDate: "처리일 시작일자는 yyyy-mm-dd 형식으로 입력하세요."},
				process_dt_e: {dpDate: "처리일 종료일자는 yyyy-mm-dd 형식으로 입력하세요.",
						dpCompareDate: "처리일자 검색 종료일은 시작일과 같거나 이후 일자를 선택하세요."}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
			},
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {
				$("#staffGrid").setGridParam({
					page : 1,
					postData : serializeObject($('#searchForm'))
				});
				$("#staffGrid").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
				//$("#staffGrid").trigger("reloadGrid");
			}
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
			setSearchDate("process_dt_s", "process_dt_e", "today");
			event.preventDefault();
		});
		
		// 1주일
		$("#btnWeek").click(function(event) {
			setSearchDate("process_dt_s", "process_dt_e", "weekago");
			event.preventDefault();
		});
		
		// 1개월
		$("#btnMonth").click(function(event) {
			setSearchDate("process_dt_s", "process_dt_e", "monthago");
			event.preventDefault();
		});
		
	});
	
	function fn_f3(){
		if(checkTermSearch("process_dt_s", "process_dt_e", "처리일자")){
			$("#searchForm").submit();
		}		
	}
</script>	
</head>

<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">운영자 기록 관리</h3>
			
			<span class="bullet6">시스템관리 &gt; 운영자 관리 &gt; 운영자 기록 관리</span>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form id="searchForm" name="searchForm" method="post" action="#">
					<fieldset>
					<legend>운영자 기록 관리 추가 정보</legend>
						<div class="product_tbl">
							<table cellspacing="0" cellpadding="0" class="tbl_type2 tbl_cell">
							<caption>운영자 기록 관리 추가 정보</caption>
								<colgroup>
									<col width="100%" />
								</colgroup>
								<tbody>
									<tr>
										<td>
											<div class="tbl_wrap">
												<dl class="section">
													<dt><label for="p_login_id">처리자 ID :</label></dt>
													<dd>
														<input type="text" id="p_login_id" name="p_login_id" style="width:90%;" maxlength="20" />
													</dd>
													<dt><label for="t_login_id">대상 ID :</label></dt>
													<dd>
														<input type="text" id="t_login_id" name="t_login_id" style="width:90%;" maxlength="20" />
													</dd>
												</dl>
												<dl class="section">
													<dt><label for="admin_typ">구분 :</label></dt>
													<dd>
														<select style="width:90%" id="admin_typ" name="admin_typ">
															<option value="">전체</option>
															<option value="1">신규</option>
															<option value="2">변경</option>
															<option value="3">삭제</option>
														</select>
													</dd>
												</dl>
												<dl class="section">
													<dt><label for="a7">처리 일자 :</label></dt>
													<dd class="cols">
														<span class="calendar" id="a7">
															<input type="text" id="process_dt_s" name="process_dt_s" class="datepicker" />
														</span>
															~
														<span class="calendar">
															<input type="text" id="process_dt_e" name="process_dt_e" class="datepicker" />
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
			<div class="grid">
				<table id="staffGrid"></table>
				<div id="pager1"></div>
			</div>
		</div>
		<!-- //product_admin -->
	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>
