<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>메뉴 관리</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-control" content="No-cache" />
<meta http-equiv="Pragma" content="No-cache" />
<meta name="Description" content="" />
<meta name="Keywords" content="" />

<%@include file="/common/include/header.jsp"%>

<script type="text/javascript">

var actionUrl = "/system/menu/updateMenuInfoDetail";
								
	/**
		ColModel 작성법
		name, index, width, align, sortable, formatter, formatoptions, editable, eidttype, editoptions, editrules, hidden, key 순으로 작성
		custom formatter를 사용한 경우 unformat을 반드시 정의할 것
	*/
	$(document).ready(function() {
		
		getTreeData();
		
		// 트리

	    jQuery("#menuGrid").jqGrid({
	  		url:'/system/menu/menuListGroupAuthListJson',
	  		datatype: "local",				   
	  		colNames:['권한 그룹 ID', '권한 그룹', '사용여부', '메뉴ID', '구분'],
	  		colModel:[
	  			{name:'groupauth_id', index:'groupauth_id', width:250, align:"center", sortable:true, editable:false, key:true},
	  			{name:'groupauth_nm', index:'groupauth_nm', width:280, align:"center", sortable:true, editable:false},
	  			{name:'use_yn'      , index:'use_yn'      , width:250, align:"center", sortable:true, editable:true, formatter:"select", edittype:"select", editoptions:{value:"Y:사용;N:미사용"}},
	  			{name:'menu_id'     , index:'menu_id'     , width:50, hidden:true},
	  			{name:'flag_yn'     , index:'flag_yn'     , width:50, hidden:true}
	  		],
	  		mtype:"get",
	  		autowidth: true,	// 부모 객체의 width를 따른다
	  		//rownumbers: true,
	  		rowNum:500,	   	
	  		//rowList:[20,50,100],
	  		//width : $("#content").width() - $("#treeDiv").width() - $("#blank").width(),
	  		height: 500,
	  		//pager: '#subPager1',
	  		sortname: 'groupauth_id',
	  	    viewrecords: true,
	  	    //sortorder: "desc",
	  	    //caption: "게시판 샘플", 
	  	    multiselect : true,
	  	    cellEdit : true,
	  		cellsubmit : 'clientArray',
	  		gridview: true,
	  		// 서버에러시 처리
	  		loadError : function(xhr,st,err) {
	  			girdLoadError();
	  	    },
	  	    
	  		// 데이터 로드 완료 후 처리 
	  	  	loadComplete: function(data) {
	  	  		

	  	  		
	  	  		setSortingGridData(this, data);
	  	  		
				var detailData = $('#menuGrid').getGridParam('userData');
				$('#upmenu_id').val(detailData.upmenu_id);
				$('#upmenu_nm').val(detailData.upmenu_nm);
				$('#menu_id').val(detailData.menu_id);
				$('#menu_nm').val(detailData.menu_nm);
				$('#menu_nm_en').val(detailData.menu_nm_en);
				$('#menu_nm_cn').val(detailData.menu_nm_cn);
				$('#screen_id').val(detailData.screen_id);
				$('#js_url').val(detailData.js_url);
				$('#menuurl_txt').val(detailData.menuurl_txt);
				$('#person_inf_yn').val(detailData.person_inf_yn);
				if(detailData.person_inf_yn == 'Y') {
					$('#person_inf_yn1').prop('checked',true);
					$('#person_inf_yn2').prop('checked',false);
				} else if(detailData.person_inf_yn == 'N') {
					$('#person_inf_yn1').prop('checked',false);
					$('#person_inf_yn2').prop('checked',true);
				};
				$('#menu_yn').val(detailData.menu_yn);
				if(detailData.menu_yn == 'Y') {
					$('#menu_yn1').prop('checked',true);
					$('#menu_yn2').prop('checked',false);
				} else if(detailData.menu_yn == 'N') {
					$('#menu_yn1').prop('checked',false);
					$('#menu_yn2').prop('checked',true);
				};
				$('#use_yn').val(detailData.use_yn);
				if(detailData.use_yn == 'Y') {
					$('#use_yn1').prop('checked',true);
					$('#use_yn2').prop('checked',false);
				} else if(detailData.use_yn == 'N') {
					$('#use_yn1').prop('checked',false);
					$('#use_yn2').prop('checked',true);
				};
				if(detailData.system_typ == undefined){
					$("#system_typ option:eq(0)").attr("selected", "selected");
				} else {
					$('#system_typ').val(detailData.system_typ);
				}
				$('#sort_seq').val(detailData.sort_seq);
				$('#comment_txt').val(detailData.comment_txt);
		    },
		    onPaging: function(btn) {
		    	if($('#'+btn).hasClass('ui-state-disabled')) {
		    		return 'stop';
		    	} else { 
		    		$("#menuGrid").jqGrid('setGridParam',{datatype:'json'});
		    		return true;
		    	}
		    },
			postData : {
				menu_id_s:function() {
					return $("#menu_id_s").val();
				},
				additionalParam:'dummy'
			},
	  	   
	  	    // cell이 변경되었을 경우 처리
	  	    afterSaveCell : function(id, name, val, iRow, iCol) {
	  	    	checkWhenColumnUpdated("menuGrid", id);
	  	    },
	  	    //스크롤바 자동 생성
	  	    shrinkToFit:true			    
	  	});

		
		// jqGrid Navigator
		//jQuery("#list1").jqGrid('navGrid','#pager1',{search:false,edit:false,add:false,del:false,refresh:true});
		
		$("#btnReg").click( function() {
			
			if ($('#levels').val()=='') {
				toast("메뉴를 선택하고 신규 등록을 해 주세요.");
				return false;
			}
			
			if ($('#levels').val()=='4') {
				toast("4Depth에서는 신규 등록을 할 수 없습니다.");
				return false;
			} else {
				CenterOpenWindow('/system/menu/menuInfoDetailPop.do?menuId='+ $("#menu_id").val(), '메뉴등록', '680','360', 'scrollbars=no, status=yes');
			}
		});
		
		$("#btnMod").click( function() {
			actionUrl = "/system/menu/updateMenuInfoDetail";
			$("#gForm").submit();
		});
		
		$("#btnMenuDel").click( function() {
			actionUrl = "/system/menu/deleteMenuInfoDetail";
			$("#gForm").submit();
		});
		
		$("#gForm").validate({
			debug : true,
			rules : {
				menu_nm:{required:true, maxlength:30},
				menuurl_txt: {required:true, maxlength:200},
				sort_seq:{required:true, number:true, max:32767},
				comment_txt:{maxlength:4000}
			}, 		
			messages: {
				menu_nm:{
					required:"메뉴명을 입력하세요.",
					maxlength:jQuery.format("메뉴명은 최대 {0}자 이하로 입력하세요.")
				},
				menuurl_txt: {
					required:"프로그램 URL을 입력하세요.",
					maxlength:jQuery.format("프로그램 URL은 최대  {0}자 이하로 입력하세요.")
				},
				sort_seq:{
					required:"정렬순서를 입력하세요",
					number:"정렬순서는 숫자로 입력하셔야합니다.",
					maxlength:jQuery.format("정렬순서는 최대  {0} 이하로 입력하세요.")
				},
				comment_txt:{						
					maxlength:jQuery.format("비고는 최대  {0}자 이하로 입력하세요.")
				}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
            },
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {							
				$.ajax({
					type: "POST",
					url: actionUrl,
					data: $(form).serialize(),
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						if(data.code == '0') {
							toast(data.msg);
							
						}	
					},
					error: function(jqXHR, textStatus, errorThrown) {
						toast(jqXHR.status);						
					}
				});
			}
		});
		
		$("#btnAdd2").click( function() {
			
			if ($('#levels').val()=='') {
				toast("메뉴를 선택하고 권한리스트 추가를 해 주세요.");
				return false;
			}
			
			if ($('#levels').val()=='1') {
				toast("1Depth에서는 권한리스트 추가를 할 수 없습니다.");
				return false;
			} else {
				CenterOpenWindow('/system/menu/menuGroupAuthDetailPop.do', '권한그룹검색', '410','630', 'scrollbars=auto, status=yes');
			}
			
		});
		
		$("#btnSave2").click(function (){
			//저장시 처리하는 부분 -2014.03.07
		    $("#menuGrid").editCell(0,0,false);
			
			saveGridSelected("menuGrid", 'selected', 'save', "/system/menu/saveMenuListGroupAuth.do");
		});
		
		
		$("#btnDel2").click(function (){
			
			var selRows = $("#menuGrid").getGridParam('selarrrow');
			
			var colModel = $("#menuGrid").getGridParam('colModel');
			
			if(selRows.length==0) {
				toast("삭제할 항목을 선택하세요.");
				return false;
			}
			
			for(var i=selRows.length-1; i>=0; i--) {
				var rowData = $("#menuGrid").getRowData(selRows[i]);
				
				var colData = rowData[colModel[5].name];
				
				if (colData == ""){
					$('#menuGrid').delRowData(selRows[i]);
				}
			}
			
			if(selRows != ''){
				saveGridSelected("menuGrid", 'selected', 'delete', "/system/menu/deleteMenuListGroupAuth.do");
			}
			
		});
		
	});	
					
	function getTreeData(){
		$.getJSON( "/system/menu/menuListTreeJson", 
				function(data) {
				 	// 결과 처리
				 	$('#menuTree').empty();
				 	$('#menuTree').append(buildNestedList(data.treeData, {
																		 		rootId : '99999', 
																		 		useJsonAttr : true,
																		 		clickEvent : function (nodeData) {
																		 		
																		 		$("#menu_id_s").val(nodeData.id);
																		 		
																		 		$("#levels").val(nodeData.levels);
																			    	
																			    $("#menuGrid").setGridParam({ datatype: "json" });
																			    $("#menuGrid").trigger("reloadGrid", nodeData.id);
																			    	
																		 		}
																		  	 }
				 	));
				 	
					$('#menuTree').treeview({
						persist: "Cookie",
						cookieId: "systemmenuTree",
						collapsed: true,
						animated: "fast"
					});
					
			  	}
		).fail(function() {
			  ajaxError();
		  });
	}
	
	function addGroup(rowData) {
		
		var selRows = $("#menuGrid").getDataIDs();
		var addFlag = true;
		
		for (var loop2 = 0; loop2 < selRows.length; loop2++) {
			
			if (rowData.groupauth_id == $("#menuGrid").getRowData(selRows[loop2])['groupauth_id']) {
				addFlag = false;
			}
		}
		
		if (! addFlag) {
			toast("동일한 권한 그룹이 존재합니다..");
			popupWin.focus();
			return;
		}
		
		var data = {
				 groupauth_id : rowData.groupauth_id
				,groupauth_nm : rowData.groupauth_nm
				,menu_id : $("#menu_id").val()
				,use_yn : rowData.use_yn
				};
		
		$("#menuGrid").addRowData(rowData.groupauth_id, data, "last");
		$("#menuGrid").jqGrid('setSelection', rowData.groupauth_id);
		
		//popupWin.close();
		
		//var data = {vendor_no : dataList[loop].vendor_no,vendor_nm : dataList[loop].vendor_nm};
		//$("#menuGrid").addRowData(dataList[loop].vendor_no, data, "last");
		//$("#menuGrid").jqGrid("setSelection", dataList[loop].vendor_no);
	}
	
	
	function setGroupData(dataList) {
		var addFlag = true;
		for (var loop = 0; loop < dataList.length; loop++) {
			var selRows = $("#menuGrid").getDataIDs();
			for (var loop2 = 0; loop2 < selRows.length; loop2++) {
				if (dataList[loop].vendor_no == $("#menuGrid").getRowData(selRows[loop2])['groupauth_id']) {
					addFlag = false;
					break;
				}
			}
			if (! addFlag)
				break;
		}
		
		if (! addFlag) {
			toast("동일한 업체가 존재합니다.");
			return;
		}
		
		for (var loop = 0; loop < dataList.length; loop++) {
			var data = {vendor_no : dataList[loop].vendor_no,vendor_nm : dataList[loop].vendor_nm};
			$("#menuGrid").addRowData(dataList[loop].vendor_no, data, "last");
			$("#menuGrid").jqGrid("setSelection", dataList[loop].vendor_no);
		}
	}
	
</script>
</head>
<body class="sky">
<!-- 	<div id="test"> -->
<!-- 	</div> -->
<!-- <textarea rows="4" id="test" name="test" style="width:90%"></textarea> -->
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">메뉴 관리</h3>
			
			<span class="bullet6">시스템 관리 &gt; 메뉴 관리</span>
		</div>

		<div class="dp_category">
			<div class="category_tree">
				<div class="tree_title">
					<h4 class="head" onclick="getTreeData();">메뉴 트리</h4>
				</div>
				<div class="tree_wrap" id="menuTree">				
				</div>
			</div>
			<!-- product_admin -->
			<div class="product_admin">
				<!-- product_form -->
				<div class="product_form">
					<div class="refer bullet6">
						<ul>
							<li>메뉴 상세 정보</li>
						</ul>
						<c:if test="${staff_id eq 'yh98kim'}">
						<div class="refer_bt">
							<div class="min_btn ">
								<button id="btnReg" class="sky">신규 등록</button>
								
							</div>
							<div class="min_btn">
								<button id="btnMod" name="btnMod" class="sky" style="margin-top:0;">저장</button>
								<button id="btnMenuDel" class="gray">삭제</button>
							</div>
						</div>
						</c:if>
					</div>
					<form id="gForm" name="gForm" method="post" action="#">
					<input type="hidden" id="menu_id_s" name="menu_id_s" />
					<input type="hidden" id="levels" name="levels" />  
						<fieldset>
						<legend>메뉴 관리 상세</legend>
							<div class="product_tbl">
								<table cellspacing="0" cellpadding="0" summary="" class="tbl_type2">
								<caption>메뉴 관리 상세</caption>
									<colgroup>
										<col width="15%" />
										<col width="35%"/>
										<col width="15%" />
										<col width="35%"/>
									</colgroup>
									<tbody>
										<tr>
											<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="upmenu_id">상위메뉴 ID</label></th>
											<td>
												<input type="text" id="upmenu_id" name="upmenu_id" style="border:none" readonly="readonly" />
											</td>
											<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="upmenu_nm">상위 메뉴명</label></th>
											<td>
												<input type="text" id="upmenu_nm" name="upmenu_nm" style="border:none" readonly="readonly" />
											</td>
										</tr>
										<tr>
											<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="menu_id">메뉴 ID</label></th>
											<td>
												<input type="text" id="menu_id" name="menu_id" style="border:none" readonly="readonly" />
											</td>
											<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="js_url">js url</label></th>
											<td>
												<input type="text" id="js_url" name="js_url" /> ex) /ad/ex/ADEX01
											</td>
										</tr>
										
										
										<tr>
											<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="menu_id">화면 ID</label></th>
											<td>
												<input type="text" id="screen_id" name="screen_id" /> ex) ADEX01
											</td>
											<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="menu_nm">메뉴명</label></th>
											<td>
												<input type="text" id="menu_nm" name="menu_nm" style="width:98%;" />
											</td>
										</tr>
										
										<tr>
											<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="menuurl_txt">프로그램 URL</label></th>
											<td>
												<input type="text" id="menuurl_txt" name="menuurl_txt" style="width:99%;" />
											</td>
											<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="menu_nm_en">메뉴명(영문)</label></th>
											<td>
												<input type="text" id="menu_nm_en" name="menu_nm_en" style="width:98%;" />
											</td>
										</tr>
										<tr>
											<th scope="row"><span class="starMark">필수입력 항목입니다.</span>메뉴여부</th>
											<td>
												<input type="radio" id="menu_yn1" name="menu_yn" value="Y" checked="checked" /><label class="int_space" for="menu_yn1">사용</label>
												<input type="radio" id="menu_yn2" name="menu_yn" value="N" /><label class="int_space" for="menu_yn2">미사용</label>
											</td>
											<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="menu_nm_cn">메뉴명(중문)</label></th>
											<td>
												<input type="text" id="menu_nm_cn" name="menu_nm_cn" style="width:98%;" />
											</td>
										</tr>
										<tr>
											<th scope="row"><span class="starMark">필수입력 항목입니다.</span>사용여부</th>
											<td>
												<input type="radio" id="use_yn1" name="use_yn" value="Y" checked="checked" /><label class="int_space" for="use_yn1">사용</label>
												<input type="radio" id="use_yn2" name="use_yn" value="N" /><label class="int_space" for="use_yn2">미사용</label>
											</td>
											<th scope="row"><label for="sort_seq"><span class="starMark">필수입력 항목입니다.</span>정렬순서</label></th>
											<td>
												<input type="text" id="sort_seq" name="sort_seq" style="width:98%;" />
											</td>
										</tr>
										<tr>
											<th scope="row"><label for="comment_txt">비고</label></th>
											<td colspan="3">
												<textarea rows="3" id="comment_txt" name="comment_txt" style="width:98.5%" ></textarea>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</fieldset>
					</form>
				</div>
				<br/>
				
				<div class="corner_tab mt30">
					<div class="grid" min="800">
						<div class="outcome info">
							<span class="res_search" >메뉴 권한 리스트 (현재 메뉴를 사용할 수 있는 권한 그룹)</span>
							
							
							<div class="min_btn" style="float:right;">
								<button id="btnAdd2" class="sky">추가</button>
								<button id="btnSave2" class="sky">저장</button>
								<button id="btnDel2" class="gray">삭제</button>
							</div>
							
							
							
						</div>
						<table id="menuGrid"></table>
					</div>
				</div>
			</div>
			<!-- //product_admin -->
		</div>
	</div>
	<!-- //content_wrap -->
 <div id="toast"></div></body>
 </html>