<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>운영자 리스트</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-control" content="No-cache" />
<meta http-equiv="Pragma" content="No-cache" />
<meta name="Description" content="" />
<meta name="Keywords" content="" />

<%@include file="/common/include/header.jsp"%>

<script type="text/javascript">
								
	$(document).ready(function() {
		
		jQuery("#staffGrid").jqGrid({
			url:'/system/staff/staffListJson',
			datatype: "local",				   
			colNames:[ '로그인ID', '운영자명', '권한 그룹', '운영자 타입', '(소속)업체명', '핸드폰 번호','계정 사용 여부', '최종로그인'],
			colModel:[
// 				{name:'staff_id'     , index:'staff_id'     , width:90, align:"center" , sortable:true, editable:false},
				{name:'login_id'     , index:'login_id'     , width:110, align:"left"  , sortable:true, editable:false},
				{name:'staff_nm'     , index:'staff_nm'     , width:110, align:"center", sortable:true, editable:false, formatter:linkFormatter, unformat:linkUnFormatter},
				{name:'groupauth_nm' , index:'groupauth_nm' , width:110, align:"center", sortable:true, editable:false},
				{name:'staff_typ'    , index:'staff_typ'    , width:110, align:"center", sortable:true, editable:false, formatter:"select", edittype:"select", editoptions:{value:"1:내부운영자;2:업체운영자"}},
				{name:'vendor_nm'    , index:'vendor_nm'    , width:260, align:"left"  , sortable:true, editable:false},
				{name:'mobile_txt'    , index:'mobile_txt'    , width:110, align:"center", sortable:true, editable:false},				
				{name:'use_yn'       , index:'use_yn'       , width:100, align:"center", sortable:true, editable:false, formatter:"select", edittype:"select", editoptions:{value:"Y:사용;N:미사용"}},
				{name:'lastlogin_dt' , index:'lastlogin_dt' , width:100, align:"center", sortable:true, editable:false}
			],
			
			mtype:"post",
			autowidth:true,
			rowNum:500,	   	
// 			rowList:[20,50,100],
			height: 500,
			sortname: 'staff_id',
		    viewrecords: true,
		    //sortorder: "asc",		
		    //shrinkToFit:false, 
			cellsubmit : 'clientArray',
			gridview: true,
			multiselect : true,
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
		
		function linkFormatter(cellVal, options, rowObj) {
			var linkURL = '<a href="javascript:CenterOpenWindow(\'/system/staff/systemStaffDetailPop?type=modify&staff_id=' + rowObj['staff_id'] + '\', \'open\', \'900\', \'535\', \'scrollbars=no, status=no\');">'+cellVal+'</a>';
			return linkURL;
		}
		
		// Link 처리 unformatter
		function linkUnFormatter(cellVal, options, cell) {
			return $('a', cell).text();
		}
		
		// 로그인ID/운영자명/핸드폰번호 입력폼에서 엔터입력 시 검색
		$('#login_id, #staff_nm, #mobil_txt').keydown(13, function(event) {
			if (event.keyCode == 13) {
				$("#btnSearch").click();
			}
		});
		
// 		$("#btnSearch").click( function(){
// 			//if(checkTermSearch("lastlogin_dt_s", "lastlogin_dt_e", "최종로그인일자")){
// 				$('#staffGrid').clearGridData();
// 				$("#searchForm").submit();
// 			//}
// 		});
				
		// jQuery validation
		$("#searchForm").validate({
			rules: {
				login_id: {maxlength: 20},
				staff_nm: {maxlength: 30},
				mobil_txt: {maxlength: 20},
				lastlogin_dt_s: {dpDate: true},
				lastlogin_dt_e: {dpDate: true, dpCompareDate:{notBefore: '#lastlogin_dt_s'}}
			},
			messages: {
				login_id: {maxlength: jQuery.format("로그인ID는 최대 {0} 글자 이하로 입력하세요.")},
				staff_nm: {maxlength: jQuery.format("운영자명은 최대 {0} 글자 이하로 입력하세요.")},
				mobil_txt: {maxlength: jQuery.format("핸드폰번호는 최대 {0} 글자 이하로 입력하세요.")},
				lastlogin_dt_s: {dpDate: "최종 로그인 시작일자는 yyyy-mm-dd 형식으로 입력하세요."},
				lastlogin_dt_e: {dpDate: "최종 로그인 종료일자는 yyyy-mm-dd 형식으로 입력하세요.",
						dpCompareDate: "최종 로그인 일자 검색 종료일은 시작일과 같거나 이후 일자를 선택하세요."}
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
		
		$("#btnReg").click( function() {
			CenterOpenWindow('/system/staff/systemStaffDetailPop?type=add&staff_id=&staff_typ=1', '시스템운영자등록', '900','425', 'scrollbars=no, status=yes');
		});
		
		$("#btnDel").click(function (){
			saveGridSelected("staffGrid", 'selected', 'delete', "/system/staff/deleteStaffList");
		});
		
		// 오늘
		$("#btnToday").click(function(event) {
			setSearchDate("lastlogin_dt_s", "lastlogin_dt_e", "today");
			event.preventDefault();
		});
		
		// 1주일
		$("#btnWeek").click(function(event) {
			setSearchDate("lastlogin_dt_s", "lastlogin_dt_e", "weekago");
			event.preventDefault();
		});
		
		// 1개월
		$("#btnMonth").click(function(event) {
			setSearchDate("lastlogin_dt_s", "lastlogin_dt_e", "monthago");
			event.preventDefault();
		});
		
		$("#btnVendor").click(function(event) {
			openPop(1);
			event.preventDefault();
		});
		
	});
	
	function jsRefresh(){
		$("#staffGrid").setGridParam({
			datatype: "json",
			page : 1
		});
		$("#staffGrid").trigger("reloadGrid");
	}
	
	function setVendorData(Data){
		$("#vendor_nm").val(Data[0].vendor_nm);
		$("#vendor_no").val(Data[0].vendor_no);
	}
	
	function fn_f3(){
		$("#searchForm").submit();
	}
	
</script>	
</head>

<body class="sky" style="overflow:hidden;">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">운영자 리스트</h3>
			
			<span class="bullet6">시스템관리 &gt; 운영자 관리 &gt; 운영자 리스트</span>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form id="searchForm" name="searchForm" method="post" action="#">
				<input type="hidden" name="vendor_no" id="vendor_no" value="10000" />
				<input type="hidden" name="vendor_typ" id="vendor_typ" value="1" />
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
													<dt><label for="login_id">로그인 ID</label></dt>
													<dd>
														<input type="text" id="login_id" name="login_id" style="width:90%;" maxlength="20" />
													</dd>
													<dt><label for="staff_nm">운영자 명</label></dt>
													<dd>
														<input type="text" id="staff_nm" name="staff_nm" style="width:90%;" maxlength="30" />
													</dd>
												</dl>

											</div>
											<div class="tbl_wrap active mark">
												<dl class="section">
													<dt><label for="groupauth_nm">권한그룹</label></dt>
													<dd>
														<select style="width:90%" id="groupauth_nm" name="groupauth_nm">
															<option value="">전체</option>
															<c:forEach var="entity" items="${_DATA}">
																<option value="<c:out value="${entity.groupauth_id}"/>"><c:out value="${entity.groupauth_nm}"/></option>
															</c:forEach>
														</select>
													</dd>
													<dt><label for="use_yn">계정 사용 여부</label></dt>
													<dd>
														<select style="width:90%" id="use_yn" name="use_yn">
															<option value="">전체</option>
															<option value="Y">사용</option>
															<option value="N">미사용</option>
														</select>
													</dd>
												</dl>
												<dl class="section">
													<dt><label for="mobil_txt">핸드폰 번호</label></dt>
													<dd>
														<input type="text" id="mobil_txt" name="mobil_txt" style="width:90%" maxlength="20" />														
													</dd>
													<dt><label for="orderby_txt">정렬 기준</label></dt>
													<dd>
														<select style="width:90%" id="orderby_txt" name="orderby_txt">
															<option value="">전체</option>
															<option value="L">로그인 최신순</option>
															<option value="S">가입 최신순</option>
														</select>												
													</dd>													
												</dl>
												<dl class="section">
													<dt><label for="a7">최종 로그인 일자</label></dt>
													<dd class="cols">
														<span class="calendar" id="a7">
															<input type="text" id="lastlogin_dt_s" name="lastlogin_dt_s" class="datepicker2" maxlength="10" />
														</span>
															~
														<span class="calendar">
															<input type="text" id="lastlogin_dt_e" name="lastlogin_dt_e" class="datepicker2" maxlength="10" />
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
			<div class="btn_add">
				<a href="#none" class="hidden"></a>
			</div>
			
					
			<div class="product_bt">
				<button id="btnSearch" class="search"><span>검색</span></button>
				<button id="btnReset" class="reset"><span>초기화</span></button>
			</div>
			<div class="report">
				<div class="min_btn">
					<button class="sky" id="btnReg" >신규등록</button>
					<button class="gray" id="btnDel" >삭제</button>
				</div>
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
