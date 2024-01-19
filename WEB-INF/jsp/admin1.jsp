<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>IL국제물류</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-control" content="No-cache" />
<meta http-equiv="Pragma" content="No-cache" />
<meta name="Description" content="" />
<meta name="Keywords" content="" />

<%@include file="/common/include/header.jsp"%>

<script type="text/javascript" src="/common/js/menu_khj.js"></script>


<script type="text/javascript">
	$(document).ready(function() {
		
		$("#pwdExpiredLayer").hide();
		$("#staffInfoLayerPop").hide();
		$("#pswChangLayerPop").hide();
		$("#sitemap_layer").hide();
		$("#favDiv").hide();

		
			$("#promoCardOrd_layer").hide();
		
				
		var lastid;
		
		// 공지사항
// 		setNoticeEventHandler();
		
		

		
		// 비밀번호 만료 여부 조회
// 		$.ajax({
// 			type: "get",
// 			url: "/system/staff/staffPasswordExpired",
// 			dataType: "json",
// 			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
// 			success: function(data) {
// 				if(data.pwd_excnt > 0 || data.pwd_reset_yn == 'Y'){
// 					if(data.pwd_excnt > 0){
// 						$("#pwdChange").text("기존 비밀번호의 유효기간 만료로 인해 현재 쓰시는 비밀번호에서 새 비밀번호를 등록해주세요.");
// 					} else if(data.pwd_reset_yn == 'Y') {
// 						$("#pwdChange").text("기존 비밀번호의 초기화로 인해 현재 쓰시는 비밀번호에서 새 비밀번호를 등록해주세요.");
// 					}
						
// 					$('#pwdExpiredLayer').center();
// 					$('#pwdExpiredLayer').show();	
// 				}
// 			},
// 			error: function(jqXHR, textStatus, errorThrown) {
// 				 if (jqXHR.status == 403) {
// 		        	topcument.location.href = "/sessionInvalid.jsp";
// 		        } else {
// 		        	toast("팝업 불러오기 실패" + " " + textStatus)
// 		        }
// 			}
// 		});
	

		
		$("#btn_logout").click(function(event) {
			if(confirm("로그아웃 하시겠습니까?")){
				location.href = '/';
				return false;
				
				$.ajax({
					type: "POST",
					url: "/member/login/logout",
					data: '',
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						$(location).attr("href", "/member/login/login"); 
	
					//},
					//error: function(jqXHR, textStatus, errorThrown) {
					//	toast("오류가 발생했습니다" + ' ' + textStatus.msg);						
					}
				});
			}
			
			//event.preventDefault();
		});
	
		$("#btn_favorite").click(function(event) {
			$('#favDiv').center();
			$('#favDiv').show();	
			$("#list1").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
		});
	
	
		$("#btnfavclose").click(function(event) {
			$('#favDiv').hide();	
			$("#bookmark_info").click();
		});
	
		$("#btnfavsave").click(function(event) {
			//$("#list1").editCell(0,0,false);
			var s;
			s = jQuery("#list1").jqGrid('getGridParam','selarrrow');
			
			if( s != ''){
				for(var i=0; i<s.length; i++){
					if(!jQuery("#list1").jqGrid('saveRow',s[i]))
						jQuery("#list1").jqGrid('restoreRow',s[i]);
				}
			}
			saveGridSelected("list1", 'selected', 'save', "/updateBookmarkGridJson");
			//$("#list1").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
			//$("#bookmark_info").click();
		});
	
		$("#btnfavdel").click(function(event) {
			var s;
			s = jQuery("#list1").jqGrid('getGridParam','selarrrow');
			
			if( s != ''){
				for(var i=0; i<s.length; i++){
					jQuery("#list1").jqGrid('saveRow',s[i]);
				}
			}
			saveGridSelected("list1", 'selected', 'delete', "/deleteBookmarkGridJson");
			//$("#list1").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
			//$("#bookmark_info").click();
		});
		
		
		$("#btn_updatestaff").click(function(event) {
			$('#staffInfoLayerPop').center();
			$('#staffInfoLayerPop').show();	
		});
	
	
		$("#close_staffinfo").click(function(event) {
			$('#staffInfoLayerPop').hide();	
		});
		

		
		$("#staffinfo_form").validate({
			debug : true,
			rules : {
				tel_txt:{
					required: true
				},
				email_txt:{
					required: true, email:true
				}
			},
			messages: {
				tel_txt:{
					required:"전화번호를 입력해 주세요"
				},
				email_txt:{
					required:"이메일 주소를 입력해 주세요",
					email:"올바른 이메일주소를 입력해 주세요"
				}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
	        },
			errorPlacement: function(error, element) {
				// nothing
			},
			submitHandler: function(form) {		
				$.ajax({
					type: "POST",
					url: "/system/staff/updateStaffinfo",
					data: $(form).serialize(),
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						if(data.code == '0') {
							toast("code:"+ data.code + "\n" + "msg:" + data.msg);
							//popupColse();
							$('#staffInfoLayerPop').hide();
						}else if(data.code == "-1"){
							toast("code:"+ data.code + "\n" + "msg:" + data.msg);
						}
					//},
					//error: function(jqXHR, textStatus, errorThrown) {
					//	toast("오류가 발생했습니다" + ' ' + textStatus.msg);						
					}
				});
			}
		});
		
		$("#save_staffinfo").click(function(event) {

			var returnFlag = true;
			
			$("input[name=arr_mobil_txt]").each(function(index){
				var v = $(this).val();
				var plen = v.length;

				if(!numcheck(v)) {
					returnFlag = false;	
				}
				
				if(plen != 0 && (plen < 10 || plen > 13)){
					returnFlag = false;
				}
			});

			if(!returnFlag){
				toast('휴대전화번호가 올바르지 않습니다.');
				return;
			}

			$("#staffinfo_form").submit();
		});


		var numcheck = function(num){
			var flag = true;

			for(var i = 0; i < num.length; i++){
				c = num.charAt(i);
				if(!(c >= '0' && c <= '9')){
					flag = false;
					break;
				}
			}
			
			return flag;
		}
	
		$.validator.addMethod(
				"passpattern1"
				, function(value,element){
					  if(value.length<8) return false;
					
					  var charCnt = 0;
					  
					  if(value.match(/[A-Z]/)){charCnt++;}
					  if(value.match(/[a-z]/)){charCnt++;}
					  if(value.match(/[0-9]/)){charCnt++;}
					  if(value.match(/[!@#$%&()_]/)){charCnt++;}
					
					  if(value.length<10 && charCnt<3) return false;
					  else if(charCnt<2) return false;
					  					  
					  return true;
				  }
				, "비밀번호는 알파벳 대문자,소문자,숫자\n,특수문자(!@#$%&()_) 중 \n세가지 이상 포함된  8자 이상이거나 \n두가지 이상 포함된  10자 이상이어야 합니다."
		);
				
		$.validator.addMethod(
				"passpattern2"
				, function(value,element){
					  var loginId = 'alexkr230';
					  if(value.indexOf(loginId)>=0) return false;
					  return true;
				  }
				, "비밀번호에 아이디는 포함될 수 없습니다."
		);
		
		$.validator.addMethod(
				"passpattern3"
				, function(value,element){
					  if($('#passwd_txt_new1').val()!=$('#passwd_txt_renew1').val()) return false;
					  return true;
				  }
				, "새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다"
		);
		
		$.validator.addMethod(
				"passpattern4"
				, function(value,element){
					  if($('#passwd_txt_new2').val()!=$('#passwd_txt_renew2').val()) return false;
					  return true;
				  }
				, "새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다"
		);
		
		$("#save_staffpwd").click(function(event) {
			
			$("#passwd_txt_new1").rules("add", {passpattern1: true});				
			$("#passwd_txt_new1").rules("add", {passpattern2: true});	
			$("#passwd_txt_new1").rules("add", {passpattern3: true});	
			
			$("#changepwd_form").submit();
		});
		
		$("#changepwd_form").validate({
			debug : true,
			rules : {
				passwd_txt:{
					required: true
				},
				passwd_txt_new:{
					required: true
				},
				passwd_txt_renew:{
					required: true
				}
			},
			messages: {
				passwd_txt:{
					required:"변경전 비밀번호를 입력해 주세요"
				},
				passwd_txt_new:{
					required:"새 비밀번호를 입력해 주세요"
				},
				passwd_txt_renew:{
					required:"새 비밀번호 확인을 입력해 주세요"
				}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
	        },
			errorPlacement: function(error, element) {
				// nothing
			},
			submitHandler: function(form) {		
				$.ajax({
					type: "POST",
					url: "/system/staff/updateStaffPwdJson",
					data: $(form).serialize(),
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						if(data.code == '0') {
							toast(data.msg);
							//popupColse();
							$('#pswChangLayerPop').hide();
						}else if(data.code == "-1" || data.code == "-2"){
							toast(data.msg);
						}
					//},
					//error: function(jqXHR, textStatus, errorThrown) {
					//	toast("오류가 발생했습니다" + ' ' + textStatus.msg);						
					}
				});
			}
		});
				
		$("#btn_changepwd").click(function(event) {
			$('#staffInfoLayerPop').hide();
			$('#pswChangLayerPop').center();
			$('#pswChangLayerPop').show();
			
			$('#passwd_txt').val("");
			$('#passwd_txt_new').val("");
			$('#passwd_txt_renew').val("");
			
			
			event.preventDefault();
		});
		
		$("#close_changepwd").click(function(event) {
			$('#pswChangLayerPop').hide();	
		});
	
		$("#bookmark_info").click(function(){
			$.ajax({
				type: "POST",
				url: "/getBookmarkListJson",
				data: '',
				dataType: 'json',
				contentType: 'application/x-www-form-urlencoded; charset=utf-8',
				success: function(data) {
					var bookMark_HTML="";
					$.each(data, function(key, value) {
						 if(key == '_BLIST'){
							$.each(value, function(key, value) {
								var bmark = value;
								//toast(bmark.menu_id);
								bookMark_HTML = bookMark_HTML + "<li class=\"thirdDepth\"><a href='" +bmark.menuurl_txt+"?menu_id=" + bmark.menu_id + "'>" + bmark.menu_nm + "</a></li><li class='xbtn'><a href=\"javascript:deleteBookmark('"+bmark.menu_id+"')\" class='hidden del'></a></li>";
							});
						 }
					});
					$("#bookmark_info").html(bookMark_HTML);
				//},
				//error: function(jqXHR, textStatus, errorThrown) {
				//	toast("오류가 발생했습니다" + ' ' + textStatus.msg);						
				}
			});
		});
		
		$("#btn_sitemap").click(function(){
			//$('#sitemap_layer').show();
			//$('#promoCardOrd_layer').hide();
			
		});
		
		
		$("#btn_closemap").click(function(){
			$('#sitemap_layer').hide();
			
		});
		$("#btn_closePromoCardOrd").click(function(){
			$('#promoCardOrd_layer').hide();
			
		});
		/*
		var SlidePoint = $(".admin_menu.inb_con").children("ul").children("li").children("a");
		$(SlidePoint).each(function(i){
			$(this).click(function(){
				if ( $(this).parent("li").children("ul").css("display") == "none" )
					{
						$(SlidePoint).parent("li").children("ul").slideUp();
						$(this).parent("li").children("ul").slideDown();
					}
				else if ($(this).parent("li").children("ul").css("display") == "block" )
					{
						$(this).parent("li").children("ul").slideUp();
					}
			});
		});
		
		var SubSlidePoint = $(".secondDepth").children("a");
		$(SubSlidePoint).each(function(i){
			$(this).click(function(){
				if ( $(this).parent("li").children("ul").css("display") == "none" )
					{
						$(SubSlidePoint).parent("li").children("ul").slideUp();
						$(this).parent("li").children("ul").slideDown();
					}
				else if ($(this).parent("li").children("ul").css("display") == "block" )
					{
						$(this).parent("li").children("ul").slideUp();
					}
			});
		});
		*/
		
		$("#pwd_save").click(function(event) {
			$("#passwd_txt_new2").rules("add", {passpattern1: true});				
			$("#passwd_txt_new2").rules("add", {passpattern2: true});	
			$("#passwd_txt_new2").rules("add", {passpattern4: true});	
			
			$("#pwdExpired_form").submit();
		});
	
		$("#pwdExpired_form").validate({
			debug : true,
			rules : {
				passwd_txt:{
					required: true
				},
				passwd_txt_new:{
					required: true
				},
				passwd_txt_renew:{
					required: true
				}
			},
			messages: {
				passwd_txt:{
					required:"변경전 비밀번호를 입력해 주세요"
				},
				passwd_txt_new:{
					required:"새 비밀번호를 입력해 주세요"
				},
				passwd_txt_renew:{
					required:"새 비밀번호 확인을 입력해 주세요"
				}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
	        },
			errorPlacement: function(error, element) {
				// nothing
			},
			submitHandler: function(form) {		
				$.ajax({
					type: "POST",
					url: "/system/staff/updateStaffPwdJson",
					data: $(form).serialize(),
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						if(data.code == '0') {
							toast(data.msg);
							$('#pwdExpiredLayer').hide();
						}else if(data.code == "-1" || data.code == "-2"){
							toast(data.msg);
						}
					//},
					//error: function(jqXHR, textStatus, errorThrown) {
					//	toast("오류가 발생했습니다" + ' ' + textStatus.msg);						
					}
				});
			}
		});
		
		
		$("#pwd_reset").click( function() {	
			$("#pwdExpired_form")[0].reset();
		});
		

		
		$("#header_btn_search").click( function(event) {	
	    	event.preventDefault();
	    	var link_html = "";
	    	//toast($("#hearer_search_typ").val());
	    	
	    	if($("#hearer_search_typ").val() == "1"){
	    		if($("#hearder_search_txt").val() == ""){
	    			toast("주문번호를 입력해 주세요")
	    			return;
	    		}
	        	link_html = '<a href="/delivery/delivery/deliveryList?menu_id=10044&ord_no='+ $("#hearder_search_txt").val() +'">주문/배송 리스트</a>';
	        	$("#orderSearch").html(link_html);
	    		$("#orderSearch").trigger('click');

	    		var $tabMenus = $('.content_tab .tab_menu');
	        	for(var i=0; i<$tabMenus.length; i++){
	        		if($tabMenus[i]['menuName'] == $("#orderSearch").find('a').text() ){
	        			$($tabMenus[i]['contentsFrame']).attr('src', '/delivery/delivery/deliveryList?menu_id=10044&ord_no='+ $("#hearder_search_txt").val());
	        			return;
	        		}
	        	}
	    	
	    	}else if($("#hearer_search_typ").val() == "2"){
	    		if($("#hearder_search_txt").val() == ""){
	    			toast("상품번호를 입력해 주세요")
	    			return;
	    		}
	        	link_html = '<a href="/product/product/productList?menu_id=10013&good_no='+ $("#hearder_search_txt").val() +'">상품리스트</a>';
	        	$("#goodSearch").html(link_html);
	    		$("#goodSearch").trigger('click');
	    		
	        	var $tabMenus = $('.content_tab .tab_menu');
	        	for(var i=0; i<$tabMenus.length; i++){
	        		if($tabMenus[i]['menuName'] == $("#goodSearch").find('a').text() ){
	        			$($tabMenus[i]['contentsFrame']).attr('src', '/product/product/productList?menu_id=10013&good_no='+ $("#hearder_search_txt").val());
	        			return;
	        		}
	        	}
	    		
	    	}else if($("#hearer_search_typ").val() == "3"){
	    		if($("#hearder_search_txt").val() == ""){
	    			toast("회원번호를 입력해 주세요")
	    			return;
	    		}
	        	link_html = '<a href="/member/member/memberList?menu_id=10011&search_txt='+ $("#hearder_search_txt").val() +'+">회원 정보 조회</a>';
	        	$("#memberSearch").html(link_html);
	    		$("#memberSearch").trigger('click');

	        	var $tabMenus = $('.content_tab .tab_menu');
	        	for(var i=0; i<$tabMenus.length; i++){
	        		if($tabMenus[i]['menuName'] == $("#memberSearch").find('a').text() ){
	        			$($tabMenus[i]['contentsFrame']).attr('src', '/member/member/memberList?menu_id=10011&search_txt='+ $("#hearder_search_txt").val());
	        			return;
	        		}
	        	}
	    	}
	    	return;
		});
		

		
// 		jQuery("#list1").jqGrid({
// 			url:'/getBookmarkListJson', 		  
// 			datatype: "json",				   
// 	//		datatype: "local",				   
// 			colNames:['메뉴ID','메뉴명', '우선순위'],
// 			colModel:[
// 				{	name:'menu_id'	, index:'menu_id'	, width:100	, align:"center"	, editable:false	, hidden:true	},
// 				{	name:'menu_nm'	, index:'menu_nm'	, width:340	, align:"center"	, editable:false	},
// 				{	name:'sort_seq'	, index:'sort_seq'	, width:100	, align:"center"	, editable:true	, editrules:{required:true,number:true}	}
// 			],
// 			mtype:"post",
// 			autowidth: true,	// 부모 객체의 width를 따른다
// 			width : 500,
// 			height: 250,
// 			pager: '#pager1',
// 			sortname: 'id',
// 		    viewrecords: true,
// 		    sortorder: "desc",				    
// 		    multiselect : true,
// 		    cellEdit : true,
// 			cellsubmit : 'clientArray',
// 			gridview: true,
// 			shrinkToFit:false,
// 			// 서버에러시 처리
// 			loadError : function(xhr,st,err) {
// 				girdLoadError();
// 		    },				    
// 		    // 데이터 로드 완료 후 처리 
// 		    loadComplete: function(data) {	
// 		    	//setSortingGridData(this, data);
// 		    }, 
// 		    // cell이 변경되었을 경우 처리
// 		    afterSaveCell : function(id, name, val, iRow, iCol) {
// 		    	//checkWhenColumnUpdated("list1", id);
// 		    },			
// 		    onSelectRow: function(id){           //jqGrid의 row를 선택했을 때 이벤트 발생
// 		        if( lastid != id ){
// 		         jQuery("#list1").jqGrid('restoreRow',lastid,true);    //해당 row 가 수정모드에서 뷰모드(?)로 변경
// 		         jQuery("#list1").jqGrid('editRow',id,false);  //해당 row가 수정모드(?)로 변경
	
// 		         lastid = id;
// 		        }
// 			 },
// 			 onCellSelect : function(rowid,cindex,cellcontent,e){   
// 				//toast(rowid + "||" + cindex + "||" + cellcontent + "||" + e ) ;
				 
// 			 }	
// 		});
	

		
		// 즐겨찾기 첫번째 메뉴를 최초 접속시 띄워준다.(내부관리자용)
		
			$("#fav_index_0").trigger('click');
			  
		 
	    $( "#new_notice" ).hide();
		function notice_show(){
	    	$( "#new_notice" ).show();
	    	setTimeout(function() {
		    	for(i=9; i > 0; i--){
		    		
					(function(i){
						setTimeout(function(){
				    		$( "#new_notice" ).removeClass('new_notice_opacity1 new_notice_opacity2 new_notice_opacity3 new_notice_opacity4 new_notice_opacity5 ');
				    		$( "#new_notice" ).removeClass('new_notice_opacity6 new_notice_opacity7 new_notice_opacity8 new_notice_opacity9');
				    		$( "#new_notice" ).addClass('new_notice_opacity' + i);
				    		if(i >= 9){
				    			$( "#new_notice" ).removeClass('new_notice_opacity9');
				    			$( "#new_notice" ).hide();
					    	}
						}, 100 * i);
						
					}(i));
			    }
		      }, 1000 );
		}
		 
	    var new_notice_value = $('#new_notice_value').val();	    
		if(new_notice_value == 'new_notice'){
			notice_show();
		}
				
		function showLoddingBar(val){
			if(val){
				$( "#loddingBar" ).show();
			}else{
				$( "#loddingBar" ).hide();
			}			
		}
		showLoddingBar(false);
	});
	
	function deleteBookmark(menu_id){
		if(confirm("삭제하시겠습니까?")){
			$.ajax({
				type: "POST",
				url: "/deleteBookmarkJson?menu_id="+menu_id,
				data: '',
				dataType: 'json',
				contentType: 'application/x-www-form-urlencoded; charset=utf-8',
				success: function(data) {
					$("#bookmark_info").click();
				//},
				//error: function(jqXHR, textStatus, errorThrown) {
				//	toast("오류가 발생했습니다" + ' ' + textStatus.msg);						
				}
			});
		}		
	}
	
	function setNoticeEventHandler() {
		// 관리자 공지사항 팝업페이지 조회
		$.ajax({
			type: "get",
			url: "/board/notice/mainNoticePopList",
			dataType: "json",
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if (data.popArry != null && data.popArry != undefined) { // 팝업공지 데이터가 있을 경우 팝업호출
					for (var loop = 0; loop < data.popArryLen; loop++) {
						window.open('/board/notice/mainNoticeDetail?mode=pop&id=' + data.popArry[loop].noticebbs_no, 
					 			'popup_page' + loop, 'width=750, height=800, scrollbars=yes, status=no');
					}
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				if (jqXHR.status == 403) {
		        	topcument.location.href = "/sessionInvalid.jsp";
		        } else {
		        	toast("팝업 불러오기 실패" + " " + textStatus)
		        }
			}
		});
		
		// 좌측하단 공지사항 리스트 상세조회
		$("#ntcList td a").click(function() {
	 		var params = "?mode=view&id=" + $(this).attr("ntcNum");
	 		var width = 750;
	 		var height = 500;
			CenterOpenWindow("/board/notice/mainNoticeDetail" + params, "_blank", width, 
					height, "scrollbars=yes, status=no");
		});
		// 공지사항이 없을 경우
		
			$(".admin_notice").hide();
		
			$('.mainFrame').hide();
		
	}
	
	// 상품리스트에서 신규등록클릭시
	function productReg() {
    	var link_html = "";
    	link_html = '<a href="/product/product/productDetail">상품 등록</a>';
    	$("#goodReg").html(link_html);
		$("#goodReg").trigger('click');
	}
	
	// 배송상태별 주문 리스트 이동
	// 출고지시 : 12403, 상품준비중 : 12404, 발송완료 : 12405
	function order_link(deli_status_cd) {
		toast(deli_status_cd);
    	alink_html = '<a href="/delivery/delivery/deliveryList?menu_id=10044&deli_status_cd='+ deli_status_cd+'">주문 배송 현황</a>';
    	$("#orderSearch").html(alink_html);
		$("#orderSearch").trigger('click');
	}
	// 발송지연 화면으로 이동
	function delayList_link(){
    	link_html = '<a href="/delivery/delivery/deliveryDelayList?menu_id=10045&deli_status_cd=Y">배송 지연 리스트</a>';
    	$("#delayList").html(link_html);
		$("#delayList").trigger('click');
	}
	// 클레임 리스트 화면으로 이동
	// 취소 : 2, 반품 : 3, 교환 : 4
	// claim_status_cd 반품:13703, 교환:13703
	function claimList_link(claim_status_cd,claim_typ){
    	link_html = '<a href="/claim/claim/claimList?menu_id=10047&claim_status_cd='+ claim_status_cd + '&claim_typ=' + claim_typ +'">클레임 리스트</a>';
    	$("#claimList").html(link_html);
		$("#claimList").trigger('click');
	}
	// 상품 리스트 화면으로 이동 _ 승인상태별
	// 승인대기 : 10601, 승인반려 : 10603
	function goodList1_link(aproval_typ_cd){
    	link_html = '<a href="/product/product/productList?menu_id=10013&aproval_typ_cd='+ aproval_typ_cd +'&reg_st_dt=">상품리스트</a>';
    	$("#goodSearch").html(link_html);
		$("#goodSearch").trigger('click');
	}
	// 상품 리스트 화면으로 이동 _ 판매상태별
	// 판매중 : 10501, 품절 : 10503, 판매종료 : 10504
	function goodList2_link(sell_st_cd){
    	link_html = '<a href="/product/product/productList?menu_id=10013&sell_st_cd='+ sell_st_cd +'">상품리스트</a>';
    	$("#goodSearch").html(link_html);
		$("#goodSearch").trigger('click');
	}
	// 기획전 리스트 화면으로 이동 _승인상태별
	// 승인대기 : 10601, 승인반려 : 10603
    function planList1_link(approve_cd){
    	link_html = '<a href="/exhibition/plan/exhibitionList?menu_id=10030&approve_cd='+ approve_cd +'">기획전 리스트</a>';
    	$("#planList").html(link_html);
		$("#planList").trigger('click');
	}
	// 기획전 리스트 화면으로 이동 _상태별
	// 진행중 : 2
    function planList2_link(plan_st_typ){
    	link_html = '<a href="/exhibition/plan/exhibitionList?menu_id=10030&plan_st_typ='+ plan_st_typ +'">기획전 리스트</a>';
    	$("#planList").html(link_html);
		$("#planList").trigger('click');
	}
	// 행사 리스트 화면으로 이동 _ 승인상태별
	//승인대기 : 1, 승인반려 : 3
	function couponList1_link(search_approve_cd){
    	link_html = '<a href="/promotion/coupon/couponList?menu_id=10036&search_approve_cd='+ search_approve_cd +'">쿠폰 행사 관리</a>';
    	$("#couponList").html(link_html);
		$("#couponList").trigger('click');
	}
	// 행사 리스트 화면으로 이동 _ 상태별
	//정상 : 1
	function couponList2_link(search_evn_st_typ){
    	link_html = '<a href="/promotion/coupon/couponList?menu_id=10036&search_evn_st_typ='+ search_evn_st_typ +'">쿠폰 행사 관리</a>';
    	$("#couponList").html(link_html);
		$("#couponList").trigger('click');
	}

</script>

</head>
<body class="sky">
	<div id="skip_navi">
		<h2>주요메뉴 건너뛰기</h2>
		<ul>
			<li><a href="#">본문 바로가기</a></li>
			<li><a href="#">주요메뉴 바로가기</a></li>
			<li><a href="#">하단영역 바로가기</a></li>
		</ul>
	</div>
		
	<div id="wrap">
		<!-- header -->
		<div id="header">
			<div class="header-wrap">
				<h1 class="logo" style="cursor:pointer;"><a href="" style="display:none;">Home</a></h1>
				<div class="search-area">
					<form method="post" action="#">
						<fieldset>
						<legend>검색</legend>
						<div class="search_wrap">
							<div class="search_st">
								<select id="hearer_search_typ">
									<option value="1">BLNO</option>
									<option value="2"></option>

									</select>
								<input type="text" id="hearder_search_txt" class="inp" />
							</div>
							<button class="btn-area" id="header_btn_search">검색</button>
						</div>
						</fieldset>
					</form>
				</div>
				<div class="logoin">

					<!-- span class="name">우수업체 <span>홍길동</span>님 안녕하세요</span-->
					<span class="name"><span>김**</span>님 안녕하세요</span>
					<a href="javascript:void(0);" id="btn_updatestaff">개인정보수정</a>
					<a href="#" id="btn_favorite">즐겨찾기수정</a>
					<a href="#" id="btn_logout">로그아웃</a>
					<a href="#"><span class="sitemap" id="btn_sitemap">사이트맵</span></a>
				</div>
			</div>
	
			<div class="sitemap_layer" style="display:none;" id="sitemap_layer">
				<div class="sitemap_header">
					<h1 class="header">Site map</h1>
				</div>
				<div class="sitemap_wrap">
						<div class="sitemap_area">
								<h2 class="tit">회원 관리</h2>
					<ul class="sitemap_txt">
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">회원 정보 조회</a>
						</li>
						</ul>
						</div>
					<div class="sitemap_area">
								<h2 class="tit">상품 관리</h2>
					<ul class="sitemap_txt">
									<li class="secondDepth"><a href="?menu_id=10013">상품 정보 관리</a>
						<ul>
										<li  class="thirdDepth"><a href="/product/option/productOptionList?menu_id=10125">옵션 항목 관리</a></li>
								<li  class="thirdDepth"><a href="/product/product/productList?menu_id=10014">상품리스트</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="?menu_id=10015">상품 등록</a>
						<ul>
										<li  class="thirdDepth"><a href="/product/product/usedProductDetail?menu_id=10124">중고상품등록</a></li>
								<li  class="thirdDepth"><a href="/product/product/productDetail?menu_id=10123">상품 등록</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="?menu_id=10016">상품 정보 일괄 관리</a>
						<ul>
										<li  class="thirdDepth"><a href="/product/data/productListUpload?menu_id=10017">상품 정보 일괄 업로드</a></li>
								<li  class="thirdDepth"><a href="/product/data/productListUpdate?menu_id=10018">상품 정보 일괄 변경</a></li>
								<li  class="thirdDepth"><a href="/product/data/productAmountUpdate?menu_id=10132">상품 가격 일괄 변경</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="/product/approval/productApprovalList?menu_id=10019">상품 승인 관리</a>
						</li>
						<li class="secondDepth"><a href="/product/reserve/productPriceReserveList?menu_id=10020">상품 가격 예약 관리</a>
						</li>
						<li class="secondDepth"><a href="/product/history/productHistoryList?menu_id=10021">상품 정보 변경 이력</a>
						</li>
						<li class="secondDepth"><a href="/product/inquiry/productInquiryList?menu_id=10022">상품 문의 관리</a>
						</li>
						<li class="secondDepth"><a href="/product/comment/productCommentList?menu_id=10023">상품평 관리</a>
						</li>
						<li class="secondDepth"><a href="/product/text/productTextList?menu_id=10142">상품문구관리</a>
						</li>
						</ul>
						</div>
					<div class="sitemap_area">
								<h2 class="tit">전시 관리</h2>
					<ul class="sitemap_txt">
									<li class="secondDepth"><a href="/exhibition/mainPage/mainPageList?menu_id=10024">메인페이지 관리</a>
						</li>
						<li class="secondDepth"><a href="?menu_id=10025">카테고리 관리</a>
						<ul>
										<li  class="thirdDepth"><a href="/exhibition/manageCategory/manageCategoryList?menu_id=10026">관리 카테고리</a></li>
								<li  class="thirdDepth"><a href="/exhibition/category/exhibitionCategoryList?menu_id=10027">전시 카테고리</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="/exhibition/besthundred/besthundredList?menu_id=10099">베스트샵 관리</a>
						</li>
						<li class="secondDepth"><a href="?menu_id=10028">기획전 관리</a>
						<ul>
										<li  class="thirdDepth"><a href="/exhibition/plan/exhibitionList?menu_id=10030">기획전 리스트</a></li>
								<li  class="thirdDepth"><a href="/exhibition/plan/exhibitionNoteList?menu_id=10031">기획전 댓글관리</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="/exhibition/exdisplay/exdisplayList?menu_id=10032">외부 전시 관리</a>
						</li>
						<li class="secondDepth"><a href="/exhibition/brand/brandList?menu_id=10033">브랜드 관리</a>
						</li>
						<li class="secondDepth"><a href="/exhibition/popup/popupList?menu_id=10034">팝업 관리</a>
						</li>
						<li class="secondDepth"><a href="/exhibition/banner/bannerList?menu_id=10035">배너 관리</a>
						</li>
						<li class="secondDepth"><a href="/exhibition/mainPage/mobileMainPageList?menu_id=10133">모바일 메인페이지 관리</a>
						</li>
						<li class="secondDepth"><a href="/exhibition/exdisplay/mddisplayList?menu_id=10134">모바일 추천상품 관리</a>
						</li>
						<li class="secondDepth"><a href="/exhibition/mobileLayer/mobileLayerList?menu_id=10135">모바일 전면 레이어 관리</a>
						</li>
						<li class="secondDepth"><a href="/exhibition/searchword/searchwordList?menu_id=10136">추천검색어 관리</a>
						</li>
						<li class="secondDepth"><a href="/exhibition/mainPage/newMainPageList?menu_id=10149">신규 메인페이지 관리</a>
						</li>
						<li class="secondDepth"><a href="/exhibition/popularword/popularwordList?menu_id=10150">인기검색어 관리</a>
						</li>
						<li class="secondDepth"><a href="/exhibition/adbanner/bannerList?menu_id=10156">광고배너 관리</a>
						</li>
						<li class="secondDepth"><a href="/system/img/imgList?menu_id=10161">이미지 관리</a>
						</li>
						<li class="secondDepth"><a href="/exhibition/theme/themeList?menu_id=10176">테마 관리</a>
						</li>
						<li class="secondDepth"><a href="/exhibition/renewmainPage/renewMainPageList?menu_id=10191">(리뉴얼)통합메인페이지</a>
						</li>
						</ul>
						</div>

					<div class="sitemap_area">
								<h2 class="tit">주문 관리</h2>
					<ul class="sitemap_txt">
									<li class="secondDepth"><a href="?menu_id=10040">주문 내역 관리</a>
						<ul>
										<li  class="thirdDepth"><a href="/order/order/orderList?menu_id=10041">주문 배송 현황</a></li>
								<li  class="thirdDepth"><a href="/order/deposit/depositStandByList?menu_id=10042">입금 대기 리스트</a></li>
								<li  class="thirdDepth"><a href="/order/deposit/updateReturnDelvFee?menu_id=10139">주문 반품배송비 변경</a></li>
								<li  class="thirdDepth"><a href="/order/order/orderAmountUpdate?menu_id=10155">주문공급가일괄변경</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="?menu_id=10043">배송 관리</a>
						<ul>
										<li  class="thirdDepth"><a href="/delivery/delivery/deliveryList?menu_id=10044">주문/배송 리스트</a></li>
								<li  class="thirdDepth"><a href="/delivery/delivery/deliveryDelayList?menu_id=10045">배송 지연 리스트</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="?menu_id=10046">클레임 관리</a>
						<ul>
										<li  class="thirdDepth"><a href="/claim/claim/claimList?menu_id=10047">클레임 리스트</a></li>
								<li  class="thirdDepth"><a href="/claim/claim/exchangeReturnEndList?menu_id=10048">교환/반품 완료처리 관리</a></li>
								<li  class="thirdDepth"><a href="/claim/refund/refundList?menu_id=10049">환불 리스트</a></li>
								<li  class="thirdDepth"><a href="claim/claim/orderCollectList?menu_id=10153">회수지시관리</a></li>
								</li>
							</ul>	
						</ul>
						</div>
					</div>
						<div class="sitemap_wrap">
						<div class="sitemap_area">
								<h2 class="tit">게시판 관리</h2>
					<ul class="sitemap_txt">
									<li class="secondDepth"><a href="?menu_id=10050">공지사항 관리</a>
						<ul>
										<li  class="thirdDepth"><a href="/board/notice/adminNoticeList?menu_id=10051">관리자 공지사항</a></li>
								<li  class="thirdDepth"><a href="/board/notice/frontNoticeList?menu_id=10052">프론트 공지사항</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="/board/oneOnone/newOneOnoneList?menu_id=10053">1:1 문의 관리</a>
						</li>
						<li class="secondDepth"><a href="/board/faq/faqList?menu_id=10054">FAQ 관리</a>
						</li>
						</ul>
						</div>
					<div class="sitemap_area">
								<h2 class="tit">업체 관리</h2>
					<ul class="sitemap_txt">
									<li class="secondDepth"><a href="/partner/partner/partnerList?menu_id=10055">공급사 정보 관리</a>
						</li>
						<li class="secondDepth"><a href="/partner/partner/partnerListPop?menu_id=10129">업체정보수정</a>
						</li>
						</ul>
						</div>
					<div class="sitemap_area">
								<h2 class="tit">정산 관리</h2>
					<ul class="sitemap_txt">
									<li class="secondDepth"><a href=".?menu_id=10165">(신)판매대금정산</a>
						<ul>
										<li  class="thirdDepth"><a href="/account/settleclose/NewgoodSaleAccountList?menu_id=10166">판매현황</a></li>
								<li  class="thirdDepth"><a href="/account/settleclose/tourGoodSaleAccount?menu_id=10167">정산현황</a></li>
								<li  class="thirdDepth"><a href="/account/settleclose/otherSalesAccountListNew?menu_id=10168">(신)기타매출정산 및 확정</a></li>
								<li  class="thirdDepth"><a href="/account/settleclose/paymentCalculationNewList?menu_id=10169">(신)정산대금지급처리</a></li>
								<li  class="thirdDepth"><a href="/account/settleclose/surtaxList?menu_id=10170">부가세신고자료</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href=".?menu_id=10100">(구)판매대금정산</a>
						<ul>
										<li  class="thirdDepth"><a href="/account/settleclose/settlecloseList?menu_id=10104">결제마감조회</a></li>
								<li  class="thirdDepth"><a href="/account/settleclose/vendorSaleInfoList?menu_id=10105">매출정보(공급업체별)</a></li>
								<li  class="thirdDepth"><a href="/account/settleclose/goodSaleAccountList?menu_id=10106">(구)상품대금정산</a></li>
								<li  class="thirdDepth"><a href="/account/settleclose/deliveryAccountList?menu_id=10107">배송비 대금 정산</a></li>
								<li  class="thirdDepth"><a href="/account/settleclose/vendorDiscountInfoList?menu_id=10130">할인금액정보(공급업체별)</a></li>
								<li  class="thirdDepth"><a href="/account/settleclose/settlementCheckValidation?menu_id=10131">정산 금액 검증</a></li>
								<li  class="thirdDepth"><a href="/account/settleclose/couponSCMList?menu_id=10140">쿠폰사용내역(공급사별)</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="?menu_id=10101">기타매출정산</a>
						<ul>
										<li  class="thirdDepth"><a href="/account/settleclose/couponUseInfoList?menu_id=10108">쿠폰사용내역 조회</a></li>
								<li  class="thirdDepth"><a href="/account/settleclose/mileagePayInfoList?menu_id=10109">마일리지지급내역조회</a></li>
								<li  class="thirdDepth"><a href="/account/settleclose/penaltyInfoList?menu_id=10110">페널티내역조회</a></li>
								<li  class="thirdDepth"><a href="/account/settleclose/otherSalesInfoList?menu_id=10111">기타내역관리</a></li>
								<li  class="thirdDepth"><a href="/account/settleclose/otherSalesAccountList?menu_id=10112">(구)기타매출정산 및 확정</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="?menu_id=10102">세금계산서발행</a>
						<ul>
										<li  class="thirdDepth"><a href="/account/taxbill/salesTaxbillList?menu_id=10114">매출세금계산서발행</a></li>
								<li  class="thirdDepth"><a href="/account/taxbill/purchaseTaxbillList?menu_id=10115">매입세금계산서발행</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="?menu_id=10103">정산처리</a>
						<ul>
										<li  class="thirdDepth"><a href="/account/settleclose/paymentCalculationList?menu_id=10116">(구)정산대금지급처리</a></li>
								<li  class="thirdDepth"><a href="/claim/claim/updateCalculateList?menu_id=10178">수기정산처리</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="/account/operation/operatingCostsList?menu_id=10162">운영비 관리</a>
						</li>
						</ul>
						</div>
					<div class="sitemap_area">
								<h2 class="tit">통계 관리</h2>
					<ul class="sitemap_txt">
									<li class="secondDepth"><a href="?menu_id=10063">매출 통계</a>
						<ul>
										<li  class="thirdDepth"><a href="/statistics/sales/todaySalesList?menu_id=10084">당일주문현황</a></li>
								<li  class="thirdDepth"><a href="/statistics/sales/periodSalelist?menu_id=10085">기간대별통계</a></li>
								<li  class="thirdDepth"><a href="/statistics/sales/paymentSalelist?menu_id=10086">결제수단별현황</a></li>
								<li  class="thirdDepth"><a href="/statistics/sales/genderSalelist?menu_id=10087">성별매출통계</a></li>
								<li  class="thirdDepth"><a href="/statistics/sales/ageSalelist?menu_id=10088">연령별매출통계</a></li>
								<li  class="thirdDepth"><a href="/statistics/sales/categorySalelist?menu_id=10089">카테고리별매출통계</a></li>
								<li  class="thirdDepth"><a href="/statistics/sales/venderSalelist?menu_id=10090">공급사별매출통계</a></li>
								<li  class="thirdDepth"><a href="/statistics/sales/areaSalesList?menu_id=10093">지역별 매출 통계</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="?menu_id=10064">회원 통계</a>
						<ul>
										<li  class="thirdDepth"><a href="/statistics/member/orderMemberList?menu_id=10091">구매회원통계</a></li>
								<li  class="thirdDepth"><a href="/statistics/member/orderCountList?menu_id=10094">구매횟수현황</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="?menu_id=10065">상품 통계</a>
						<ul>
										<li  class="thirdDepth"><a href="/statistics/good/interestGoodList?menu_id=10095">인기상품현황</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="?menu_id=10066">기타 통계</a>
						<ul>
										<li  class="thirdDepth"><a href="/statistics/other/milegeList?menu_id=10096">마일리지통계</a></li>
								<li  class="thirdDepth"><a href="/statistics/other/couponList?menu_id=10097">쿠폰통계</a></li>
								<li  class="thirdDepth"><a href="/statistics/other/couponUseOrderList?menu_id=10098">쿠폰사용순위별통계</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="/statistics/agree/shoppingAgreeList?menu_id=10148">쇼핑알림동의 통계</a>
						</li>
						</ul>
						</div>
					<div class="sitemap_area">
								<h2 class="tit">시스템 관리</h2>
					<ul class="sitemap_txt">
									<li class="secondDepth"><a href="?menu_id=10067">코드 관리</a>
						<ul>
										<li  class="thirdDepth"><a href="/system/code/systemCodeList?menu_id=10068">시스템 코드 관리</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="/system/menu/menuList?menu_id=10070">메뉴 관리</a>
						<ul>
										<li  class="thirdDepth"><a href="/system/menu/menuList?menu_id=10145">메뉴 관리</a></li>
								<li  class="thirdDepth"><a href="/system/menu/menuHistoryList?menu_id=10146">메뉴 권한변경 로그 관리</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="?menu_id=10071">운영자 관리</a>
						<ul>
										<li  class="thirdDepth"><a href="/system/staff/staffList?menu_id=10072">운영자 리스트</a></li>
								<li  class="thirdDepth"><a href="/system/staff/staffLogList?menu_id=10073">운영자 접속 로그 조회</a></li>
								<li  class="thirdDepth"><a href="/system/staff/loginHistoryList?menu_id=10080">로그인 기록관리</a></li>
								<li  class="thirdDepth"><a href="/system/staff/personalInfoHistoryList?menu_id=10081">개인정보 처리 기록 관리</a></li>
								<li  class="thirdDepth"><a href="/system/staff/staffHistoryList?menu_id=10083">운영자 기록 관리</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="?menu_id=10074">권한 그룹 관리</a>
						<ul>
										<li  class="thirdDepth"><a href="/system/auth/groupAuthList?menu_id=10075">권한 그룹 리스트</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href="/system/edm/edmSendList?menu_id=10117">EDM발송</a>
						</li>
						</ul>
						</div>
					</div>
						<div class="sitemap_wrap">
						<div class="sitemap_area">
								<h2 class="tit">PG 이중화 관리</h2>
					<ul class="sitemap_txt">
									<li class="secondDepth"><a href="/payment/pg/paymentPgList?menu_id=10144">PG 분배율조정</a>
						</li>
						</ul>
						</div>
					<div class="sitemap_area">
								<h2 class="tit">EP연동관리</h2>
					<ul class="sitemap_txt">
									<li class="secondDepth"><a href="/order/order/orderListEP?menu_id=10173">주문현황관리(EP조회)</a>
						</li>
						<li class="secondDepth"><a href="/product/product/epCategoryMgt?menu_id=10174">EP카테고리매핑관리</a>
						</li>
						</ul>
						</div>
					<div class="sitemap_area">
								<h2 class="tit">컨텐츠관리</h2>
					<ul class="sitemap_txt">
									<li class="secondDepth"><a href=".?menu_id=10182">매거진관리</a>
						<ul>
										<li  class="thirdDepth"><a href="/contents/magazine/magazineList?menu_id=10183">매거진리스트</a></li>
								<li  class="thirdDepth"><a href="/contents/magazine/CategoryList?menu_id=10184">카테고리 관리(매거진)</a></li>
								</li>
							</ul>	
						<li class="secondDepth"><a href=".?menu_id=10185">커뮤니티관리</a>
						<ul>
										<li  class="thirdDepth"><a href="/contents/community/CategoryList?menu_id=10186">카테고리 관리(커뮤니티)</a></li>
								<li  class="thirdDepth"><a href="/contents/community/postList?menu_id=10187">게시물 관리</a></li>
								<li  class="thirdDepth"><a href="/contents/community/commentsList?menu_id=10188">댓글 관리</a></li>
								<li  class="thirdDepth"><a href="/contents/community/ReportList?menu_id=10189">신고내역 관리</a></li>
								<li  class="thirdDepth"><a href="/contents/community/banKeywordList?menu_id=10190">금칙어 관리</a></li>
								</li>
							</ul>	
						</ul>
						</div>
					<button class="close" id="btn_closemap">닫기</button>
				</div>
			</div>
				
			<div class="promoCardOrd_layer" style="display:none;" id="promoCardOrd_layer">
				<div class="promoCardOrd_header">
					<h1 class="header">진행중인 프로모션 주문현황</h1>
				</div>
				<table id="tpromoCardOrd_layer">
					<tr>
						<td>일자</td>
						<td>PC/모바일/앱</td>
						<td>총 주문금액</td>
						<td>주문건수</td>
						<td>pg명</td>
						<td>카드명</td>
					</tr>
				</table>
					<button class="close" id="btn_closePromoCardOrd">닫기</button>
				</div>
			</div>				
	
		<!-- //header -->
	
		<!-- contneiner -->
		<div id="contneiner">
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
			<!-- lnb -->
			<div id="lnb">
				<div class="inb_area">
					<div class="inb_tab tab">
						<ul>
							<li><a href="#authority" class="on">권한메뉴</a></li>
							<li><a href="#bookmark">즐겨찾기</a></li>
						</ul>
					</div>
					<div class="inb_wrap">
						<div class="admin_menu inb_con active" id="authority">
							<ul>
							
							
							
							
							<!-- 여기부터 LNB메뉴 -->
							<li class="firstDepth"><a href="#" class="admin">문서 관리<span></span></a></li>
							<li class="secondDepthArea" style="display:none;">
								<ul class="admin_wrap">
									<li class="secondDepth"><a href="/document/notice?menu_id=10011">공지안내</a></li>
									<li class="secondDepth"><a href="/document/send?menu_id=10011">문서발송</a></li>
									<li class="secondDepth"><a href="/document/receive?menu_id=10011">받은문서</a></li>
									<li class="secondDepth"><a href="/document/sent?menu_id=10011">보낸문서</a></li>
									<li class="secondDepth"><a href="/document/storage?menu_id=10011">보관문서</a></li>
									<li class="secondDepth"><a href="/document/manual?menu_id=10011">메뉴얼</a></li>
									<li class="secondDepth"><a href="/document/form?menu_id=10011">업무서식</a></li>
									<li class="secondDepth"><a href="/document/preferences?menu_id=10011">환경설정</a></li>
									<li class="thirdDepthArea" style="display:none;">
								 		<ul>
											<li class="thirdDepth"><a href="/product/option/productOptionList?menu_id=10125">설정1</a></li>
											<li class="thirdDepth"><a href="/product/product/productList?menu_id=10014">설정2</a></li>
										</ul>
									</li>
								</ul>
							</li>
							<li class="firstDepth"><a href="#" class="admin">무역대금<span></span></a></li>
							<li class="secondDepthArea" style="display:none;">
								<ul class="admin_wrap">
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">도착현황</a></li>
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">발송현황</a></li>
								</ul>
							</li>
							
							<li class="firstDepth"><a href="#" class="admin">회원 관리<span></span></a></li>
							<li class="secondDepthArea" style="display:none;">
								<ul class="admin_wrap">
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">회원현황</a></li>
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">협력업체</a></li>
								</ul>
							</li>
							<li class="firstDepth"><a href="#" class="admin">지사 관리<span></span></a></li>
							<li class="secondDepthArea" style="display:none;">
								<ul class="admin_wrap">
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">등록현황</a></li>
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">신청현황</a></li>
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">심사현황</a></li>
								</ul>
							</li>
							<li class="firstDepth"><a href="#" class="admin">지역 관리<span></span></a></li>
							<li class="secondDepthArea" style="display:none;">
								<ul class="admin_wrap">
									<li class="secondDepth"><a href="/region/region?menu_id=10011">지역관리</a></li>
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">지역수정</a></li>
								</ul>
							</li>
							<li class="firstDepth"><a href="#" class="admin">통관 관리<span></span></a></li>
							<li class="secondDepthArea" style="display:none;">
								<ul class="admin_wrap">
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">코드관리</a></li>
								</ul>
							</li>
							<li class="firstDepth"><a href="#" class="admin">재무관리<span></span></a></li>
							<li class="secondDepthArea" style="display:none;">
								<ul class="admin_wrap">
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">관리비용</a></li>
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">지사정산</a></li>
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">환율정보</a></li>
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">환율등록</a></li>
								</ul>
							</li>
							<li class="firstDepth"><a href="#" class="admin">협력관리<span></span></a></li>
							<li class="secondDepthArea" style="display:none;">
								<ul class="admin_wrap">
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">무역회사</a></li>
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">운송회사</a></li>
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">통관회사</a></li>
								</ul>
							</li>
							<li class="firstDepth"><a href="#" class="admin">정보관리<span></span></a></li>
							<li class="secondDepthArea" style="display:none;">
								<ul class="admin_wrap">
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">용호관리</a></li>
									<li class="secondDepth"><a href="/member/member/memberList?menu_id=10011">권한관리</a></li>
								</ul>
							</li>

							<li class="firstDepth"><a href="#" class="admin">시스템관리<span></span></a></li>
							<li class="secondDepthArea" style="display:none;">
								<ul class="admin_wrap">
									<li class="secondDepth"><a href="?menu_id=10067">코드 관리</a></li>
									<li class="thirdDepthArea" style="display:none;">
								 		<ul>
											<li class="thirdDepth"><a href="/system/code/systemCodeList?menu_id=10068">시스템 코드 관리</a></li>
										</ul>
									</li>
									<li class="secondDepth"><a href="/system/menu/menuList?menu_id=10070">메뉴 관리</a></li>
									<li class="thirdDepthArea" style="display:none;">
								 		<ul>
											<li class="thirdDepth"><a href="/system/menu/menuList?menu_id=10145">메뉴 관리</a></li>
											<li class="thirdDepth"><a href="/system/menu/menuHistoryList?menu_id=10146">메뉴 권한변경 로그 관리</a></li>
										</ul>
									</li>
									<li class="secondDepth"><a href="?menu_id=10071">운영자 관리</a></li>
									<li class="thirdDepthArea" style="display:none;">
								 		<ul>
											<li class="thirdDepth"><a href="/system/staff/staffList?menu_id=10072">운영자 리스트</a></li>
											<li class="thirdDepth"><a href="/system/staff/staffLogList?menu_id=10073">운영자 접속 로그 조회</a></li>
											<li class="thirdDepth"><a href="/system/staff/loginHistoryList?menu_id=10080">로그인 기록관리</a></li>
											<li class="thirdDepth"><a href="/system/staff/personalInfoHistoryList?menu_id=10081">개인정보 처리 기록 관리</a></li>
											<li class="thirdDepth"><a href="/system/staff/staffHistoryList?menu_id=10083">운영자 기록 관리</a></li>
										</ul>
									</li>
									<li class="secondDepth"><a href="?menu_id=10074">권한 그룹 관리</a></li>
									<li class="thirdDepthArea" style="display:none;">
								 		<ul>
											<li class="thirdDepth"><a href="/system/auth/groupAuthList?menu_id=10075">권한 그룹 리스트</a></li>
										</ul>
									</li>
								</ul>
							</li>								
								

							</ul>
							<!-- 여기까지 LNB메뉴 -->
	
	
							<div class="admin_notice">
								<h2 class="tit">관리자 공지사항</h2>
								<ul>
									<li><a href="#"><span class="subject">시스템이 오픈 하였 시스템이 오픈 하였</span></a><span class="date">06-14</span></li>
									<li><a href="#"><span class="subject">시스템이 오픈 하였 시스템이 오픈 하였</span></a><span class="date">06-14</span></li>
									<li><a href="#"><span class="subject">시스템이 오픈 하였 시스템이 오픈 하였</span></a><span class="date">06-14</span></li>
								</ul>
							</div>
							
							<span class="alim asterisk">Golfing Shopping 시스템은 1280x1024해상도에 최적화 되어 있습니다...</span>
						</div>
						
						<div class="favorites_menu">
							<div class="favorites inb_con" id="bookmark">
								<div class="favorites_wrap">
									<ul class="bullet_f6" id="bookmark_info">
									</ul>
								</div>
							</div>
						</div>
						
					</div>
				</div>
				<span class="inb_close" style="position:absolute;"><a href="#" class="hidden">close</a></span>
			</div>
			<!-- //lnb -->
	
				<!-- contenst -->
				<div id="contents">
				
				
					<div class="con_area">
						<div class="content_tab" style="line-height:28px;">
							<div class="tab_menu fixed mainFrame"><a href="#"><span>Home</span><span class="menu_close"></span></a></div>
						</div>
						<div class="contentsFrames">
							<iframe src="" name="mainframe" width="100%" height="3000px" scrolling="no" frameborder="0" class="mainFrame" ></iframe>
							<div id="new_notice" class="ui-widget-content ui-corner-all marginTop" style="text-align:center;">
								<h3 class="ui-widget-header ui-corner-all">새로운 공지글이 있습니다.</h3>
							</div>
							<div id="loddingBar" class="marginTop_200 loddingBar" style="text-align:center; ">
								<h3 class="ui-widget-header ui-corner-all">데이터를 불러오고 있습니다.</h3>
							</div>
						</div>
					</div>
				</div>			
				<!-- //contents -->
		</div>
		<!-- //contneiner -->
	
	<!-- 비밀번호변경 -->
	<div class="lypopWrap lypop_imgUp" style="display:none" id="pswChangLayerPop">
		<!-- header -->
		<div class="header">
			<h3>비밀번호 변경</h3>
			<p class="btnR">
				<button type="button" class="sky" id="save_staffpwd">저장</button>
				<button type="button" class="gray" id="close_changepwd">닫기</button>
			</p>
		</div>
		<!-- //header -->
		<!-- contents -->
		<div class="contents">
			<!-- 본문 -->
			<form method="post" action="" id="changepwd_form" name="changepwd_form">
			<input type="hidden" id="system_gubun" name="system_gubun" value="admin" />
				<fieldset>
					<legend>입력폼 양식</legend>
					<div class="lypop_tbl_wrap">
					<table cellspacing="0" cellpadding="0" summary="" class="lypop_tbl">
					<caption>비밀번호 변경</caption>
						<colgroup>
							<col width="50%" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span class="starMark">필수입력 항목입니다.</span>변경전 비밀번호</th>
								<td><input type="password" id="passwd_txt1" class="wid35"  name="passwd_txt" /></td>
							</tr>					
							<tr>
								<th scope="row"><span class="starMark">필수입력 항목입니다.</span>새 비밀번호</th>
								<td><input type="password" id="passwd_txt_new1" class="wid35"  name="passwd_txt_new" /></td>
							</tr>					
							<tr>
								<th scope="row"><span class="starMark">필수입력 항목입니다.</span>새 비밀번호 확인</th>
								<td><input type="password" id="passwd_txt_renew1" class="wid35"  name="passwd_txt_renew" /></td>
							</tr>					
						</tbody>
					</table>
					</div>
				</fieldset>
			</form>
			<!-- //본문 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //비밀번호변경 -->
	
	
	<div class="lypopWrap lypop_bnimg" style="display:none" id="staffInfoLayerPop" >
		<!-- header -->
		<div class="header">
			<h3>계정정보 수정</h3>
			<p class="btnR">
				<button type="button" class="sky" id="save_staffinfo">저장</button>
				<a href="#" class="gray" id="close_staffinfo">닫기</a>
			</p>
		</div>
		<!-- //header -->
		<!-- contents -->
		<div class="contents">
			<!-- 본문 -->
			<form method="post" action="" id="staffinfo_form">
				<fieldset>
					<legend>입력폼 양식</legend>
					<div class="lypop_tbl_wrap infoadd">
					
					
					
					
					<table cellspacing="0" cellpadding="0" summary="" class="lypop_tbl">
					<caption>계정정보 수정</caption>
						<colgroup>
							<col width="20%" />
							<col width="30%" />
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">운영자번호</th>
								<td>10582</td>
								<th scope="row">운영자명</th>
								<td>김**</td>
							</tr>					
							<tr>
								<th scope="row">로그인아이디</th>
								<td>alexkr230</td>
								<th scope="row"><span class="starMark">필수입력 항목입니다.</span>비밀번호</th>
								<td><button class="btn_gray" id="btn_changepwd">비밀번호변경</button></td>
							</tr>					
							<tr>
								<th scope="row">운영자구분</th>
								<td></td>
								<th scope="row">소속(업체명)</th>
								<td></td>
							</tr>
							<tr>
								<th scope="row"><span class="starMark">필수입력 항목입니다.</span>전화번호</th>
								<td><input type="text" id="tel_txt" class="wid55 first"  name="tel_txt" value="02-0000-0000"/></td>
								<th scope="row"><span class="starMark">필수입력 항목입니다.</span>이메일</th>
								<td><input type="text" id="email_txt" class="wid55" name="email_txt" value="*****@***.***" /></td>
							</tr>
						</tbody>
					</table>
					
					<div style="text-align:left; padding:5px;">* 로그인 시 인증할 전화번호를 추가하세요. ('-'제외, 숫자만 입력하세요.)</div>
					
					<table cellspacing="0" cellpadding="0" summary="" class="lypop_tbl">
					<caption>계정정보 수정</caption>
						<colgroup>
							<col width="20%" />
							<col width="30%" />
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">전화번호1</th>
								<td><input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" id="arr_mobil_txt1" class="wid55 first"  name="arr_mobil_txt" value="" /></td>
								<th scope="row">비고</th>
								<td><input type="text" id="arr_staff_nm1" class="wid55" name="arr_staff_nm" value="" /></td>
							</tr>
							<input type="hidden" name="arr_seq" value="1" />
							<tr>
								<th scope="row">전화번호2</th>
								<td><input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" id="arr_mobil_txt2" class="wid55 first"  name="arr_mobil_txt" value="" /></td>
								<th scope="row">비고</th>
								<td><input type="text" id="arr_staff_nm2" class="wid55" name="arr_staff_nm" value="" /></td>
							</tr>
							<input type="hidden" name="arr_seq" value="2" />
							<tr>
								<th scope="row">전화번호3</th>
								<td><input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" id="arr_mobil_txt3" class="wid55 first"  name="arr_mobil_txt" value="" /></td>
								<th scope="row">비고</th>
								<td><input type="text" id="arr_staff_nm3" class="wid55" name="arr_staff_nm" value="" /></td>
							</tr>
							<input type="hidden" name="arr_seq" value="3" />
							<tr>
								<th scope="row">전화번호4</th>
								<td><input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" id="arr_mobil_txt4" class="wid55 first"  name="arr_mobil_txt" value="" /></td>
								<th scope="row">비고</th>
								<td><input type="text" id="arr_staff_nm4" class="wid55" name="arr_staff_nm" value="" /></td>
							</tr>
							<input type="hidden" name="arr_seq" value="4" />
							<tr>
								<th scope="row">전화번호5</th>
								<td><input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" id="arr_mobil_txt5" class="wid55 first"  name="arr_mobil_txt" value="" /></td>
								<th scope="row">비고</th>
								<td><input type="text" id="arr_staff_nm5" class="wid55" name="arr_staff_nm" value="" /></td>
							</tr>
							<input type="hidden" name="arr_seq" value="5" />
							</tbody>
					</table>			
					<table cellspacing="0" cellpadding="0" summary="" class="lypop_tbl">
					<caption>비고</caption>
						<colgroup>
							<col width="20%" />
							<col width="30%" />
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">비고</th>
								<td colspan="3">
									<textarea name="comment_txt" id="comment_txt" rows="5"  class="tarea_mapInfo" ></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					
					
					
					</div>
				</fieldset>
			</form>
			<!-- //본문 -->
		</div>
		<!-- //contents -->
	</div>
	
	<!-- 유효기간 만료로 인한 비밀번호 변경 -->
	<div class="lypopWrap lypop_bnimg" style="display:none" id="pwdExpiredLayer">
		<!-- header -->
		<div class="header">
			<h3>비밀번호를 변경 해주세요</h3>
		</div>
		<!-- //header -->
		<!-- contents -->
		<div class="contents">
			<p id="pwdChange"></p>
			<!-- 본문 -->
			<form method="post" action="" id="pwdExpired_form" name="pwdExpired_form">
			<input type="hidden" id="system_gubun" name="system_gubun" value="admin" />
				<fieldset>
					<legend>입력폼 양식</legend>
					<div class="lypop_tbl_wrap">
					<table cellspacing="0" cellpadding="0" summary="" class="lypop_tbl">
					<caption>비밀번호 변경</caption>
						<colgroup>
							<col width="50%" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span class="starMark">필수입력 항목입니다.</span>현재 비밀번호</th>
								<td><input type="password" id="passwd_txt2" class="wid35"  name="passwd_txt" /></td>
							</tr>					
							<tr>
								<th scope="row"><span class="starMark">필수입력 항목입니다.</span>새 비밀번호</th>
								<td><input type="password" id="passwd_txt_new2" class="wid35"  name="passwd_txt_new" /></td>
							</tr>					
							<tr>
								<th scope="row"><span class="starMark">필수입력 항목입니다.</span>새 비밀번호 확인</th>
								<td><input type="password" id="passwd_txt_renew2" class="wid35"  name="passwd_txt_renew" /></td>
							</tr>					
						</tbody>
					</table>
					</div>
				</fieldset>
			</form>
			<br/>
			<p class="btnR">
				<button type="button" class="sky" id="pwd_save">확인</button>
				<button type="button" class="gray" id="pwd_reset">다시입력</button>
			</p>
			<!-- //본문 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //비밀번호변경 -->	
	
	<!--  즐겨찾기 수정 -->
	<div class="favDiv" style="display:none" id="favDiv" >
		<div class="facHeader">
			<h3>즐겨찾기 수정</h3>
		</div>
		<div class="btnArea">
			<button type="button" id="btnfavsave">저장</button>
			<button type="button" id="btnfavdel">삭제</button>
			<button type="button" id="btnfavclose">닫기</button>
		</div>
	
		<!-- grid 영역 -->
	
		<div  class="grid" id="parentDiv" >
			<table id="list1"></table>
		</div>
	
		<!-- grid 영역 -->
	</div>
		
	<div style="display:none">
		<li class="secondDepth" id="memberSearch"></li>
		<li class="thirdDepth" id="orderSearch"></li>
		<li class="secondDepth" id="goodSearch"></li>
		<li class="thirdDepth" id="goodReg"></li>
		<li class="thirdDepth" id="delayList"></li>
		<li class="thirdDepth" id="claimList"></li>	
		<li class="thirdDepth" id="planList"></li>	
		<li class="secondDepth" id="couponList"></li>	
	</div>
	
		<!-- footer -->
		<div id="footer">
	
		</div>
		<!-- //footer -->
	
	</div>

<div id="toast"></div></body>
</html>