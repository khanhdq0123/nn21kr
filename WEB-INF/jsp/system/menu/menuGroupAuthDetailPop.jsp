<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<%@include file="/common/include/header.jsp"%>
<script type="text/javascript">
							
	$(document).ready(function() {
	    
		jQuery("#authGrid").jqGrid({
			url:'/system/menu/menuGroupAuthDetailPopJson.do',
			datatype: "json", 
			colNames:['권한그룹명', '권한그룹ID', '사용여부'],
			colModel:[
				{name:'groupauth_nm', index:'groupauth_nm', width:200,	align:"center",	sortable:true},
				{name:'groupauth_id', index:'groupauth_id',	hidden:true },
				{name:'use_yn'      , index:'use_yn',	hidden:true}
			],
			mtype:"post",
			autowidth: true,	// 부모 객체의 width를 따른다
			height: 450,
			multiselect : true,
			cellsubmit : 'clientArray',
			gridview: true,
			// 서버에러시 처리
			loadError : function(xhr,st,err) {
				girdLoadError();
		    },				    
		    // 데이터 로드 완료 후 처리 
		    loadComplete: function() {}, 
		 	// 그리드 부가 파라미터 정보
		    postData : serializeObject($('#gForm')),
		 	// cell이 변경되었을 경우 처리
		    afterSaveCell : function(id, name, val, iRow, iCol) {},
		    onSelectRow: function(id){           //jqGrid의 row를 선택했을 때 이벤트 발생
		    	//var rowData = $("#authGrid").getRowData(id);
		    	//window.opener.addGroup(rowData);
			 }
		});

		// grid 검색
		$("#btnSearch").click( function(){
			$("#gForm").submit();
		});
		
		// jQuery validation
		$("#gForm").validate({
			rules: {
				groupauth_nm: {maxlength: 30}				
			},
			messages: {
				groupauth_nm: {maxlength: jQuery.format("권한그룹명은 최대 {0} 글자 이하로 입력하세요.")}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
			},
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {
				$("#authGrid").setGridParam({
					page : 1,
					postData : serializeObject($('#gForm'))
				});
				$("#authGrid").trigger("reloadGrid");
			}
		});
		
		
		
		
		$("#btnApply").on("click", function(){
			
			var selRows = $("#authGrid").getGridParam('selarrrow');
			if(selRows.length==0) {
				toast('삭제할 항목을 선택하세요.');
			} else {
				for(var i=0; i<selRows.length; i++) {
					var rowData = $("#authGrid").getRowData(selRows[i]);
					window.opener.addGroup(rowData);
				}
			}
			
			window.close();

		});
		
	});

	
	function fn_f3(){
		$("#gForm").submit();
	}
</script>
</head>

<body class="sky">
	<!-- content_wrap -->
	<div class="layerpop_inner">
	<div class="ly_body">
		<h1 class="ly_header">권한그룹 검색</h1>
		<br/>
		
		<!-- product_admin -->
			<!-- product_form -->
			<div class="layer_contents">
				<form method="post" id="gForm" name="gForm" action="#">
					<fieldset>
					<legend>추가 검색조건</legend>
						<div class="product_tbl">
							<table cellspacing="0" cellpadding="0" class="layer_tbl">
							<caption>추가 검색조건 정보</caption>
								<colgroup>
<!-- 									<col width="25%" /> -->
<!-- 									<col width="40%" /> -->
									<col width="98%" />
								</colgroup>
								<tbody>
									<tr>
<!-- 										<th scope="row"><label for="groupauth_nm">권한그룹</label></th> -->
<!-- 										<td> -->
<!-- 											<input type="text" id="groupauth_nm" name="groupauth_nm" style="width:95%" /> -->
<!-- 										</td> -->
										<td>
											<div class="refer_bt" align="right">
<!-- 												<button id="btnSearch" class="sky">검색</button> -->
												<button id="btnApply" class="sky">적용</button>
												<button id="btnClose" class="gray">닫기</button>&nbsp;&nbsp;
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

			<div class="grid" min="180">
				<table id="authGrid"></table>
			</div>
		<!-- //product_admin -->
	</div>
	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>