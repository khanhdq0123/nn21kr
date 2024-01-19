//======================================= 변수 정의 시작 =======================================

/**
 * 메세지 유형
 */
var MSG_TP_ERR = "error"; // 에러 메세지
var MSG_TP_MSG = "msg"; // 일반 메세지
var MSG_TP_STATUS = "status"; // 상태 메세지
var DATE_DELIMETER = "-";

/**
 * 로딩이미지 제어를 위한 변수
 * ajax call이 발생할 때 마다 (+)해 주고 ajax complete시 (-)해서, complete시 0이 되면 로딩이미지를 닫는다.
 */
var g_ajaxCallCount = 0;

var g_localeOptions = {
	dateFormat_nm : "YYYY-MM-DD", 				 /* 일자포멧 */
	yymmFormat : "YYYY-MM",						 /* 년월포멧 */
	mmddFormat : "MM-DD",       				 /* 월일포멧 */
	timeFormat_nm : "", 						 /* 포맷-시간 */
    numberType : "#,##0",				         /* 숫자 포멧 */
};

/**
 * biz API URL정보 설정 값
 */
var bizApiInfoObj = {};

/**
 * 팝업 참조 Array
 */
var winToCloseArr = [];

// 물품콤보
var lrgClasList		= [];
var medClasList		= [];
var smlClasList		= [];
//======================================= 변수 정의 끝 =======================================

//======================================= prototype 정의 시작 ============================================

/* string prototype */
/**
* 공백 문자를 제거
*/
String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g, "");
};

/**
* 왼쪽에 위치한 공백 문자를 제거
*/
String.prototype.ltrim = function() {
	return this.replace(/^\s+/, "");
};

/**
* 오른쪽에 위치한 공백 문자를 제거
*/
String.prototype.rtrim = function() {
	return this.replace(/\s+$/, "");
};

/**
* 문자열의 왼쪽을 padding 문자로 채운다
*/
String.prototype.lpad = function(maxLength, fillChar) {
	var srcStr = this.substr(0, maxLength);
	var cnt = 0;

	for (var inx = srcStr.length; inx < maxLength; inx++) {
		srcStr = fillChar.charAt(cnt) + srcStr;
		cnt++;
		cnt = (cnt == fillChar.length) ? 0 : cnt;
	}
	return srcStr;
};

/**
* 문자열의 오른쪽을 padding 문자로 채운다
*/
String.prototype.rpad = function(maxLength, fillChar) {
	var srcStr = this.substr(0, maxLength);
	var cnt = 0;

	for (var inx = srcStr.length; inx < maxLength; inx++) {
		srcStr = srcStr + fillChar.charAt(cnt);
		cnt++;
		cnt = (cnt == fillChar.length) ? 0 : cnt;
	}
	return srcStr;

};

/**
* 문자열이 null,Blank 인지 체크
*/
String.prototype.isNull = function(pattern) {
	if (this == undefined || this == null || this == '') return true;
	return false;
};

/**
* 영문자 유효성 체크
*/
String.prototype.isAlpha = function() {
	var str = this.trim();
	if (str.isNull()) return true;
	return (/^[a-zA-Z]+$/).test(str);
};

/**
* 영문자(Blank허용) 유효성 체크
*/
String.prototype.isAlphaBlank = function() {
	var str = this.trim();
	if (str.isNull()) return true;
	return (/^[\sa-zA-Z]+$/).test(str);
};

/**
* 영문자/숫자 유효성 체크
*/
String.prototype.isAlphaNum = function() {
	var str = this.trim();
	if (str.isNull()) return true;
	return (/^[0-9a-zA-Z]+$/).test(str);
};



/**
* 영문자/숫자/특수문자 유효성 체크
*/
String.prototype.isAlphaNumSpec = function() {
	var str = this.trim();
	if (str.isNull()) return true;
	//var  pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
	var pattern =  /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/

	if(pattern.test(str)) {
		return false;
	}
	return true;

	//return (/^[0-9a-zA-Z]+$/).test(str);
};


/**
* 숫자형 유효성 체크
*/
String.prototype.isNumber = function() {
	var str = this.trim();
	str = gfn_removeChar(str, "[,]");
	str = gfn_removeChar(str, "[-]");
	str = gfn_removeChar(str, "[+]");
	str = gfn_removeChar(str, "[.]");
	if (str.isNull()) return true;
	return (/^[0-9]+$/).test(str);
};

/**
* 입력문자열 바이트 계산
*/
String.prototype.getByte = function() {
    var str = this;
    var len = 0;
    for( var i = 0; i < str.length; i++) {
    	var nCode = str.charCodeAt(i);
        if( nCode < 0 || 127 < nCode ) {
            len += 3; // 아스키코드 외
        } else if( nCode == 10 ) {
            len += 2; // textarea LF to CRLF
        } else {
            len += 1; // 아스키코드
        }
    }
    return len;
};

/**
* 이메일 유효성 체크
*/
String.prototype.isEmail = function() {
	var str = this.trim();
	if (str.isNull())
		return true;
	return (/\w+([-+.]\w+)*@\w+([-.]\w+)*\.[a-zA-Z]{2,4}$/).test(str);
};

/**
* 문자열 replaceAll
*/
String.prototype.replaceAll = function (target, replacement) {
	return this.split(target).join(replacement);
};

/**
* html tag 제거
*/
String.prototype.stripTags = function () {
	var rex = /(<([^>]+)>)/ig;
	return this.replace(rex , '');
};


// IE 대응
if (!String.prototype.startsWith) {
	String.prototype.startsWith = function(searchString, position) {
		position = position || 0;
		return this.indexOf(searchString, position) === position;
	};
}

//======================================= prototype 정의 끝 ============================================

	var isCtrl = false;	//ctrl 눌림여부
	var isAlt = false;	//alt 눌림여부
	
	var F1 = 112;
	var F2 = 113;
	var F3 = 114;
	var F4 = 115;
	var F5 = 116;
	var F6 = 117;
	var F7 = 118;
	var F8 = 119;
	var F9 = 120;
	var F10 = 121;
	var F11 = 122;
	var F12 = 123;

	document.onkeyup = function(e){
		
		if(e.which == 17) isCtrl = true;
		if(e.which == 18) isAlt = true;
		
	}
	
	document.onkeydown = function(e){
		
		if(e.keyCode == F1 || e.keyCode == F2 || e.keyCode == F3 || e.keyCode == F4 || e.keyCode == F6 || e.keyCode == F7 || e.keyCode == F8 || e.keyCode == F9 || e.keyCode == F10 || e.keyCode == F11){
			e.keyCode = 0;
			e.cancelBubble = true;
			e.returnValue = false;
		}
		
		switch (e.keyCode) {
			case F1:
				fn_f1();
				break;
			case F2:
				fn_f2();
				break;
			case F3:
				fn_f3();
				break;
			case F4:
				fn_f4();
				break;
			case F5:
				fn_f5(e);
				break;
			case F6:
				fn_f6();
				break;
			case F7:
				fn_f7();
				break;
			case F8:
				fn_f8();
				break;
			case F9:
				fn_f9();
				break;
			case F10:
				fn_f10();
				break;
			case F11:
				fn_f11();
				break;
			default:
		}
	}

function fn_f5(e){
	
	e.preventDefault();
	parent.mainframe.location.reload();

}


function fn_reset(){
	$('#searchForm')[0].reset();
}




/**
  * 화면중앙에 새창열기 -2004.09.05일 추가
  * window.open 에서 사용되는 방식으로 features 설정
  * @param theURL    새창의 Url
  * @param winName   새창의 name
  * @param features  새창의 세부 설정
  * @return
  */
function CenterOpenWindow(theURL, winName, width, height, fstate ) {
    var features = "width=" + width ;
    features += ",height=" + height ;

	var state = "";

	if (fstate == "") {
       state = features + ", left=" + (screen.width-width)/2 + ",top=" + (screen.height-height)/2;
	} else {
       state = fstate + ", " + features + ", left=" + (screen.width-width)/2 + ",top=" + (screen.height-height)/2;
	}

	popupWin = window.open(theURL,winName,state+",resizable=1 ");

    popupWin.focus();
}

/**
 * 공통 팝업
 * @param kind		팝업 종류
 * @param params	파라미터(? 를 제외한 파라미터 URL)
 * @returns
 */
function openPop(kind, params) {
	var link = [ 
	    {url:'/exhibition/banner/bannerSearch.do', winName:'bannerPop', width:480 , height:520 } 		//6 배너이미지
	   ,{url:'/common/common/zipcodeSearch.do', winName:'zipcodeInfo', width:910 , height:600 } 	//25 우편번호
	];

	if(kind == 9 || kind == 21 || kind == 10 || kind == 24  ) {
		if(kind == 9)
		    openLayerPop(2, params);
		if(kind == 10)
			openLayerPop(1, params);
		if(kind == 21)
			openLayerPop(0, params);
		if(kind == 24)
			openLayerPop(3, params);
		//if(kind == 27)
		//	openLayerPop(4, params);
	}
	else if(kind == 0 || kind == 16 || kind ==  13 || kind ==  14 || kind ==  15 || kind ==  23 || kind ==  12 || kind ==  8) {
		
		var popName = link[kind].winName;
		if(kind == 16) popName = popName + params.replace('ord_no=',''); 
		
		console.log(params)
		if(kind == 0 && params != undefined) {
			params = 'ctg_no=' + String(params)
		}
		
		CenterOpenWindow(link[kind].url+((typeof params == 'undefined')?'':'?'+params)
				, popName
				, link[kind].width
				, link[kind].height
				, 'scrollbars=yes, resizable=no, status=no' );	
	}
	else {
		CenterOpenWindow(link[kind].url+((typeof params == 'undefined')?'':'?'+params)
				, link[kind].winName
				, link[kind].width
				, link[kind].height
				, 'scrollbars=auto,resizable=no, status=no' );	
	}
}

/**
 * 공통 레이어 팝업
 * @param kind
 * @param params
 * @returns {Boolean}
 */
function openLayerPop(kind, params) {
	var link = [
	    {url:'/member/member/memberSummary.do'} //1 회원 요약 정보
	   ,{url:'/partner/partner/partnerThumbDetail.do'} //2 공급사 요약정보
	   ,{url:'/promotion/coupon/couponSummaryInfo.do'} //3 행사 요약정보

	];	
	
	if($("#layerPop").length>0) $("#layerPop").remove();
	$('<div/>',{id:'layerPop'}).appendTo($('body'));
	

	$("#layerPop").hide();
	$('#layerPop').load(link[kind].url+((typeof params == 'undefined')?'':'?'+params), function(){
		$('#layerPop').css("position","absolute");
		//iframe 상위 header 높이(88px)
		$('#layerPop').css("top", Math.max(0, (($(window.top).height() - 88 - $(this).outerHeight()) / 2) + 
	                                                $(window.top).scrollTop()) + "px");
		$('#layerPop').css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + 
	                                                $(window).scrollLeft()) + "px");
		$('#layerPop').show();	
	});	
	
	return false;
}

/**
 * 검색 폼에서 날짜 자동 계산(오늘, 일주일전, 한달전)
 * @param from		검색 시작 날짜를 할당할 폼객체 ID
 * @param to		검색 종료 날짜를 할당할 폼객체 ID
 * @param when		"today"|"weekago"|"monthago"|"twomonthago"|"threemonthago"
 * @returns void	
 */
function setSearchDate(from, to, when) {
	var obdt = new Date();
	
	var dtTo = obdt.getFullYear() + "-"
			+ ((obdt.getMonth() + 1).toString().length == 1 ? "0" : "") 
			+ (obdt.getMonth() + 1) + "-" 
			+ (obdt.getDate().toString().length == 1 ? "0" : "") + obdt.getDate();
	
	switch (when) {
	case 'today':
		break;
	case 'yesterday':
		obdt.setDate(obdt.getDate() - 1);
		break;
	case 'weekago':
		obdt.setDate(obdt.getDate() - 7);
		break;
	case 'halfmonthago':
		obdt.setDate(obdt.getDate() - 15);
		break;
	case 'monthago':
		obdt.setMonth(obdt.getMonth() -1);
		break;
	case 'twomonthago':
		obdt.setMonth(obdt.getMonth() -2);
		break;
	case 'threemonthago':
		obdt.setMonth(obdt.getMonth() -3);
		break;
	case 'allago':
		break;
	}
	
	var dtFrom = obdt.getFullYear() + "-"
			+ ((obdt.getMonth() + 1).toString().length == 1 ? "0" : "") 
			+ (obdt.getMonth() + 1) + "-" 
			+ (obdt.getDate().toString().length == 1 ? "0" : "") + obdt.getDate();
	
	// 인터페이스시 날짜 전체 조건 시작일이 필요
	if(when=='allago'){
		dtFrom = '2014-01-01'
	}
	
	$("#" + from).val(dtFrom);
	$("#" + to).val(dtTo);
}

/**
 * 검색조건의 시작일 종료일 체크 함수
 * @param from		검색 시작 날짜 폼객체 ID
 * @param to		검색 종료 날짜 폼객체 ID
 * @param title_nm	검색일의 타이틀명 (예 : '등록일', '행사기간', '유효기간')
 * @returns boolean (true/false)	
 */
function checkTermSearch(from, to, title_nm){
	if( $("#" + from).val() == "" && $("#" + to).val() == ""){
		return true;
	}else if ($("#" + from).val() == ""){
		toast("시작일을 입력해 주세요.(" +title_nm + ")" );
		return false;
	}else if ($("#" + to).val() == ""){
		toast("종료일을 입력해 주세요.(" +title_nm + ")" );
		return false;
	}else{
		var from_val =  $("#" + from).val().replace(/-/g, '');
		var to_val = $("#" + to).val().replace(/-/g, '');
		
		if(from_val > to_val){
			toast("시작일이 종료일보다 클 수 없습니다.(" +title_nm + ")" );
			return false;
		}
		return true;
	}
}

/**
 * Form 안의 input 객체값을 json 형태로 return
 * @param  Form 객체
 * @return json Data
 */
function serializeObject(formObj){
    var o = {};
    var a = formObj.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

/**
 * json 객체로 treeview에 맞는 format object 생성
 * 
 * @param treeNodes jsonObject
 * @param option - rootId : 최상위 ID 
 * 				 - useJsonAttr : json Data 전체 사용 여부
 * 								(기본값 : id - 노드 ID 및 Name, name - 노드 text, parent_id - 상위 노드 ID)
 *               - checkBox : checkBox 사용여부
 *               - lastCheck : true인 경우 json Data에 last_yn 이 Y인 값만 checkbox 사용
 *               - onClick : 노드를 선택한 경우 실행되는 function ( return 값은 jsonData)
 * @returns 
 */
function buildNestedList(treeNodes, option) {
	  var nodesByParent = {};
	  
	  $.each(treeNodes, function(i, node) {
	    if (!(node.parent_id in nodesByParent)) nodesByParent[node.parent_id] = [];
	    nodesByParent[node.parent_id].push(node);
	  });
	  
	  function buildTree(children) {
	    var $container = $("<ul>");
	    if (!children) return;
	    $.each(children, function(i, child) {
	      var o;
	      if(option.useJsonAttr !== undefined && option.useJsonAttr == true) {
	    	  o = $("<li>", child);
	    	  o.attr('name',child.id).html("<label>"+child.name+"</label>");
	      } else {
	    	  o = $("<li>", {id:child.id, 
	    		  			 name:child.id,
	    		  			 html:"<label>"+child.name+"</label>"});
	      }
	      o.appendTo($container)
	       .append( buildTree(nodesByParent[child.id]) );
	      
	      var checkYn = false;
	      if(option.checkBox) {
	    	  if(option.lastCheck !== undefined && option.lastCheck == true) {
	    		  if(child.last_yn !== undefined && child.last_yn == 'Y')	checkYn = true;
	    	  } else {
	    		  checkYn = true;
	    	  }
	    	  
	    	  if(checkYn) {
	    		  if(option.rootId != child.parent_id) {
			    	  o.prepend($(document.createElement('input')).attr({
		             	   id:    child.id+'_chk'
		                 ,name:  child.id+'_chk'
		                 ,value: child.id
		                 ,type:  'checkbox'
		              }).css({
		            	  	  'margin-left': '2px',
		            	  	  'margin-right': '5px'
		            	  	  }));
	    		  }
	    	  }
	      }
	      
	      $(o.find('label')[0]).click(function(){
	    	 option.clickEvent(child);
	      });
	    });
	    
	    return $container;
	  }
	  
	  return buildTree(nodesByParent[option.rootId]);
}

/**
 * 
 * @param frame
 * @returns
 */
function getDoc(frame) {
    var doc = null;
 
    // IE8 cascading access check
    try {
        if (frame.contentWindow) {
            doc = frame.contentWindow.document;
        }
    } catch(err) {
    }
 
    if (doc) { // successful getting content
        return doc;
    }
 
    try { // simply checking may throw in ie8 under ssl or mismatched protocol
        doc = frame.contentDocument ? frame.contentDocument : frame.document;
    } catch(err) {
        // last attempt
        doc = frame.document;
    }
    return doc;
}

/********
 * 이미지 업로드 미리보기
 * sourceID : file 객체 iD
 * targetID : 미리보기할 이미지 객체 ID
 */
function PreviewImage(sourceId, targetId) {
	 if (window.FileReader) {
	
	    var oFReader = new FileReader();
	    oFReader.readAsDataURL(document.getElementById(sourceId).files[0]);
	
	    oFReader.onload = function (oFREvent) {
	        document.getElementById(targetId).src = oFREvent.target.result;
	    };
	 } else {
		 
		 $("#"+targetId).css("filter", "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"
             + $('#'+sourceId).val() + "', sizingMethod='scale')");
	 }
};

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function limitCharacters(textid, limit, limitid) {
    var text = $('#'+textid).val();
    var textlength = text.length;
    if(textlength > limit) {
        $('#'+textid).val(text.substr(0,limit));
        return false;
    }
    else {
        $('#' + limitid).text(textlength+'/ '+ limit +'자');
        return true;
    }
}

$.ajaxSetup({
    beforeSend: function(xhr,settings) {
        xhr.setRequestHeader("AJAX",  "Y");
    },
    cache: false,
    error: function(xhr, status, err) {
        if (xhr.status == 403) {
        	top.document.location.href = "/sessionInvalid.jsp";
        } else {
        	toast("오류가 발생했습니다" + ' ' + status.msg);		
        }
    }
});

$.extend($.jgrid.defaults, { 
	ajaxGridOptions: {
		beforeSend : function(jqXHR,settings) {
			jqXHR.setRequestHeader("AJAX", "Y");
	    }, 
	    cache: false,
	    error: function(xhr, status, err) {
	        if (xhr.status == 403) {
	        	top.document.location.href = "/sessionInvalid.jsp";
	        }
	    }
    }
});

	$(document).ready(function() {
		
		$("#btnSearch").on("click", function(){
			fn_f3();
		});	
		
		$("#btnAdd").on("click", function(){
			fn_f9();
		});	
		
		$("#btnSave").on("click", function(){
			fn_f10();
		});	
		
		$("#btnDel").on("click", function(){
			fn_f11();
		});	
		
		$("#btnClose, .btnClose").click(function() {
			window.close();
		});		
		
		
		$(".logoin a").on("click", function(){
			location.reload();
		});
		
	});
	
	
function gfn_comma(num) {
	var reg = /(^[+-]?\d+)(\d{3})/; num += '';
	while (reg.test(num)) num = num.replace(reg, '$1' + ',' + '$2');
	return num;
}		

/**
 * undefined, null을 지정값으로 치환
 */
function gfn_nvl(strValue,strValue2){
	if(strValue == undefined || strValue == null || strValue == '') return strValue2;
	return strValue;
}

//그리드 컬럼 전체row cell 값변경
function gfn_gridSetCell(grid,col,val){
	
	
	console.log('grid',grid);
	console.log('col',col);
	console.log('val',val);
	
	var rowData = $("#"+grid).getRowData();
	for(var i=0; i<rowData.length; i++) {
		$("#"+grid).jqGrid('setCell', i+1, col, val);
	}
}

	//현재날짜비교
	function gfn_is_past_date(_date){
		var retVal = false;
		
		let current = new Date();
		let date2 = new Date(_date);

		var _year = current.getFullYear();
		var _month = current.getMonth() + 1;
		var _day = current.getDate();
		
		_month = String(_month).lpad(2,'0');
		_day = String(_day).lpad(2,'0');

		let date1 = new Date(_year + '-' + _month + '-' + _day);

		if(date2 < date1) retVal = true;

		return retVal;
	}

	//날짜비교
	function gfn_compare_date(_date1, _date2){
		var retVal = false;
		
		let date1 = new Date(_date1);
		let date2 = new Date(_date2);

		if(date1 > date2) retVal = true;

		return retVal;
	}



