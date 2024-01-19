<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>제조사 코드 관리</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-control" content="No-cache" />
<meta http-equiv="Pragma" content="No-cache" />
<meta name="Description" content="" />
<meta name="Keywords" content="" />

<%@include file="/common/include/header.jsp"%>

<script type="text/javascript">
								
	$(document).ready(function() {
		
		jQuery("#codeGrid").jqGrid({
			url:'/system/code/companyCodeListJson', 		  
			datatype: "local",
			colNames:['제조사 명', '제조사 코드', '등록자', '등록일', '사용 여부'],
			colModel:[
				{name:'maker_nm'   , index:'maker_nm'   , width:290, align:"left"  , sortable:true, editable:true},
				{name:'maker_no'   , index:'maker_no'   , width:200, align:"center", sortable:true, editable:false},
				{name:'regstaff_nm', index:'regstaff_nm', width:200, align:"center", sortable:true, editable:false},
				{name:'reg_dt'     , index:'reg_dt'     , width:230, align:"center", sortable:true, editable:false},
				{name:'use_yn'     , index:'use_yn'     , width:210, align:"center", editable:true, formatter:"select", edittype:"select", editoptions:{value:"Y:사용;N:미사용"}}
			],
			mtype:"post",
			autowidth:true,
			rowNum:20,	   	
			rowList:[20,50,100],
			height: 500,
			editable:true,
			pager: '#pager1',
			sortname: 'maker_no',
		    viewrecords: true,
		    sortorder: "desc",		
		    //shrinkToFit:true, 
			cellsubmit : 'clientArray',
			multiselect : true,
			cellEdit : true,
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
		    		$("#codeGrid").jqGrid('setGridParam',{datatype:'json'});
		    		return true;
		    	}
		    }, 
		    // 그리드 부가 파라미터 정보
		    postData : serializeObject($('#searchForm')),
		    // cell이 변경되었을 경우 처리
		    afterSaveCell : function(id, name, val, iRow, iCol) {
		    	checkWhenColumnUpdated("codeGrid", id);
		    }
		    
		});
		
		jQuery("#codeGrid").jqGrid('navGrid','#pager1',{search:false,edit:false,add:false,del:false,refresh:true});
		
		// 제조사명/제조사코드 입력폼에서 엔터입력 시 검색
		$('#maker_nm, #maker_no').keydown(13, function(event) {
			if (event.keyCode == 13) {
				$("#btnSearch").click();
			}
		});
		
		$("#btnSearch").click( function(){
			$('#codeGrid').clearGridData();
			$("#searchForm").submit();
		});
		
		// jQuery validation
		$("#searchForm").validate({
			rules: {
				maker_nm: {maxlength: 30},
				maker_no: {maxlength: 5}
			},
			messages: {
				maker_nm: {maxlength: jQuery.format("상위코드명은 최대 {0} 글자 이하로 입력하세요.")},
				maker_no: {maxlength: jQuery.format("상위코드ID는 최대 {0} 글자 이하로 입력하세요.")}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);
			},
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {
				$("#codeGrid").setGridParam({
					page : 1,
					postData : serializeObject($('#searchForm'))
				});
				$("#codeGrid").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
				//$("#codeGrid").trigger("reloadGrid");
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
			CenterOpenWindow('/system/code/companyCodeDetail.do', '제조사상세', '500','285', 'scrollbars=auto, status=yes');
		});
		
		$("#btnSave").click(function (){
			//저장시 처리하는 부분 -2014.03.07
		    $("#codeGrid").editCell(0,0,false);
			
			saveGridSelected("codeGrid", 'selected', 'save', "/system/code/updateCompanyCodeList.do");
		});
		
		
	});
	
	function jsRefresh(){
		$("#codeGrid").setGridParam({
			datatype: "json",
			page : 1
		});
		$("#codeGrid").trigger("reloadGrid");
	}
	
</script>	
</head>

<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">제조사 코드 관리</h3>
			
			<span class="bullet6">시스템관리 &gt; 코드관리 &gt; 제조사 코드 관리</span>
		</div>
		

		<div>
			<!-- 버튼 -->
					
			<input type="button" class="btn btn-info btn-lg" value="SAVE" id="BTN_SetSave">
			<input type="button" class="btn btn-primary btn-lg" value="SAVE" id="BTN_SetSave">
			<input type="button" class="btn btn-danger btn-lg" value="DELETE" id="BTN_SetDelete">
			<input type="button" class="btn btn-success btn-lg" value="DELETE" id="BTN_SetDelete">
			<input type="button" class="btn btn-warning btn-lg" value="DELETE" id="BTN_SetDelete">
														
			<input type="button" class="btn btn-info btn-sm" value="SAVE" id="BTN_SetSave">								
			<input type="button" class="btn btn-primary btn-sm" value="SAVE" id="BTN_SetSave">
			<input type="button" class="btn btn-danger btn-sm" value="DELETE" id="BTN_SetDelete">
			<input type="button" class="btn btn-success btn-sm" value="DELETE" id="BTN_SetDelete">
			<input type="button" class="btn btn-warning btn-sm" value="DELETE" id="BTN_SetDelete">
			<input type="button" class="btn btn-close btn-sm" value="DELETE" id="BTN_SetDelete">
			
			<input type="button" class="btn btn-link btn-sm" value="DELETE" id="BTN_SetDelete">
			
			<input type="button" class="btn btn-info btn-xs" value="Choose">
			<input type="button" class="btn btn-primary btn-xs" value="저장">
			<input type="button" class="btn btn-danger btn-xs" value="삭제">
			<input type="button" class="btn btn-success btn-xs" value="Choose">
			<input type="button" class="btn btn-warning btn-xs" value="Choose">
			<input type="button" class="btn btn-close btn-xs" value="닫기" id="BTN_SetDelete">

			<input type="button" class="btn btn-primary btn-xs" value="저장[F10]" id="btnSave">
			<input type="button" class="btn btn-close btn-xs" value="닫기" id="btnClose">
			

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
													<dt><label for="maker_nm">제조사 명 :</label></dt>
													<dd>
														<input id="maker_nm" name="maker_nm" type="text" style="width:80%;" maxlength="30" />
													</dd>
													<dt><label for="maker_no">제조사 코드 :</label></dt>
													<dd>
														<input id="maker_no" name="maker_no" type="text" style="width:80%;" maxlength="5" />
													</dd>
												</dl>
												<dl class="section">
													<dt><label for="use_yn">사용 여부 :</label></dt>
													<dd>
														<select id="use_yn" name="use_yn" style="width:82%">
															<option value="">전체</option>
															<option value="Y">사용</option>
															<option value="N">미사용</option>
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
			
			<div class="product_bt mt30">
				<button class="search" id="btnSearch"><span>검색</span></button>
				<button class="reset" id="btnReset"><span>초기화</span></button>
			</div>
			<div class="report">
				<div class="min_btn">
					<button id="btnReg" class="sky" >신규등록</button>
					<button id="btnSave" class="sky" >저장</button>
				</div>
			</div>
			
			<div class="grid">
				<table id="codeGrid"></table>
				<div id="pager1"></div>
			</div>
		</div>
		<!-- //product_admin -->
	</div>
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>