<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>운영자 접속 로그 조회</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-control" content="No-cache" />
<meta http-equiv="Pragma" content="No-cache" />
<meta name="Description" content="" />
<meta name="Keywords" content="" />

<%@include file="/common/include/header.jsp"%>

<script type="text/javascript">
								
	$(document).ready(function() {
		
		jQuery("#logGrid1").jqGrid({
			url:'/system/staff/staffLogListJson.do',
			datatype: "local",				   
			colNames:['순번', '운영자 명', '운영자 ID', '총접속수', '최종 접속 일시', 'staff_id'],
			colModel:[
				{name:'rownum'  	, index:'rownum'      	, width:100, align:"center", sortable:true, editable:false},
				{name:'staff_nm' 	, index:'staff_nm'		, width:140, align:"center", sortable:true, editable:false, formatter:staffLinkFormatter, unformat:staffUnLinkFormatter},
				{name:'login_id'	, index:'login_id' 		, width:230, align:"left"  , sortable:true, editable:false},
				{name:'total_cnt'  	, index:'total_cnt'  	, width:120, align:"center", sortable:true, editable:false},
				{name:'last_logindt', index:'last_logindt'	, width:150, align:"center", sortable:true, editable:false},
				{name:'staff_id'	, index:'staff_id'		, width:150, align:"center", hidden:true}
			],
			//multiselect : true,
			mtype:"post",
			autowidth:true,
			rowNum:500,	   	
// 			rowList:[10,30,50],
			height: 260,
			sortname: 'rownum',
		    viewrecords: true,
		    //sortorder: "asc",		
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
		    		$("#logGrid1").jqGrid('setGridParam',{datatype:'json'});
		    		return true;
		    	}
		    },
		    // 그리드 부가 파라미터 정보
		    postData : serializeObject($('#searchForm'))
		});
		
		jQuery("#logGrid1").jqGrid('navGrid','#pager1',{search:false,edit:false,add:false,del:false,refresh:true});
		
		
		jQuery("#logGrid2").jqGrid({
			url:'/system/staff/staffLogDetailJson.do',   		  
			datatype: "local",				   
			colNames:['순번', '운영자 명', '운영자 ID', '메뉴 명', '메뉴 ID', 'IP 주소', '접속 일 시'],
			colModel:[
				{name:'rownum'  	, index:'rownum'      	, width:100, align:"center", sortable:true, editable:false},
				{name:'staff_nm' 	, index:'staff_nm'		, width:140, align:"center", sortable:true, editable:false},
				{name:'login_id'	, index:'login_id' 		, width:140, align:"left"  , sortable:true, editable:false},
				{name:'menu_nm'  	, index:'menu_nm'  		, width:280, align:"left"  , sortable:true, editable:false},
				{name:'menu_id'		, index:'menu_id'  		, width:180, align:"center", sortable:true, editable:false},
				{name:'conn_ip_txt'	, index:'conn_ip_txt'	, width:130, align:"center", sortable:true, editable:false},
				{name:'reg_dt'		, index:'reg_dt'		, width:150, align:"center", sortable:true, editable:false}
			],
			//multiselect : true,
			mtype:"post",
			autowidth:true,
			rowNum:500,	   	
// 			rowList:[10,30,50],
			height: 260,
			sortname: 'rownum',
		    viewrecords: true,
		    //sortorder: "asc",		
		    //shrinkToFit:false, 
			cellsubmit : 'clientArray',
			gridview: true,
			pager: '#pager2',
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
		    		$("#logGrid2").jqGrid('setGridParam',{datatype:'json'});
		    		return true;
		    	}
		    },
		    // 그리드 부가 파라미터 정보
		    postData : serializeObject($('#searchForm'))
		});
		
		jQuery("#logGrid2").jqGrid('navGrid','#pager2',{search:false,edit:false,add:false,del:false,refresh:true});
		
		// 운영자명/운영자ID/메뉴명/메뉴ID 입력폼에서 엔터입력 시 검색
		$('#staff_nm, #login_id, #menu_nm, #menu_id').keydown(13, function(event) {
			if (event.keyCode == 13) {
				$("#btnSearch").click();
			}
		});
		
		
// 		$("#btnSearch").click( function(){
			
// 			// 로그 상세 조회를 위한 검색값 hidden으로 저장
// 			var menu_id = $("#menu_id").val();  
// 			var menu_nm = $("#menu_nm").val();
// 			var check_dt1 = $("#search_dt_s").val();
// 			var check_dt2 = $("#search_dt_e").val();
			
// 			$("#menu_id_s").val(menu_id);
// 			$("#menu_nm_s").val(menu_nm);
// 			$("#check_dt_s").val(check_dt1);
// 			$("#check_dt_e").val(check_dt2);
			
// 			if(checkTermSearch("search_dt_s", "search_dt_e", "조회기간")){
// 				$('#logGrid1').clearGridData();
// 				$("#searchForm").submit();
// 			}
			
// 		});
		
		// jQuery validation
		$("#searchForm").validate({
			rules: {
				staff_nm: {maxlength: 30},
				login_id: {maxlength: 20},
				menu_nm: {maxlength: 30},
				menu_id: {maxlength: 5},
				search_dt_s: {dpDate: true},
				search_dt_e: {dpDate: true, dpCompareDate:{notBefore: '#search_dt_s'}}
			},
			messages: {
				staff_nm: {maxlength: jQuery.format("운영자명은 최대 {0} 글자 이하로 입력하세요.")},
				login_id: {maxlength: jQuery.format("운영자ID는 최대 {0} 글자 이하로 입력하세요.")},
				menu_nm: {maxlength: jQuery.format("메뉴명은 최대 {0} 글자 이하로 입력하세요.")},
				menu_id: {maxlength: jQuery.format("메뉴ID는 최대 {0} 글자 이하로 입력하세요.")},
				search_dt_s: {dpDate: "조회기간 시작일자는 yyyy-mm-dd 형식으로 입력하세요."},
				search_dt_e: {dpDate: "조회기간 종료일자는 yyyy-mm-dd 형식으로 입력하세요.",
						dpCompareDate: "조회기간 일자 검색 종료일은 시작일과 같거나 이후 일자를 선택하세요."}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
			},
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {
				$("#logGrid1").setGridParam({
					page : 1,
					postData : serializeObject($('#searchForm'))
				});
				$("#logGrid1").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
				//$("#logGrid1").trigger("reloadGrid");
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
			setSearchDate("search_dt_s", "search_dt_e", "today");
			event.preventDefault();
		});
		
		// 1주일
		$("#btnWeek").click(function(event) {
			setSearchDate("search_dt_s", "search_dt_e", "weekago");
			event.preventDefault();
		});
		
		// 1개월
		$("#btnMonth").click(function(event) {
			setSearchDate("search_dt_s", "search_dt_e", "monthago");
			event.preventDefault();
		});
		
		function staffLinkFormatter(cellVal, options, rowObj) {
			
			var cellval = String(cellVal);
			
			cellval = '<a href="javascript:searchContentsData(\'' + rowObj['staff_id'] + '\');" cellVal="'+ rowObj['staff_id'] +'">'+cellval+'</a>';										
			
			return  cellval === "" ? $.fn.fmatter.defaultFormat(cellval,options) : cellval;
		}
		
		function staffUnLinkFormatter(cellVal, options, cell) {
			return $('a', cell).attr('cellVal');
		}
		
	});
	
	function searchContentsData(staff_id) {
		$('#staff_id').val(staff_id);
		
		contentsSubmit = true;
		
		$("#logGrid2").setGridParam({
			datatype: "json",
			page : 1,
			postData : serializeObject($('#searchForm'))
		}).trigger("reloadGrid");
	}
	
	function fn_f3(){
		// 로그 상세 조회를 위한 검색값 hidden으로 저장
		var menu_id = $("#menu_id").val();  
		var menu_nm = $("#menu_nm").val();
		var check_dt1 = $("#search_dt_s").val();
		var check_dt2 = $("#search_dt_e").val();
		
		$("#menu_id_s").val(menu_id);
		$("#menu_nm_s").val(menu_nm);
		$("#check_dt_s").val(check_dt1);
		$("#check_dt_e").val(check_dt2);
		
		if(checkTermSearch("search_dt_s", "search_dt_e", "조회기간")){
			$('#logGrid1').clearGridData();
			$("#searchForm").submit();
		}
	}
</script>	
</head>

<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">운영자 접속 로그 조회</h3>
			
			<span class="bullet6">시스템관리 &gt; 운영자 관리 &gt; 운영자 접속 로그 조회</span>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form method="post" id="searchForm" name="searchForm" action="#">
				<input type="hidden" id="staff_id" name="staff_id" />
				<input type="hidden" id="menu_id_s" name="menu_id_s" />				
				<input type="hidden" id="menu_nm_s" name="menu_nm_s" />
				<input type="hidden" id="check_dt_s" name="check_dt_s" />
				<input type="hidden" id="check_dt_e" name="check_dt_e" />
					<fieldset>
					<legend>운영자 접속 로그 조회 추가 정보</legend>
						<div class="product_tbl">
							<table cellspacing="0" cellpadding="0" class="tbl_type2 tbl_cell">
							<caption>운영자 접속 로그 조회 추가 정보</caption>
								<colgroup>
									<col width="100%" />
								</colgroup>
								<tbody>
									<tr>
										<td>
											<div class="tbl_wrap">
												<dl class="section">
													<dt><label for="staff_nm">운영자 명 :</label></dt>
													<dd>
														<input type="text" id="staff_nm" name="staff_nm" style="width:90%;" maxlength="30" />
													</dd>
													<dt><label for="login_id">운영자 ID :</label></dt>
													<dd>
														<input type="text" id="login_id" name="login_id"style="width:90%;" maxlength="20" />
													</dd>
												</dl>
												<dl class="section">
													<dt><label for="menu_nm">메뉴 명 :</label></dt>
													<dd>
														<input type="text" id="menu_nm" name="menu_nm" style="width:90%;" maxlength="30" />
													</dd>
													<dt><label for="menu_id">메뉴 ID :</label></dt>
													<dd>
														<input type="text" id="menu_id" name="menu_id" style="width:90%;" maxlength="5" />
													</dd>
												</dl>
												<dl class="section">
													<dt><label for="a7">조회 기간 :</label></dt>
													<dd class="cols">
														<span class="calendar" id="a7">
															<input type="text" id="search_dt_s" name="search_dt_s" class="datepicker" />
														</span>
															~
														<span class="calendar">
															<input type="text" id="search_dt_e" name="search_dt_e" class="datepicker" />
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
				<table id="logGrid1"></table>
				<div id="pager1"></div>
			</div>
			<br/><br/>
			<div class="grid">
				<table id="logGrid2"></table>
				<div id="pager2"></div>
			</div>
		</div>
		<!-- //product_admin -->
	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>
