	$(function(){ 
		function initTabs() {
			$('.tab a').bind('click',function(e) {
				e.preventDefault();
				var thref = $(this).attr("href").replace(/#/, '');
				$('.tab a').removeClass('on');
				$(this).addClass('on');
				$('.inb_con').removeClass('active');
				$('#'+thref).addClass('active');
			});
		}
		initTabs();

//		$("#tree").treeview({
//			collapsed: true,
//			animated: "fast",
//			control:"#sidetreecontrol",
//			prerendered: true,
//			persist: "location"
//		});
	})

// 2014 - 01 - 08 이전 Lnb 스크립트 
/*
	$(function() {
		var openCheck = 1;
		$('.inb_close a').click(function(){
			var _btn = $(this)
			if(openCheck == 0){
				openCheck = 1;
				$('.inb_close a').addClass('close').removeClass('open');
				$('.inb_area').css('display','block');
				$('#contents').css('width','81%').css('margin-left','216px');
				$('#lnb').css('width','190px');
			} else {
				openCheck = 0;
				$('.inb_close a').addClass('open').removeClass('close');
				$('.inb_area').css('display','none');
				$('#contents').css('width','96.5%').css('margin-left','30px');
				$('#lnb').css('width','0');
				$('.inb_close').css('top','50px');
			}
		})
	});
*/

// 2014 - 01 - 09 Lnb 스크립트 수정본 
	$(function() {
		var cnt = 0;
		$('.inb_close a').click(function(){
			if ( cnt == 0)
			{
				$('.inb_close a').addClass('open').removeClass('close');
				$("#lnb").addClass("add");
				$("#contents").css("margin-left","34px");
				cnt++;
			} else {
				$('.inb_close a').addClass('close').removeClass('open');
				$("#lnb").removeClass("add");
				$("#contents").css("margin-left","216px");
				cnt = 0;
			}
		});
	});
// 2014 - 01 - 09 Lnb 스크립트 수정본 
/*
	$(function() {
		var openCheck = 0;
		$('.btn_add a').addClass('open').removeClass('close');
		//$('.tbl_wrap.active').slideUp('600');

		$('.btn_add a').click(function(){
			var _btn = $(this)
			if(openCheck == 0){
				openCheck = 1;
				$('.btn_add a').addClass('close').removeClass('open');
				$('.tbl_wrap.active').slideDown('600');

			} else {
				openCheck = 0;
				$('.btn_add a').addClass('open').removeClass('close');
				$('.tbl_wrap.active').slideUp('600');
			}
		})
	});
*/
	
	$(document).ready(function(){
		$('.btn_add a').addClass('open').removeClass('close');
		$('.btn_add a').click(function(){
			if ( $('.tbl_wrap.active').css('display') == 'block' )
			{
				//toast("닫을꺼임");
				$('.tbl_wrap.active').slideUp(600);
				$(this).removeClass('close').addClass('open');
			}
			else if ( $('.tbl_wrap.active').css('display') == 'none' )
			{
				//toast("열을꺼임");
				$('.tbl_wrap.active').slideDown(600);
				$(this).removeClass('open').addClass('close');
			}
		});
	});
	
	
$(function(){ 
		function initTabs_add() {
			$('.Display_tab a').bind('click',function(i) {
				i.preventDefault();
				var thref = $(this).attr("href").replace(/#/, '');
				$('.Display_tab a').removeClass('on');
				$(this).addClass('on');
				$('.inb_con').removeClass('jDisplay');
				$('#'+thref).addClass('jDisplay');
			});
		}
		initTabs_add();
});

// 2014 - 01 - 15 스크립트 추가

$(document).ready(function(){
	$("#good_no_list").css("width","93%");
	$("#good_no_list").parent("div").css("height","64px");
});
