<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript">
	var jsonData;
	$(document).ready(function() {
		var isMultiSelect = "isMultiSelect=Y";

	    
		$.getJSON( "/system/auth/groupAuthMenuDetailPopJson", 
				function(data) {
				 	// 결과 처리
				 	jsonData = data.treeData;
				 	
				 	console.log(jsonData);
				 	
				 	
				 	$('#categoryTree').empty();
				 	$('#categoryTree').append(buildNestedList(data.treeData, {
																		 		rootId : '99999', 
																		 		useJsonAttr : true,
																		 		checkBox : true,
																		 		//<c:if test="${param.lastCheck eq 'Y'}">
																		 			lastCheck : true,
																		 		//</c:if>
																				clickEvent : function (nodeData) {
																					$('#'+nodeData.id+'_chk').trigger('click');
																		 		}
																		  	 }
				 	));
				 	
					$('#categoryTree').treeview({
						persist: "local",
						collapsed: true,
						animated: "fast"
					});
					
			  	}
		).fail(function() {
			  ajaxError();
		  });
		
		$('#btnSelect').click(function (){
			
			var checkLength = $('input:checkbox:checked').length;
			if(checkLength == 0) {
				toast("선택된 건이 없습니다.");
				return;
			} else {
				var returnData = [];
				$('input:checkbox:checked').each(function (){
					var value = $(this).attr('value');
					
					 $.each(jsonData, function(i, data) {
						 if(value == data.id) {
							 returnData.push(data);
						 }
					 });
				});
				//toast(returnData[0].id + ":" + returnData[0].name);
				//toast(returnData[1].id + ":" + returnData[1].name);
				opener.setMenuData(returnData);
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
			<h3 class="ly_header" style="float:left; margin-top:5px;">메뉴 검색</h3>
		</div>
		<div class="refer_bt" style="float:right;margin-right:20px;">
			<div class="min_btn mini">
				<button class="sky" id="btnSelect">선택</button>
				<button class="gray" id="btnClose">닫기</button>
			</div>
		</div>
		<div class="dp_category" style="width:100%;">
			<div class="category_tree mt20" style="width:90%;margin-left:15px;">
				<div class="tree_title">
					<h4 class="head">메뉴 TREE</h4>
				</div>
				<div class="tree_wrap" id="categoryTree" style="height:300px;overflow-y:auto;">
				</div>
			</div>
		</div>
	</div>
	<!-- //content_wrap -->
 <div id="toast"></div></body>


</html>