<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript">
	var jsonData;
	$(document).ready(function() {
		var isMultiSelect = "isMultiSelect=Y";

		//b.vendor_no, b.vendor_nm, c.login_id, c.staff_nm, c.job_cd, d.code_nm as job_nm
		
		jQuery("#staffList").jqGrid({
			url:'/notice/selectVendorPopJson',
			datatype: "local",				   
			colNames : [ '업체코드','(소속)업체명'],
			colModel:[
	            { name: 'vendor_no', index: 'vendor_no', align: 'center', width:100, sortable: false },
	            { name: 'vendor_nm', index: 'vendor_no', align: 'center', width:400, sortable: false }
			],
			
			mtype:"post",
			autowidth:true,
			rowNum:500,	   	
// 			rowList:[20,50,100],
			height: 280,
			sortname: 'staff_id',
		    viewrecords: true,
			cellsubmit : 'clientArray',
			cellEdit : true,
			gridview:true,
			editable:true,
			multiselect : true,
			pager: '#pager1',
			// 서버에러시 처리
			loadError : function(xhr,st,err) {
				girdLoadError();
		    },
			// 데이터 로드 완료 후 처리 
		    loadComplete: function(data) {
		    	jsonData = data.rows;
		    	setSortingGridData(this, data);
		    },
		    // 그리드 부가 파라미터 정보
		    postData : serializeObject($('#searchForm')),
		    beforeSelectRow: function (rowid, e) {
// 		    	checkWhenColumnUpdated("upGrid", rowid);
		    	$("#staffList").jqGrid('setSelection', rowid);
		    }
		});
		
		$("#staffList").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");

		$('#btnSelect').click(function (){
			
			var checkLength = $('input:checkbox:checked').length;
			
			
			if(checkLength == 0) {
				toast("선택된 건이 없습니다.");
				return;
			} else {
				var returnData = [];
				
				$('input:checkbox:checked').each(function (){
					
					var value = $(this).attr('value');
					var index = $('input:checkbox').index(this) - 1;
					 $.each(jsonData, function(i, data) {
						 if(index == i) {
							 returnData.push(jsonData[i]);
						 }
					 });
				});
				
				opener.setVendorListData(returnData);
				window.close();
			}
		});
		
	});
	
	</script>
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="layerpop_inner"  id="#">
		<div class="tit_area mt20">
			<h3 class="ly_header" style="float:left; margin-top:5px;">수신업체 선택</h3>
		</div>
		<div class="refer_bt" style="float:right;margin-right:20px;">
			<div class="min_btn mini">
			
				<input type="button" class="btn btn-primary btn-xs" id="btnSelect" value="선택">
				<input type="button" class="btn btn-close btn-xs" id="btnClose" value="닫기">
				
			</div>
		</div>
		<div class="dp_category" style="width:100%;">
		<form id="searchForm" name="searchForm" method="post" action="#">
			<div class="category_tree mt20" style="width:90%;margin-left:15px;">
				
				
				<div class="grid">
					<table id="staffList"></table>
				</div>

			</div>
		</form>
		</div>
	</div>
	<!-- //content_wrap -->
 <div id="toast"></div></body>


</html>