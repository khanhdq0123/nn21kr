<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>권한 그룹 리스트</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-control" content="No-cache" />
<meta http-equiv="Pragma" content="No-cache" />
<meta name="Description" content="" />
<meta name="Keywords" content="" />

<%@include file="/common/include/header.jsp"%>

<script type="text/javascript">
								
	$(document).ready(function() {
		
		jQuery("#groupAuthGrid").jqGrid({
			url:'/system/auth/groupAuthListJson.do', 		  
			datatype: "local",				   
			colNames:['권한 그룹 ID', '권한 그룹 명', '사용여부', '시스템 유형', '정렬순서'],
			colModel:[
				{name:'groupauth_id' , index:'groupauth_id'	, width:190, align:"center", sortable:true, editable:false, formatter:staffLinkFormatter, unformat:staffUnLinkFormatter},
				{name:'groupauth_nm' , index:'groupauth_nm'	, width:230, align:"left"  , sortable:true, editable:true, editoptions:{maxlength:30}, editrules:{required:true}},
				{name:'use_yn'		 , index:'use_yn'		, width:190, align:"center", sortable:true, editable:true, formatter:"select", edittype:"select", editoptions:{value:"Y:사용;N:미사용"}},
				{name:'system_typ'	 , index:'system_typ'	, width:220, align:"center", sortable:true, editable:true, formatter:"select", edittype:"select", editoptions:{value:"1:내부운영자;2:지사;3:고객사"}},
				{name:'sort_seq'	 , index:'sort_seq'		, width:190, align:"center", sortable:true, editable:true, editrules:{required:true, integer:true, maxValue:32767}}
			],
			
			mtype:"post",
			autowidth:true,
			rowNum:500,	   	
// 			rowList:[10,30,50],
			height: 260,			
		    viewrecords: true,
		    //sortname: 'code_cd',
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
		    		$("#groupAuthGrid").jqGrid('setGridParam',{datatype:'json'});
		    		return true;
		    	}
		    },
		    // 그리드 부가 파라미터 정보
		    postData : {
			},
		    afterSaveCell : function(id, name, val, iRow, iCol) {
		    	checkWhenColumnUpdated("groupAuthGrid", id);
		    }
		});

		jQuery("#groupAuthGrid").jqGrid('navGrid','#pager1',{search:false,edit:false,add:false,del:false,refresh:true});
		
		$("#btnReg").click( function() {
			CenterOpenWindow('/system/auth/groupAuthDetailPop.do', '권한그룹등록', '650','267', 'scrollbars=no, status=yes');
		});
		
		$("#btnSaveGroup").click(function (){
			saveGridSelected("groupAuthGrid", 'selected', 'save', "/system/auth/updateGroupAuthListJson");
		});
		
		
		jQuery("#menuAuthGrid").jqGrid({
			url:'/system/auth/menuAuthListJson',
			datatype: "local",				   
			colNames:['메뉴ID', '메뉴 명', '프로그램 URL', '메뉴여부', '사용여부', '개인정보포함여부', '권한그룹ID', 'flag'],
			colModel:[     
				{name:'menu_id'		 , index:'menu_id'		, width:100, align:"center", sortable:true, editable:false},
				{name:'menu_nm'	 	 , index:'menu_nm'		, width:260, align:"left"  , sortable:true, editable:false},
				{name:'menuurl_txt'	 , index:'menuurl_txt'	, width:500, align:"left"  , sortable:true, editable:false},
				{name:'menu_yn'		 , index:'menu_yn'		, width:150, align:"center", sortable:true, editable:false},
				{name:'use_yn'		 , index:'use_yn'		, width:150, align:"center", sortable:true, editable:true, formatter:"select", edittype:"select", editoptions:{value:"Y:사용;N:미사용"}},
				{name:'person_inf_yn', index:'person_inf_yn', width:150, align:"center", sortable:true, editable:false, formatter:"select", edittype:"select", editoptions:{value:"Y:포함;N:미포함"}},
				{name:'groupauth_id' , index:'groupauth_id'	, width:100, align:"center", sortable:true, editable:false, hidden:true},
				{name:'flag_yn'		 , index:'flag_yn'		, width:100, align:"center", sortable:true, editable:false, hidden:true}
			],
			
			mtype:"post",
			autowidth:true,
			rowNum:500,	   	
// 			rowList:[10,30,50],
			height: 260,			
		    viewrecords: true,
		    //sortname: 'code_id',
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
		    		$("#menuAuthGrid").jqGrid('setGridParam',{datatype:'json'});
		    		return true;
		    	}
		    },
		    // 그리드 부가 파라미터 정보
		    postData : serializeObject($('#searchForm')),
		    afterSaveCell : function(id, name, val, iRow, iCol) {
		    	checkWhenColumnUpdated("menuAuthGrid", id);
		    }
		});
		
		jQuery("#menuAuthGrid").jqGrid('navGrid','#pager2',{search:false,edit:false,add:false,del:false,refresh:true});
		
		$("#btnAdd").click( function() {
			CenterOpenWindow('/system/auth/groupAuthMenuDetailPop', '메뉴추가', '320','473', 'scrollbars=no, status=yes');
		});
		
		$("#btnSaveMenu").click(function (){
			saveGridSelected("menuAuthGrid", 'selected', 'save', "/system/auth/saveGroupMenuListJson.do");
		});
		
		
		$("#btnDel").click(function (){
			
			var selRows = $("#menuAuthGrid").getGridParam('selarrrow');
			var colModel = $("#menuAuthGrid").getGridParam('colModel');
			
			if(selRows.length==0) {
				toast("삭제할 항목을 선택하세요.");
				return false;
			}
			
			for(var i=selRows.length-1; i>=0; i--) {
				var rowData = $("#menuAuthGrid").getRowData(selRows[i]);
				
				var colData = rowData[colModel[7].name];
				
				if (colData == ""){
					$('#menuAuthGrid').delRowData(selRows[i]);
				}
			}
			
			if(selRows != ''){
				saveGridSelected("menuAuthGrid", 'selected', 'delete', "/system/menu/deleteMenuListGroupAuth.do");
			}			
		});
		
		// 권한그룹명/권한그룹ID 입력폼에서 엔터입력 시 검색
		$('#groupauth_nm, #groupauth_id').keydown(13, function(event) {
			if (event.keyCode == 13) {
				$("#btnSearch").click();
			}
		});
		
//
// 		$("#btnSearch").click( function(){
// 			$('#groupAuthGrid').clearGridData();
// 			$("#searchForm").submit();
// 		});
		
		// jQuery validation
		$("#searchForm").validate({
			rules: {
				groupauth_nm: {maxlength: 30},
				groupauth_id: {maxlength: 5}
			},
			messages: {
				groupauth_nm: {maxlength: jQuery.format("권한그룹명은 최대 {0} 글자 이하로 입력하세요.")},
				groupauth_id: {maxlength: jQuery.format("권한그룹ID는 최대 {0} 글자 이하로 입력하세요.")}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
			},
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {
				$("#groupAuthGrid").setGridParam({
					page : 1,
					postData : serializeObject($('#searchForm'))
				});
				$("#groupAuthGrid").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
				//$("#groupAuthGrid").trigger("reloadGrid");
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
		
		function staffLinkFormatter(cellVal, options, rowObj) {
			var cellval = String(cellVal);
			cellval = '<a href="javascript:searchContentsData(\'' + rowObj['groupauth_id'] + '\');" cellVal="'+ rowObj['groupauth_id'] +'">'+cellval+'</a>';										
			
			return  cellval === "" ? $.fn.fmatter.defaultFormat(cellval,options) : cellval;
		}
		
		function staffUnLinkFormatter(cellVal, options, cell) {
			return $('a', cell).attr('cellVal');
		}
	});
	
	function searchContentsData(groupauth_id) {
		$('#groupauth_id_s').val(groupauth_id);
		
		contentsSubmit = true;
		
		$("#menuAuthGrid").setGridParam({
			datatype: "json",
			page : 1,
			postData : serializeObject($('#searchForm'))
		}).trigger("reloadGrid");
	}
	
	function jsRefresh(){
		$("#groupAuthGrid").setGridParam({
			datatype: "json",
			page : 1
		});
		$("#groupAuthGrid").trigger("reloadGrid");
		
		$("#menuAuthGrid").setGridParam({
			datatype: "json",
			page : 1
		});
		$("#menuAuthGrid").trigger("reloadGrid");
	}
	
	function setMenuData(data){
		
		var allGridData = [];
		var idx = jQuery("#menuAuthGrid").getDataIDs();
		
		var addFlag = true;
		var countFlag = 0;
		
		for(var i=0;i<data.length;i++){
			var fullName,subName1,subName2,subName3,id,menuUrl,menuYn,personinfyn,useYn,groupauthId;
			var newGridData={menu_nm:"",menuurl_txt:"",menu_yn:"",person_inf_yn:"",use_yn:"", groupauth_id:"", menu_id:"" };
			
			/*
			fullName = data[i].full_name;
			
			subName1 = fullName.substr(0,fullName.indexOf('>')-1);
			fullName = fullName.substr(fullName.indexOf('>')+1,fullName.length);
			subName2 = fullName.substr(0,fullName.indexOf('>')-1);
			fullName = fullName.substr(fullName.indexOf('>')+1,fullName.length);
			*/
			
			menuUrl = data[i].menuurl_txt;
			menuYn = data[i].menu_yn;
			personinfyn = data[i].person_inf_yn;
			useYn = data[i].use_yn;
			groupauthId = $("#groupauth_id_s").val();
			id = data[i].id;
			
			newGridData.menu_nm = fullName;
			newGridData.menuurl_txt = menuUrl;
			newGridData.menu_yn = menuYn;
			newGridData.person_inf_yn = personinfyn;
			newGridData.use_yn = useYn;
			newGridData.groupauth_id = groupauthId;
			newGridData.menu_id = id;
			
			var temp = newGridData;
			allGridData[i] = temp;
			
			// 권한메뉴 추가 시 기존에 있는 메뉴와 중복인지 확인 후 처리
			for (var loop2 = 0; loop2 < idx.length; loop2++) {
				
				var predata = data[i].id;
				var newdata = $("#menuAuthGrid").getRowData(idx[loop2])['menu_id'];
				
				if (predata == newdata){
					addFlag = false;
					break;
				}
			}			
			if (! addFlag)
				break;
		}
		
		if (! addFlag) {
			toast("동일한 권한 메뉴가 존재합니다.");
			popupWin.focus();
			return;
		}
		
		for(var i=0;i<data.length;i++){
			jQuery("#menuAuthGrid").jqGrid('addRowData', idx.length+i+1, allGridData[i]);
			$("#menuAuthGrid").jqGrid('setSelection', idx.length+i+1);
		}
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
			<h3 class="header">권한 그룹 관리</h3>
			
			<span class="bullet6">시스템관리 &gt; 권한 그룹 관리</span>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form id="searchForm" name="searchForm" method="post" action="#">
				<input type="hidden" id="groupauth_id_s" name="groupauth_id_s" value="" />
					<fieldset>
					<legend>권한 그룹 관리 검색조건</legend>
						<div class="product_tbl">
							<table cellspacing="0" cellpadding="0" class="tbl_type2 tbl_cell">
							<caption>권한 그룹 관리 검색조건 정보</caption>
								<colgroup>
									<col width="100%" />
								</colgroup>
								<tbody>
									<tr>
										<td>
											<div class="tbl_wrap">
												<dl class="section">
													<dt><label for="groupauth_nm">권한 그룹 명 :</label></dt>
													<dd>
														<input type="text" id="groupauth_nm" name="groupauth_nm" style="width:80%;" maxlength="30" />
													</dd>
													<dt><label for="groupauth_id">권한 그룹 ID :</label></dt>
													<dd>
														<input type="text" id="groupauth_id" name="groupauth_id" style="width:80%;" maxlength="5" />
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
					<span class="res_search" >권한 그룹 리스트</span>
					<div class="min_btn" style="float:right;">
						<button id="btnReg" class="sky">권한 그룹 등록</button>					
						<button id="btnSaveGroup" class="sky">저장</button>
					</div>
				</div>			
				<table id="groupAuthGrid"></table>
				<div id="pager1"></div>
			</div>
			
			<br/><br/>
			<div class="grid">
				<div class="outcome info">
					<span class="res_search" >권한 메뉴 리스트</span>
					<div class="min_btn" style="float:right;">
						<button id="btnAdd" class="sky">추가</button>
						<button id="btnSaveMenu" class="sky">저장</button>
						<button id="btnDel" class="gray" >삭제</button>
					</div>
				</div>	
				
				<table id="menuAuthGrid"></table>
				<div id="pager2"></div>
			</div>
		</div>
		<!-- //product_admin -->
	</div>
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>