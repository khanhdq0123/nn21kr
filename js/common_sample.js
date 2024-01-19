/**
 * frameone+ 에서 사용하는 공통 js
 * 프로젝트에서는 이곳에 공통 js를 추가하지 말고 project-commons.js 에 추가하도록 한다.
 */

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

//======================================= JQuery 확장 정의 시작 ============================================
/**
 * 자신(jQuery랩핑된 폼 객체)이 가지고 있는 폼필드들을 객체로 만들어 리턴한다. (FO1) - 내부적으로 사용되고 있는
 * serializeArray() 메서드가 disabled 된 폼필드들을 가져오지 않는 것에 주의할 것 !!!
 */
$.fn.serializeObject = function( bUnChkVal ) {
	var storedDisabled = this.find(':input:disabled').removeAttr('disabled');
	var a = this.serializeArray();
	storedDisabled.prop('disabled', true);
	var o = {};
	var inputValue = "";

	$.each(a, function() {
		inputValue = this.value;

		var input = $('[name=' + this.name + ']');
		if (input.hasClass('com-ym-picker') || input.hasClass('com-ymd-picker')) inputValue = inputValue.replace(/-/g, '');
		if (input.hasClass('com-num-input')) inputValue = inputValue.replace(/,/g, '');

		// ---------- Date형 Input Data unfomat처리 - start ----------
		if ($('#' + this.name).hasClass('dateSelect') == true) {
			inputValue = gfn_removeSpecChar(inputValue); // 로케일 포멧 특수문자 제거
		} else if ($('#' + this.name).hasClass('number') == true && $('#' + this.name).attr("mask")) {
			inputValue = inputValue.replace(/,/g, ''); // , 제거
		}
		// ---------- Date형 Input Data unfomat처리 - end ----------
		if (o[this.name] !== undefined) {
			o[this.name] = o[this.name] + "," + inputValue;
		} else {
			o[this.name] = inputValue || '';
		}

		//검색팝업 코드 배열처리
		if( $('#' + this.name).attr("multiYn") == "Y" ) {
			o[this.name]	=	gfn_isNull( inputValue ) ? [] : inputValue.trim().split( "," );
		}
	});

	//체크안된 checkbox값 셋팅
	if( bUnChkVal ) {
		this.find( "input[type='checkbox']" ).not( ":checked" ).each( function() {
			o[this.name]	=	"0";
		});
	}
	return o;
};

/*
 * 입력 Form Validation 체크(필수입력, Byte 입력 제한 등...)
 */
$.fn.gfn_checkFormValidation = function(gbn, visible)
{
    var $frm    = this;
    var rsltChk = true;
    var chkCond = ':input:not(:disabled)';
    var visibleChk = gfn_isNull(visible) ? false: visible;

    if (gfn_nvl(gbn,'') == 'ALL') {
    	chkCond = ':input';
    }

    $frm.find(chkCond).each(function(){
        var $input = $(this);

		if(! visibleChk) {
        	if (!$input.is(':visible')) return;
        }

        // 1. 필수 입력 체크
        if($input.attr("required") != undefined){
            if(gfn_checkRequired($input) == false) {
                rsltChk = false;
                return rsltChk;
            }
        }

        // 2. Byte 입력 제한  체크
        if($input.attr("maxbyte") != undefined){
            if(gfn_checkMaxbyte($input, $input.attr("maxbyte")) == false) {
                rsltChk = false;
                return rsltChk;
            }
        }

        // 3. 숫자 입력 오류  체크
        if($input.attr("number") != undefined){
            if(gfn_checkNumber($input) == false) {
                rsltChk = false;
                return rsltChk;
            }
        }

        // 4. 영문자 입력 오류  체크
        if($input.attr("alpha") != undefined){
            if(gfn_checkAlphabet($input) == false) {
                rsltChk = false;
                return rsltChk;
            }
        }

        // 5. 영문자/숫자 입력 오류  체크
        if($input.attr("onlyalphanum") != undefined){
            if(gfn_checkAlphaNumeric($input) == false) {
                rsltChk = false;
                return rsltChk;
            }
        }

        // 6. Email 입력 오류  체크
        if($(this).attr("email") != undefined){
            if(gfn_checkEmail($input) == false) {
                rsltChk = false;
                return rsltChk;
            }
        }

        //7.숫자 최소값 체크 - min
        if($(this).attr("min") != undefined){
        	if(!gfn_isNull($(this).attr("min")) && !gfn_isNull($(this).val())){
    			if (!$(this).val().isNumber()) {
    				gfn_showMessage("MSG.COM.VAL.038"); // 숫자만 입력할 수 있습니다.
    				$(this).focus();
    				rsltChk = false;
                    return rsltChk;
    			}

    			if (gfn_toNum($(this).val()) < gfn_toNum($(this).attr("min"))) {
    				gfn_showMessage('MSG.COM.VAL.064', gfn_toStr($(this).attr("min"))); //최소 {0} 이상 입력하셔야 합니다.
    				$(this).focus();
    				rsltChk = false;
                    return rsltChk;
    			}
            }
        }

		//8. 숫자 최대값 체크 - max
        if($(this).attr("max") != undefined){
        	if(!gfn_isNull($(this).attr("max")) && !gfn_isNull($(this).val())){
    			if (!$(this).val().isNumber()) {
    				gfn_showMessage("MSG.COM.VAL.038"); // 숫자만 입력할 수 있습니다.
    				$(this).focus();
    				rsltChk = false;
                    return rsltChk;
    			}

    			if (gfn_toNum($(this).val()) > gfn_toNum($(this).attr("max"))) {
    				gfn_showMessage('MSG.COM.VAL.065', gfn_toStr($(this).attr("max"))); //최대 {0} 까지 입력할 수 있습니다.
    				$(this).focus();
    				rsltChk = false;
                    return rsltChk;
    			}
            }
        }


       // 9. 특수문자
        if($input.attr("onlyalphanumspec") != undefined){
            if(gfn_checkAlphaNumericSpec($input) == false) {
                rsltChk = false;
                return rsltChk;
            }
        }


        // 10. FromTo 날짜
        if($(this).attr("data-calandar-multi") != undefined && $(this).attr("data-calandar-to-id") != undefined){


	         let toId =  $('#' +$(this).attr("data-calandar-to-id"));


			 if(gfn_dateCompare($input, toId) == false) {
                rsltChk = false;
                return rsltChk;
            }
	    }


    });
    return rsltChk;
};



/**
* 폼 내의 모든 엘리먼트의 값을 초기화한다.
*  initData - {엘리먼트id(혹은 엘리먼트name) : 사용자정의초기값, .... } 형태의 객체
*/
$.fn.resetForm = function(initData) {
	var $frm = this;
	$frm.find(':input').each(function() {
		var $elem = $(this), id = this.id, name = this.name, userVal, type = (gfn_nvl(this.type, "")).toLowerCase();

		// 라디오버튼일 경우, 엘리먼트의 값을 초기화해서는 안되며, 선택상태만 초기화해야 한다.
		if (type === 'radio') {
			$elem.prop('checked', false);
			return true;
		}

		// 사용자정의 값이 존재할 경우 그 값으로 초기화
		if (initData) {
			if (initData[id]) { // 현재 loop의 엘리먼트id에 해당하는 data key가 존재할 경우
				userVal = initData[id];
			} else if (initData[name]) { // 현재 loop의 엘리먼트name에 해당하는 data key가 존재할 경우
				userVal = initData[name];
			}
			if (userVal) {
				if (userVal.toLowerCase() === 'null') {
					userVal = '';
				} // initData에 공백문자를 넘겼을 경우 인식하지 못하기 때문에, 초기값을 공백문자로 하고 싶으면 'null' 문자열을 사용한다.
				$elem.val(userVal);
				return true; // loop continue
			}
		}

		// class가 calendar일 경우 오늘날짜로 초기화하는 것을 기본으로 하고, 그 외의 경우 사용자정의값으로 override
		/****
		if ($elem.hasClass('calendar')) {
			var today = new Date();
			var todayStr = gfn_formatDate(String(today.getFullYear()) + String(today.getMonth() + 1).lpad(2, '0') + String(today.getDate()).lpad(2, '0'));
			$elem.val(todayStr);
			return true;
		}
		****/

		// 디폴트 초기화
		if (type === 'checkbox') { // 체크박스일 경우
			$elem.prop('checked', false);
		} else {
			$elem.val(''); // 기타의 경우 null 초기화
		}

		if (!gfn_isNull($elem.data("select2Id")))
			$elem.trigger('change');

	});
};
//======================================= JQuery 확장 정의 끝 ============================================

//======================================= 공통 Function 정의 시작 ============================================

//-------------------------------------- validation  ------------------------------------------------------
/**
 * undefined이거나 null인지 체크
 */
function gfn_isNull(sValue) {

	if ($.isFunction(sValue)) {
		return false;
	} else if ( sValue instanceof String ) {
		var sVal = new String(sValue);
		if (sVal.valueOf() == "undefined" || sValue == null || sValue == "null" || sValue.trim().length <= 0 ) return true;
	} else {
		if(typeof(sValue) == "undefined" || sValue == "null" || sValue == "undefined" || sValue == null || sValue == undefined || sValue.length == 0 ) return true;
	}

    var v_ChkStr = new String(sValue);
    if (v_ChkStr == null || v_ChkStr.length == 0 ) return true;

    return false;
}

/**
 * undefined, null을 지정값으로 치환
 */
function gfn_nvl(strValue,strValue2){
	if(this.gfn_isNull(strValue)) return strValue2;
	return strValue;
}




/**
 * 필수 입력 체크
 */
function gfn_checkRequired(obj) {
	$objInput = $(obj);
	let text = _gfn_inputText(obj);

	if ($objInput.hasClass("number")) {

		if ($objInput.val() == '' || parseFloat($objInput.val().trim()) == 0) {
			gfn_showMessage("MSG.COM.VAL.006", text).done(function(){
				$objInput.focus();
			});		 // {0}을(를) 입력해 주십시오.
			return false;
		} else {
			return true;
		}
	} else {
		if ($objInput.get(0).type == "checkbox" || $objInput.get(0).type == "radio") {
			var objName = $objInput.get(0).name;
			if ($("input[name='" + objName + "']:checked").length == 0) {
				gfn_showMessage("MSG.COM.VAL.006", text).done(function(){
					$objInput.focus();
				});		 // {0}을(를) 입력해 주십시오.
				return false;
			} else {
				return true;
			}
		} else if ($objInput.hasClass("calendarM")) {

			if ($objInput.val() == '') {
				gfn_showMessage("MSG.COM.VAL.006", text); // {0}을(를) 입력해 주십시오.
				$objInput.focus();
				return false;
			} else {
				return true;
			}

		} else {
			if ($.trim($objInput.val()) == '') {
				gfn_showMessage("MSG.COM.VAL.006", text); // {0}을(를) 입력해 주십시오.
				$objInput.focus();
				return false;
			} else {
				return true;
			}
		}
	}
}


/**
 * TEXT 값 추출
 */
function _gfn_inputText(obj){

	$objInput = $(obj);
	let text  = $objInput.attr("id");

	try{
		//text	=	$objInput.attr("title");
		text = $objInput.prev("label").text();
		if(gfn_isNull(text)) {
			text = $objInput.parent().prev().find("label").text();
		}

		if(gfn_isNull(text)) {
			text = $objInput.parent().prev("label").text();
		}
		if(gfn_isNull(text)) {
			text = $("label[for='" + $objInput.attr("id") + "']").text();
		}
		if(gfn_isNull(text)) {
			text	=	$objInput.attr("title");
		}

	}catch(e){
		text = ""
	}



	return gfn_removeChar(text,'[*]');
}


/**
 * Email 입력 오류 체크
 */
function gfn_checkEmail(obj) {
	let val;
	let $objInput;
	let text;

	if (obj instanceof jQuery){
		$objInput = $(obj);
		val = $objInput.val();

	}else{
		val = obj;
	}

	// Email 유효성 체크
	if (val.isEmail() == false) {
		if (obj instanceof jQuery){
			text = _gfn_inputText(obj);

			gfn_showMessage("MSG.COM.VAL.131", text).done(function(){
				$objInput.focus();
			});
		}
		return false;
	} else {
		return true;
	}
}

/**
 * Byte 입력 제한 체크
 */
function gfn_checkMaxbyte(obj, maxByte) {

	let val;
	let $objInput;
	let text ;

	if (obj instanceof jQuery){
		$objInput = $(obj);
		val = $objInput.val();
	}else{
		val = obj;
	}

	if (obj instanceof jQuery){

		text = _gfn_inputText(obj);

		// 숫자포맷팅이 되어 있는 경우 콤마를 제거하여 검사한다.
		if ($objInput.hasClass("number") && $objInput.attr("mask")) {
			val = val.replace(/,/g, '');
		}
	}


	if(gfn_isNull(val)) {
		val = "";
	}

	// Byte 입력 제한 체크
	if (val.getByte() > maxByte) {
		if (obj instanceof jQuery) {

			let message  = text + "|" + maxByte;

			gfn_showMessage("MSG.COM.VAL.102", message).done(function(){
			   $objInput.select();
			   $objInput.focus();
			});
			return false;
		}
	} else {
		return true;
	}
}

/**
 * 숫자형 유효성 체크
 */
function gfn_checkNumber(obj) {
	let value;
	let $objInput;
	let text;

	if (obj instanceof jQuery){
		$objInput = $(obj);
		value = $(obj).val();
	}else{
		value = obj;
	}


	if(gfn_isNull(value)) {
		value = "";
	}



	// 숫자 입력 체크
	if (value.isNumber() == false) {
		if (obj instanceof jQuery){
			text = _gfn_inputText(obj);
			gfn_showMessage("MSG.COM.VAL.129", text).done(function(){
				$objInput.focus();
			});
		}
		return false;
	} else {
		return true;
	}
}

/**
 * 영문자 유효성 체크
 */
function gfn_checkAlphabet(obj) {

	let value;
	let $objInput;
	let text;

	if (obj instanceof jQuery){
		$objInput = $(obj);
		value = $(obj).val();
	}else{
		value = obj;
	}


	if(gfn_isNull(value)) {
		value = "";
	}

	// 영문자 입력 체크
	if (value.isAlpha() == false) {
		if (obj instanceof jQuery){
			text = _gfn_inputText(obj);
			gfn_showMessage("MSG.COM.VAL.040", text).done(function(){
				$objInput.focus();
			});
		}
		return false;
	} else {
		return true;
	}
}



/**
 * 영문자/숫자 유효성 체크
 */
function gfn_checkAlphaNumeric(obj) {
	$objInput = $(obj);

	// 영문자/숫자 입력 체크
	if ($objInput.val().isAlphaNum() == false) {
		gfn_showMessage("MSG.COM.VAL.040").done(function(){
			$objInput.focus();
		});
		return false;
	} else {
		return true;
	}
}


/**
 * 특수문자 유효성 체크
 */
function gfn_checkAlphaNumericSpec(obj) {

	let value;
	let $objInput;

	if (obj instanceof jQuery){
		$objInput = $(obj);
		value = $(obj).val();
	}else{
		value = obj;
	}

	if(gfn_isNull(value)) {
		value = "";
	}

	// 특수문자까지 허용
	if (value.isAlphaNumSpec() == false) {
		if (obj instanceof jQuery){
			gfn_showMessage("MSG.COM.VAL.040").done(function(){
				$objInput.focus();
			});
		}
		return false;
	} else {
		return true;
	}
}





/**
 * 날짜비교
 */
function gfn_dateCompare(fromObj, toObj) {
	$fromObjInput = $(fromObj);
	$toObjInput   = $(toObj);


	//console.log($fromObjInput.val(), $toObjInput.val() );


	if (!gfn_isNull($fromObjInput.val()) && !gfn_isNull($toObjInput.val())) {
        // Form 날짜가 To보다 큰 경우 체크
        if (gfn_strToDate($fromObjInput.val(), 'YYYYMMDD') > gfn_strToDate($toObjInput.val(), 'YYYYMMDD')) {
            gfn_showMessage("MSG.COM.VAL.130").done(function(){
				$fromObjInput.focus();
			});
			return false;
        }
    }
	return true;
 }



/**
 * 날짜 유효성 체크
 */
function gfn_checkDate(date){

	if (date.length != 10){
		return false;
    }

	//들어가는지 유효성검사
	var date_pattern = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
	if(!date_pattern .test(date)){
		return false;
	}
	date = date.replaceAll(/-/gi, "");
	var nYear = Number(date.substr(0, 4));
    var nMonth = Number(date.substr(4, 2));
    var nDay = Number(date.substr(6, 2));

    // 해당달의 마지막 일자 구하기
    var nMaxDay = new Date(new Date(nYear, nMonth, 1) - 86400000).getDate();
    if (nDay < 1 || nDay > nMaxDay){
    	return false;
    }

	return true;
}




//-------------------------------------- format, convert  ------------------------------------------------------

/**
 * 날짜문자열을 구분자로 잘라서 배열로 리턴.
 */
function gfn_splitDateStr(dateStr) {
	var dateStr = gfn_formatDateStr(gfn_removeChar(dateStr, DATE_DELIMETER));
	var format = gfn_removeSpecChar('YYYY-MM-DD').toUpperCase();
	var date = new Date(moment(dateStr, format));
	arr = [ date.getFullYear(), date.getMonth(), date.getDate() ];
	return arr;
}

/**
 * 주어진 날짜형 문자열에 일정 개월 수를 더한 날짜형 문자열로 돌려준다.
 */
function gfn_afterMonths(dateStr, addMonth) {
	addMonth = parseInt(addMonth);
	var dateArr = gfn_splitDateStr(dateStr);
	var date = new Date(dateArr[0], dateArr[1], dateArr[2]);
	date.setMonth(date.getMonth() + addMonth);
	return gfn_formatDateType(date);
}

/**
 * 주어진 날짜 문자열을 형식화한다.
 */
function gfn_formatDateStr(dateStr, isSysFmt) {
	/* 값이 없으면 빈 문자열을 돌려 준다. */
	if (gfn_isNull(dateStr))
		return "";
	isSysFmt = gfn_isNull(isSysFmt) ? true : isSysFmt;

	var result = "";
	var len = dateStr.length;

	if (!isSysFmt) {
		dateStr = gfn_removeChar(dateStr, DATE_DELIMETER);

		if (len >= 4) {
			result += dateStr.substr(0, 4);
			if (len >= 6) {
				result += DATE_DELIMETER + dateStr.substr(4, 2);
				if (len >= 8) {
					result += DATE_DELIMETER + dateStr.substr(6, 2);
				}
			}
		}
	} else {
		dateStr = gfn_removeSpecChar(dateStr);
		if (len >= 8) {
			result = gfn_formatDate(dateStr);
		} else if (len >= 6 && len < 8) {
			result = gfn_formatDate(dateStr, "YYYYMM", CONST.LOCALE_YYMM_FORMAT.toUpperCase());
		} else if (len >= 4 && len < 6) {
			result = dateStr.substr(0, 4);
		}
	}
	return result;
}

/**
 * 주어진 Date 객체의 값을 형식화한다.
 */
function gfn_formatDateType(date) {
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var day = date.getDate();
	var strDate = String(year) + String(month).lpad(2, '0') + String(day).lpad(2, '0')
	return gfn_formatDate(strDate);
}

/**
 * 문자열에 들어 있는 특정한 문자를 지운다. removedChar 지워질 문자열
 */
function gfn_removeChar(str, removedChar) {
	if (typeof (str) == "undefined" || str == null)
		return str;
	if (typeof (removedChar) == "undefined" || removedChar == null)
		return str;
	if (typeof (str) != "string")
		str = new String(str);
	var regExp = new RegExp(removedChar, "g");
	return str.replace(regExp, "");
}

/**
 * 문자열로 변환,undefined or null이면 ""로 초기화
 */
function gfn_toStr(str, dfVal) {
    dfVal = dfVal || "";
    if (typeof(str) == 'undefined' || str == 'undefined' || str == null || str == 'null') {
        str = dfVal;
    }
    return String(str);
}

/**
 * 숫자로 변환. 숫자가 아니면 지정된값으로 초기화
 */
function gfn_toNum(num, dfVal) {
    dfVal = dfVal || 0;
    num = gfn_toStr(num).replaceAll(',', '');
    if ($.isNumeric(num)) {
        num = parseFloat(num);
    }
    else {
        num = dfVal;
    }
    return num;
}

/**
 * 날짜형식 보정
 */
function gfn_fixDate(strDate) {
	strDate = gfn_toStr(strDate);
	if (strDate != '') {
		strDate = strDate.replaceAll('-', '').replaceAll('/', '').replaceAll('.', '');
	}

	return strDate;
}

/**
 * 날짜(년월일) 포맷팅
 * @ex gfn_formatDate('[날짜문자열]', '[문자열날짜포맷]', '[변환할문자열날짜포맷]')
 * @ex gfn_formatDate('20160913')
 * @ex gfn_formatDate('20160913', 'YYYYMMDD', 'YYYY-MM-DD')
 */
function gfn_formatDate(str, fromFmt, toFmt) {
	fromFmt = fromFmt || 'YYYYMMDD';
	toFmt = toFmt || g_localeOptions.dateFormat_nm.toUpperCase();
	if (gfn_toStr(str) != '') {
        var ret = moment(str, fromFmt).format(toFmt);
        if (ret.indexOf('Invalid') != -1) {
            return str;
        }
    }
	return ret;
}

function gfn_strToDate(_str, _format) {
	var _result = null ;
	if (!!_str && !!_format) {
		if (_str.length != _format.length) throw "FormatError: 날짜값과 포맷형식이 일치하지 않습니다." ;
		var _$tmpDate = new Date() ;
		var _year = _$tmpDate.getUTCFullYear(), _month = 0, _date = 1 ;
		if (_format.indexOf("YYYY") > -1) _year = parseInt(_str.substr(_format.indexOf("YYYY"), 4), 10) ;
		if (_format.indexOf("MM") > -1) _month = parseInt(_str.substr(_format.indexOf("MM"), 2), 10) - 1 ;
		if (_format.indexOf("DD") > -1) _date = parseInt(_str.substr(_format.indexOf("DD"), 2), 10) ;
		_result = new Date(Date.UTC(_year, _month, _date)) ;
	}
	return _result ;
}

/**
 * 문자열에 있는 모든 영어를 소문자로 바꾸는 Basic API
 */
function gfn_toLower(args){
	if(this.gfn_isNull(args)) return "";
	return	String(args).toLowerCase();
}

/**
 * 특수문자 제거
 */
function gfn_removeSpacCharRegExr(str, regExp) {
	return str.replace(regExp, "");
}

function gfn_removeSpecChar(str) {
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	return gfn_removeSpacCharRegExr(str, regExp);
}

/**
 * svc모듈 사용 시 svc모듈 호출을 위해 svc모듈 도메인정보를 포함한 url 생성하여 리턴한다
 * @param uri svc모듈 호출 대상 uri(ex. app1/sample/apiSampleMngExt/search)
 * @returns {string|*} svc모듈 호출을 위한 최종 url(ex. http://localhost:8082/app1/sample/apiSampleMngExt/search)
 */
function gfn_getSvcUrl(uri){
	var svcUrl = uri;
	for(var i = 0; i < SVC_URLS.length; i++){
		var rootUriIdx = SVC_URLS[i].lastIndexOf("/"); // http://localhost:8082/app1
		var startUri = SVC_URLS[i].substring(rootUriIdx); // /app1, app2
		if(uri.startsWith(startUri)){
			svcUrl = SVC_URLS[i].substring(0, rootUriIdx) + uri;
			//console.log(apiUrl);
			return svcUrl;
		}
	}
	return svcUrl;
}

//-------------------------------------- data, message 처리 ------------------------------------------------------

/**
 * 여러 개의 javascript 객체를 하나로 묶어서 리턴해 주는 함수
 * 시그니처 상에는 인수가 1개로 되어 있지만, 함수의 목적이 여러 개의 인수를 받아서 하나로 묶는 것이기 때문에 실제 호출시에는 여러 개의 인수를 받아들인다.
 */
function gfn_getMergedObject(obj) {
	var ret = {};
	for (var i = 0; i < arguments.length; i++) {
		$.extend(true, ret, arguments[i]);
	}
	return ret;
}

/**
 * 그리드가 아닌 일반 javascript 객체를 데이터셋 파라미터로 보내고 싶을 때,
 * 데이터셋 형태로 받을 수 있도록 해당 JSON 형식으로 wrapping해 주는 함수
 */
function gfn_wrapDatasetParam() {
	var ret = {};
	ret["data"] = arguments.length > 0 ? [arguments[0]] : [] ;
	ret["deletedData"] = [];
	return ret;
}

/**
 * ajax 응답객체로부터 수행결과코드 및 출력해 주어야할 메세지를 선별하여 리턴하는 함수.
 */
function gfn_getReturnMsg(returnData) {
	// 응답 객체에서 메세지 값을 읽어들이며 메세지를 조회해서 어떤 메세지를 뿌려주어야 할 지 정하고 메세지타입을 결정한다.
	// 메세지 타입은 동시에 존재할 수 없고 한 요청에 하나만 존재할 수 있다. 그러므로 이 중에서 한 set의 msgTp, msgCd, msgText만 출력 대상이 된다.
	var errCd, normalMsgCd, normalMsgText, statusMsgCd, statusMsgText, errMsgCd, errMsgText, msgTp, msgCd, msgText;
	errCd = returnData[ERROR_CODE]; // 결과 코드
	errMsgCd = returnData[ERROR_MESSAGE_CODE]; // 에러메세지 코드
	errMsgText = returnData[ERROR_MESSAGE_TEXT]; // 에러메세지
	normalMsgCd = returnData[MESSAGE_CODE]; // 메세지 코드
	normalMsgText = returnData[MESSAGE_TEXT]; // 메세지
	statusMsgCd = returnData[STATUS_MESSAGE_CODE]; // 상태메세지 코드
	statusMsgText = returnData[STATUS_MESSAGE_TEXT]; // 상태메세지

	//console.log(returnData);
	//console.log("값", errCd, normalMsgCd, normalMsgText, statusMsgCd, statusMsgText, errMsgCd, errMsgText, msgTp, msgCd, msgText);

	if (errMsgCd != null && errMsgCd.length > 0) {
		msgTp = "error";
		msgCd = errMsgCd;
		msgText = errMsgText;
	} else if (normalMsgCd != null && normalMsgCd.length > 0) {
		//성공적인 메시지는 전부 Toast 메세지로 처리 한다.
		if(normalMsgCd.indexOf("MSG.COM.SUC") > -1 ) {
			msgTp = "toastMsg"
		}else{
			msgTp = "msg";
		}

		msgCd = normalMsgCd;
		msgText = normalMsgText;
	} else if (statusMsgCd != null && statusMsgCd.length > 0) {
		msgTp = "status";
		msgCd = statusMsgCd;
		msgText = statusMsgText;
	}

	return {
		errCd : errCd,
		msgTp : msgTp,
		msgCd : msgCd,
		msgText : msgText
	};
}

/**
 * 응답 메세지를 선별하여 alert()이나 footer에 출력한다.
 */
function gfn_outMessage(retMsg) {
	if (retMsg.msgText == null || retMsg.msgText.length == 0) {
		return;
	} // 값이 없으면 리턴


	// 에러메세지나 일반메세지는 alert을 띄운다.
	if (retMsg.msgTp === "error" || retMsg.msgTp === "msg") {
		gfn_showMessageByText(retMsg.msgText.replace(/\\n/gi, '\n'));
		//alert(retMsg.msgText.replace(/\\n/gi, '\n'));
		// 상태메세지는 footer에 출력한다.
	}else if (retMsg.msgTp === "toastMsg") {
		gfn_showMessageByToast(retMsg.msgText.replace(/\\n/gi, '\n'));

	}else if (retMsg.msgTp === "status") {
		var t = gfn_getFOTopWin(window);
		if (t.name === "FO_MESSAGE_FRAME") {
			if ($("#footer .work_progress strong", t.document).length > 0) {
				$("#footer .work_progress strong", t.document).html(retMsg.msgText);
			}
		}
	}
}

/**
 * 메세지를 조회하여 alert 출력
 *
 * @param messageCd 메세지 코드
 * @param bindInfo 메세지 코드에 바인딩할 정보(바인딩 정보가 여러건일경우 "|"로 구분 ex: "사용자|부서|직급"
 */
function gfn_showMessage(messageCd, bindInfo) {
	var message = messageCd;
	if(clientMessage != undefined){
		if(clientMessage.hasOwnProperty(messageCd)){
			message = clientMessage[messageCd];
			if(bindInfo != undefined){
				message = gfn_replaceMessageBind(message, bindInfo)
			}
		}
	}

	return gfn_showMessageByText(message, bindInfo);
}

/**
 * 메시지를 조회하여 confirm 출력 - 이 함수의 인수로 넘기는 메세지코드는 반드시 messageFrame의 캐싱 대상이어야 한다.
 * (transaction으로 넘어가게 될 경우 현재 스레드를 block 시킬 수 없기 때문에)
 *
 * @param messageCd 메세지 코드
 * @param bindInfo 메세지 코드에 바인딩할 정보(바인딩 정보가 여러건일경우 "|"로 구분 ex: "사용자|부서|직급"
 */
function gfn_showConfirm(messageCd, bindInfo) {

	var message = messageCd;
	if(clientMessage != undefined){
		if(clientMessage.hasOwnProperty(messageCd)){
			message = clientMessage[messageCd];
		}
	}
	if(bindInfo != undefined){
		message = gfn_replaceMessageBind(message, bindInfo)
	}

	return gfn_showConfirmByText(message);
}

/**
 * 메세지 텍스트를 인수로 받아서 modal 출력
 *
 * @param message 메세지 텍스트
 * @param bindInfo 바인딩 정보
 */
function gfn_showMessageByText(message, bindInfo) {


	if(bindInfo != undefined){
		message = gfn_replaceMessageBind(message, bindInfo)
	}

	var defer = $.Deferred();
	var divPre = '<div id="modalMessageByText" class="popup alert"><div class="msg-box">';
	var divAfter = '</div></div>';
	//var headerClass = "bgPacony"; // $("body", parent.document).attr("class");

	// parent.document가 같은 도메인인지 체크
	// try{
	// 	var doc = parent.document;
	// 	if(!doc)
	// 		throw new Error('Unaccessible');
	// 	// accessible
	// }catch(e){
	// 	// not accessible
	// }

	// if(!headerClass){
	// 	headerClass = "bgPacony";
	// }
	setTimeout(function() {
		$(divPre + message + divAfter).dialog({
			autoOpen : true,
			open: function() {
				$(this).parent().find(".ui-dialog-titlebar-close").hide(); // 해당 다이얼로그 닫기 버튼 hide
			},
			close : function() {
				$(this).dialog('destroy');
			},
			modal : true,
			draggable : false,
			resizable : false,
			title : 'Information',
			width : 400, // dialog 넓이 지정
			// height : 500, // dialog 높이 지정
			buttons : {
				OK : function() {
					$(this).dialog("close");
					defer.resolve(true); // on Yes click, end deferred state
											// successfully (done)
				}
			}
		});  // 불필요: .parents(".ui-dialog").find(".ui-dialog-titlebar").addClass(headerClass);
    }, 50);

	$('.ui-dialog-buttonset').find('button').each(function(idx) {
		$(this).addClass('ui-button ui-corner-all ui-widget');
	});


	return defer.promise();


}

/**
 * 메시지 텍스트를 인수로 받아서 modal 출력
 *
 * @param message 메세지 텍스트
 * @param bindInfo 바인딩 정보
 */
function gfn_showConfirmByText(message) {


	var defer = $.Deferred();
	var divPre = '<div id="modalConfirmByText" class="popup alert"><div class="msg-box">';
	var divAfter = '</p></div>';

	setTimeout(function() {
		$(divPre + message + divAfter).dialog({
			autoOpen : true,
			close : function() {
				$(this).dialog('destroy');
				defer.resolve(false);
			},
			modal : true,
			draggable : false,
			resizable : false,
			title : 'Confirm',
			width : 400, // dialog 넓이 지정
			// height : 500, // dialog 높이 지정
			buttons : {
				OK : function() {
					// $( this ).dialog( "close" );
					$(this).dialog('destroy');
					defer.resolve(true); // on Yes click, end deferred state successfully (done)
				},
				CANCEL : function() {
					$(this).dialog("close");
					defer.resolve(false);
				}
			}
		}); // .parents(".ui-dialog").find(".ui-dialog-titlebar").addClass(headerClass);

		$('.ui-dialog-buttonset').find('button').each(function(idx) {
			$(this).addClass('ui-button ui-corner-all ui-widget');
		});

		$('.ui-dialog-titlebar').find('button').each(function(idx) {
			$(this).hide();
		});
	}, 50);

	return defer.promise();

}

/**
 * 메시지 바인딩 처리
 *
 * @param message 메세지
 * @param bindInfo 바인딩 정보
 */
function gfn_replaceMessageBind(message, bindInfo) {
	var arrBind;
	if (bindInfo != null && bindInfo.length > 0) {
		arrBind = bindInfo.split("|");
		for (var i = 0; i < arrBind.length; i++) {
			message = message.replace("{" + i + "}", arrBind[i]);
		}
	}
	return message;
}

//-------------------------------------- transaction ------------------------------------------------------

/**
 * 데이터를 전송/저장하는 함수.
 */
function gfn_transaction(options) {
	if (options.inDs!=null && options.inDs!=undefined) {
		for(key in options.inDs) {
			if (options.inDs[key]=='NO_CHANGE') {
				options.inDs[key] = {};
				options.inDs[key]['data'] = [];
				options.inDs[key]['deletedData'] = [];
			}
		}
	}

	//현재 Page 정보 알아오기
	var progmId = null;
	if(gfn_isNull(options.pServiceId)) {
		try{
			progmId = parent.fn_currentProgramId();
		}catch(e){
		}
	}else{
		progmId = options.pServiceId;
	}

	//개발 환경 세팅 체크 및 적용
	gfn_setDevParam(options);

	// 전송할 데이터 셋팅
	var data = {};
	var isAsync = options.async;
	if (typeof (isAsync) == "undefined" || isAsync == null) {
		isAsync = true;
	}

	$.extend(data, options.param, options.inDs);

	$.ajax({
		url : options.strUrl,
		data : JSON.stringify(data),
		method : 'POST',
		async : isAsync,
		crossDomain: false,
		contentType : "application/json; charset=UTF-8",
		beforeSend : function(jqXHR, settings) {
			jqXHR.setRequestHeader("AJAX", "true")
			jqXHR.setRequestHeader("SERVICE_ID",CONST.PROG_CD);
			jqXHR.setRequestHeader("LOG_TYPE",options.pSvcFlag);

			gfn_openLoadingImage({pLoad : options.pLoad}); // 로딩이미지 노출
		},
		xhrFields : {
			withCredentials : options.withCredential != null && options.withCredential == true ? true : false
		},
		complete : function(jqXHR, textStatus) {
			gfn_closeLoadingImage(); // 로딩이미지 닫기

			// 서버에서 에러 발생시 HtmlErrorHandlingFilter에서 SVC_ERR_DETAIL에 에러메세지를 담는데,
			// 이 에러메세지에 JSON parsing이 불가능한 문자가 들어 있을 경우 JSON.parse()에서 에러가 발생하고
			// 200 에러와 함께 이후 콜백이 수행되지 않는 문제 때문에 try ~ catch로 감싸주고, catch절에서 빈 메세지를 셋팅함.
			var returnData;
			try {
				if (jqXHR.responseJSON)
					returnData = jqXHR.responseJSON;
				else
					returnData = JSON.parse(jqXHR.responseText);
			} catch (e) {
				if ( jqXHR.status == '403'|| jqXHR.status == '401') {
					returnData = {};
					returnData[ERROR_CODE] = -10;
					returnData[ERROR_MESSAGE_CODE] = '-10';
					returnData[ERROR_MESSAGE_TEXT] = 'ERR_NO_AUTH';
				} else {
					returnData = {};
					returnData[ERROR_CODE] = -1;
					returnData[ERROR_MESSAGE_CODE] = '-1';
					returnData[ERROR_MESSAGE_TEXT] = '';
				}
			}

			// ajax 응답객체로부터 수행결과코드 및 출력해 주어야할 메세지를 선별하여 리턴.
			var retMsg = gfn_getReturnMsg(returnData);

			if (returnData[ERROR_CODE] == ERR_CD_NO_AUTH) {
				//console.log("transaction : " + ERR_CD_NO_AUTH);
				gfn_goSessionExpiredPage({alert:true});
			}
			gfn_outMessage(retMsg);
			// 사용자정의 콜백 실행
			if ($.isFunction(options.pCall)) { // 사용자정의 parent.document).attr("class")에러처리를 해야 할 수도 있기 때문에 수정함
				options.pCall(options.svcId, returnData, retMsg.errCd, retMsg.msgTp, retMsg.msgCd, retMsg.msgText);
			}
		}
	});
}

/**
 * 로컬 개발환경인 경우의 호출정보(url 등) 세팅(모놀리식에서 개별 업무모듈 로컬에서 개발 시 적용)
 */
function gfn_setDevParam(param){
	if(IS_SVC_ENABLE == "true"){
		// gfn_getSvcUrl()메소드 등으로 url이 세팅된것이 아니고, 다른모듈의 URL 호출이면 Portal호출
		if(!param.strUrl.startsWith("http") && !param.strUrl.startsWith(contextPath + SVC_PREFIX)){
			param.strUrl = PORTAL_URL + param.strUrl;
			param.withCredential = true;
		}
	}
}

/**
 * form 내의 파라미터를 serializing 한 후 객체로 리턴
 */
function gfn_getFormParam(formId, addParams) {
	formId = formId || '#frmSearch';


	addParams = addParams || {};
	return gfn_getMergedObject($(formId).serializeObject(), addParams);
}

/**
 * 로딩이미지 노출
 */
function gfn_openLoadingImage(o) {
	if (o && o.pLoad && g_ajaxCallCount <= 0) {
		$.blockUI({
			message : '<div class="loading-wrap"><div class="loading"><div class="loading-img"></div><h3>Loading</h3></div></div>',
			// 메세지(로딩이미지를 감싸고 있는 box)영역에 대한 css
			css : {
				// top: getLoaderTop(o), //FrameOne2.0a 에서는 로딩이미지의 수직위치를 center정렬 하는 것만 기본으로 제공하기 때문에 주석처리한다.
				centerX : true,
				centerY : true,
				border : 'none',
				backgroundColor : 'transparent',
				opacity : 1
			},
			// 오버레이영역에 대한 css
			overlayCSS : {
				opacity : 0, // 오버레이가 덮지 않는 것 처럼 보이면서 block한다.
				cursor : 'wait' // 오버레이영역의 커서 모양
			}
		});
	}
	g_ajaxCallCount++;
}

/**
 * 로딩이미지 닫기 - ajacCallCount 전역변수에 종속성을 가지고 있다.
 */
function gfn_closeLoadingImage() {
	g_ajaxCallCount--;
	if (g_ajaxCallCount <= 0) {
		$.unblockUI();
	}
}

/**
 * ajax sync 호출
 */
function gfn_ajaxSync(url, params, isLoad) {
	var programId = "";

	try{
		if(!gfn_isNull(params.POPUP_ID)) {
			programId = params.POPUP_ID;
		}else{
			programId = CONST.PROG_CD;
		}
	}catch(e) {};

	isLoad = isLoad || false;
	var result = $.ajax({
	    type: 'POST'
	    ,dataType: 'json'
	    ,contentType: 'application/json; charset=UTF-8'
	    ,url: url
	    ,data: JSON.stringify(params)
	    ,async: false
		,xhrFields : {
			withCredentials : params.withCredential != null && params.withCredential == true ? true : false
		}
	    ,beforeSend: function (jqXHR, settings) {
			jqXHR.setRequestHeader("AJAX","true");
			jqXHR.setRequestHeader("SERVICE_ID", programId);
			jqXHR.setRequestHeader("LOG_TYPE","SELECT");
	    	gfn_openLoadingImage({pLoad: isLoad}); //로딩이미지 노출
	    }
	    ,complete : function(jqXHR, textStatus){
	    	gfn_closeLoadingImage(); //로딩이미지 닫기
	    }
	}).responseText;

	var returnData;
	try{
		returnData = JSON.parse(result);
	}catch(e){
		returnData = {};
		returnData[ERROR_CODE] = -1;
		returnData[ERROR_MESSAGE_CODE] = '-1';
		returnData[ERROR_MESSAGE_TEXT] = '';
	}

	//ajax 응답객체로부터 수행결과코드 및 출력해 주어야할 메세지를 선별하여 리턴.
	var retMsg = gfn_getReturnMsg(returnData);
	//선별된 메세지를 타입에 맞추어 출력(alert or footer출력 등)
	gfn_outMessage(retMsg);

	return returnData;
}

/**
 * 세션 만료시 페이지 이동 팝업일경우에 팝업창을 닫고 부모창을 이동 시킴 - 현재 window에서 계속 opener를 찾아 내려가면서 팝업을
 * 닫고, - 최초의 부모페이지를 세션만료 페이지로 이동시킨다.
 */
function gfn_goSessionExpiredPage(opts) {
	console.log('============== gfn_goSessionExpiredPage() - start ===============');

	if (!opts) {
		opts = {};
	}

	// opener가 없으면 자기 자신을 반환할 것이다.
	var fo = gfn_closeAllPopupAndGetFirstOpener(gfn_getFOTopWin(window));
	var tw = gfn_getFOTopWin(fo); // fo를 기준으로 재귀적으로 찾은 topmost window

	// alert을 띄워도 되는 상황인지 판단하여 에러메시지 alert을 띄운다.
	if (opts.alert) {
		gfn_showMessage('ERR_NO_AUTH');
	}

	var expUrl = CONST.CONTEXT_PATH + "/"; // 세션만료 후 이동 페이지 (ex: 로그인)

	// fo의 opener가 존재할 경우
	var foo = fo.opener;
	if (foo) {
		console.log('@ fo의 opener가 존재할 경우');
		if (gfn_isInaccessibleWin(foo)) {
			console.log('@ 접근할 수 없는(다른 도메인의) opener임, 현재 창을 닫음');
			fo.close();
		} else {
			console.log('@ 접근할 수 있는(같은 도메인의) opener임: ' + foo.name);
			// 실제로 이 경우로 들어올 일은 없음, 왜냐하면 gfn_closeAllPopupAndGetFirstOpener()에서 이미 한단계 거르기 때문에
		}
		// fo의 opener가 존재하지 않을 경우
	} else {
		var fop = fo.parent; // fo의 parent

		// fo의 parent가 존재할 경우
		if (fo != fop) {
			console.log('@ fo의 parent가 존재함.');
			if (gfn_isInaccessibleWin(fop)) {
				console.log('@ 접근할 수 없는(다른 도메인의) parent임');
				// Portal의 로그인으로 이동
				top.location.href = PORTAL_URL;
			} else {
				console.log('@ 접근할 수 있는 (같은 도메인의) parent임: ' + fop.name + ', topmost window를 세션만료 페이지로 전환');
				tw.location.href = expUrl;
			}

			// fo의 parent가 존재하지 않을 경우
		} else {
			console.log('@ parent가 존재하지 않음. 현재 창을 세션만료 페이지로 전환');
			if(IS_SVC_ENABLE == "true"){
				fo.location.href = PORTAL_URL;
			} else{
				fo.location.href = expUrl;
			}
		}

	}

	// -------- 종료해야 했던 팝업윈도우들을 일괄 close() - start ---------
	for (var i = 0; i < winToCloseArr.length; i++) {
		console.log('winToCloseArr[' + i + ']: ' + winToCloseArr[i]);
		winToCloseArr[i].close();
	}
	winToCloseArr = [];
	// -------- 종료해야 했던 팝업윈도우들을 일괄 close() - end ----------

	console.log('============== gfn_goSessionExpiredPage() - end ================');
}

//-------------------------------------- popup ------------------------------------------------------

/**
 * 최상위 윈도우가 다른 도메인에 존재할 경우 window.top 프로퍼티를 사용하면 접근에러가 발생하므로,
 * 다른 방식으로 topmost window 객체를 리턴하기 위해 만든 함수.
 */
function gfn_getFOTopWin(o) {
	var p = o.parent;
	// 재귀호출을 멈추는 조건 1 - (parent == self)
	if (p === o) {
		return o;
	} else {
		// 재귀호출을 멈추는 조건 2 - 현재 레벨의 parent가 다른 도메인 소속일 경우
		if (gfn_isInaccessibleWin(p)) {
			return o;
		}
		// 재귀호출
		return gfn_getFOTopWin(p);
	}
}

/**
 * 접근할 수 없는 윈도우 객체일 경우 true를 리턴한다.
 *
 * 자바스크립트에서는 다른 도메인의 window객체의 프로퍼티에 접근하는 것을 원칙적으로 금하고 있다. parent나 opener를 참조하려
 * 할 때 parent나 opener가 다른 도메인의 소속일 경우 이런 상황을 만날 수 있는데, 이럴 때 스크립트 에러로 인해 페이지가 멈추는
 * 것을 막기 위해, 일부러 에러를 발생시킨 후 try~catch로 감싸주어 접근 가능여부를 판별해서, 타 도메인 문서의 참조 가능성을 미연에
 * 방지하도록 처리했다. 타 도메인 윈도우의 프로퍼티를 참조하는 것은 대부분의 브라우저에서는 에러로 처리하지만, 유독 webkit 계열에서는
 * 에러로 처리되지 않는다. 그러므로 좀 더 확실한 에러발생 조건을 만들기 위해서 getElementById를 사용하였다.
 *
 * @param w window객체
 */
function gfn_isInaccessibleWin(w) {
	try {
		w.document.getElementById('');
	} catch (e) {
		console.log('@ window 프로퍼티 접근 불가 - 다른 도메인의 parent나 opener를 참조했을 수 있음');
		return true; // 접근 불가
	}
	return false;
}

/**
 * 현재 window에서 계속 opener를 찾아 내려가면서 팝업의 참조를 winToCloseArr에 담고, 최초의 부모페이지(opener)의
 * 참조를 리턴한다. 인수는 반드시 각 위상의 topmost window여야 한다.
 */
function gfn_closeAllPopupAndGetFirstOpener(o) {
	console.log('gfn_closeAllPopupAndGetFirstOpener() > ' + o.name);
	var op = o.opener;

	// 재귀호출을 멈추는 조건 - 더 이상 opener가 없을 경우
	if (!op) {
		console.log('@@ opener가 존재하지 않음');
		return o;
    // 재귀호출을 하는 조건 - opener가 존재
	} else {
		// opener가 존재하더라도, 크로스도메인 상황일 경우에는 재귀호출을 멈춘다.
		if (gfn_isInaccessibleWin(op)) {
			console.log('@ opener가 다른 도메인 소속이므로 재귀호출 종료');
			return o;
		}
		winToCloseArr.push(o); // 배열에 담았다가 나중에 일괄 close() 처리를 한다.

		return gfn_closeAllPopupAndGetFirstOpener(gfn_getFOTopWin(op)); // 재귀호출
	}
}

function gfn_layerPopup(options){
	if($.isFunction(forceLayerPopup)){
		forceLayerPopup(options);
	}else if($.isFunction(parent['forceLayerPopup'])){
		options.param['pId'] = options.popupId;
		parent.forceLayerPopup(options);
	}else {
		gfn_layerPopupOrigin(options);
	}
}

function gfn_layerPopupOrigin(options) {
	var defer = $.Deferred();
	var strHeight	=	options.popupHeight > 1500 ? 1500 : options.popupHeight;
	strHeight	=	options.exceptHeight ? options.exceptHeight : strHeight;

	if(gfn_isNull(options.modal)){
		options.modal = true;
	}


	var defaultOptions = {
		width : options.popupWidth,  //사용자정의값 우선
		height : strHeight,
		modal : true,
		closeOnEscape : false,
		resizable : false,
		draggable : true,
		dialogClass : 'layerpopup-wrap',
		open: function(event, ui) {
      		$(".ui-dialog-titlebar-close", $(this).parent()).hide();
   		},
		close: function () {
            $(this).dialog('destroy').remove();
        }
	};



	var popup = $(gfn_replaceDivTag(gfn_getDivTagTemplate(), options)).dialog($.extend(defaultOptions, options));
	//$(".ui-dialog-title").text('');
	$(".ui-dialog-title").text(options.title);
	var $form = $('<form>');
	$form.attr('action', options.popupUrl);
	$form.attr('method', 'post');
	$form.attr('target', 'MODAL_IF-' + options.popupId);
	var postData = $('<input name="__postData__" type="hidden" />');
	postData.val(JSON.stringify(options));
	$form.append(postData);
	$form.appendTo('body');
	$form.submit();
	popup.dialog("open");
	return defer.promise(); // important to return the defer promise
}

function gfn_getDivTagTemplate() {
	var modaltmpl = "<div id=\"#[popupId]\" class=\"iframe-area\">";
		modaltmpl += "<iframe id=\"MODAL_IF-#[popupId]\" name=\"MODAL_IF-#[popupId]\" src=\"\" style=\"width:100%;height:100%;border:none;overFlow:visible;\"></iframe>";
		modaltmpl += "</div>";
	return modaltmpl;
}

function gfn_replaceDivTag(template, options){
	return template.replace(/#\[popupId\]/g, options.popupId);
}



/**
 * 팝업 호출 - 공통
 * @obj : 팝업창에서 넘겨 받은 option.
 */
function gfn_commonPopup(obj){
	// 검색어가 없는경우 초기화 진행
	if( gfn_isNull(obj.param.P_SEARCH_VAL) ){
		var arrElm = obj.param.arrElmId;
		var arrDs = obj.param.arrDsCol;
	}

	var method = '';
	if( !gfn_isNull(obj.param.METHOD) ){
		method = obj.param.METHOD.toLowerCase();
	}

	// 개발환경 체크 및 세팅
	gfn_setDevPopupParam(obj);

	// GET 방식이고 검색어가 있을경우 미리 Ajax로 데이터 조회한다.
	if( method == 'get' && !gfn_isNull(obj.param.P_SEARCH_VAL) ){
		var data = gfn_ajaxSync(obj.srchUrl, obj.param);

		// 데이터가 1건 있을때 팝업을 열지 않고 데이터 셋팅.
		if( !gfn_isNull( data.ds_popData.data ) && data.ds_popData.data.length == 1){
			var item = data.ds_popData.data[0];
			var pData = [{}];
			pData[0].item = item;
			gfn_parentSetParam(pData,obj.param);
			if( !gfn_isNull(obj.callBack) ){
				var fn_user = eval(obj.callBack);
				if($.isFunction(fn_user)){
					fn_user(pData);
				}
			}

		// 데이터가 없을때 팝업 호출.
		}else{
			obj.param.METHOD = 'pop';



			gfn_layerPopup(obj);
		}
	// GET 방식이 아니고 POPUP을 호출 하는경우.
	}else{
		obj.param.METHOD = 'pop';
		gfn_layerPopup(obj);
	}
}


/**
 * window popup
 */
function gfn_windowPopup(options) {

	let defer = $.Deferred();

	let panelY;
	let panelX;


	if(options.param.TYPE == "S") {
	    panelX = Math.ceil(( window.screen.width - options.width )/2);
        panelY = Math.ceil(( window.screen.height - options.height )/2); 

	}else{
	    panelX = Math.ceil(( window.screen.width - options.width )/2);
        panelY = Math.ceil(( window.screen.height - options.height )/2); 
	}

	panelX = Math.ceil(( window.screen.width - options.width )/2);
    panelY = Math.ceil(( window.screen.height - options.height )/2);

    let defaultOptions = ' width='+options.width+', height='+options.height+ ',  left='+ panelX + ', top='+ panelY + ',status=no , center=yes , scroll=no , location=no ,resizable=no, channelmode, fullscreen=yes';

	const frm = document.getElementsByName( 'popForm' );

	let frmPop;

	if ( frm.length == 1 ) {
		frmPop = frm[0];
	} else {
		frmPop = document.createElement( 'form' );
		frmPop.name = 'popForm';
		const input = document.createElement( 'input' );
		      input.type = 'hidden';
		      input.name = '__postData__';
		frmPop.appendChild( input );
		document.body.appendChild( frmPop );
	}

	window.open('',options.popupId,   defaultOptions );    
	frmPop.action = options.popupUrl;
	frmPop.method="post";
	frmPop.target = options.popupId; //window,open()의 두번째 인수와 같아야 하며 필수다.       

	//json parsing 오류
	options.element="";
	options.event="";

	frmPop.__postData__.value = JSON.stringify(options);    

	frmPop.submit();   
	return defer.promise(); // important to return the defer promise

}




/**
 * 로컬 개발환경인 경우의 호출정보(url 등) 세팅(모놀리식에서 개별 업무모듈 로컬에서 개발 시 적용)
 */
function gfn_setDevPopupParam(obj){
	if(IS_SVC_ENABLE == "true"){
		// gfn_getSvcUrl()메소드 등으로 url이 세팅된것이 아니고, 다른모듈의 URL 호출이면 Portal호출
		if(!obj.popupUrl.startsWith("http") && !obj.popupUrl.startsWith(contextPath + SVC_PREFIX)){
			obj.popupUrl = PORTAL_URL + obj.popupUrl;
		}
		if(obj.srchUrl && !obj.srchUrl.startsWith("http") && !obj.srchUrl.startsWith(contextPath + SVC_PREFIX)){
			obj.srchUrl = PORTAL_URL + obj.srchUrl;
			obj.param.withCredential = true;
		}
	}
}

/**
 * 공통 팝업 닫기
 * @param popupName
 * @resultData : 팝업창에서 넘겨 받은 데이터
 * userFunc : 부모창 호출 대상 펑션
 */
function gfn_closePopUp(popupId, resultData, userFunc) {

	if (parent.$("#"+popupId).dialog("isOpen") == true) {


		setTimeout(function() {
			parent.$("#"+popupId).dialog('close');
		}, 0);

		// 코드 검색 후 실행할 사용자 정의 함수 호출(조회 결과값 Data를 parameter로  넘김)
		//var callback = eval("window.opener.popupId." + userFunc);

		var callback = eval("parent." + userFunc);

		if ($.isFunction(callback)) {
			if (resultData != "undefined" || resultData != null || resultData != "") {
				callback(popupId, resultData);
			}
		}
		return true;
	} else {

		try{
			var callback = eval("opener." + userFunc);

			if ($.isFunction(callback)) {
				if (resultData != "undefined" || resultData != null || resultData != "") {

					callback(popupId, resultData);
				}
			}
		}catch(e) {

		}

		setTimeout(function() {
			this.close();
		}, 100);

	}
}

/**
 * 팝업 종료 전 부모창에 데이터 셋팅
 * @param : data :  팝업창에서 넘겨 받은 data
 * @obj : 팝업창에서 넘겨 받은 option.
 */
function gfn_parentSetParam(data, obj) {
	if (!gfn_isNull(data)) {
		var multy = {};

		var arrElmId = obj.arrElmId; // return 받을 element ID
		var arrDsCol = obj.arrDsCol; // return 받을 element ID

		// 데이터셋 컬럼 배열이 넘어 오지 않으면 고정 값으로 대체.
		if (gfn_isNull(arrDsCol)) {
			arrDsCol = [ 'CODE', 'NAME' ];
		}
		// 다중 선택으로 내려받은 데이터
		if (!gfn_isNull(arrDsCol) && !gfn_isNull(arrElmId)) {
			// dataSet 을 담을 배열을 미리 생성한다.
			for (var i = 0; i < arrDsCol.length; i++) {
				multy[i] = [];
			}
			for (var j = 0; j < arrDsCol.length; j++) {
				for (var i = 0; i < data.length; i++) {
					// 미리생성한 배열에 조회한 데이터의 arrDsCol를 찾아서 배열에 담아둔다.
					// 단건과 다건을 같이 사용하기 위해서 arr[] 사용.
					multy[j].push(data[i].item[arrDsCol[j]]);
				}
			}
			// 그리드가 아닌경우.
			if (obj.TYPE != 'G') {
				// 리턴받을 elementId가 있는 경우.
				if (arrElmId.length > 0) {
					for (var i = 0; i < arrElmId.length; i++) {
						// GET 방식인 경우 팝업을 띄우지 않고 데이터를 가지고 왔기 때문에 document.
						if (obj.METHOD == 'get') {
							if ($('#' + arrElmId[i], document) != 'undefined') {
								$('#' + arrElmId[i], document).val(multy[i]);
							}
						// POP 방식인 경우 팝업에서 데이터를 보내야 하기 때문에 parent.document
						} else {
							if(obj.pId){
								if(parent.$('#MODAL_IF-'+obj.pId).contents().find('#'+data.arrElmId[i]) != 'undefined'){
									parent.$('#MODAL_IF-'+obj.pId).contents().find('#'+data.arrElmId[i]).val(multy[i]);
								}
							}else{
								if ($('#' + arrElmId[i], parent.document) != 'undefined') {
									$('#' + arrElmId[i], parent.document).val(multy[i]);
								}
							}
						}
					}
				}
			// 그리드인 경우
			} else {
				// 그리드가 존재 할경우.
				if( typeof obj.GRID != 'undefined' ){

					var item = {};
					var itemLen = 0;
					if( arrElmId.length > 0 && ( arrElmId.length >= arrDsCol.length ) ){
						for(var i = 0; i < arrElmId.length; i++){
							item[arrElmId[i]] = data[0].item[arrDsCol[i]];
							itemLen++;
						}
					}

					if( obj.METHOD == 'get' ){
						if( window[obj.GRID] != 'undefined' ){
							// 내려받은 데이터를 INDEX(ROWINDEX)를 사용하여 그리드를 수정한다.
							//window[obj.GRID].updateRow(item , obj.INDEX);
							for(var i = 0 ; i < itemLen ; i++){
								window[obj.GRID].setValue(obj.INDEX, arrElmId[i], item[arrElmId[i]]);
							}
						}
					}else{
						if( parent[obj.GRID] != 'undefined' ){
							// 내려받은 데이터를 INDEX(ROWINDEX)를 사용하여 그리드를 수정한다.
							//parent[obj.GRID].updateRow(item , obj.INDEX);
							for(var i = 0 ; i < itemLen ; i++){
								parent[obj.GRID].setValue(obj.INDEX, arrElmId[i], item[arrElmId[i]]);
							}
						}
					}
				}
			}
		}
	}
}

//-------------------------------------- file ------------------------------------------------------

/**
 *	JWORK_ATTACHFILE 테이블을 이용한 파일 업/다운로드
 *
 *	JWORK_ATTACHFILE_M 에 파일의 기본 정보를 저장 하고
 *	FILE_ID (파일그룹ID) 로 JWORK_ATTACHFILE 에 업로드 한 파일 정보를 저장
 *
 *	업로드된 파일은 NAS 에 저장 됨으로
 *	다운로드를 위한 처리가 별도로 필요 함
 *	( FileDownloader )
 *
 *	이미지 파일에 대한, 미리보기(THNAIL_FILE_MASK)가 아닐 경우,
 *	파일 다운로드시 파일의 조회 카운트가 증가됨
 */

/**
 * 파일 다운로드(HTML)
 *
 * @param serviceUrl : 서비스 호출 경로
 * @param parameters : 업로드된 파일정보
 */
function gfn_downloadFile(o) {
	var sUrl = CONST.FILE_DOWN_PATH;
	sUrl = sUrl + "&" + $.param(o.params);
	window.location = sUrl;
}

/**
 *	파일업로드 팝업 공통
 *
 *	{
 *		title       : "파일업로드",				//	[선택] 팝업창 제목
 *		popupId     : "PopupFile",				//	[선택] 팝업창 ID
 *		userFunc    : '',						//	[선택] Callback 함수
 *		param : {
 *			'TYPE'              : 'S'         ,	//	[필수] G:그리드 / S:????
 *			'PREVIEW'           : true        ,	//	[선택] 첨부파일 이미지 미리보기 여부
 *			'BIZ_TYPE'          : 'PD'        ,	//	[필수] 업무 구분
 *			'FILE_ID'           : ''          ,	//	[선택] 신규 파일 업로드일 경우 공백("")
 *			'FILE_GRP_NAME'     : '파일그룹명',	//	[선택] 파일그룹_명
 *			'FILE_EXT_LIMIT'    : 'ppt|doc|xls|pptx|xlsx|docx|txt|jpg|gif|bmp|jpeg|pdf|tif|png',	//	[선택] 업로드 가능한 파일 확장자. 시스템 설정 한도내에서 제한
 *			'FILE_SIZE_LIMIT'   : 10          ,	//	[선택] 업로드 파일 사이즈 제한. MB 단위. 시스템 설정 한도내에서 제한
 *			'FILE_SIZE_CHK'     : true        ,	//	[선택] true : 첨부 파일의 전체 사이즈를 제한 / false : 새로 업로드 하는 파일만 체크 (default)
 *		},
 *	}
 *
 *	@param opt.param.TYPE     [필수] G:그리드 / S:????
 *	@param opt.param.BIZ_TYPE [필수] 업무 구분
 *
 */
function gfn_commonFileUploadPopup( opt ) {

	//console.log( 'opt', JSON.stringify(opt) );

	//	필수 항목 체크
	if (
		   gfn_isNull( opt.param.TYPE     ) || opt.param.TYPE     == ''
		|| gfn_isNull( opt.param.BIZ_TYPE ) || opt.param.BIZ_TYPE == ''
	) {
		gfn_showMessage( '필수 파라미터값이 누락 되어, 파일 업로드를 처리 할 수 없습니다.' );
		return;
	}

	const options = {
			title       : opt.title    ? opt.title    : "파일업로드",
			popupId     : opt.popupId  ? opt.popupId  : "PopupFile",
			popupWidth  : opt.width    ? opt.width    : 864,
			popupHeight : opt.height   ? opt.height   : 700,
			popupUrl    : opt.popupUrl ? opt.popupUrl : '/comfunc/func/file/page',
			userFunc    : opt.userFunc ? opt.userFunc : '',
			param : {
				'METHOD'              : 'pop',
				'TYPE'                : opt.param.TYPE,				//	[필수] G:그리드 / S:????
				'arrElmId'            : [],
				'arrDsCol'            : [],
				'PREVIEW'             : opt.param.PREVIEW       === true ? true : false                           ,	//	[선택] 첨부파일 이미지 미리보기 여부
				'BIZ_TYPE'            : opt.param.BIZ_TYPE                                                        ,	//	[필수] 업무 구분
				'FILE_ID'             : opt.param.FILE_ID         ? opt.param.FILE_ID         : ''                ,	//	[선택] 신규 파일 업로드일 경우 공백("")
				'FILE_GRP_NAME'       : opt.param.FILE_GRP_NAME   ? opt.param.FILE_GRP_NAME   : opt.param.BIZ_TYPE,	//	[선택] 파일그룹_명
				'FILE_EXT_LIMIT'      : opt.param.FILE_EXT_LIMIT  ? opt.param.FILE_EXT_LIMIT  : 'ppt|doc|xls|pptx|xlsx|docx|txt|jpg|gif|bmp|jpeg|pdf|tif|png',	//	[선택] 업로드 가능한 파일 확장자. 시스템 설정 한도내에서 제한
				'FILE_SIZE_LIMIT'     : opt.param.FILE_SIZE_LIMIT ? opt.param.FILE_SIZE_LIMIT : 1                 ,	//	[선택] 업로드 파일 사이즈 제한. MB 단위. 시스템 설정 한도내에서 제한
				'FILE_SIZE_CHK'       : opt.param.FILE_SIZE_CHK === true ? true : false                           ,	//	[선택] true : 첨부 파일의 전체 사이즈를 제한 / false : 새로 업로드 하는 파일만 체크 (default)
				'DELETE_YN'           : opt.param.DELETE_YN           == 'N' ? 'N' : 'Y'                          ,	//	[선택] 삭제 사용여부. Y:사용(Default)/N:미사용(팝업창에서 버튼 삭제)
				'MULTIFILE_UPLOAD_YN' : opt.param.MULTIFILE_UPLOAD_YN == 'N' ? 'N' : 'Y'                          ,	//	[선택] 다중 파일 업로드 사용 여부. Y:사용(Default)/N:미사용(한번에 하나의 파일만 업로드)
			},
		};

	//console.log( 'options', JSON.stringify(opt) );
	if(gfn_isNull(opt.modal) || opt.modal == true) {
		gfn_commonPopup(options);
	}else if ( opt.modal == false) {
		gfn_windowPopup(options);
	}
}

function gfn_uploadTran(svcId, callUrl, objForm, inDs, tranCallback, pShowLoading) {

	// 업무별 사용자 json 데이터
	let formData;

	if ( objForm == undefined ) {
		console.error( 'objForm undefined...' );
		//	MSG.COM.ERR.010	업로드중 오류가 발생하였습니다.
		gfn_showMessage("MSG.COM.ERR.010");
		return;
	} else if ( objForm.tagName && objForm.tagName.toLowerCase() == 'form' ) {

		//	Form
		formData = new FormData(objForm);

		formData.method  = 'POST';
		formData.enctype = 'multipart/form-data';

	} else if ( objForm.constructor.name.toLowerCase() == 'formdata' ) {
		//	FormData
		formData = objForm;
	} else {
		console.error( 'objForm type unknown...' );
		//	MSG.COM.ERR.010	업로드중 오류가 발생하였습니다.
		gfn_showMessage("MSG.COM.ERR.010");
		return;
	}

	formData.append("inputData", JSON.stringify(inDs));

	//console.log(svcId, callUrl, pShowLoading);

	// APPEND FILE TO POST DATA
	var uploadData = {
	    url: callUrl,
	    type: 'POST',
	    headers:{'AjaxType':'FOUpload'},	//FrameOne에서 정한 공통 JSON 형식
	    data: formData,				//JSON.stringify(uploadJson),
        async: true,
	    cache: false,
	    contentType: false,
	    processData: false,
	    beforeSend: function(jqXHR, settings) {
	    	gfn_openLoadingImage({pLoad: pShowLoading});	//로딩이미지 노출
	    },
	    success: function(data, textStatus, jqXHR){
	    	//window.console.log("Success!! [" + textStatus + "] \r\n - data : " + data + " \r\n - jqXHR.responseText : " + jqXHR.responseText);
	    	//tranCallback(svcId, data, ERR_CD_SUCCESS); //  msgTp, msgCd, msgText
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	window.console.error("에러발생!! [" + textStatus + "] / " + errorThrown);
	    },
	    complete: function(jqXHR, textStatus) {
		    gfn_closeLoadingImage();	//로딩이미지 닫기

			//서버에서 에러 발생시 HtmlErrorHandlingFilter에서 SVC_ERR_DETAIL에 에러메세지를 담는데,
			//이 에러메세지에 JSON parsing이 불가능한 문자가 들어 있을 경우 JSON.parse()에서 에러가 발생하고
			//200 에러와 함께 이후 콜백이 수행되지 않는 문제 때문에 try ~ catch로 감싸주고, catch절에서 빈 메세지를 셋팅함.
	    	//window.console.log("--> textStatus : " + textStatus + " response : <<< " + jqXHR.responseText + " >>>");
			var returnData;
			try{
				if (jqXHR.responseJSON)
					returnData = jqXHR.responseJSON;
				else
					returnData = JSON.parse(jqXHR.responseText);
			}catch(e){
				returnData = {};
				returnData[ERROR_CODE] = -1;
				returnData[ERROR_MESSAGE_CODE] = '-1';
				returnData[ERROR_MESSAGE_TEXT] = 'ERR_NO_AUTH';
			}

			//ajax 응답객체로부터 수행결과코드 및 출력해 주어야할 메세지를 선별하여 리턴.
			var retMsg = gfn_getReturnMsg(returnData);
			//선별된 메세지를 타입에 맞추어 출력(alert or footer출력 등)
			gfn_outMessage(retMsg);

			//사용자정의 콜백 실행
			if($.isFunction(tranCallback)){ //사용자정의 에러처리를 해야 할 수도 있기 때문에 수정함
				tranCallback(svcId, returnData, retMsg.errCd, retMsg.msgTp, retMsg.msgCd, retMsg.msgText);
			}
	    }
	};
	$.ajax(uploadData);
}

function gfn_file_createUploadDataset(bizType, attchNo, workFgCd, keyVal, draftNo, fileFgCd) {
	var dsUploadInfo = {};
	/******************************************************************
	 * file upload 필수 입력 데이터 항목
	 ******************************************************************/
	// file upload 필수 dataset json data
	// 반드시 Dataset json item 명을 ds_upload, ds_uploadGroup로 지정해야 함.
	dsUploadInfo["ds_uploadGroup"] = [];
	dsUploadInfo["ds_upload"] = [];

	dsUploadInfo.ds_uploadGroup = gfn_file_getDataset(
		{
			BIZ_TYPE          : bizType,
			FILE_ID           : attchNo,	//	NEW
			ATTCH_FILE_GRP_NO : attchNo,	//	OLD
		},
		(gfn_isNull(attchNo) ? "I" : "U")
	);
	return dsUploadInfo;
}

/**
 * json 또는 json-array 데이터를 공통데이타셋 형식으로 변경
 */
function gfn_file_getDataset(data, rowStatus){
	rowStatus = rowStatus || 'I';
	var ret = {};
	ret["data"] = [];
	ret["deletedData"] = [];

	if ($.isArray(data)) {
		if (data.length > 0) {
			if (gfn_isNull(data[0].__rowStatus)) {
				for(var i=0; i<data.length; i++) {
					//if ( data[i]['ATTCH_FILE_NO'] == null ) {  // 업로드 실행 전 상태의 파일만. ATTCH_FILE_NO(OLD) / FILE_SEQ(NEW)
					if ( gfn_isNull( data[i]['ATTCH_FILE_NO'] ) && gfn_isNull( data[i]['FILE_SEQ'] ) ) {  // 업로드 실행 전 상태의 파일만. ATTCH_FILE_NO(OLD) / FILE_SEQ(NEW)
						data[i].__rowStatus = rowStatus;
						ret["data"].push(data[i]);
					}
				}
			}
		}
	} else {
		if (gfn_isNull(data.__rowStatus)) {
			data.__rowStatus = rowStatus;
		}
		ret["data"].push(data);
	}
	return ret;
}

/**
 * 파일 제한 조건(사이즈, 파일 종류) 검증
 * @param	file  : 선택된 파일
 *			sizeLimit  : 제한 파일 사이즈
 *			extLimit : 제한 확장자 목록 (;구분자로 여러 파일 지정 - 서버 설정)
 *			showMsg  : 메시지 표시 여부 true/false
 */
function gfn_checkUploadFile(file, sizeLimit, extLimit, showMsg) {
	// 파일 용량 제한 확인.
	var limit = gfn_toNum(gfn_decode(sizeLimit, null, -1, sizeLimit));
	if (limit != -1) {
		if (file.size > (limit * 1024)) {
			showMsg && gfn_showMessage("업로드 가능한 용량을 초과하였습니다.");
			return false;
		}
	}
	var fileName = file.name;
	// 파일 확장자 체크. 파일명에 . 이 들어갔을 경우 업로드 가능해야 한다.
	var ext = String(fileName).substr(fileName.lastIndexOf(".") + 1);
	var arrExt = String(extLimit).split("|");
	if (gfn_length(arrExt) > 0) {
		var extValid = false;
		for (var i = 0; i < gfn_length(arrExt); i++) {
			if (arrExt[i] == gfn_toLower(ext)) {
				extValid = true;
				break;
			}
		}
		if (!extValid) {
			showMsg && gfn_showMessage("업로드 가능한 파일이 아닙니다.");
			return false;
		}
	}
	return true;
}

/**
 *	파일 다운로드
 *	파일 1건 다운로드이며
 *	FILE_ID, FILE_SEQ 가 필요 함
 *
 *	@param fileId
 *	@param fileSeq
 */
function gfn_fileDownload( fileId, fileSeq ) {
	gfn_downloadFile( {
		params: {
			'FILE_ID'  : fileId,
			'FILE_SEQ' : fileSeq,
			'TYPE'     : 'DOWNLOAD'
		}
	} );
}

/**
 *	파일 미리보기
 *	파일 1건 미리보기이며
 *	FILE_ID, FILE_SEQ 가 필요 함
 *
 *	호출시 파일 조회 카운트를 증가시키기 않음
 *
 *	이미지 썸네일일 경우 img 의 src 를 다음과 같은 형식으로 지정 해주도록 함
 *	`${CONST.FILE_DOWN_PATH}FILE_ID=${item.FILE_ID}&FILE_SEQ=${item.FILE_SEQ}&TYPE=THNAIL`
 *
 *	@param fileId
 *	@param fileSeq
 */
function gfn_filePreview( fileId, fileSeq ) {
	gfn_downloadFile( {
		params: {
			'FILE_ID'  : fileId,
			'FILE_SEQ' : fileSeq,
			'TYPE'     : 'PREVIEW'	//	PREVIEW(미리보기) / THNAIL(썸네일)
		}
	} );
}


//-------------------------------------- file 끝 ------------------------------------------------------

//-------------------------------------- 단순한(?) file 관리 ------------------------------------------------------

/**
 *	JWORK_ATTACHFILE 테이블에 파일 정보를 저장 하지 않고
 *	(그리드로 조회 하기 위한 ) 엑셀파일 업로드나 - 데이터 파싱후 업로드 파일 삭제
 *	엑셀 업로드를 위한 템플릿 파일 다운로드와 같이
 *	단순한 파일 업/다운로드 처리
 */

/**
 *	파일(만) 업로드
 *
 *	FormData 에 파일(Object)과 (추가)파라미터 설정해서 호출
 *
 *	호출 URL 에서 필요한 처리 구현
 *
 *	ex)
 *	@RequestMapping(value = "/excelUpload", produces = "application/json; charset=utf8")
 *	public Parameters upload( MultipartHttpServletRequest request, Parameters params,  Map<String,String> uploadConfig ) {
 *		... ( request 를 이용해 파일 처리 및 필요 로직 구현 )
 *	}
 *
 *	@param  svcId        [필수] 서비스ID
 *	@param  callUrl      [필수] 호출 URL. 파일 업로드
 *	@param  formData     [필수] FormData 객체. 파일 및 추가 파라미터
 *	@param  tranCallback [선택] 콜백함수. svcId / returnData / retMsg = { errCd, msgTp, msgCd, msgText } 전달
 *	@param  pLoad        [선택] 로딩 이미지 표시 여부. true(표시) / false(표시안함)
 *	@return void
 */
function gfn_fileUpload( svcId, callUrl, formData, tranCallback, pLoad ) {

	// APPEND FILE TO POST DATA
	const uploadData = {
	    url         : callUrl,
	    type        : 'POST',
	    headers     : {'AjaxType':'FOUpload'},	//FrameOne에서 정한 공통 JSON 형식
	    data        : formData,
        async       : true,
	    cache       : false,
	    contentType : false,
	    processData : false,
	    beforeSend  : function() {	//console.log( jqXHR, settings );
	    	//gfn_openLoadingImage( { pLoad } );	//로딩이미지 노출
	    	gfn_openLoadingImage({pLoad : pLoad}); // 로딩이미지 노출
	    },
	    success     : function() {	//console.log( data, textStatus, jqXHR );
	    	//window.console.log("Success!! [" + textStatus + "] \r\n - data : " + data + " \r\n - jqXHR.responseText : " + jqXHR.responseText);
	    	//tranCallback(svcId, data, ERR_CD_SUCCESS); //  msgTp, msgCd, msgText
	    },
	    error       : function( jqXHR, textStatus, errorThrown ) {
	    	window.console.error( `에러발생!! [${textStatus}] / ${errorThrown}` );
	    },
	    complete    : function( jqXHR, textStatus ) {

		    gfn_closeLoadingImage();	//로딩이미지 닫기

			//서버에서 에러 발생시 HtmlErrorHandlingFilter에서 SVC_ERR_DETAIL에 에러메세지를 담는데,
			//이 에러메세지에 JSON parsing이 불가능한 문자가 들어 있을 경우 JSON.parse()에서 에러가 발생하고
			//200 에러와 함께 이후 콜백이 수행되지 않는 문제 때문에 try ~ catch로 감싸주고, catch절에서 빈 메세지를 셋팅함.
	    	//window.console.log("--> textStatus : " + textStatus + " response : <<< " + jqXHR.responseText + " >>>");
			let returnData;

			try {
				if ( jqXHR.responseJSON ) {
					returnData = jqXHR.responseJSON;
				} else {
					returnData = JSON.parse( jqXHR.responseText );
				}
			} catch(e) {
				console.error( e );
				returnData = {};
				returnData[ERROR_CODE        ] = -1;
				returnData[ERROR_MESSAGE_CODE] = '-1';
				returnData[ERROR_MESSAGE_TEXT] = 'ERR_NO_AUTH';
			}

			//ajax 응답객체로부터 수행결과코드 및 출력해 주어야할 메세지를 선별하여 리턴.
			let retMsg = gfn_getReturnMsg(returnData);

			//선별된 메세지를 타입에 맞추어 출력(alert or footer출력 등)
			gfn_outMessage( retMsg );

			//사용자정의 콜백 실행
			if ( $.isFunction( tranCallback ) ) {
				tranCallback( svcId, returnData, retMsg.errCd, retMsg.msgTp, retMsg.msgCd, retMsg.msgText );
			} else if ( $.isFunction( eval( tranCallback ) ) ) {
				eval(tranCallback)( svcId, returnData, retMsg.errCd, retMsg.msgTp, retMsg.msgCd, retMsg.msgText );
			}
	    }
	};

	$.ajax( uploadData );
}

/**
 *	간단한(?) 파일 다운로드
 *	파일 1건 다운로드이며
 *	서버 URL 호출 방식
 *	서버에서는 (알아서) 다운로드 로직 처리
 *
 *	다음과 같이 단순하게 다운로드 할 수 도 있지만,
 *	로딩 이미지를 표시 하기 위해, $.ajax() 사용 함...
 *
 *	window.location = contextPath + url;
 *
 *	@param url  [필수] 파일 다운로드 요청 URL. 처리 로직 구현 필요
 *	@param data [선택] JSON 형식 추가 파라미터. { filename : '다운받을_파일명' }
 */
function gfn_simpleFileDownload( url, data ) {

	$.ajax( {
		url         : url,
		data        : gfn_isNull(data) ? '{}' : JSON.stringify(data),
		type        : 'POST',
		async       : true,
		crossDomain : false,
		contentType : "application/json; charset=UTF-8",
		beforeSend : function( jqXHR ) {
			jqXHR.setRequestHeader("AJAX", "true")
			jqXHR.setRequestHeader("SERVICE_ID",CONST.PROG_CD);
			//jqXHR.setRequestHeader("LOG_TYPE",options.pSvcFlag);
			gfn_openLoadingImage( { pLoad : true } ); // 로딩이미지 노출
		},
		xhrFields : {
			 responseType    : "blob",
			 withCredentials : false		//	default
		},
		complete : function( jqXHR ) {
			gfn_closeLoadingImage(); // 로딩이미지 닫기
			if ( jqXHR.status == '403'|| jqXHR.status == '401') {
				console.error( 'transaction : ' + ERR_CD_NO_AUTH );
				gfn_goSessionExpiredPage( { alert: true } );
			}
		}
	} ).done(function (blob, status, xhr) {

		//	https://jjester.tistory.com/106

		// check for a filename
        var fileName = "";
        var disposition = xhr.getResponseHeader("Content-Disposition");

        if (disposition && disposition.indexOf("attachment") !== -1) {
            var filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
            var matches = filenameRegex.exec(disposition);

            if (matches != null && matches[1]) {
                fileName = decodeURI(matches[1].replace(/['"]/g, ""));
            }
        }

        // for IE
        if (window.navigator && window.navigator.msSaveOrOpenBlob) {
            window.navigator.msSaveOrOpenBlob(blob, fileName);
        } else {
            var URL = window.URL || window.webkitURL;
            var downloadUrl = URL.createObjectURL(blob);

            if (fileName) {
                var a = document.createElement("a");

                // for safari
                if (a.download === undefined) {
                    window.location.href = downloadUrl;
                } else {
                    a.href = downloadUrl;
                    a.download = fileName;
                    document.body.appendChild(a);
                    a.click();
                }
            } else {
                window.location.href = downloadUrl;
            }
        }
    } )
	;

}


//-------------------------------------- 단순한(?) file 관리 끝 ------------------------------------------------------

//-------------------------------------- 계좌 인증(API) 공통 팝업 시작 ------------------------------------------------------

/**
 *	계좌 인증 공통 팝업
 *
 *	ex)
 *	const options = {
 *		param   : {
 *			BANK_CD : $( '#BANK_CD' ).val(),	//	은행코드
 *			OWAC_NM : $( '#OWAC_NM' ).val(),	//	예금주 명
 *			ACCT_NO : $( '#ACCT_NO' ).val(),	//	계좌 번호
 *		},
 *		callBack: 'fn_acctCertPopupCallback',	//	콜백. 함수명(문자)
 *	};
 *
 *	gfn_commonAcctCertPopup( options );
 *
 *	@param	param    [선택] 파라미터
 *							BANK_CD : 은행코드
 *	                        OWAC_NM : 예금주
 *	                        ACCT_NO : 계좌 번호
 *	@param	callBack [선택]
 *
 *	@return	data[0].item 에 다음과 같은 결과 값 리턴
 *				AUTH_YN : 인증 성공 여부. Y(성공)/N(실패)
 *				BANK_CD : 은행코드
 *	            OWAC_NM : 예금주 명
 *	            ACCT_NO : 계좌 번호
 */
function gfn_commonAcctCertPopup( opt ) {

	//console.log( 'opt', JSON.stringify(opt) );

	const options = {
			title       : "계좌 인증",
			popupId     : "AcctCert",
			popupWidth  : 450,
			popupHeight : 350,
			popupUrl    : '/comfunc/func/common/CMAcctCertApi/popup',
			callBack    : opt.callBack ? opt.callBack : '',
			param       : opt.param    ? opt.param    : {},
		};

	//console.log( 'options', JSON.stringify(opt) );
	if(gfn_isNull(opt.modal) || opt.modal == true) {
		gfn_commonPopup(options);
	}else if ( opt.modal == false) {
		gfn_windowPopup(options);
	}
}

//-------------------------------------- 계좌 인증(API) 공통 팝업 시작 ------------------------------------------------------


/**
 * 입력된 값 또는 수식을 검사해 적당한 값을 Return
 */
function gfn_decode(){
    var condVal = (arguments[0]==undefined)?null:arguments[0];

    for(var i = 1 ; i < arguments.length; i+=2 ) {
		if(i + 1 == arguments.length) return arguments[i];

		if(condVal == arguments[i]) {
			return arguments[i+1];
		}
	}
	return arguments[i-2];
}

/**
 * 입력값 형태에 따라서 길이 또는 범위를 구하는 함수 ( bound 함수와 같음 )
 * @argument       	: 객체, 문자열, 배열
 * @returns        	: Type에 따라 구해진 길이 또는 범위
 * @ex : Length("123")
 */
function gfn_length(args){
	if(gfn_isNull(args)) return 0;

	if(args.components) {
		return args.components.length;//object인 경우 count of components
	} else {
		return gfn_nvl(args.length, 0);//Array, String, Variant인 경우
	}
}

function gfn_subString(stringValue,nStart,nLength){
	if(arguments.length == 3)
		return String(stringValue).substr(nStart, nLength);
	else
		return String(stringValue).substr(nStart);
}


//-------------------------------------- UI Component(pageTitle, authBtn, selectbox) ------------------------------------------------------


/**
 * ParentElement의 하위에 있는 버튼들 중 Auth타입(data-authType)에 해당하는 권한을 처리한다
 * @param btnParentElements auth버튼들의 ParentElement들 (ex. #page-header, .page-header )
 */
function gfn_initAuthBtn(btnParentElements){


    // 상위버튼 처리
	let authTopButton = _.filter(PRG_INFO.PAGE_BUTTON, {SERVICE_TYPE: '4'});

    for(let data of authTopButton) {
	    if (data.MENU_NM.indexOf("F3") > -1) {
		  lement = "<button type='button' class='ctn-btn ctn-btn--primary ml-2-5'" + " id=" + data.MENU_ID +  " onclick='gfn_btncallFunc(\"" + data.EVENT_NAME + "\")';>" + data.MENU_NM + "</button>";
	    }else{
		  lement = "<button type='button' class='ctn-btn ctn-btn--dark ml-2-5'" + " id=" + data.MENU_ID +  " onclick='gfn_btncallFunc(\"" + data.EVENT_NAME + "\")';>" + data.MENU_NM + "</button>";
		}
		$(".page-button").append(lement);
	}


	//Tab 버튼
	let authTap = _.filter(PRG_INFO.PAGE_BUTTON, {SERVICE_TYPE: '6'});

	if (!$.isArray(btnParentElements))
		btnParentElements = [btnParentElements];

	for(var i = 0; i < btnParentElements.length; i++) {
		var btnParentEl = btnParentElements[i];
		$(btnParentEl).find('li').each(function (idx) {
			var authType = $(this).attr("data-authType"); // required 속성

			if (!gfn_isNull(authType)) {
				if (authTap[authType] != "Y") {
					$(this).remove(); // 엘리먼트 삭제
				}
			}
		});
	}

	try{
		if(PRG_INFO.PAGE_FACTORY != null && PRG_INFO.PAGE_FACTORY.length > 0) {
		   let btnFav = $(".btn-favToggle");
		    btnFav.addClass("active");
		}
    }catch(e){}



	try{
		let btnHelp = $("#titleHelp");


		if(PRG_INFO.PAGE_HELP != null && PRG_INFO.PAGE_HELP[0].HELP_REG_YN == "Y") {
		  let btnHelp = $("#titleHelp");
		  btnHelp.addClass("ctn-btn--secondary").removeClass("ctn-btn--gray");
		}else{
		  btnHelp.removeClass("ctn-btn--secondary").addClass("ctn-btn--gray");
		}
	}catch(e){}



}


/**
 *  현업 요구 사항으로 공통버튼 처리
 */
function gfn_btncallFunc(eventId){


	let callFunc = eval("fn_" + eventId);

	if ($.isFunction(callFunc)) {
		callFunc.call();
	}
}


/**
 * ParentElement의 하위에 있는 버튼들 중 Auth타입(data-authType)에 해당하는 권한을 처리한다
 * @param btnParentElements auth버튼들의 ParentElement들 (ex. #page-header, .page-header )
 */
function gfn_initAuthBtnOrg(btnParentElements){

	//console.log(PAGE_INFO);

	if (!$.isArray(btnParentElements))
		btnParentElements = [btnParentElements];

	for(var i = 0; i < btnParentElements.length; i++) {
		var btnParentEl = btnParentElements[i];
		// console.log(btnParentEl);
		$(btnParentEl).find('button').each(function (idx) {
			var authType = $(this).attr("data-authType"); // required 속성
			//console.log($(this).text(), authType, PAGE_INFO[authType]);
			if (!gfn_isNull(authType)) {
				if (PAGE_INFO[authType] == "1") {
					$(this).removeClass('btn-auth');
				} else {
					$(this).remove(); // 엘리먼트 삭제
				}
			}
		});
	}
}

/**
 * 해당 엘리먼트에 PageTitle 텍스트를 설정한다.
 * @param elementId PageTitle이 설정될 엘리먼트 ID(ex. #pageTitle )
 */
function gfn_initPageTitle(elementId){

	//console.log(PAGE_INFO);

	let pageNm = PAGE_INFO["MENU_NM"] + " ( " + PAGE_INFO["MENU_ID"] + " )";
	$(elementId).text(pageNm);
}

/**
 * 페이지타이틀 및 권한버튼,select 등 공통 컴포넌트 init 메소드
 * @param authBtnParentEls authBtn,select 처리가 필요한 컴포넌트들을 포함하고 있는 부모 엘리먼트들
 */
function gfn_initComponent(componentParentEls){

	gfn_initPageTitle("#pageTitle"); // pageTitle 디폴트 엘리먼트ID '#pageTitle'

	if(!gfn_isNull(componentParentEls)){
		gfn_initAuthBtn(componentParentEls);
		gfn_initCommCdSelect(componentParentEls);
	}


	 // === 즐겨찾기 버튼 ===
	 try{
	     let btnFav = $(".btn-favToggle");
		  btnFav.click(function() {

			_gfn_factory();

			if($(this).hasClass("active") === true) {
				$(this).removeClass("active");
			}else{
				$(this).addClass("active");
			}

		  });
      }catch(e){}


     // === 도움말  버튼 ===
	 try{
	     let btnHelp = $("#titleHelp");
		  btnHelp.click(function() {
			_gfn_help();
		  });
      }catch(e){}


	//클릭시 종료 처리
	document.onclick = function(e){
        // 달력을 닫는다
        CalendarUtil.closeCalendar();

        try{
	   		parent.fn_removeQuickMenu();
	   	}catch(e){};

    }

}

/**
 * 나코 크로스 에디터 설정
 * @param namoElements 에디터 엘리먼트
 * @param configs 설정 속성
 */
function gfn_initNamoComponent(namoElements, configs){
	if (!window.NamoSE) return;

	let elem = $(namoElements);
	if (elem.length == 0) return;
	if (gfn_isNull(configs)) configs = {};

	let CrossEditor = new NamoSE('namoeditor');
	CrossEditor.params.UploadFileExecutePath = configs.UploadFileExecutePath ||  NAMO_UPLOAD_URL;
	CrossEditor.params.Width = configs.width || "100%";
	CrossEditor.params.Height = configs.height || elem.height();
	CrossEditor.params.ParentEditor =  elem[0]; //  document.getElementById("CONTENTS");
	CrossEditor.params.ResizeBar = configs.resize === true ? configs.resize : false;
	CrossEditor.params.DisplayToolbar = configs.toolbar === false ? configs.toolbar : true;
	CrossEditor.EditorStart();
}

/*
 * 즐겨찾기 추가 및 삭제 처리
*/

function _gfn_factory(){

	let insertYn = 'N';

	if($('.btn-favToggle').hasClass("active")){
		insertYn = 'N';
	}else{
		insertYn = 'Y'
	}

	var progCd = CONST.PROG_CD;

	if (gfn_isNull(progCd)) {
		return;
	}

	var inDs = {
				'SERVICE_ID'  :	progCd,
				'ADD_YN'      : insertYn,
				'__rowStatus' :	'I'
	};

	//트랜젝션 파라미터 설정
	var param = {
				svcId 	: 'addDeleteUsersMyMenu',						// tranCallBack 에서 처리할 ID
				strUrl  : CONST.CONTEXT_PATH + "/common/main/insertUsersMyMenu", // 전송 url
				param : {'ds_usersMyMenu' : gfn_wrapDatasetParam(inDs)},
	 			pCall : _factoryCallBack,
	 			pLoad : false
	};

	//트랜젝션 실행
	gfn_transaction(param);
}


function _factoryCallBack(svcId, data, errCd, msgTp, msgCd, msgText) {

    // 결과가 성공일 경우
    if (errCd != ERR_CD_SUCCESS) {
        return;
    }


}



/*
 * 도움말 클릭
*/
function _gfn_help(){

	let serviceId = CONST.PROG_CD;


	let options = {
			param: {'TYPE' : 'S', SERVICE_ID : serviceId}
			, width: 1000
			, height: 800
			, popupId: 'SSHlpInqPopup'
			, popupUrl: '/sysmgt/func/ss/SSHlpInqPopup/page'
			, callBack: 'fn_popupCallBack'
	};

	if(PRG_INFO.PAGE_HELP != null && PRG_INFO.PAGE_HELP[0].HELP_REG_YN == "N") {
		options.popupUrl = '/sysmgt/func/ss/SSHlpRegPopup/page';
	}

	gfn_windowPopup(options);

}



/**
 * gfn_commCdSelectCallBack 콜백 메소드
 * @param element select 엘리먼트(jquery)
 * @param commCdList select의 option으로 처리할 코드리스트
 */
function gfn_commCdSelectCallBack(element, commCdList){
	//console.log(element);

	// SelectDefaultName 설정
	//var defaultNm = element.attr("data-defaultNm");
	//if(!gfn_isNull(defaultNm)) {
	//	element.append($('<option>').val("").text(defaultNm));
	//}


	if(!gfn_isNull(commCdList)){
		for(var i = 0; i < commCdList.length; i++) {
			// selectbox 처리 commCdList[i]
			var option = $('<option>').val(commCdList[i].CODE).text(commCdList[i].CODE_NAME);
			option.data = JSON.stringify(commCdList[i]);

			if (commCdList[i].CODE == element.attr("data-selectedVal")) {
				option.attr("selected", "selected"); // selected Value
			}
			//console.log(option);
			element.append(option);
		}

		var multiple = element.attr("multiple");

		if(!gfn_isNull(multiple)){
			element.SumoSelect({ csvDispCount: 10, search: true, searchText:'선택하세요.' , clearAll:true});
			element[0].sumo.selectItem(0);

			// multiple combo 랜더링 시 바뀐 옵션들을 적용하기위해 reload를 해야함
			element[0].sumo.reload();
		}

	}
}



/**
 * ParentElement의 하위에 있는 select 중 공통코드 기반 select를 생성한다.
 * ex. <select id="BBS_TP_CD_TEST" name="BBS_TP_CD_TEST" data-grpCd="BBS_TP" data-defaultNm="<spring:message code='LABEL.CPT.ALL' />" data-selectedVal="FAQ" data-addParam="RSV_STR1_VAL=test|RSV_STR2_VAL=test2">
 * @param selectParentElements 처리가 필요한 select들의 ParentElement들 (ex. #page-header, .page-header )
 */
function gfn_initCommCdSelect(selectParentElements){



	if (!$.isArray(selectParentElements))
		selectParentElements = [selectParentElements];


	for(var i = 0; i < selectParentElements.length; i++) {
		var selectParentEl = selectParentElements[i];

		//InputBox
		$(selectParentEl).find('input').each(function (idx) {

			// 2022-09-02 input box 에 type 속성 처리
			let _searchYn     = $(this).attr("data-enterSearchYn");            // 자동조회여부
			let _searchButton = $(this).attr("data-callFunction");             // 조회시 버튼
			let _type         = $(this).attr("type");                          // type 값 조회
			let _id           = $(this).attr("id");                            // type 값 조회
			let _calandar     = $(this).attr("data-calandar");                 // 칼렌터
			let _popup        = $(this).attr("data-popup");                    // 팝업

			// 입력창 AUTOCOMPLETE 제거
			$(this).attr('autocomplete', 'off');

			if(_type == "text") {

				/* InputMask인경우 Document.click 이벤트가 발생 안함 */
				$(this).on('click', function(e) {
					CalendarUtil.closeCalendar();
	   			});

	   			if(gfn_isNull(_calandar)) {

					$(this).on('keyup', function(e) {

						e.preventDefault();
					    e.stopPropagation();

						if (_searchYn) {
			   				if (e.keyCode === 13) {

								var _fn_search = eval(_searchButton);
			   					if ($.isFunction(_fn_search)) {
									_fn_search.call();

								}
			   			    }
			   			 }
		   			});
		   		}

	   			//달력
	   			if(_calandar) {

		            let _calandarFormat    = $(this).attr("data-calandar-format");           // 칼렌터 Format
		            let _calandarMulti     = $(this).attr("data-calandar-multi");           // 칼렌터 Format

		            if(gfn_isNull(_calandarFormat)){
						_calandarFormat = "yyyy-mm-dd";
		            }

		            if(gfn_isNull(_calandarMulti)){
						_calandarMulti = false;
		            }

		   			let disabled = this.getAttribute("disabled");


		   			if(_calandarFormat == "yyyy-mm-dd") {

				        $(this).inputmask({ alias: "datetime"
				                        //, inputFormat:"yyyy-mm-dd"
				                        , inputFormat:_calandarFormat
				                        , showMaskOnHover:false  // 마우스를 가리킬 때 마스크를 표시 여부
				                        , showMaskOnFocus:false  // 입력에 포커스가있을 때 마스크를 표시 여부
				                        , placeholder:" "        // placeholder 표시 글자 default: inputFormat
				                        , autoUnmask :  true
				                        , clearIncomplete : true   // 불완전한 입력 삭제
				                        , outputFormat : "yyyymmdd"
				                        , removeMaskOnSubmit:true
				                     });
				    } else {

					    $(this).inputmask({ alias: "datetime"
				                        //, inputFormat:"yyyy-mm-dd"
				                        , inputFormat:_calandarFormat
				                        , showMaskOnHover:false  // 마우스를 가리킬 때 마스크를 표시 여부
				                        , showMaskOnFocus:false  // 입력에 포커스가있을 때 마스크를 표시 여부
				                        , placeholder:" "        // placeholder 표시 글자 default: inputFormat
				                        , autoUnmask :  true
				                        , clearIncomplete : true   // 불완전한 입력 삭제
				                        , outputFormat : "yyyyMM"
				                        , removeMaskOnSubmit:true
				                     });

				    }

			        //alert(_id + "," + _calandarMulti);



			        if(! _calandarMulti) {
				      	if(_calandarFormat == "yyyy-mm-dd") {
							 $(this).after("<button id='btn"+_id+"' type='button' onclick='gfn_cmmnCal(\""+_id+"\",\"yyyy-MM-dd\", event)'><i class='icon calendar'></i></button>");
						}else{
							 $(this).after("<button id='btn"+_id+"' type='button' onclick='gfn_cmmnCal(\""+_id+"\",\"yyyy-MM\", event)'><i class='icon calendar'></i></button>");
						}
					}

	                 // Disable 처리
				    if(disabled != null){
				    	$("#btn"+_id).hide();
				    }


				    $(this).on('change', function(e) {

					    let min = $(this).attr("data-date-min");
					    let max = $(this).attr("data-date-max");

					    if(gfn_isNull(min)){
						  min = '19500101';
					    }

					    if(gfn_isNull(max)){
						  max = '20991231';
					    }

					    if(_calandarFormat == "yyyy-mm-dd" ) {
						    min   = gfn_strToDate(min,'yyyyMMdd');
						    max   = gfn_strToDate(max,'yyyyMMdd');
						    time  = gfn_strToDate(this.value,'yyyyMMdd');


						    if( min > time || max < time) {
				   	     		this.value= "";
				   	     	}
				 	    }
				    });
	   			} // if(_calandar) {


	   			// 팝업일경우 change Event 처리
	   			if(! gfn_isNull(_popup)) {

					$(this).bind('paste', function() {
						 $(this).trigger('input');
					});

					$(this).on('input', function(e) {
						var arrBind = _popup.split("|");
						for (var i = 0; i < arrBind.length; i++) {
							 $('#' + arrBind[i]).val("");
						}
				    });
				}

			}

		}); //input Box 종료

		// SelectBox 시작
		$(selectParentEl).find('select').each(function (idx) {
			let _searchYn     = $(this).attr("data-enterSearchYn");            // 자동조회여부
			let _searchButton = $(this).attr("data-callFunction");             // 조회시 버튼

			$(this).on('keypress', function(e) {

				let code = (e.keyCode ? e.keyCode : e.which);
				e.preventDefault();
			    e.stopPropagation();

				if (_searchYn) {
					if (code === 13) {
						let _fn_search = eval(_searchButton);
			   			if ($.isFunction(_fn_search)) {
							_fn_search.call();
						 }
			   	   }
			   	}
		   });

		}); //Select Box 종료



	}
}

/*
* input type Number 일경우 처리
*/
function _gfn_comma(obj, point) {

	let n = obj.value;
	if( n == 'undefined' || n == null || n == '') {
		return n;
	}

	if(n.toString() == "0") {
	    return 0;
	}

	let _value = n.toString();
	let v      = '';
	let _rtnValue = '';
	// 솟수점 null check
	if (gfn_isNull(point)) {
		point = 0;
	}

	// 숫자 이외에 제거
	if(point == "0") {
		_value = _value.replace(/[^0-9]/g, "");
	}else{
		_value = _value.replace(/[^0-9\\.\\-]/g, "");
	}

	if(_value.indexOf("0.") === -1 ) {
		//숫자 앞자리 제거
		_value = _value.replace(/^0+/g,"");
	}

	if(_value.lastIndexOf(".") > 0) {    //중간에 -가 있다면 replace
		_value = _value.substring(0, _value.indexOf(".") + 1)  + _value.substring(_value.indexOf(".") + 1).replace(/[.]/gi,'');
	}

	if(_value.lastIndexOf("-") > 0) {    //중간에 -가 있다면 replace
	    if(_value.indexOf("-") == 0){    //음수라면 replace 후 - 붙여준다.
		    _value = "-" + _value.replace(/[-]/gi,'');
	    }else{
		    _value = _value.replace(/[-]/gi,'');
	    }
	}

	let reg = /(^[+-]?\d+)(\d{3})/;
	let ret = (_value + '');

	while (reg.test(ret)) ret = ret.replace(reg, '$1' + ',' + '$2');


	if(ret.indexOf(".") > 0 ) {
		let v = ret.substring(ret.indexOf(".") + 1);

		if(v.length > this.point ) {
			_rtnValue = ret.substring(0,ret.indexOf(".") + 1 + Number(this.point));
			return _rtnValue;
		}
	}

	return ret;
}


/*
* input type alphaNumber
*/
function _gfn_alphaNumber(obj) {

	var n = obj.value;
	if( n == 'undefined' || n == null || n == '') {
      		return n;
    }

    var _pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;

	if (_pattern.test(n)) {
		return n.replace(_pattern, "");
	}

	n = n.replace(/ /gi, "");

    return n;
}



function gfn_getMessage(msgCode, bindInfo) {

	//console.log(clientMessage);

	var message = msgCode;
	if(clientMessage != undefined){
		if(clientMessage.hasOwnProperty(msgCode)){
			message = clientMessage[msgCode];
			if(bindInfo != undefined){
				message = gfn_replaceMessageBind(message, bindInfo)
			}
		}
	}
	return message.replace(/\\n/gi, '\n');

}

/**
 * 메시지 텍스트를 인수로 받아서 confirm 출력
 *
 * @param message
 *            메세지 텍스트
 * @param bindInfo
 *            바인딩 정보
 */
function gfn_showModalConfirmByText(message, bindInfo) {

	// jQuery dialog 타이틀 없애기
	// $("#dialog").dialog().parents(".ui-dialog").find(".ui-dialog-titlebar").remove();
	var msg = replaceMessageBind(message, bindInfo);
	var defer = $.Deferred();
	var divPre = '<div id="modalConfirmByText" class="dialog-confirm"><div class="msg-box">';
	var divAfter = '</div></div>';


	// console.log(headerClass)


	$(divPre + msg + divAfter).dialog({
		autoOpen : true,
		close : function() {
			$(this).dialog('destroy').remove();;
			defer.resolve(false);
		},
		closeOnEscape:false,
		open: function() {
			$(".ui-dialog-titlebar-close", $(this).parent()).hide();

   		},
		modal : true,
		draggable : false,
		resizable : false,
		title : 'Confirm',
		width : 400, // dialog 넓이 지정
		// height : 500, // dialog 높이 지정
		buttons : {
			OK : function() {
				// $( this ).dialog( "close" );
				$(this).dialog('destroy');
				defer.resolve(true); // on Yes click, end deferred state
										// successfully (done)
			},
			CANCEL : function() {
				$(this).dialog("close");
				defer.resolve(false);
			}
		},
	}); // .parents(".ui-dialog").find(".ui-dialog-titlebar").addClass(headerClass)
	//}).parents(".ui-dialog").find(".ui-dialog-titlebar").remove();


	return defer.promise(); // important to return the defer promise

}

/**
 * 메시지 바인딩 처리
 *
 * @param message
 *            메세지
 * @param bindInfo
 *            바인딩 정보
 */
function replaceMessageBind(message, bindInfo) {
	var arrBind;
	if (bindInfo != null && bindInfo.length > 0) {
		arrBind = bindInfo.split("|");
		for (var i = 0; i < arrBind.length; i++) {
			message = message.replace("{" + i + "}", arrBind[i]);
		}
	}
	return message;
}

/**
 * 메시지 텍스트를 인수로 받아서 confirm 출력
 *
 * @param message
 *            메세지 텍스트
 * @param bindInfo
 *            바인딩 정보
 */
function showModalConfirmByText(message, bindInfo) {


	// jQuery dialog 타이틀 없애기
	// $("#dialog").dialog().parents(".ui-dialog").find(".ui-dialog-titlebar").remove();
	var msg = replaceMessageBind(message, bindInfo);
	var defer = $.Deferred();
	var divPre = '<div id="modalConfirmByText" class="dialog-confirm"><div class="msg-box">';
	var divAfter = '</div></div>';

	var headerClass = $("body", parent.document).attr("class");
	if (!headerClass) {
		headerClass = "bgPacony";
	}

	$(divPre + msg + divAfter).dialog({
		autoOpen : true,
		close : function() {
			$(this).dialog('destroy');
			defer.resolve(false);
		},
		closeOnEscape:false,
		open: function() {
			$(".ui-dialog-titlebar-close", $(this).parent()).hide();
   		},
		modal : true,
		draggable : false,
		resizable : false,
		title : 'Confirm',
		width : 400, // dialog 넓이 지정
		// height : 500, // dialog 높이 지정
		buttons : {
			OK : function() {
				// $( this ).dialog( "close" );
				$(this).dialog('destroy');
				defer.resolve(true); // on Yes click, end deferred state
										// successfully (done)
			},
			CANCEL : function() {
				$(this).dialog("close");
				defer.resolve(false);
			}
		}
	}); //.parents(".ui-dialog").find(".ui-dialog-titlebar").addClass(headerClass);





	return defer.promise(); // important to return the defer promise

}

/**
 * 입력유효성체크
 *
 * @param  parentId
 * @return bool(true:유효하지않음, false:유효함)
 * @example
 *   if (gfn_isNotValid('searchForm')) return;
 *   if (gfn_isNotValid('saveForm')) return;
 *   if (gfn_isNotValid('otherDiv')) return;
 */
function gfn_isNotValid(parentId) {
	var isValid = true;
    $('#'+parentId).find(':input:not(:disabled)').each(function(){
        var input = $(this);
        if (input.attr("required")  != undefined) { isValid = gfn_checkRequired(input); if(!isValid) return isValid; }
        if (input.attr("maxbyte")   != undefined) { isValid = gfn_checkMaxbyte(input, input.attr("maxbyte")); if(!isValid) return isValid; }
        if (input.attr("maxnumber") != undefined) { isValid = gfn_checkMaxNumber(input, input.attr("maxnumber")); if(!isValid) return isValid; }
    });
    return ( ! isValid);
};

/**
 *  숫자 입력 제한 체크
 */
function gfn_checkMaxNumber(obj, maxNumber) {
	var $objInput = $(obj);
	var val = $objInput.val();
	val = val.replace(/,/g, '');
	val = val.replace(/%/g, '');
	var title = $objInput.attr('title');
	if (val == '') return true;
	var regExp;
	var strMsg;
	if (maxNumber.indexOf(',') != -1) {
		var arr = maxNumber.split(',');
		if (arr[1] == 0) {
			regExp = new RegExp('^\\d{1,' + arr[0] + '}$', 'g');
			strMsg = '정수 : ' + arr[0] + '자리 이하로 입력하여 주십시오.';
		} else {
			regExp = new RegExp('^\\d{1,' + (arr[0] - arr[1]) + '}(\\.\\d{1,' + arr[1] + '})?$', 'g');
			strMsg = '정수 ' + (arr[0] - arr[1]) + '자리 / 소수 ' + arr[1] + '자리 이하로 입력하여 주십시오.';
		}
	} else {
		regExp = new RegExp('^\\d{1,' + maxNumber + '}$', 'g');
		strMsg = '정수 : ' + maxNumber + '자리 이하로 입력하여 주십시오.';
	}
	if ($objInput.attr("title") != undefined) strMsg = $objInput.attr("title")+'은(는) '+strMsg;
	if( regExp.test(val) ) return true;
	gfn_showMessageByText(strMsg).done(function(){ $objInput.focus(); });
	return false;
}

function gfn_comma(num) {
	var reg = /(^[+-]?\d+)(\d{3})/; num += '';
	while (reg.test(num)) num = num.replace(reg, '$1' + ',' + '$2');
	return num;
}

function gfn_isEmpty(value){
	if( value == "" || value == null || value == "null" || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){
		return true
	}else{
		return false
	}
}

function gfn_isNotEmpty(value){
	return ! gfn_isEmpty(value);
}



//-------------------------------------- 공통로직 추가  처리 ------------------------------------------------------

/**
 * 공통코드 리스트 조회
 * @param   json
 * @returns jsonObject
 */

function gfn_getCommonCdLists(jsonData){


	let urlPrefix = IS_SVC_ENABLE == "true" ? PORTAL_URL : contextPath;
	let result = [];

	if(typeof(jsonData.length) == "undefined" ){
       jsonData = [jsonData];
    }

    let vParams = {
           commData : jsonData
    };

	let options = {
		strUrl: urlPrefix + "/common/view/init/commonCdLists",
		async: false,  // javascript 변수에 할당을 위한 동기 호출
		param: vParams,
		//param:jsonData,

		pCall: function (svcId, returnData, errCd, msgTp, msgCd, msgText) {
			result = returnData;

			console.log(result)
		}
	};

	gfn_transaction(options);
	return result;
}


/**
 * 콤보용 Data 조회 처리
 * @param   json
 * @returns jsonObject
 */

function gfn_getComboList(jsonData, param){


	let urlPrefix = IS_SVC_ENABLE == "true" ? PORTAL_URL : contextPath;
	let result = [];

	if(typeof(jsonData.length) == "undefined" ){
       jsonData = [jsonData];
    }
    let vParams = {
           commData : jsonData
    };

    let data = {};

    $.extend(data, vParams, param);


	let options = {
		strUrl: urlPrefix + "/common/view/init/comboList",
		async: false,  // javascript 변수에 할당을 위한 동기 호출
		param: data,

		pCall: function (svcId, returnData, errCd, msgTp, msgCd, msgText) {
			result = returnData;

		}
	};

	gfn_transaction(options);
	return result;
}



/**
 * 자동조회 Complete
 * @param   json
 * @returns jsonObject
 */
function gfn_makeAutoComplete(element, url, completeOption, paramObj){

	let urlPrefix = IS_SVC_ENABLE == "true" ? PORTAL_URL : contextPath;

	let $this = element;
    let multiple = $this.attr('multiple');

    if(gfn_isNull(completeOption)) {
       completeOption = {};
    }

    if(gfn_isNull(paramObj)) {
       paramObj = {};
    }

    let placeholder = completeOption.placeholder;

    let minimumInputLength = "";

    if(!gfn_isNull(completeOption.minimumInputLength)){
		minimumInputLength = completeOption.minimumInputLength;
    }

    //let allowClear = $this.data('allowclear');

    $this.select2({
       // width: (width ? width : '100%'),
        // placeholder: (placeholder ? placeholder : ''),
        //allowClear: (allowClear ? true : (multiple ? false : true)),
        //allowClear:  (multiple ? false : true),
        placeholder: placeholder,
        allowClear:  false,
        minimumInputLength: (minimumInputLength ? minimumInputLength : 1),
        ajax: {url: urlPrefix + url , delay: 300,
        		data: function (params) {
      				 var query = Object.assign(paramObj,{srch_id:params.term}) ; return query}
      	},
        /**
        ajax: {url: urlPrefix + '/common/view/init/deptList', delay: 300,
            					data: function (params) {
      								   var query = { user_id: params.term, type: 'public'}; return query}},
        **/
        escapeMarkup: function(markup){return markup;},
        templateResult: function(data){return data.html;},
        initSelection: function(element, callback) {}
    });


    if(!gfn_isNull(completeOption.callback)) {
	    $this.on('change', function (evt) {
		  //if  ($this.select2('val') != null){
		    //alert($this.select2('data')[0].id);
		    var array=[];
		    for (var option of $this.select2('data'))
		    {
		       array.push(option.id);
		    }

		    var callback2 = eval(completeOption.callback);
			if ($.isFunction(callback2)) {
				callback2($this.attr('id'), array);
			}
	   });
	}
}





var _firstEmptySelect = true;

function _formatSelect(result) {



	if(gfn_isNull(result.html)) {
		_firstEmptySelect = true;
 	    return "";
	}

	let dataObj = result.html.split('| ');
	let headerObj = result.header.split('| ');

	let resultHtml = "";

    if (_firstEmptySelect) {

		_firstEmptySelect = false;

        resultHtml += '<div class="row">' ;
		for(var i = 0; i < headerObj.length; i++) {
			resultHtml += '<div class="col-md-3">' + headerObj[i] + '</div>';
		}
        resultHtml += '</div>';

        resultHtml += '<div class="row">' ;

		for(var j= 0; i < dataObj.length; j++) {
			resultHtml += '<div class="col-md-3">' + dataObj[j] + '</div>';
		}

		resultHtml += '</div>';


        _firstEmptySelect = false;
    } else {
        resultHtml += '<div class="row">' ;

		for(var i = 0; i < dataObj.length; i++) {
			resultHtml += '<div class="col-md-3">' + dataObj[i] + '</div>';
		}

		resultHtml += '</div>';
	}

	//console.log(resultHtml)

    return resultHtml;

}


function _matcher(query, option) {
	/***
    firstEmptySelect = true;
    if (!query.term) {
        return option;
    }
    var has = true;
    var words = query.term.toUpperCase().split(" ");
    for (var i =0; i < words.length; i++){
        var word = words[i];
        has = has && (option.text.toUpperCase().indexOf(word) >= 0);
    }
    if (has) return option;
    return false;
    **/
}


/**
 * 자동조회 Complete Popup  용
 * @param   json
 * @returns jsonObject
 */
function gfn_makeAutoCompletePopup(element, url, completeOption, paramObj){

	let urlPrefix = IS_SVC_ENABLE == "true" ? PORTAL_URL : contextPath;

	let $this = element;
    let multiple = $this.attr('multiple');

    if(gfn_isNull(completeOption)) {
       completeOption = {};
    }

    if(gfn_isNull(paramObj)) {
       paramObj = {};
    }

    let placeholder = completeOption.placeholder;

    let minimumInputLength = "";

    if(!gfn_isNull(completeOption.minimumInputLength)){
		minimumInputLength = completeOption.minimumInputLength;
    }



    $this.select2({
        minimumResultsForSearch: Infinity,                       //검색창 숨기기 왜 안돼
        placeholder: placeholder,
        allowClear:  false,
        minimumInputLength: (minimumInputLength ? minimumInputLength : 1),
        ajax: {url: urlPrefix + url , delay: 300,
        		data: function (params) {
      				 var query = Object.assign(paramObj,{srch_id:params.term}) ; return query}
      	},
        escapeMarkup: function(markup){return markup;},
        templateResult: _formatSelect,
    	//templateSelection: function(data){return data.header.split('| ')[0];},
        initSelection: function(element, callback) {}
    });


    if(!gfn_isNull(completeOption.callback)) {
	    $this.on('change', function (evt) {
		  //if  ($this.select2('val') != null){
		    //alert($this.select2('data')[0].id);
		    var array=[];
		    for (var option of $this.select2('data'))
		    {
		       array.push(option.id);
		    }

		    var callback2 = eval(completeOption.callback);
			if ($.isFunction(callback2)) {
				callback2($this.attr('id'), array);
			}
	   });
	}
}


/**
 * 콤보생성
 * @param   json
 * @option  {defaultText:"선택",callback:"fn_callback"}
 * @returns jsonObject
 * 참조URL : https://hemantnegi.github.io/jquery.sumoselect/sumoselect_demo.html
 */
function gfn_makeCombo(element, commCdList, comboOption){

	var multiple = element.attr("multiple");
	var $this = element;

	if(gfn_isNull(comboOption)) {
       comboOption = {};
    }

	//초기화작업
	$this.empty();

	if(!gfn_isNull(comboOption.defaultText)) {

		var flag = comboOption.defaultText == "전체" && !gfn_isNull(multiple) ? false : true;

		if(flag) {
			var option = $("<option></option>");
			var value = gfn_isNull(comboOption.defaultValue) ? "" : comboOption.defaultValue;
			option.val(value);
	        option.text(comboOption.defaultText);
	        option.data("member", {"CODE":"","CODE_NAME":"선택"});
	        $this.append(option);
	    }
		//$this.append($('<option>').val(comboOption.defaultText).text());
	}

	$this.data("option" , JSON.stringify(comboOption));

	var result = [];

	if(!gfn_isNull(multiple)) {

		/***
		try{
			$this[0].sumo.unload();
		}catch(e){};
		**/

		if(comboOption.defaultText == "전체") {
			element.SumoSelect({ csvDispCount: 20, search: true, searchText:'선택하세요.' , selectAll:true});
		}else{
			element.SumoSelect({ csvDispCount: 20, search: true, searchText:'선택하세요.' , clearAll:true});
		}
	}


	var result = [];
	var arrList = [];

	if(typeof comboOption.selectCode == "object") {
		arrList = _.clone(comboOption.selectCode);
	}else{
		if(!gfn_isNull(comboOption.selectCode)) {
			arrList.push(comboOption.selectCode);
		}
	}


	if(!gfn_isNull(commCdList)){
		for(var i = 0; i < commCdList.length; i++) {
			// selectbox 처리 commCdList[i]
			var option = $("<option></option>");
	        option.val(commCdList[i].CODE);
	        option.text(commCdList[i].CODE_NAME);
	        option.data("member", JSON.stringify(commCdList[i]));

			for(var j = 0; j < arrList.length; j++) {
				if (commCdList[i].CODE == arrList[j]) {

					var key = 0;
					var flag = comboOption.defaultText == "전체" && !gfn_isNull(multiple) ? false : true;

					if(!gfn_isNull(comboOption.defaultText) && flag == true) {
						key = i + 1;
					}else{
						key = i ;
					}
					result.push(key);
				}
			}

			if(gfn_isNull(multiple)) {
				if (commCdList[i].CODE == comboOption.selectCode) {
					option.attr("selected", "selected"); // selected Value
				}
			}

			$this.append(option);
		}
	}

	if(!gfn_isNull(multiple)){
		if(!gfn_isNull(comboOption.selectCode)) {
			for(var j = 0; j < result.length; j++) {
				element[0].sumo.selectItem(result[j]);
			}
		}
		// multiple combo 랜더링 시 바뀐 옵션들을 적용하기위해 reload를 해야함
		element[0].sumo.reload();
	}

	if(!gfn_isNull(comboOption.callback)) {
		$this.off('change', _gfn_comboChage); // 이벤트 해제
		$this.on('change', _gfn_comboChage); // 이벤트 선언
	}
}



function _gfn_comboChage(event){

   let $this = $(this);

   let multiple = $this.attr("multiple");
   let data = $this.data("data");
   let _comboOption = $this.data("option");
   let comboOption = gfn_isNull(_comboOption) ? "": JSON.parse(_comboOption);


    if(!gfn_isNull(multiple)){
		var _obj = [];
		var result = $this.val();

		/****
		if(result.length >= 1) {


			var findResult = result.indexOf('');

			// 값이 "" 일경우 ComboOption이 allCheckYn = "Y" 인경우 전체 선택 기능 처리
			if(findResult != -1 ) {
				event.preventDefault();
				$this.off('change', _gfn_comboChage); // 이벤트 해제

				if ( comboOption.allCheckYn == "Y") {
					$this[0].sumo.selectAll();
					$this[0].sumo.unSelectItem(0);
				}else {
					$this[0].sumo.toggSelAll(!1, 1);
					$this[0].sumo.selectItem(0);
				}

				$this[0].sumo.reload();
				result = $this.val();
				$this.on('change', _gfn_comboChage); // 이벤트 선언
			}
		}
		****/

		// index를 통해 값 넣기
		result.forEach(function(value){
			$this.find('option').each(function() {
			    if($(this).val() == value) {
					_obj.push($(this).data('member'));
				}
			});
		});

	    var callback = eval(comboOption.callback);
		if ($.isFunction(callback)) {
			callback($this.attr("id"), _obj);
		}
	}else{

	    var _obj = $('option:selected', '#' + $this.attr('id')).data('member');

	    var callback = eval(comboOption.callback);

	    if ($.isFunction(callback)) {

			if ( _obj != "") {
				if (typeof _obj === 'object') {
					callback($this.attr('id'), _obj);
				}else{
					callback($this.attr('id'), JSON.parse(_obj));
				}
			}else{
				callback($this.attr('id'), "");
			}
	    }
	}
}

/**
 * Selection 콤보생성
 * @param   json
 * @option  {defaultText:"선택",defaultValue:""}
 * @returns jsonObject
 * 참조URL : https://hemantnegi.github.io/jquery.sumoselect/sumoselect_demo.html
 */
function gfn_makeComboSelection(element, commCdList, comboOption){
	if(gfn_isNull(comboOption)) {
		comboOption = {};
	}

	var $this = element,
		value = comboOption.defaultValue,
		placeholder = comboOption.placeholder;

	if (!gfn_isNull(value) && gfn_isNull(comboOption.selectCode)) {
		comboOption.selectCode = value;
	}

	gfn_makeCombo(element, commCdList, comboOption);


	// 20230323 두번 호출시 $this.data("select2Id") 가 존재시 삭제 후 다시 생성
    if(!gfn_isNull($this.data("select2Id"))) {
		$this.select2('destroy');
	}

	//if (gfn_isNull($this.data("select2Id"))) {
	$this.select2({
		placeholder: placeholder,
     	allowClear:  false,
		maximumSelectionLength:10,
		tags: true,
		createTag: function (params) {
			return null;
		}
	});
	//}

	if (!!comboOption.selectCode || !!comboOption.selectCode) {
		$this.trigger("change");
	}
 }

/**
 * 라디오 생성
 * @param   element
 * @option  {defaultText:"선택", defaultValue: "Y", callback : fn}
 * @returns jsonObject
 */
function gfn_makeRadio(element, commCdList, option) {

	let $this = element;

	const id = element.attr('id');

	if (gfn_isNull(option)) {
		option = {};
	}

	let innerHtml = "";

	if (!gfn_isNull(option.defaultText)) {
		innerHtml += "<input type='radio' name='" + id + "' id='" + id + "_ALL' value='' class='ctn-radio-input' >";
		innerHtml += "<label for='" + id + "_ALL' class='ctn-input-label' >";
		innerHtml += "<span class='mr-2'>" + option.defaultText + "</span>"
		innerHtml += "</label>"
	}

	if (!gfn_isNull(commCdList)) {

		let inputId = '';

		for (var i = 0; i < commCdList.length; i++) {

			inputId = commCdList[i].CODE;

			innerHtml += "<input type='radio' name='" + id + "' id='" + id + "_" + inputId + "' value='" + inputId + "' class='ctn-radio-input' >";
			innerHtml += "<label for='" + id + "_" + inputId + "' class='ctn-input-label' >";
			innerHtml += "<span class='mr-2'>" + commCdList[i].CODE_NAME + "</span>"
			innerHtml += "</label>"
		}
	}

	element.append(innerHtml);

	// 기본값 설정
	if (gfn_isNull(option.defaultValue)) {
		$("[name=" + id + "]:first").prop('checked', true);
	} else {
		$("[value='" + option.defaultValue + "']", element).prop("checked", true);
	}

	let callback = eval(option.callback);
	if ($.isFunction(callback)) {
		callback();
	}
}



/**
 * 체크박스 생성
 * @param   json
 * @option  {defaultText:"선택"}
 * @returns jsonObject
 */
function gfn_makeCheckBox(element, commCdList, option) {

	let $this = element;

	const id = element.attr('id');

	if (gfn_isNull(option)) {
		option = {};
	}

	let innerHtml = "";

	if (!gfn_isNull(option.defaultText)) {
		innerHtml += "<input type='checkbox' name='" + id + "' id='" + id + "_ALL' value='' class='ctn-checkbox-input' >";
		innerHtml += "<label for='" + id + "_ALL' class='ctn-input-label' >";
		innerHtml += "<span class='mr-2'>" + option.defaultText + "</span>"
		innerHtml += "</label>"
	}

	if (!gfn_isNull(commCdList)) {

		let inputId = '';

		for (var i = 0; i < commCdList.length; i++) {

			inputId = commCdList[i].CODE;

			innerHtml += "<input type='checkbox' name='" + id + "' id='" + id + "_" + inputId + "' value='" + inputId + "' class='ctn-checkbox-input' >";
			innerHtml += "<label for='" + id + "_" + inputId + "' class='ctn-input-label' >";
			innerHtml += "<span class='mr-2'>" + commCdList[i].CODE_NAME + "</span>"
			innerHtml += "</label>"
		}
	}

	element.append(innerHtml);
}



/**
 * 달력 호출
 * @param   id ( input Box), gubun
 * @returns jsonObject
 */
function gfn_cmmnCal(id, gubun) {


    if(event!=null){
        event.preventDefault();
    }

    if(gubun == 'yyyy-MM'){
        CalendarUtil.openMonthCalendar(id);
    }  else {
        CalendarUtil.openCalendar(id);
    }
}






/**
 * 달력 From~To 호출
 * @param   id ( input Box), gubun
 * @returns jsonObject
 */
function gfn_cmmnCalFromTo(from, to, format, gubun){

	console.log("event", event);

    if(event!=null){
        event.preventDefault();
    }
    CalendarUtil.openFrToCalendar(from, to, gubun);
}





/**
 * 조직콤보를 채운다.
 * element : combo id 객체
 * orgCd : 조직코드 - 필수
 * level : 조직레벨 - "1,2,3,4"
 * option :
 * selectCode : display될때 select될 value - 옵션
 * defaultText: '전체'
 * useYn     : 사용여부 -- 옵션
 * selectCode, defaultText, useYn
 * removeCodes :삭제 하고 싶은 코드
 */
function  gfn_orgCodeCombo(element, orgCd , level, comboOption ) {

	let $this = element;


	var multiple = element.attr("multiple");
	var id      =  element.attr("id");


	if(gfn_isNull(comboOption)) {
       comboOption = {};
    }

	//조직코드 orgCd 가 없을시 "000" 으로 처리
	if(level == "1") {
		if(gfn_isNull(orgCd))  orgCd = "000";
	}else{
		if(gfn_isNull(orgCd)) orgCd = "";
	}
	var _deepObj = _.cloneDeep(gv_org_cd_list);


	var commCdList = _.filter(_deepObj, {BLNG_ORG: orgCd});


	if(!gfn_isNull(comboOption.removeCodes)) {
		if (typeof comboOption.removeCodes === 'object') {
			for(var j=0; j<comboOption.removeCodes.length; j++){
			  _.remove(commCdList,{CODE:comboOption.removeCodes[j]})
		    }
		}else{
			  _.remove(commCdList,{CODE:comboOption.removeCodes})
		}
	}


	//초기화작업
	$this.empty();
	$this.data("option" , JSON.stringify(comboOption));

	let defaultText = comboOption.defaultText;

	if(!gfn_isNull(defaultText)) {

		var flag = comboOption.defaultText == "전체" && !gfn_isNull(multiple) ? false : true;

		if(flag) {
			var option = $("<option></option>");
			var value = gfn_isNull(comboOption.defaultValue) ? "" : comboOption.defaultValue;
	        option.val(value);
	        option.text(defaultText);
	        option.data("member", {"CODE":"","CODE_NAME":"선택","ORG_LVL":"","BLNG_ORG":""});
	        $this.append(option);
	    }
	}

	var result = [];
	var arrList = [];

	if(typeof comboOption.selectCode == "object") {
		arrList = _.clone(comboOption.selectCode);
	}else{
		if(!gfn_isNull(comboOption.selectCode)) {
			arrList.push(comboOption.selectCode);
		}
	}


	for(var i = 0; i < commCdList.length; i++) {

		var option = $("<option></option>");
        option.val(commCdList[i].CODE);
        option.text(commCdList[i].CODE_NAME);
        option.data("member", JSON.stringify(commCdList[i]));

		for(var j = 0; j < arrList.length; j++) {
			if (commCdList[i].CODE == arrList[j]) {

				var key = 0;
				var flag = comboOption.defaultText == "전체" && !gfn_isNull(multiple) ? false : true;

				if(!gfn_isNull(defaultText) && flag == true) {
					key = i + 1;
				}else{
					key = i ;
				}
				result.push(key);
			}
		}


		if(gfn_isNull(multiple)) {
			if (commCdList[i].CODE == comboOption.selectCode) {
				option.attr("selected", "selected"); // selected Value
			}
		}


		$this.append(option);
	}


	if(!gfn_isNull(multiple)){

		try{
			$this[0].sumo.unload();
		}catch(e){};

		if(comboOption.defaultText == "전체") {
			const sumoOptions = Object.assign({ csvDispCount: 20, search: true, searchText:'선택하세요.' , clearAll:true},comboOption.sumo)
			element.SumoSelect(sumoOptions);
		}else{
			const sumoOptions = Object.assign({ csvDispCount: 20, search: true, searchText:'선택하세요.' , clearAll:true},comboOption.sumo)
			element.SumoSelect(sumoOptions);
		}

		//$this.SumoSelect({ csvDispCount: 10, search: true, searchText: "" , clearAll:true, triggerChangeCombined: false,placeholder: '-- 선택 --',});

		if(!gfn_isNull(comboOption.selectCode)) {
			$this.off('change', _gfn_comboChage); // 이벤트 해제
			for(var j = 0; j < result.length; j++) {
				$this[0].sumo.selectItem(result[j]);
			}
			$this.on('change', _gfn_comboChage); // 이벤트 선언
		}

		// multiple combo 랜더링 시 바뀐 옵션들을 적용하기위해 reload를 해야함
		element[0].sumo.reload();
	}

	if(!gfn_isNull(comboOption.callback) || !gfn_isNull(defaultText)) {
		$this.off('change', _gfn_comboChage); // 이벤트 해제
		$this.on('change', _gfn_comboChage); // 이벤트 선언
	}

}





/**
* 지역 +  조직콤보를 셋팅한다
* element :
* 사용예 :
 	let obj = [
	     { id   : "orgCdLvl0" , code : "" , level: "0" , select2:"Y" , defaultText:'선택'}
	    ,{ id   : "orgCdLvl1" , code : "" , level: "1" , select2:"Y" , defaultText:'선택'}
	    ,{ id   : "orgCdLvl2" , code : "" , level: "2" , select2:"Y" , defaultText:'선택'}
	    ,{ id   : "orgCdLvl3" , code : "" , level: "3" , select2:"Y" , defaultText:'선택'}
	    ,{ id   : "orgCdLvl4" , code : "" , level: "4" , select2:"Y" , defaultText:'선택'}
    ]

  	id: selection id 값
  	code : default 값
  	level : 조직정보 레벨
  	select2 : select 할수 있는 옵션
  	defaultText : default로 Text 문구
  	removeCodes : 삭제 코드 값
  	regionYn    : 구역콤보 설정 여부

  	gfn_orgCodeComboInit(obj, {callback:"fn_orgCallBack" , defaultText:'선택' , authYn:"Y", regionYn:"Y"});
*/

function  gfn_orgCodeComboInit(objList , comboOption ) {

	for(let element of objList) {

		let $this = $("#" + element.id);

		let id      =  $this.attr("id");
		let commCdList;

		if(gfn_isNull(comboOption)) {
	       comboOption = {};
	    }

	    let regionYn = gfn_isNull(comboOption.regionYn) ? "N" : comboOption.regionYn ;


	    let placeholder = comboOption.placeholder;

		var _deepObj = _.cloneDeep(gv_org_cd_list);

		var orgCd ;

		try{
			$this.off("change");
		}catch(e){}


		if (! gfn_isNull(element.code )) {
			if(element.level == "0") orgCd = "0";
			if(element.level == "1") orgCd = ( regionYn == "Y" ? element.code : "000" );
		   	if(element.level == "2") orgCd = element.code.substr(0,3);
		   	if(element.level == "3") orgCd = element.code.substr(0,6);
		   	if(element.level == "4") orgCd = element.code.substr(0,9);
		}else{
			if(element.level == "0") orgCd = "0"
			if(element.level == "1") orgCd = ( regionYn == "Y" ? USER_INFO.REGION_CD : "000" );
			if(element.level == "2") orgCd = USER_INFO.BLNG_CD
			if(element.level == "3") orgCd = USER_INFO.ENPLCHQBROF_CD
			if(element.level == "4") orgCd = USER_INFO.DEPT_GRP_CD
		}

		/* 구역정보 표시 여부일때 사용 */
		if (regionYn == "Y" && element.level == "1" ) {
			commCdList = _.filter(_deepObj, {RNGA_CD: orgCd });
		}else{
			commCdList = _.filter(_deepObj, {BLNG_ORG: orgCd });
		}

		if(!gfn_isNull(element.removeCodes)) {
			if (typeof element.removeCodes === 'object') {
				for(var j=0; j<element.removeCodes.length; j++){
					_.remove(commCdList,{CODE:element.removeCodes[j]})
		 	    }
		    }else{
					_.remove(commCdList,{CODE:element.removeCodes})
			}
		}

		//초기화작업
	    $this.empty();

		$this.data("option" , JSON.stringify(comboOption));
		$this.data("objList" , JSON.stringify(objList));

	    let authYn = gfn_isNull(element.authYn) == false ? element.authYn : gfn_nvl(comboOption.authYn, 'Y');
		let defaultText = gfn_isNull(element.defaultText) == false ? element.defaultText : comboOption.defaultText;
		//if(!gfn_isNull(defaultText) && authYn == "N") {
		if(!gfn_isNull(defaultText)) {
			var option = $("<option></option>");
	        option.val("");
	        option.text(defaultText);
	        option.data("member", JSON.stringify({"CODE":"","CODE_NAME":defaultText,"ORG_LVL":element.level,"BLNG_ORG":""}));
	        $this.append(option);
		}

		for(var i = 0; i < commCdList.length; i++) {

			var option = $("<option></option>");
	        option.val(commCdList[i].CODE);
	        option.text(commCdList[i].CODE_NAME);
	        option.data("member", JSON.stringify(commCdList[i]));
	        //option.data("option" , JSON.stringify(comboOption));
	        //option.data("objList" , JSON.stringify(objList));

			$this.append(option);
		}


	    if(element.select2 == "Y"  || gfn_isNull(element.select2)  ) {
			// 20230323 두번 호출시 $this.data("select2Id") 가 존재시 삭제 후 다시 생성
		    if(!gfn_isNull($this.data("select2Id"))) {
				$this.select2('destroy');
			}

		    //if (gfn_isNull($this.data("select2Id"))) {
			$this.select2({
				    placeholder: placeholder,
        		    allowClear:  false,
				    maximumSelectionLength:10,
				    tags: true,
				    createTag: function (params) {
					    return null;
				    }
			});
		    //}
	    }

		let value = element.code;

		//PRG_INFO.PAGE_COMBO_AUTH = "111";

		if(element.level == "0") value = gfn_isNull(element.code) ? USER_INFO.REGION_CD : element.code;
		if(element.level == "1" && authYn == "Y") value = !gfn_isNull(element.code) ? element.code :   PRG_INFO.PAGE_COMBO_AUTH == "1111"   && !gfn_isNull(defaultText) ? "" :  USER_INFO.BLNG_CD ;
		if(element.level == "2" && authYn == "Y") value = !gfn_isNull(element.code) ? element.code : ( PRG_INFO.PAGE_COMBO_AUTH == "1111" || PRG_INFO.PAGE_COMBO_AUTH == "111" )  && !gfn_isNull(defaultText) ? "" :  USER_INFO.ENPLCHQBROF_CD;
		if(element.level == "3" && authYn == "Y") value = !gfn_isNull(element.code) ? element.code : ( PRG_INFO.PAGE_COMBO_AUTH == "1111" || PRG_INFO.PAGE_COMBO_AUTH == "111" ||  PRG_INFO.PAGE_COMBO_AUTH == "11" )   && !gfn_isNull(defaultText) ? "" :  USER_INFO.DEPT_GRP_CD;
		if(element.level == "4" && authYn == "Y") value = !gfn_isNull(element.code) ? element.code : ( PRG_INFO.PAGE_COMBO_AUTH == "1111" || PRG_INFO.PAGE_COMBO_AUTH == "111" ||  PRG_INFO.PAGE_COMBO_AUTH == "11" && PRG_INFO.PAGE_COMBO_AUTH == "1" ) && !gfn_isNull(defaultText) ? "" :  USER_INFO.TEAM_CD;



		// 선택값이 없으면 value 를 빈값으로 변경
		if ($('option[value="' + value +'"]', $this).length == 0) {
			value = "";
		}

		if(element.select2 == "Y" || gfn_isNull(element.select2)  ) {
		    $this.val(value).trigger('change');
		}else{
		    $this.val(value).prop("selected", true);
		}

		// 콤보 Disable 처리
		if ( authYn == "Y" ) {
			$this.prop("disabled", true); //설정
		}

		if(element.level == "0") $this.prop("disabled", false);
		if(authYn == "Y" && element.level > "0" && PRG_INFO.PAGE_COMBO_AUTH == "1111" ) $this.prop("disabled", false);
		if(authYn == "Y" && element.level > "1" && PRG_INFO.PAGE_COMBO_AUTH == "111" ) $this.prop("disabled", false);
		if(authYn == "Y" && element.level > "2" && PRG_INFO.PAGE_COMBO_AUTH == "11" ) $this.prop("disabled", false);
		if(authYn == "Y" && element.level > "3" && PRG_INFO.PAGE_COMBO_AUTH == "1" ) $this.prop("disabled", false);


		$this.on('change', function(event) {

		   let _obj     = $('option:selected', '#' + $this.attr('id')).data('member');
		   let _objList = $this.data('objList');
		   let _option = $this.data('option');

		   let _selectionObj = gfn_isNull(_obj) ? "": JSON.parse(_obj);
		   let _selectionObjList = gfn_isNull(_objList) ? "" : JSON.parse(_objList);
		   let _selectionOption = gfn_isNull(_option) ? "" :  JSON.parse(_option);
		   //값 초기화 처리
		   //_objList.code = "";

		    if(!gfn_isNull(_selectionOption.callback)) {
			    let callback = eval(_selectionOption.callback);
			    if ($.isFunction(callback)) {
				    if ( _obj != "") {
					    if (typeof _obj === 'object') {
							callback($this.attr('id'), _obj);
						}else{
							callback($this.attr('id'), JSON.parse(_obj));
						}

					}else{
						callback($this.attr('id'), "");
					}
			      }
			} // !gfn_isNull(


			if(_selectionObj.ORG_LVL == "0") {
				let levelEle1 = _.find(_selectionObjList,{level:"1"});
				if(! gfn_isNull(levelEle1)) {

					let removeObj = _.remove(_selectionObjList, function(n) {
  													if( n.level == "1" || n.level == "2" || n.level == "3" || n.level == "4" ) return true;
													else return false;
													});;

				    _gfn_orgCodeMakeCombo(removeObj, _selectionObj, objList,_selectionOption,"1");
				}
			}

			if(_selectionObj.ORG_LVL == "1") {
				let levelEle2 = _.find(_selectionObjList,{level:"2"});
				if(! gfn_isNull(levelEle2)) {

					let removeObj = _.remove(_selectionObjList, function(n) {
  													if( n.level == "2" || n.level == "3" || n.level == "4" ) return true;
													else return false;
													});;

				    _gfn_orgCodeMakeCombo(removeObj, _selectionObj, objList,_selectionOption,"2");
				}
			}

			if(_selectionObj.ORG_LVL == "2") {
				let levelEle2 = _.find(_selectionObjList,{level:"3"});
				if(! gfn_isNull(levelEle2)) {

					let removeObj = _.remove(_selectionObjList, function(n) {
													if( n.level == "3" || n.level == "4" ) return true;
													else return false;
													});

					 _gfn_orgCodeMakeCombo(removeObj, _selectionObj, objList,_selectionOption, "3");
				}
			}

			if(_selectionObj.ORG_LVL == "3") {
				let levelEle2 = _.find(_selectionObjList,{level:"4"});
				if(! gfn_isNull(levelEle2)) {
					let removeObj = _.remove(_selectionObjList, function(n) {
													if( n.level == "4" ) return true;
													else return false;
													});

					_gfn_orgCodeMakeCombo(removeObj, _selectionObj, objList,_selectionOption,"4");
			   }
			}

		}) // $this.on(
	} // for(let emement of objList)
};





/*
 * 조직 정보 콤모 셋팅
 */
function _gfn_orgCodeMakeCombo(removeObj, _selectionObj,  objList, _selectionOption, level){

	let _deepObj = _.cloneDeep(gv_org_cd_list);

	for(let value of removeObj) {

		if(value.level == level) {
			value.code = _selectionObj.CODE;
		}else{
			value.code = "";
		}


		/* 구역정보 표시 여부일때 사용 */
		if (_selectionOption.regionYn == "Y" && level == "1" ) {
			commCdList = _.filter(_deepObj, {RNGA_CD: value.code });
		}else{
			commCdList = _.filter(_deepObj, {BLNG_ORG: value.code });
		}

		//commCdList = _.filter(_deepObj, {BLNG_ORG: value.code });

		let $this = $("#" + value.id);
		//초기화작업
	    $this.empty();

		let defaultText = gfn_isNull(value.defaultText) == false ? value.defaultText : _selectionOption.defaultText;
		if(!gfn_isNull(defaultText)) {
			let option = $("<option></option>");
	        option.val("");
	        option.text(defaultText);
	        option.data("member", JSON.stringify({CODE:"",CODE_NAME:defaultText, ORG_LVL:value.level,BLNG_ORG:""}));
	        option.data("option" , JSON.stringify(_selectionOption));
	        option.data("objList" , JSON.stringify(objList));
	        $this.append(option);

		}


		for(var i = 0; i < commCdList.length; i++) {

			let option = $("<option></option>");
	        option.val(commCdList[i].CODE);
	        option.text(commCdList[i].CODE_NAME);
	        option.data("member", JSON.stringify(commCdList[i]));
	        option.data("option" , JSON.stringify(_selectionOption));
	        option.data("objList" , JSON.stringify(objList));

			$this.append(option);
		}

		/***
		if(value.select2 == "Y")  {
		   	$this.val("").trigger('change');
		}
		**/
	}
}


/**
	* 물품코드 3단계  콤보박스를 채운다.
	* lrgClasElement : 대분류 combo id 객체
	* medClasElement : 중분류 combo id 객체
	* smlClasElement : 소분류 combo id 객체
	* 호출 예시 : gfn_clsCodeCombo('MITM_LRG_CLAS_CD', 'MITM_MED_CLAS_CD', 'MITM_SML_CLAS_CD', '1');
*/
function  gfn_clsCodeCombo(lrgClasElement, medClasElement, smlClasElement, lvl, message) {
	let lrgClasCd = $("#" + lrgClasElement);
	let medClasCd = $("#" + medClasElement);
	let smlClasCd = $("#" + smlClasElement);
	let lrgClasList = [];
	let medClasList = [];
	let smlClasList = [];

	if(lvl == '1') {
		lrgClasList = gfn_getComboList({QUERY_ID : "getClasList" }, {'LVL' : lvl} )['getClasList'];

		if (!gfn_isNull(message)) {
			gfn_makeCombo(lrgClasCd, lrgClasList, {defaultText: message});
			gfn_makeCombo(medClasCd, medClasList, {defaultText: message});
			gfn_makeCombo(smlClasCd, smlClasList, {defaultText: message});
		}
		else {
			gfn_makeCombo(lrgClasCd, lrgClasList, {defaultText: '전체'});
			gfn_makeCombo(medClasCd, medClasList, {defaultText: '전체'});
			gfn_makeCombo(smlClasCd, smlClasList, {defaultText: '전체'});
		}
	}

	else if(lvl == '2') {
		if (!gfn_isNull(lrgClasCd.val())) {
			medClasList = gfn_getComboList( { QUERY_ID : "getClasList" }, { 'LVL' : lvl, 'MITM_LRG_CLAS_CD' : lrgClasCd.val() } )['getClasList'];
		}

		if (!gfn_isNull(message)) {
			gfn_makeCombo(medClasCd, medClasList, {defaultText: message});
			gfn_makeCombo(smlClasCd, smlClasList, {defaultText: message});
		}
		else {
			gfn_makeCombo(medClasCd, medClasList, {defaultText: '전체'});
			gfn_makeCombo(smlClasCd, smlClasList, {defaultText: '전체'});
		}
	}

	else {
		if (!gfn_isNull(medClasCd.val())) {
			smlClasList = gfn_getComboList( { QUERY_ID : "getClasList" }, { 'LVL' : lvl, 'MITM_LRG_CLAS_CD' : lrgClasCd.val(), 'MITM_MED_CLAS_CD' : medClasCd.val() } )['getClasList'];
		}

		else {
			smlClasList = [];
		}

		if (!gfn_isNull(message)) {
			gfn_makeCombo(smlClasCd, smlClasList, {defaultText: message});
		}
		else {
			gfn_makeCombo(smlClasCd, smlClasList, {defaultText: '전체'});
		}
	}
}


/**
* 물품코드 3단계  콤보박스를 채운다.
* lrgClasElement : 대분류 combo id 객체
* medClasElement : 중분류 combo id 객체
* smlClasElement : 소분류 combo id 객체
* 호출 예시 : gfn_gdsCodeCombo('SCH_LRG_CLAS_CD', 'SCH_MED_CLAS_CD', 'SCH_SML_CLAS_CD', '2');
*/
function  gfn_gdsCodeCombo(lrgClasElement, medClasElement, smlClasElement, lvl) {

	let lrgClasCd = $("#" + lrgClasElement);
	let medClasCd = $("#" + medClasElement);
	let smlClasCd = $("#" + smlClasElement);

	if(lvl == '2'){

		if ( lrgClasCd.val() ) {
			medClasList = gfn_getComboList({QUERY_ID : "getGdsClasList"}, {'LVL' : lvl, 'MITM_LRG_CLAS_CD' : lrgClasCd.val() } )['getGdsClasList'];
		} else {
			medClasList = [];
		}
		smlClasList = [];

		gfn_makeCombo( medClasCd, medClasList, { defaultText: '선택' } );
		gfn_makeCombo( smlClasCd, smlClasList, { defaultText: '선택' } );

	} else {

		if ( medClasCd.val() ) {
			smlClasList = gfn_getComboList( { QUERY_ID : "getGdsClasList" }, { 'LVL' : lvl, 'MITM_LRG_CLAS_CD' : lrgClasCd.val(), 'MITM_MED_CLAS_CD' : medClasCd.val() } )['getGdsClasList'];
		} else {
			smlClasList = [];
		}
		gfn_makeCombo( smlClasCd, smlClasList, { defaultText: '선택' } );

	}

}

/**
* 지역, 권역, 공동체 3단계 콤보박스를 채운다.
* areaElement : 지역 combo id 객체
* rngaElement : 권역 combo id 객체
* 호출 예시 : gfn_areaCodeCombo('AREA_CD', 'RNGA_CD', 'CMMT_NO');
*/
function  gfn_areaCodeCombo(areaElement, rngaElement, cmmtElement) {

  	let area = $("#" + areaElement);
  	let rnga = $("#" + rngaElement);
  	let cmmt = $("#" + cmmtElement);

  	if (!gfn_isEmpty( area.val() )) {

  		// 조회전에 비운다.
  		if (gfn_isEmpty( cmmtElement )) {
  			rnga.empty().append("<option value=''>전체</option>");
  		} else {
  			cmmt.empty().append("<option value=''>전체</option>");
  		}

  		// 기본 Service ViewInitService
  		let comboParam = [{QUERY_ID : gfn_isEmpty(cmmtElement) ? 'getRngaCdList' : 'getCmmtNoList'}];
  		let srchParam = {AREA_CD: area.val(), RNGA_CD: rnga.val()};

  		let resultComboObj = gfn_getComboList(comboParam, srchParam);
  		let resultArray = gfn_isEmpty(cmmtElement) ? resultComboObj.getRngaCdList : resultComboObj.getCmmtNoList;

  		// 지역선택값으로 권역을 채울지, 권역선택값으로 공동체를 채울지
  		$.each(resultArray, function(idx, row) {

  			let option = $("<option></option>");
  				option.val(resultArray[idx].CODE);
  				option.text(resultArray[idx].CODE_NAME);

  			if (gfn_isEmpty( cmmtElement )) {
  				$('#'+rngaElement).append(option);
  			} else {
  				$('#'+cmmtElement).append(option);
  			}
  		});
  	}
}


/**
 *	지역, 권역, 공동체 3단계 콤보박스의
 *	이벤트 설정 및 처리
 *
 *	지역 콤보박스는 함수 호출시 자동으로 콤보값 설정이 됨으로
 *	별도로 ( fn_initCombo 에서 )초기화 할 필요 없음
 *
 *	사용방법 : gfn_areaRngaCmmtCodeCombo( '지역콤보ID', '권역콤보ID', '공동체콤보ID' )
 *	     ex)   gfn_areaRngaCmmtCodeCombo( 'SCH_AREA_CD', 'SCH_RNGA_CD', 'SCH_CMMT_NO'         );	//	콤보의 첫 번째 황목으로 '전체' 표시
 *	     ex)   gfn_areaRngaCmmtCodeCombo( 'SCH_AREA_CD', 'SCH_RNGA_CD', 'SCH_CMMT_NO', ' '    );	//	''(null과 동일)는 '전체' 표시. ' '(공백)은 그대로 표시 됨
 *	     ex)   gfn_areaRngaCmmtCodeCombo( 'SCH_AREA_CD', 'SCH_RNGA_CD', 'SCH_CMMT_NO', '선택' );
 *	     ex)   gfn_areaRngaCmmtCodeCombo( 'SCH_AREA_CD', 'SCH_RNGA_CD', 'SCH_CMMT_NO', '전체' );
 *
 *	@param  aId  [필수] 지역콤보ID
 *	@param  rId  [필수] 권역콤보ID
 *	@param  cId  [필수] 공동체콤보ID
 *	@param  opt  [선택] 콤보 옵션 첫번째 항목값. '전체'(default) / '선택' / ' ' (공백)
 *	@return      void
 */
function  gfn_areaRngaCmmtCodeCombo( aId, rId, cId, opt, params ) {

	const aObj = $( `#${aId}` );
	const rObj = $( `#${rId}` );
	const cObj = $( `#${cId}` );
	const paramObj = gfn_isEmpty(params) ? {} : params;

	let optVal = gfn_isNull(opt) ? '전체' : opt;

	const optDef = `<option value=''>${optVal}</option>`;

	//	지역콤보 설정
	const ifn_makeAreaCombo = function() {

		const comboOpt = [ { ID : 'AREA_CD', CODE_GROUP : 'PD001', USE_YN : 'Y' } ];

		//	공통코드 조회
		const resultObj = gfn_getCommonCdLists( comboOpt );

		gfn_makeCombo( aObj, resultObj['AREA_CD'], { defaultText: opt } );
	}

	const ifn_changeCombo = function( tObj ) {

  		const comboParam = [];
  		const srchParam  = { AREA_CD : aObj.val(), ...paramObj };

		if ( tObj == rObj ) {
			//	지역 콤보 변경일 경우...
			comboParam.push( { QUERY_ID : 'getRngaCdList' } );
		} else if ( tObj == cObj ) {
			//	권역 콤보 변경일 경우...
			comboParam.push( { QUERY_ID : 'getCmmtNoList' } );
			srchParam['RNGA_CD'] = rObj.val();
		}

		const retList = gfn_getComboList( comboParam, srchParam );

		let   list    = null;

		if ( tObj == rObj ) {
			//	지역 콤보 변경일 경우...
			list = retList.getRngaCdList;
		} else if ( tObj == cObj ) {
			//	권역 콤보 변경일 경우...
			list = retList.getCmmtNoList;
		}

		$.each( list, function(idx, row) {
			tObj.append( `<option value='${list[idx].CODE}'>${list[idx].CODE_NAME}</option>` );
		} );
	}

	//	콤보 초기화
	ifn_makeAreaCombo();
	gfn_makeCombo( rObj, [], { defaultText: optVal } );
	gfn_makeCombo( cObj, [], { defaultText: optVal } );

	//	콤보 변경(change) 이벤트 발생시
	$( `#${aId},#${rId}` ).on( 'change', e => {

		//	일단 공동체 콤보 초기화
		cObj.empty().append( optDef );

		//	지역이 변경 되면 권역 콤보도 초기화
		if ( e.target.id == aObj.attr('id') ) {
			rObj.empty().append( optDef );
			aObj.val() && ifn_changeCombo( rObj );
		} else if ( e.target.id == rObj.attr('id') ) {
			rObj.val() && ifn_changeCombo( cObj );
		}
	} );

}

/**
 *	년도/주차 콤보
 *	이벤트 설정 및 처리
 */
function  gfn_yearWeekCodeCombo( aId, rId, opt ) {

	const aObj = $( `#${aId}` );
	const rObj = $( `#${rId}` );

	let optVal = gfn_isNull(opt) ? '전체' : opt;

	const optDef = `<option value=''>${optVal}</option>`;

	//	년도콤보 설정
	const ifn_makeYearCombo = function() {

		const comboOpt = [ { ID : 'YR', CODE_GROUP : 'CO109', USE_YN : 'Y' } ];

		//	공통코드 조회
		const resultObj = gfn_getCommonCdLists( comboOpt );

		const AFTER2001 = resultObj["YR"].filter( e => { return e.CODE > "2000" && e.CODE < "9999"; }).sort( (a, b) => { return b.CODE - a.CODE; });

		gfn_makeCombo( aObj, AFTER2001, { defaultText: opt } );
	}

	const ifn_changeCombo = function( tObj ) {

  		const comboParam = [];
  		const srchParam  = { YR : aObj.val() };

		if ( tObj == rObj ) {
			//	년도콤보변경
			comboParam.push( { QUERY_ID : 'getWeekList' } );
		}

		const retList = gfn_getComboList( comboParam, srchParam );

		let   list    = null;

		if ( tObj == rObj ) {
			//	년도콤보변경
			list = retList.getWeekList;
		}

		$.each( list, function(idx, row) {
			tObj.append( `<option value='${list[idx].CODE}'>${list[idx].CODE_NAME}</option>` );
		} );
	}

	//	콤보 초기화
	ifn_makeYearCombo();
	gfn_makeCombo( rObj, [], { defaultText: optVal } );

	//	콤보 변경(change) 이벤트 발생시
	$( `#${aId},#${rId}` ).on( 'change', e => {

		//	년도가 변경되면 주차콤보도 초기화
		if ( e.target.id == aObj.attr('id') ) {

			rObj.empty().append( optDef );
			aObj.val() && ifn_changeCombo( rObj );

		}
	} );

}

/*
* 메뉴 OPEN 처리
*/
function gfn_addOpenTabPopup(menuId, tabOpenYn, paramObj) {


    let menuList = _.filter(gv_menuList, {MENU_ID:menuId});
    if(gfn_isNull(tabOpenYn)) tabOpenYn = "Y"


    if(menuList.length > 0){
		if(tabOpenYn == "Y" ) {
			parent.openTabManager.addOpenTab(menuList[0].MENU_NM, menuList[0].MENU_URL, menuList[0].MENU_ID, paramObj );
		}else{
			paramObj.width    = gfn_isNull(paramObj.width)    ? 1598 : paramObj.width;
			paramObj.height   = gfn_isNull(paramObj.height)   ? 869  : paramObj.height;
			paramObj.popupId  = gfn_isNull(paramObj.popupId)  ? menuList[0].MENU_ID  : paramObj.popupId;
			paramObj.popupUrl = gfn_isNull(paramObj.popupUrl) ? menuList[0].MENU_URL : paramObj.popupUrl;

			gfn_windowPopup(paramObj);
		}
    }
}


/**
* KEY Down CODE 처리
*/
function gfn_keyDownEvent(gbn, e) {


	// F3:조회 F4:저장 F5:신규 F6:삭제 F7:출력 F8:엑셀다운
	const functionKeyConstant = {"8":"BACK", "114":"F3", "115":"F4", "116":"F5", "117":"F6", "118":"F7", "119":"F8", "120":"F9", "121":"F10", "122":"F11", "123":"F12"};

	let evt = e ? e : event;

	let keyCode = evt.keyCode;
	let eventKeyCode = functionKeyConstant[keyCode];

	let stopPropargation = false
	let isBackspace = (eventKeyCode == "BACK")
	if(isBackspace){

		/***
		if(!gfn_isNull(evt.target)) {
			let isText = (evt.target.type == 'text' || evt.target.type == 'textarea')
			let isEditorable = !$(evt.target).attr("readonly") && !$(evt.target).attr("enabled")
			if(isText && isEditorable) return
			stopPropargation = true
		}
		**/
	}

	// F12는 막음
	if(!stopPropargation && keyCode >= 114 && keyCode <= 122){
	//if(!stopPropargation && keyCode >= 114 && keyCode <= 123){

		stopPropargation = true;

		if (!$.isArray(PRG_INFO.PAGE_BUTTON)) PRG_INFO.PAGE_BUTTON = [PRG_INFO.PAGE_BUTTON];

		const functionList = PRG_INFO.PAGE_BUTTON

		const findObj = _.find(functionList,{HOT_KEY:eventKeyCode});

		if(findObj != null) {
			try{
				if(! gfn_isNull(findObj.EVENT_NAME)) {

					if($(".ui-widget").has(e.target).length === 0){
						const btn = $("#" + findObj.MENU_ID);
						if (btn.length > 0) {
							btn.focus();
							btn.trigger('click');
						}
						//gfn_btncallFunc(findObj.EVENT_NAME)
					}
				}
			}catch(e){};
		}

   }

    if(stopPropargation){
		evt.keyCode=0;
		evt.cancelBubble = true;
		evt.returnValue = false;
		if(gbn != "G") {
			evt.preventDefault();
		}
    }

}



/**
* KEY Down CODE 처리
*/
function gfn_namoKeyDownEvent(e) {


	let evt = e ? e : event;

	let keyCode = evt.keyCode;

	let stopPropargation = false

	if(!stopPropargation && keyCode >= 112 && keyCode <= 123){
		stopPropargation = true;
	}

	if(stopPropargation){
	    evt.orgEvent.preventDefault();
	}

}




/**
* 서버에서 리턴받은 javascript객체를 자신(jQuery랩핑된 폼 객체)에게 바인딩하는 함수. 두 번째 인수인
* datasetName이 주어지지 않으면 넘어온 data의 속성 각각을 폼의 하위엘리먼트와 매칭시키고, datasetName이
* 주어지면 넘어온 data에서 해당 datasetName을 가진 key를 찾아서 그 하위 속성들을 폼의 하위엘리먼트와 매칭시킨다.
*/
$.fn.jsonToForm = function(resultData, reset) {
	var $frm = this, frm = $frm.get(0), data;

	if (frm.tagName.toUpperCase() !== 'FORM') {
		alert('jsonToForm() - form element use only');
		return;
	}

	data = _.cloneDeep(resultData);
	//폼초기화 작업
	if (reset !== false) $frm.resetForm();

	var dataValue;
	if( data == null )	return;
	$frm.find(':input').each(function(idx) {
		var input = this, $input = $(input), inputName = input.name, initValue = input.value;
		dataValue = data[inputName];

		if (reset !== true && dataValue === undefined) return;

		//if (input.name != "undefined" && dataKey === inputName) {
		if (input.name != "undefined" && data.hasOwnProperty(inputName) ) {
			var type = input.type.toLowerCase();

			// ex:"0000" 문자열 처리 관련 Attribute 추가 - 2018.08.08
			if($input.attr('valueType') == 'string'){
				$input.attr( "oldvalue", ( dataValue ) || "" );
			} else {
				$input.attr( "oldvalue", ( dataValue == 0 ? "0" : dataValue ) || "" );
			}


			if (type === 'radio') {
				if (dataValue === initValue) {
					$input.prop('checked', true);
				}
			} else if (type == 'checkbox') {
				if (dataValue && dataValue.push) { // 체크박스의 값이 배열일 경우
					$input.val(dataValue); // 일반적인 처리
				} else { // 체크박스의 값이 배열이 아닐 경우의 예외처리, 배열일 경우에는 val() 함수만으로도 처리 가능하다.
					$input.val([ dataValue ]);
				}
				if ($input.next().is('label')) {
					if (dataValue == '0') {
						$input.prop('checked', false);
					} else if (dataValue == '1') {
						$input.prop('checked', true);
					}
				}

				if ($input.next().is('label')) {
					if (dataValue == 'N') {
						$input.prop('checked', false);
					} else if (dataValue == 'Y') {
						$input.prop('checked', true);
					}
				}
			/***
			}else  if ($input.hasClass('calendar') == true) {
				// 날짜형 Format
				if (dataValue != null && dataValue != "") {
					dataValue = gfn_removeSpecChar(dataValue);
				}
				if (dataValue == null || dataValue == "null") {
					dataValue = gfn_formatDate(gfn_fixDate(dataValue));
					$input.val(dataValue); // 일반적인 처리
				} else {
					dataValue = dataValue.trim();
					var cnt = 8 - dataValue.length;

					for (var i = 0; i < cnt; i++) {
						dataValue = dataValue + '1';
					}
					var value = dataValue;
					dataValue = gfn_formatDate(gfn_fixDate(dataValue));
					$input.val(dataValue); // 일반적인 처리
					$input.data("datepicker").dates.replace(gfn_strToDate(value, "YYYYMMDD")); // 선택값을 종료일자에 매핑
					$input.data("datepicker").viewDate = $input.data("datepicker").dates.get(-1);
					$input.data("datepicker").fill();
				}
				if (dataValue == undefined) {
					dataValue = "";
					$input.val(dataValue); // 일반적인 처리
				}
			} else if ($input.hasClass('number') == true && $('#' + this.name).attr("mask")) {
				// 숫자형 Format
				if ($(this).attr("dec") == undefined) {
					dataValue = formatNo(dataValue);
				} else {
					dataValue = formatNo(dataValue, $(this).attr("dec"));
				}
				$input.val(dataValue); // 일반적인 처리
			***/
			} else {
				if( $input.prop("tagName").toLowerCase() == "textarea" ) {
					$input.attr( "oldvalue", dataValue == null ? "" : dataValue.replaceAll( "\r\n", "<br>" ).replaceAll( "\n", "<br>") );
				}
				$input.val(dataValue); // 일반적인 처리
			}

			// select2 설정 콤보에 대한 데이터 설정
			if (!gfn_isNull($input.data("select2Id")))
				$input.trigger('change');
			// ---------- Date형/숫자형 Input Data fomat처리 - end
		}
	});
};


var _toastDiv;

/*
 * 저장후 Toast 메시지 처리
 */
function gfn_showMessageByToast(message, bindInfo) {


	try{
	   document.body.removeChild(this._toastDiv);
	}catch(e){
		//console.log(e);
	}

	try{

		if(bindInfo != undefined){
			message = gfn_replaceMessageBind(message, bindInfo)
		}

		 this._toastDiv = document.createElement('div');
		 this._toastDiv.classList.add('ctn-toast');

		 let innerHtml = "<i class='icon-l toast-deco mr-2-5'></i><span>" +message + "</span>"

		 _toastDiv.innerHTML = innerHtml;

		 document.body.appendChild(this._toastDiv);

		 setTimeout(function(){
			$(".ctn-toast").removeClass("--active");
				},3000)
				$(".ctn-toast").addClass("--active");
   }catch(e) {
	 gfn_showMessageByText(message, bindInfo);
   }

}





/**
 * 데이터 비교
 * @desc 2개의 데이터(json, jsonArray)를 비교 후, 변경 된 부분의 값을 반환
 * @param 데이터1, 데이터2, 키이름 배열
// 데이터 비교  테스트중


 let obj = grdMst._getRowItem();          //선택되어있는 권한그룹객체


 let compareKeyLists = Object.keys(obj);

 // 필요 없는 key 제거
 compareKeyLists = this._.remove(compareKeyLists, function (o) {
	return o != '_rowIdField' && o != 'PAGEHELPER_ROW_ID'  ;
 });

 const compResult =  gfn_compareDatas(obj, obj,compareKeyLists );
 console.log(compResult);

if(compResult.length == 0) {
		   modified = false;   // 변경 사항이 없음.
}else{
				 modified = true;    // 변경 사항이 있음
}

*/
function gfn_compareDatas(obj1, obj2, keyLists) {
	let rtnValue = null;

	if(keyLists.length == undefined) {
		return 'err';
	}

	if(obj1.length == undefined && obj2.length == null) {
		rtnValue = [];
		// object
		if(Object.keys(obj1).length == Object.keys(obj2).length) {

			_.forEach(keyLists, function (keyNm) {
				// console.log(keyNm);
				if(obj1[keyNm] != obj2[keyNm]) {
					rtnValue.push({
						[keyNm] : false,
						'data1' : obj1[keyNm],
						'data2' : obj2[keyNm]
					});

				}
			});

		} else {
			return 'err';
		}

	} else if(obj1.length == obj2.length) {
		// 비교 데이터 배열 길이 동일
		// list
		rtnValue = [];

		if(Object.keys(obj1[0]).length == Object.keys(obj2[0]).length) {
			_.forEach(obj1, function(row, index) {
				_.forEach(keyLists, function (keyNm) {
					if(obj1[index][keyNm] != obj2[index][keyNm]) {
						rtnValue.push({
							rowNum:(index + 1),
							[keyNm]: false,
							'data1' : obj1[index][keyNm],
							'data2' : obj2[index][keyNm]
						});
					}
				});
			});

		} else {
			return 'err';
		}

	} else {
		// 비교 데이터 배열 길이 같지 않음
		// list
		rtnValue = [];

		let sizeCalc = obj1.length - obj2.length;

		let standardNum = obj2.length;

		if(sizeCalc < 0) {
			sizeCalc = sizeCalc * -1;
			standardNum = obj1.length;
		}

		_.forEach(sizeCalc, function(row, index) {
			rtnValue.push({
				rowNum:(standardNum + index + 1)
			});
		});
	}

	return rtnValue;
}


/**
 * 버튼형 라디오 생성
 * @param   element
 * @option  {defaultText:"선택", defaultValue: "Y", callback : fn}
 * @returns jsonObject
 */
function gfn_makeBtnRadio(element, commCdList, option) {

	// let $this = element;
	const id = element.attr('id');

	if (gfn_isNull(option)) {
		option = {};
	}

	let innerHtml = "";

	if (!gfn_isNull(option.defaultText)) {
		innerHtml += "<div class='option'>"
		innerHtml += "<input type='radio' name='" + id + "' id='" + id + "_ALL' value='' >";
		innerHtml += "<label for='" + id + "_ALL' class='radio-container' >"+ option.defaultText + "</label>";
		innerHtml += "</div>";
	}

	if (!gfn_isNull(commCdList)) {

		let inputId = '';

		for (var i = 0; i < commCdList.length; i++) {

			inputId = commCdList[i].CODE;
            innerHtml += "<div class='option'>"
			innerHtml += "<input type='radio' name='" + id + "' id='" + id + "_" + inputId + "' value='" + inputId + "' >";
			innerHtml += "<label for='" + id + "_" + inputId + "' class='radio-container' >"+ commCdList[i].CODE_NAME + "</label>";
			innerHtml += "</div>";
		}
	}

	element.append(innerHtml);

	// 기본값 설정
	if (gfn_isNull(option.defaultValue)) {
		$("[name=" + id + "]:first").prop('checked', true);
	} else {
		$("[value='" + option.defaultValue + "']", element).prop("checked", true);
	}

	let callback = eval(option.callback);
	if ($.isFunction(callback)) {
		callback();
	}
}

/**
 * 폼 내용 백업
 * @param   formId
 * @returns str
 */
function gfn_backupForm(formId) {
	return $('#'+formId).serialize();
}

/**
 * 폼 변경 체크
 * @param   orgData
 * @option  formId
 * @returns bool
 */
function gfn_hasChangedForm(orgData, formId) {
	var ret = true;
	var obj = $('#'+formId).serialize();

	if(obj == orgData) {
		ret =  false;
	}
	return ret;
}


/**
 *	폼 요소 입력값 Byte 단위로 길이 제한
 *	UTF-8 에서는 한글이 3byte 임으로, maxbyte/3 자 만 입력 가능하며,
 *	초과 되는 글자는 삭제 됨
 *
 *	@param  $obj 폼 요소 ( jQuery 객체 )
 *	@param  maxByte
 */
function gfn_setMaxByteValue( $obj, maxByte ) {
	if ( ! gfn_checkMaxbyte( $obj, maxByte ) ) {
		let str = $obj.val();
		while ( str.getByte() > maxByte ) {
			str = str.substring( 0, str.length - 1 );
		}
		$obj.val(str);
	}
}

/**
 *	폼 요소의 INPUT, TEXTAREA 중
 *	maxbyte 속성이 설정된 경우
 *	keyup 이벤트를 설정 하고, maxbyte 이상의 입력이 있을 경우,
 *	메시지 팝업 및 입력값을 maxbyte 로 자름
 *	( UTF-8 에서는 한글이 3byte 임으로, maxbyte/3 자 만 입력 가능 )
 *
 *	ex) <input id="RMK" name="RMK" type="text" class="w-full option-input" maxbyte='50'><!-- 한글 기준 16자 이내로 입력 하세요. -->
 *	ex) <textarea id="DESC" name="DESC" class="w-full h-full" maxbyte='1500'><!-- 한글 기준 500자 이내로 입력 하세요. -->
 *
 *	@param  $frm 폼 ( jQuery 객체 )
 */
function gfn_frmMaxbyteChkHandler( $frm ) {
	$frm.find( 'input,textarea' ).each( (i,o) => {
	    if ( $(o).attr( 'maxbyte' ) ) {
	        $(o).attr( 'placeholder', `한글 기준 ${Math.floor(Number($(o).attr('maxbyte'))/3)}자(${$(o).attr('maxbyte')}바이트) 이내로 입력 하세요.` )
	        	.on( 'keyup', e => gfn_setMaxByteValue( $( e.target ), $(o).attr( 'maxbyte' ) ) );
	    }
	} );
}



/**
 * gfn_showReport 호출
 * @param       파라메터
 * @reportGbn   REPORT, EXEREPORT
 *  호출방법
 *  let param={
		    OZFILENAME    : 'TEST/sample.ozr',
		    ARGUMNET      : {aaa:'1', bbb:'2'},
		    EXEOZ_OPTION  : {                        // EXE Report 전용
			               viewer : "print"   ,      // 미리보기 없이 인쇄일 경우에만 사용 미리 보기시에는 삭제 요망
			               mode   : "silent"  ,      // 인쇄 설정창 사용여부 (silent면 안나옴)
			               size   : "A4"      ,      // 용지크기
			               copies : "1"       ,      // 인쇄매수
			               once   : "false"   ,      // 한번만 인쇄할지 여부
			               printername : ""   ,      // print name
		                 }

	 };

	 gfn_showReport(param,"EXEREPORT");               // EXE REPORT 호출
	 gfn_showReport(param);                           // 일반 OZ Report
 */
function gfn_showReport(param, reportGbn, exeParam){

	console.log('param',param);
	console.log('reportGbn',reportGbn);
	console.log('exeParam',exeParam);

	if(gfn_isNull(reportGbn)) {
		reportGbn = "REPORT"
	}

	if(gfn_isNull(reportGbn)) {
		reportGbn = "REPORT"
	}

	let obj = {
		 SERVICE_ID : CONST.PROG_CD ,
		 LOG_TYPE   : "PRINT"
	}

	let paramObj = $.extend({}, param, obj);


	/*************
	console.log("aaaaaaaaaaaaaaaaaaaaaa=", PROFILE);
	let url = "http://localhost:8080";
	if(PROFILE == "dev") {
		url = "http://devsalime.hansalim.or.kr";

	}else if (PROFILE == "prd") {
		url = "http://salime2.hansalim.or.kr";
	}
	console.log("aaaaaaaaaaaaaaaaaaaaaa=", url);
	***/

	let options = {
		  param    : paramObj
		, width    : 850
		, height   : reportGbn == "REPORT"  ? 880 : 330
		, popupId  : gfn_isNull(param.REPORT_ID) ? "ozReport" :  param.REPORT_ID
		, popupUrl : reportGbn == "REPORT"  ? contextPath + '/comfunc/func/common/ozreport/page' : contextPath + '/comfunc/func/common/ozexereport/page'
		, callBack : 'fn_popupCallBack'
	};

	//팝업 호출
	gfn_windowPopup(options);
}



/**
 * Am5 Chart
 * @param   차트 id
 */
function gfn_amChartInit(chart){

	chart.setThemes([
	  am5themes_Animated.new(chart)
	]);
}