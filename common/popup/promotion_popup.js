/**
 * 사용 방법 sample
 *  var popup = new windowPopup();
	popup.open(popupId, -- popup id
		url,  -- 호출 url
		param, -- 넘기는 parameter
		{width : 700,
		 height : 360,
		 callbackF:function(data) {
			toast('success'); -- callback 시 적용될 script 정의
		 }
	});
 */
function windowPopup(){
	var popObj = this;
	this.defaultOption = {
		menubar : "no",
		scrollbars : "yes",
		resizable : "no",
		status : "yes",
		width : 1000,
		height : 600,
		top : (screen.width)/2 - 800,
		left : (screen.height)/2 - 250,
		isMultiSelect : false,
		callbackF : null
	},
	
	this.popupWindow = null,
	
	this.data = null,
	
	this.open = function (id, url, param, o) {
		if (o != undefined && o != null) {	// 옵션 셋팅
			if (o.isMultiSelect != undefined && o.isMultiSelect != null) {
				this.defaultOption.isMultiSelect = o.isMultiSelect;
			}
			if (o.width != undefined && o.width != null) {
				this.defaultOption.width = o.width;
			}
			if (o.height != undefined && o.height != null) {
				this.defaultOption.height = o.height;
			}
			if (o.scrollbars != undefined && o.scrollbars != null) {
				this.defaultOption.scrollbars = o.scrollbars;
			}
			if (o.callbackF != undefined && o.callbackF != null) {
				this.defaultOption.callbackF = o.callbackF;
			}
		}
		if (param != undefined && param != null) {
			if(param.substring(0,1) != '&')
				param = '&'+param;
		} else {
			param = '';
		}
		this.popupWindow = window.open(
				url + "?isMultiSelect=" + this.defaultOption.isMultiSelect + param,
				id,
				"menubar=" + this.defaultOption.menubar + ",scrollbars=" + this.defaultOption.scrollbars 
				+ ",resizable=" + this.defaultOption.resizable + ",status=" + this.defaultOption.status 
				+ ",width=" + this.defaultOption.width + ",height=" + this.defaultOption.height 
				+ ",top=" + this.defaultOption.top + ",left=" + this.defaultOption.left
		);
		
		if (this.popupWindow != undefined && this.popupWindow!= null) {
			this.popupWindow.focus();
		}
		
    	this.popupWindow.onload = new function(){
    		try{
    			if(popObj.popupWindow.closed == false) {
    				popObj.popupWindow.RunCallbackFunction = popObj.selected;
    			}
    		}catch(e){
	    		/*setTimeout(function() { 
	    			if(popObj.popupWindow.closed == false) {
	    				popObj.popupWindow.RunCallbackFunction = popObj.selected;
	    			}
	    		}, 
	    		1000);
	    		
	    		//화면이 늦게 로딩되는걸 대비해서 5초 후도 세팅
	    		setTimeout(function() {
	    			if(popObj.popupWindow.closed == false) {
	    				popObj.popupWindow.RunCallbackFunction = popObj.selected;
	    			} 
	    		}, 
	    		5000);*/
	    		setTimeout(function() {
	    			if(popObj.popupWindow.closed == false) {
	    				popObj.popupWindow.RunCallbackFunction = popObj.selected;
	    			} 
	    		}, 
	    		10000);
    		}
		};
   
	},
	
	/**
	 * 선택 후 실행되어야 할 function 실행
	 */
	this.selected = function(data) {

		if (popObj.defaultOption.callbackF != undefined && popObj.defaultOption.callbackF != null) {
			popObj.defaultOption.callbackF(data);
		}
		if (popObj.popupWindow != undefined && popObj.popupWindow != null) {
			popObj.popupWindow.close();
		}
	};
}

/**
 * 쿠폰 등록 팝업 
 * @return
 */
function couponRegPopup(option) {
	var param = "";
	var couponRegPopup = new windowPopup();
	
	couponRegPopup.open("couponRegPopup",
			"/promotion/coupon/couponRegPopup.do",
			param, 
			{
				width:960,
				height:540
				//,callbackF : option.callbackF
			});				
}

/**
 * 카드행사 등록 팝업 
 * @return
 */
function cardpromoRegPopup(option) {
	var param = "";
	var cardpromoRegPopup = new windowPopup();
	
	cardpromoRegPopup.open("cardpromoRegPopup",
			"/promotion/cardpromo/cardpromoRegPopup.do",
			param, 
			{
				width:900,
				height:840
				//,callbackF : option.callbackF
			});				
}

/**
 * 카드행사 상세 팝업 
 * @return
 */
function cardpromoDtlPopup(option) {
	var param = "";
	var cardpromoDtlPopup = new windowPopup();
	
	cardpromoDtlPopup.open("cardpromoRegPopup",
			"/promotion/cardpromo/cardpromoDtlPopup.do",
			param, 
			{
				width:700,
				height:840
				//,callbackF : option.callbackF
			});				
}


function popupColse(){
	self.close();
}

/**
 * 브랜드할인권검색 조회팝업 
 * @return
 */
function brandDiscountSearchPopup(option) {
	var param = "";
	var brandDiscountSearchPopup = new windowPopup();
	
	brandDiscountSearchPopup.open("brandDiscountSearchPopup",
			"/brand/brand.discount.list.popup.ldpm",
			param, 
			{
				width:960,
				height:540,
				callbackF : option.callbackF
			});				
}  


	