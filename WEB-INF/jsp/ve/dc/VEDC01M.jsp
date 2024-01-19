<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript" src="/js<%=jsUrl%>.js"></script>
	<script>
	$(document).ready(function(){
		
		$("#btnSet").on("click",function(){
			location.href = "/ve/dc/VEDC01/page";
		});
	});
	</script>
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
	
		<div class="tagCover">
			<div class="fl" style="border:1px solid #ccc; width:calc(20% - 20px) !important; ">
				<div>
					<input type="button" class="btn btn-close btn-sm" value="보드세팅" id="btnSet" style="width:100%;">
				</div>
				
				<div>
					게시판 리스트
				</div>

			</div>
			<div class="fr" style="border:1px solid #ccc; width:calc(80% - 20px) !important; ">
				<p>
					<img id="Image1" src="http://xilaisong.com/UploadedFiles/cBanner/14477.jpg" style="height:130px;width:738px;border-width:0px;">
				</p>
				<div>
					<div class="fl">사내공지</div>
					<div class="fr">업무연락</div>
				</div>

			</div>
		</div>

	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>