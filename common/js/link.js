
var url = "";

/* 팝업 */
var urlOrderReg = "/cu/or/CUOR01/popup1?ord_typ=";					//접수하기
var urlOrderReg2 = "/ve/or/VEOR01/popup1?ord_typ=";					//접수하기
var urlCoopCompReg = "/partner/coopCompForRegPop?vendor_typ=";		//협력사등록하기
var urlPartnerReg = "/partner/partnerForRegPop?vendor_typ=";		//거래처등록하기
var urlDocumentReg = "/document/docDetail?mode=new";				//문서발송




//접수하기
var cfOrderReg = function(_typ, _no){
	
	var url = urlOrderReg;

	url += _typ;
	
	if(_no != null){
		url += '&vendor_no=' + _no;
	} 
	
	CenterOpenWindow(url, '접수하기', '1280','1024', 'scrollbars=yes, status=no');
}

//접수하기(지사)
var cfOrderReg2 = function(ord_typ){
	CenterOpenWindow(urlOrderReg2 + ord_typ, '접수하기', '1280','1024', 'scrollbars=yes, status=no');
}

//협력사등록
var cfCoopCompReg = function(vendor_typ){
	CenterOpenWindow(urlCoopCompReg + vendor_typ, '협력사등록하기', '900','380', 'scrollbars=yes, status=no');
}

//거래처등록
var cfPartnerReg = function(vendor_typ){
	CenterOpenWindow(urlPartnerReg + vendor_typ, '거래처등록하기', '900','440', 'scrollbars=yes, status=no');
}

//문서발송
var cfDocumentReg = function(){
	CenterOpenWindow(urlDocumentReg, '문서발송', '1000','800', 'scrollbars=yes, status=no');
}






