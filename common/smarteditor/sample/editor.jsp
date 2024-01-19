<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
	<title>에디터 샘플</title>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript">
	$(document).ready(function() {

		console.log(nhn.husky.EZCreator);
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "editArea",
			sSkinURI: "../SmartEditor2Skin.html", // 각 프로젝트에 맞는 Skin으로 대체
			fCreator: "createSEditor2"
		});
	});	
	</script>
</head>
<body>
<form name="prodForm">
	<textarea name="editArea" id="editArea" rows="10" cols="10" style="width:766px; height:412px;display:none">
	</textarea>
</form>	
<div id="toast"></div></body>
</html>