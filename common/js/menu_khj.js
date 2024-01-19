/**
 * 1. Lnb, Tab기능 구현
 * 2. 윈도우사이즈가 MIN_WRAP_WIDTH 사이즈보다 작어졌을때 min사이즈 설정
 * 작성자 : 권홍재
 * 작성일 : 2013. 11.02
 */


//
// Lnb, Tab기능 구현
//
	var MAX_TAB_CNT = 20;
	
	var $g_defaultTabMenu = null;
	var $g_defaultContentsFrame = null;
	var g_isMotioning = false;	// 이벤트 중복발생 방지를 위한 flag
	
(function($){

	
	$(document).ready(function(){
		
		$g_defaultTabMenu = $('.content_tab .tab_menu').eq(0).remove();
		$g_defaultContentsFrame = $('.contentsFrames iframe').eq(0).remove();
		
		// home tabMenu 추가

		
		addTabMenu($('.logo')[0]);
		$('.content_tab .tab_menu').eq(0).find('.menu_close').remove();
		
		initLnb();
	});

})(jQuery);




//
// 윈도우사이즈가 MIN_WRAP_WIDTH 사이즈보다 작어졌을때 min사이즈 설정
//
(function($){

	var MIN_WRAP_WIDTH = 1024;

	$(document).ready(function(){

		var setWidth = function(){
			if($(window).width() <= MIN_WRAP_WIDTH){
				$('#wrap').css('width', MIN_WRAP_WIDTH);
			}else{
				$('#wrap').css('width', '100%');
			}
		}

		setWidth();
		
		$(window).resize(function(){
			setWidth();
		});
		
	});
	
})(jQuery);


//
// 탭메뉴 추가
//
var addTabMenu = function(oMenu){

	var $tabMenus = $('.content_tab .tab_menu');
	
	for(var i=0; i<$tabMenus.length; i++){
		//if($tabMenus[i]['menu'] == oMenu){
		if($tabMenus[i]['menuName'] == $(oMenu).find('a').text() 
				/*&& $tabMenus[i]['menuClass'] == $(oMenu).attr('class')*/ ){
			enableTabMenu($tabMenus[i]);
			return;
		}
	}
	
	if($tabMenus.length >= MAX_TAB_CNT){
		toast('탭의 개수는 ' + MAX_TAB_CNT + '개를 초과할 수 없습니다.');
		return;
	}

	var $newContentsFrame = $g_defaultContentsFrame.clone();
	var strSrc = $(oMenu).find('a').attr('href');
	if(strSrc == '#'){	// 빠르게 클릭할 경우 발생할 수 있어서 url이 지정되지않았다면 return처리한다.
		return;
	} else if(strSrc.indexOf('?menu_id') == 0) { //빠르게 클릭할 경우 페이지를 호출하게 될 수 있어 menu_id로 시작될 경우 return 처리
		return;
	} 
	$newContentsFrame.attr('src', strSrc);
	$('.contentsFrames').append($newContentsFrame);
	
	var $newTabMenu = $g_defaultTabMenu.clone();
	$newTabMenu[0]['menuName'] = $(oMenu).find('a').text();
	
	if($(oMenu).closest('.favorites_menu').length){
		
		$('#authority > ul:eq(0)').find('li').each(function (){
			if($(this).find('a').text()  == $(oMenu).find('a').text()) {
				$newTabMenu[0]['menu'] = this;
				$newTabMenu[0]['menuClass'] = $(this).attr('class');
			}
		});
		
	} else {
		$newTabMenu[0]['menu'] = oMenu;
		$newTabMenu[0]['menuClass'] = $(oMenu).attr('class');
	}
	
	$newTabMenu[0]['contentsFrame'] = $newContentsFrame[0];
	$newTabMenu.find('a span').eq(0).text($(oMenu).find('a').text());
	$newTabMenu.bind('click', function(){
		
		if(g_isMotioning){ return; }	// motion이 종료되기전까지는 탭클릭 이벤트를 무시하도록 처리한다.
		g_isMotioning = true;	
		enableTabMenu($newTabMenu[0], function(){
			g_isMotioning = false;
		});
		if($(oMenu).find('a').text() == 'Home') g_isMotioning = false;
	});
	$newTabMenu.find('.menu_close').bind('click', {currTabMenu:$newTabMenu[0]}, function(event){
		var $deletingTabMenu = $(event.data.currTabMenu);
		var deletingTabIdx = $('.content_tab .tab_menu').index($deletingTabMenu);
		var selectTabIdx = -1;
		if(deletingTabIdx == getCurrTabIdx()){			// 활성화된 탭을 삭제할경우
			var lastTabIdx = $('.content_tab .tab_menu').length - 1;
			if(deletingTabIdx == lastTabIdx){	// 삭제한 탭이 마지막 탭일경우
				selectTabIdx = deletingTabIdx - 1;
			}else{
				selectTabIdx = deletingTabIdx;
			}
		}else{
			if(deletingTabIdx < getCurrTabIdx()){	// 삭제한 탭이 마지막 탭일경우
				selectTabIdx = getCurrTabIdx() - 1;
			}
		}
		$($deletingTabMenu[0]['contentsFrame']).remove();
		$deletingTabMenu.remove();
		var selectTabMenu = $('.content_tab .tab_menu').eq(selectTabIdx);
		enableTabMenu(selectTabMenu[0]);
	});
	
	$('.content_tab').append($newTabMenu);
	enableTabMenu($newTabMenu[0]);
};


//
// 현재 선택된 tab index 반환
//
var getCurrTabIdx = function(){
	var $tabMenus = $('.content_tab .tab_menu');
	var curTabIdx = $tabMenus.index($tabMenus.filter('.fixed'));
	return curTabIdx;
}


//
// 탭메뉴 확성화
//
var enableTabMenu = function(tabMenu, fnMotionCompleted){
	var $tabMenus = $('.content_tab .tab_menu');
	var $currTabMenu = $tabMenus.eq(getCurrTabIdx());
	$currTabMenu.removeClass('fixed');
	
	// contents 확성화
	{
		$('.contentsFrames iframe').hide();
		//$(tabMenu['contentsFrame']).show();
		$(tabMenu['contentsFrame']).show();
		$(tabMenu['contentsFrame']).css("height","1200px");
	}
	
	// Lnb 활성화
	{
		var menuClass = $(tabMenu['menu']).attr('class');
		if(menuClass == 'firstDepth'){
			enableFirstDepth(tabMenu['menu'], fnMotionCompleted);
		}else if(menuClass == 'secondDepth'){
			enableSecondDepth(tabMenu['menu'], fnMotionCompleted);
		}else if(menuClass == 'thirdDepth'){
			enableThirdDepth(tabMenu['menu'], fnMotionCompleted);
		}else{
			
			$('.secondDepth a').removeClass('activate');
			$('.firstDepth').find('a span').removeClass('low');
			
			$('.secondDepthArea').hide('blind', function(){
				$('.thirdDepthArea').hide('blind', fnMotionCompleted);
			});
		}
		//
	}
	
	$(tabMenu).addClass('fixed');
};

//
// first depth Lnb 활성화
//
var enableFirstDepth = function(firstDepth, fnMotionCompleted){
	var $secondDepthArea = $(firstDepth).next('.secondDepthArea');
	$(firstDepth).find('a span').addClass('low');
	$('.firstDepth').not(firstDepth).find('a span').removeClass('low');
	if($secondDepthArea[0] != null){
		$secondDepthArea.show('blind', fnMotionCompleted);
		$('.secondDepthArea').not($secondDepthArea).hide('blind');
	}else{
		$('.secondDepthArea').hide('blind', function(){
			$('.thirdDepthArea').hide('blind', fnMotionCompleted);
		});
	}
};

//
// second depth Lnb 활성화
//
var enableSecondDepth = function(secondDepth, fnMotionCompleted){
	var $secondDepthArea = $(secondDepth).parentsUntil('.secondDepthArea').parent();
	var $thirdDepthArea = $(secondDepth).next('.thirdDepthArea');
	$('.secondDepth a').removeClass('activate');
	$(secondDepth).find('a').addClass('activate');
	var firstDepth = $secondDepthArea.prev()[0];
	if($thirdDepthArea[0] != null){
		$thirdDepthArea.show('blind', function(){
			enableFirstDepth(firstDepth, fnMotionCompleted);
		});
		$('.thirdDepthArea').not($thirdDepthArea).hide('blind');
	}else{
		enableFirstDepth(firstDepth, fnMotionCompleted);
		$('.thirdDepthArea').hide('blind');
	}
};


//
// third depth Lnb 활성화
//
var enableThirdDepth = function(thirdDepthMenu, fnMotionCompleted){
	var $thirdDepth = $(thirdDepthMenu);

	$('.thirdDepth a').removeClass('on');
	$thirdDepth.find('a').addClass('on');
	var $thirdDepthArea = $thirdDepth.parentsUntil('.thirdDepthArea').parent();
	var $secondDepth = $thirdDepthArea.prev();
	var secondDepth = $secondDepth[0];
	enableSecondDepth(secondDepth, fnMotionCompleted);
};



//
// Lnb 초기화
//
var initLnb = function(){
	// 1Depth menu
	$('.firstDepth').bind('click', function(event){
		event.preventDefault();
		var $secondDepthArea = $(this).next('.secondDepthArea');
		if($secondDepthArea[0] == null){	// 2Depth가 없다면
			addTabMenu(this);
		}else{
			if($(this).find('a span').hasClass('low')){
				$secondDepthArea.hide('blind');
				$(this).find('a span').removeClass('low');
			}else{
				enableFirstDepth(this);
			}
		}
	});

	// 2Depth menu
	$('.secondDepth').bind('click', function(event){
		event.preventDefault();
		var $thirdDepthArea = $(this).next('.thirdDepthArea');
		if($thirdDepthArea[0] == null){	// 3Depth가 없다면
			addTabMenu(this);
		}else{
			if($(this).find('a').hasClass('activate')){
				$thirdDepthArea.hide('blind');
				$('.secondDepth a').removeClass('activate');
				//$(secondDepth).find('a').addClass('activate');
			}else{
				enableSecondDepth(this, true);
			}
		}
	});

	/* 3Depth menu
	$('.thirdDepth, .logo').bind('click', function(event){
		event.preventDefault();
		addTabMenu(this);
	});*/	

	$(document).on("click",".thirdDepth, .logo", function(event){
		event.preventDefault();
		addTabMenu(this);
	});
	/* favorites menu
	$('.thirdDepth2 .menu').bind('click', function(event){
		event.preventDefault();
		addTabMenu($(this).parent());
	});*/		
};

