<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%String ip = request.getRemoteAddr();%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="shortcut icon" href="/common/image/icon.ico" /> 
	<title>IL Intranet</title>
	
	<script type="text/javascript">
		var logtrk_url =  "/member/login/login.do";
		
		if( navigator.userAgent.match(/iPad|iPod|iPhone|Mobile|UP.Browser|Android|BlackBerry|Windows CE|Windows Phone|Nokia|webOS|SonyEricsson|Opera Mini|opera mobi|IEMobile|POLARIS/) != null ) {
			toast("정상적인 접근이 아닙니다.\n본 사이트는 IL의 인트라넷 사이트입니다.");
			document.location.href=logtrk_url;
		}
	</script>
	<c:if test="${empty sessionScope.STAFFINFORMATION}">
		<script>
				document.location.href = logtrk_url;
		</script>
	</c:if>
	<c:if test="${!empty sessionScope.STAFFINFORMATION}">
		<script>
			document.location.href = "/admin.do";
		</script>
	</c:if>			
	</head>             
</html>
