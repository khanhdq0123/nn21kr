<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
var commonCodes = $.parseJSON('<c:out escapeXml="false" value="${applicationScope['CODEJSON']}"/>');

function getSubCodeList(upcode) {
	var subCodeList = commonCodes[upcode];
	var result = new Array();

	if(typeof subCodeList !== 'undefined') {
		for(i=0; i<subCodeList.length;i++) {		
			result[i] = {code:subCodeList[i]['code_cd'],name:subCodeList[i]['code_nm']};
		}
	}	
	return result;
}

</script>	