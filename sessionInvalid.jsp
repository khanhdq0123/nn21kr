<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var loginURL = "/member/login/login";
	
	alert('세션이 종료되었습니다. 로그인 페이지로 이동합니다.')
	
	if(opener == null) {
		window.top.location.href = loginURL;
	}else {
		try {				
			if(opener.getId()=="nn21"){
				opener.window.top.location.href = loginURL;
				window.close();
			}				
		} catch(e) {
			document.top.location.href = loginURL;
		}				
	}
</script>	            