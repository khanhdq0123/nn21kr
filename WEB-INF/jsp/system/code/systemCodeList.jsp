<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>시스템 코드 관리</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-control" content="No-cache" />
<meta http-equiv="Pragma" content="No-cache" />
<meta name="Description" content="" />
<meta name="Keywords" content="" />

<%@include file="/common/include/header.jsp"%>

<script type="text/javascript">
								
	$(document).ready(function() {
		
		jQuery("#upGrid").jqGrid({
			url:'/system/code/systemUpperCodeListJson',
			datatype: "local",				   
			colNames:['상위 코드 ID', '상위 코드 명', '사용여부', '정렬순서', '내부 연동 코드', '코드 설명', '임시필드1', '임시필드2'],
			colModel:[
				{name:'code_cd'		 , index:'code_cd'		, width:100, align:"center", sortable:true, editable:false, formatter:codeLinkFormatter, unformat:codeUnLinkFormatter},
				{name:'code_nm'	 	 , index:'code_nm'		, width:200, align:"left"  , sortable:true, editable:true, editoptions:{maxlength:100}, editrules:{required:true}},
				{name:'use_yn'		 , index:'use_yn'		, width:80,  align:"center", sortable:true, editable:true, formatter:"select", edittype:"select", editoptions:{value:"Y:사용;N:미사용"}},
				{name:'sort_seq'	 , index:'sort_seq'		, width:80,  align:"center", sortable:true, editable:true, editrules:{required:true, integer:true, maxValue:32767}},
				{name:'inside_txt'	 , index:'inside_txt'	, width:110, align:"left"  , sortable:true, editable:true, editoptions:{maxlength:20}},
				{name:'comment_txt'	 , index:'comment_txt'	, width:220, align:"left"  , sortable:true, editable:true, editoptions:{maxlength:4000}},
				{name:'tmpfield1_txt', index:'tmpfield1_txt', width:160, align:"left"  , sortable:true, editable:true, editoptions:{maxlength:20}},
				{name:'tmpfield2_txt', index:'tmpfield2_txt', width:160, align:"left"  , sortable:true, editable:true, editoptions:{maxlength:20}}
			],
			
			mtype:"post",
			autowidth:true,
			rowNum:500,
// 			rowList:[10,30,50],
			height: 260,
		    viewrecords: true,
		    sortname: 'code_cd',
		    //sortorder: "asc",
		    //shrinkToFit:false, 
			cellsubmit : 'clientArray',
			multiselect : true,
			cellEdit : true,
			gridview:true,
			editable:true,
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
		    		$("#upGrid").jqGrid('setGridParam',{datatype:'json'});
		    		return true;
		    	}
		    },
		    // 그리드 부가 파라미터 정보
		    postData : serializeObject($('#searchForm')),
		    afterSaveCell : function(id, name, val, iRow, iCol) {
		    	checkWhenColumnUpdated("upGrid", id);
		    }
		});

		jQuery("#upGrid").jqGrid('navGrid','#pager1',{search:false,edit:false,add:false,del:false,refresh:true});
		
		$("#btnRegUpper").click( function() {
			CenterOpenWindow('/system/code/systemCodeDetail?codeCd=00000', '상위코드등록', '650','335', 'scrollbars=no, status=yes');
		});
		
		$("#btnSaveUpper").click(function (){
			//저장시 처리하는 부분 -2014.03.07
		    $("#upGrid").editCell(0,0,false);
			
			saveGridSelected("upGrid", 'selected', 'save', "/system/code/updateSystemCodeList");
		});
		
		jQuery("#lowGrid").jqGrid({
			url:'/system/code/systemLowerCodeListJson',
			datatype: "local",
			colNames:['하위 코드 ID', '하위 코드 명', '사용여부', '정렬순서', '내부 연동 코드', '코드 설명', '임시필드1', '임시필드2'],
			colModel:[
				{name:'code_cd'		 , index:'code_cd'		, width:100, align:"center", sortable:true, editable:false},
				{name:'code_nm'	 	 , index:'code_nm'		, width:200, align:"left"  , sortable:true, editable:true, editoptions:{maxlength:100}, editrules:{required:true}},
				{name:'use_yn'		 , index:'use_yn'		, width:80,  align:"center", sortable:true, editable:true, formatter:"select", edittype:"select", editoptions:{value:"Y:사용;N:미사용"}},
				{name:'sort_seq'	 , index:'sort_seq'		, width:80,  align:"center", sortable:true, editable:true, editrules:{required:true, integer:true, maxValue:32767}},
				{name:'inside_txt'	 , index:'inside_txt'	, width:110, align:"left"  , sortable:true, editable:true, editoptions:{maxlength:20}},
				{name:'comment_txt'	 , index:'comment_txt'	, width:220, align:"left"  , sortable:true, editable:true, editoptions:{maxlength:4000}},
				{name:'tmpfield1_txt', index:'tmpfield1_txt', width:160, align:"left"  , sortable:true, editable:true, editoptions:{maxlength:20}},
				{name:'tmpfield2_txt', index:'tmpfield2_txt', width:160, align:"left"  , sortable:true, editable:true, editoptions:{maxlength:20}}
			],
			
			mtype:"post",
			autowidth:true,
			rowNum:500,
// 			rowList:[10,30,50],
			height: 260,
		    viewrecords: true,
		    sortname: 'code_cd',
		    //sortorder: "asc",
		    //shrinkToFit:false,
			cellsubmit : 'clientArray',
			multiselect : true,
			cellEdit : true,
			gridview:true,
			editable:true,
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
		    		$("#lowGrid").jqGrid('setGridParam',{datatype:'json'});
		    		return true;
		    	}
		    },
		    // 그리드 부가 파라미터 정보
		    postData : serializeObject($('#searchForm')),
		    //postData : {
				//code_id:function() {
					//return $("#code_id").val();
				//},
				//additionalParam:'dummy'
			//},
		    afterSaveCell : function(id, name, val, iRow, iCol) {
		    	checkWhenColumnUpdated("lowGrid", id);
		    }
		});
		
		jQuery("#lowGrid").jqGrid('navGrid','#pager2',{search:false,edit:false,add:false,del:false,refresh:true});
		
		$("#btnRegLower").click( function() {
			if($("#code_id").val() != ""){
				CenterOpenWindow('/system/code/systemCodeDetail?codeCd='+ $("#code_id").val(), '하위코드등록', '650','335', 'scrollbars=no, status=yes');
			} else {
				toast("상위코드 ID를 선택해 주세요.");
			}
		});
		
		$("#btnSaveLower").click(function (){
			//저장시 처리하는 부분 -2014.03.07
		    $("#lowGrid").editCell(0,0,false);

			saveGridSelected("lowGrid", 'selected', 'save', "/system/code/updateSystemCodeList");
		});
		
		// 상위코드명/상위코드ID 입력폼에서 엔터입력 시 검색
		$('#code_nm, #code_cd').keydown(13, function(event) {
			if (event.keyCode == 13) {
				//$("#btnSearch").click();
				fn_f3();
			}
		});
		
// 		$("#btnSearch").click( function(){
// 			$('#upGrid').clearGridData();
// 			$("#searchForm").submit();
// 		});
		
		// jQuery validation
		$("#searchForm").validate({
			rules: {
				code_nm: {maxlength: 100},
				code_cd: {maxlength: 5}
			},
			messages: {
				code_nm: {maxlength: jQuery.format("상위코드명은 최대 {0} 글자 이하로 입력하세요.")},
				code_cd: {maxlength: jQuery.format("상위코드ID는 최대 {0} 글자 이하로 입력하세요.")}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);
			},
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {
				$("#upGrid").setGridParam({
					page : 1,
					postData : serializeObject($('#searchForm'))
				});
				$("#upGrid").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
				//$("#upGrid").trigger("reloadGrid");
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
		
		function codeLinkFormatter(cellVal, options, rowObj) {
			
			var cellval = String(cellVal);
			
			
			//toast('code_cd : ' + rowObj['code_cd']);
			
			cellval = '<a href="javascript:searchContentsData(\'' + rowObj['code_cd'] + '\');" cellVal="'+ rowObj['code_cd'] +'">'+cellval+'</a>';										
			
			return  cellval === "" ? $.fn.fmatter.defaultFormat(cellval,options) : cellval;
		}
		
		function codeUnLinkFormatter(cellVal, options, cell) {
			return $('a', cell).attr('cellVal');
		}
	});
	
	function searchContentsData(code_cd) {
		$('#code_id').val(code_cd);
		
		contentsSubmit = true;
		
		$("#lowGrid").setGridParam({
			datatype: "json",
			page : 1,
			postData : serializeObject($('#searchForm'))
		}).trigger("reloadGrid");
	}
	
	
	function jsRefresh(){
		$("#upGrid").setGridParam({
			datatype: "json",
			page : 1
		});
		$("#upGrid").trigger("reloadGrid");
		
		$("#lowGrid").setGridParam({
			datatype: "json",
			page : 1
		});
		$("#lowGrid").trigger("reloadGrid");
	}
	
	
	function fn_f3(){
		$("#searchForm").submit();
	}
</script>

</head>

<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">시스템 코드 관리</h3>
			
			<span class="bullet6">시스템관리 &gt; 코드관리 &gt; 시스템 코드 관리</span>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form id="searchForm" name="searchForm" method="post" action="#">
				<input type="hidden" id="code_id" name="code_id" value="" />
					<fieldset>
					<legend>시스템 코드 관리 검색조건</legend>
						<div class="product_tbl">
							<table cellspacing="0" cellpadding="0" class="tbl_type2 tbl_cell">
							<caption>시스템 코드 관리 검색조건 정보</caption>
								<colgroup>
									<col width="100%" />
								</colgroup>
								<tbody>
									<tr>
										<td>
											<div class="tbl_wrap">
												<dl class="section">
													<dt><label for="code_nm">상위 코드 명 :</label></dt>
													<dd>
														<input id="code_nm" name="code_nm" type="text" style="width:80%;" maxlength="100" />
													</dd>
													<dt><label for="code_cd">상위 코드 ID :</label></dt>
													<dd>
														<input id="code_cd" name="code_cd" type="text" style="width:80%;" maxlength="5" />
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
				<button id="btnSearch" name="btnSearch" class="search"><span>검색</span></button>
				<button id="btnReset" name="btnReset" class="reset"><span>초기화</span></button>
			</div>
			<br/><br/>
			
			<div class="grid">
				<div class="outcome info">
					<span class="res_search" >상위 코드 리스트</span>
					<div class="min_btn" style="float:right;">
						<button id="btnRegUpper" class="sky">상위 코드 등록</button>
						<button id="btnSaveUpper" class="sky">저장</button>
					</div>
				</div>
			
				<table id="upGrid"></table>
				<div id="pager1"></div>
			</div>
			
			<br/><br/>
			<div class="grid">
				<div class="outcome info">
					<span class="res_search" >하위 코드 리스트</span>
					<div class="min_btn" style="float:right;">
						<button id="btnRegLower" class="sky">하위 코드 등록</button>
						<button id="btnSaveLower" class="sky">저장</button>
					</div>
				</div>
					
				<table id="lowGrid"></table>
				<div id="pager2"></div>
			</div>
			
		</div>
		<!-- //product_admin -->
	</div>
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>