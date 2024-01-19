<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>IL system</title>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-control" content="No-cache" />
<meta http-equiv="Pragma" content="No-cache" />
<meta name="Description" content="" />
<meta name="Keywords" content="" />

<%@include file="/common/include/header.jsp"%>

<style type="text/css">
#ntcList {
	table-layout: fixed; /*테이블 내에서 <td>의 넓이,높이를 고정한다.*/
}
#ntcList td {
    width:100%; /* width값을 주어야 ...(말줄임)가 적용된다. */
    overflow: hidden;
    text-overflow:ellipsis; /*overflow: hidden; 속성과 같이 써줘야 말줄임 기능이 적용된다.*/
    white-space:nowrap; /*<td>보다 내용이 길경우 줄바꿈 되는것을 막아준다.*/
}

#tpromoCardOrd_layer {
		border: 1px solid #444444;
		border-collapse: collapse;
		width: 800px;
		margin-left: auto;
		margin-right: auto;
		font-family: 나눔고딕,NanumGothic,돋움,Dotum;
	}
#tpromoCardOrd_layer	th, td {
		border-bottom: 1px solid #444444;
		padding: 5px;
		text-align:center;
		font-size:15px;
	}    
</style>

<script type="text/javascript" src="/common/js/menu_khj.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		
		$("#pwdExpiredLayer").hide();
		$("#staffInfoLayerPop").hide();
		$("#pswChangLayerPop").hide();
		$("#sitemap_layer").hide();
		$("#favDiv").hide();

		<c:if test="${empty promoCardOrdList}">
			$("#promoCardOrd_layer").hide();
		</c:if>
				
		var lastid;
		
		// 공지사항
		setNoticeEventHandler();

		//테스트
		//window.open('/board/notice/mainNoticeDetail.do?mode=pop&id=0', '_blank', 'width=750, height=800, scrollbars=yes, status=no');
		
		// 비밀번호 만료 여부 조회
// 		$.ajax({
// 			type: "get",
// 			url: "/system/staff/staffPasswordExpired.do",
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
// 		        	top.document.location.href = "/sessionInvalid.jsp";
// 		        } else {
// 		        	toast("팝업 불러오기 실패" + " " + textStatus)
// 		        }
// 			}
// 		});
	
		$("#btn_logout").click(function(event) {
			if(confirm("로그아웃 하시겠습니까?")){
				$.ajax({
					type: "POST",
					url: "/member/login/logout.do",
					data: '',
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						$(location).attr("href", "/member/login/login.do"); 
	
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
			saveGridSelected("list1", 'selected', 'save', "/updateBookmarkGridJson.do");
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
			saveGridSelected("list1", 'selected', 'delete', "/deleteBookmarkGridJson.do");
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
							toast(data.msg);
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
					  var loginId = '<c:out escapeXml="false" value="${sessionScope['STAFFINFORMATION']['login_id']}" />';
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
					url: "/system/staff/updateStaffPwdJson.do",
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
				url: "/getBookmarkListJson.do",
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
			$('#sitemap_layer').show();
			$('#promoCardOrd_layer').hide();
			
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
	        	link_html = '<a href="/delivery/delivery/deliveryList.do?menu_id=10044&ord_no='+ $("#hearder_search_txt").val() +'">주문/배송 리스트</a>';
	        	$("#orderSearch").html(link_html);
	    		$("#orderSearch").trigger('click');

	    		var $tabMenus = $('.content_tab .tab_menu');
	        	for(var i=0; i<$tabMenus.length; i++){
	        		if($tabMenus[i]['menuName'] == $("#orderSearch").find('a').text() ){
	        			$($tabMenus[i]['contentsFrame']).attr('src', '/delivery/delivery/deliveryList.do?menu_id=10044&ord_no='+ $("#hearder_search_txt").val());
	        			return;
	        		}
	        	}
	    	
	    	}else if($("#hearer_search_typ").val() == "2"){
	    		if($("#hearder_search_txt").val() == ""){
	    			toast("상품번호를 입력해 주세요")
	    			return;
	    		}
	        	link_html = '<a href="/product/product/productList.do?menu_id=10013&good_no='+ $("#hearder_search_txt").val() +'">상품리스트</a>';
	        	$("#goodSearch").html(link_html);
	    		$("#goodSearch").trigger('click');
	    		
	        	var $tabMenus = $('.content_tab .tab_menu');
	        	for(var i=0; i<$tabMenus.length; i++){
	        		if($tabMenus[i]['menuName'] == $("#goodSearch").find('a').text() ){
	        			$($tabMenus[i]['contentsFrame']).attr('src', '/product/product/productList.do?menu_id=10013&good_no='+ $("#hearder_search_txt").val());
	        			return;
	        		}
	        	}
	    		
	    	}else if($("#hearer_search_typ").val() == "3"){
	    		if($("#hearder_search_txt").val() == ""){
	    			toast("회원번호를 입력해 주세요")
	    			return;
	    		}
	        	link_html = '<a href="/member/member/memberList.do?menu_id=10011&search_txt='+ $("#hearder_search_txt").val() +'+">회원 정보 조회</a>';
	        	$("#memberSearch").html(link_html);
	    		$("#memberSearch").trigger('click');

	        	var $tabMenus = $('.content_tab .tab_menu');
	        	for(var i=0; i<$tabMenus.length; i++){
	        		if($tabMenus[i]['menuName'] == $("#memberSearch").find('a').text() ){
	        			$($tabMenus[i]['contentsFrame']).attr('src', '/member/member/memberList.do?menu_id=10011&search_txt='+ $("#hearder_search_txt").val());
	        			return;
	        		}
	        	}
	    	}
	    	return;
		});
		
		jQuery("#list1").jqGrid({
			url:'/getBookmarkListJson.do', 		  
			datatype: "json",				   
	//		datatype: "local",				   
			colNames:['메뉴ID','메뉴명', '우선순위'],
			colModel:[
				{	name:'menu_id'	, index:'menu_id'	, width:100	, align:"center"	, editable:false	, hidden:true	},
				{	name:'menu_nm'	, index:'menu_nm'	, width:340	, align:"center"	, editable:false	},
				{	name:'sort_seq'	, index:'sort_seq'	, width:100	, align:"center"	, editable:true	, editrules:{required:true,number:true}	}
			],
			mtype:"post",
			autowidth: true,	// 부모 객체의 width를 따른다
			width : 500,
			height: 250,
			pager: '#pager1',
			sortname: 'id',
		    viewrecords: true,
		    sortorder: "desc",				    
		    multiselect : true,
		    cellEdit : true,
			cellsubmit : 'clientArray',
			gridview: true,
			shrinkToFit:false,
			// 서버에러시 처리
			loadError : function(xhr,st,err) {
				girdLoadError();
		    },				    
		    // 데이터 로드 완료 후 처리 
		    loadComplete: function(data) {	
		    	//setSortingGridData(this, data);
		    }, 
		    // cell이 변경되었을 경우 처리
		    afterSaveCell : function(id, name, val, iRow, iCol) {
		    	checkWhenColumnUpdated("list1", id);
		    },			
		    onSelectRow: function(id){           //jqGrid의 row를 선택했을 때 이벤트 발생
		        if( lastid != id ){
		         jQuery("#list1").jqGrid('restoreRow',lastid,true);    //해당 row 가 수정모드에서 뷰모드(?)로 변경
		         jQuery("#list1").jqGrid('editRow',id,false);  //해당 row가 수정모드(?)로 변경
	
		         lastid = id;
		        }
			 },
			 onCellSelect : function(rowid,cindex,cellcontent,e){   
				//toast(rowid + "||" + cindex + "||" + cellcontent + "||" + e ) ;
				 
			 }	
		});
	
		// 즐겨찾기 첫번째 메뉴를 최초 접속시 띄워준다.(내부관리자용)
		<c:if test="${sessionScope['STAFFINFORMATION']['system_gubun'] ne 'scm'}">
			$("#fav_index_0").trigger('click');
		</c:if>	  
		 
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
				url: "/deleteBookmarkJson.do?menu_id="+menu_id,
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
						window.open('/board/notice/mainNoticeDetail.do?mode=pop&id=' + data.popArry[loop].noticebbs_no, 
					 			'popup_page' + loop, 'width=750, height=800, scrollbars=yes, status=no');
					}
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				if (jqXHR.status == 403) {
		        	top.document.location.href = "/sessionInvalid.jsp";
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
			CenterOpenWindow("/board/notice/mainNoticeDetail.do" + params, "_blank", width, 
					height, "scrollbars=yes, status=no");
		});
		// 공지사항이 없을 경우
		<c:if test="${empty ntcList}">
			$(".admin_notice").hide();
		</c:if>
		
		<c:if test="${sessionScope['STAFFINFORMATION']['system_gubun'] eq 'scm'}">
			$('.contentsFrames iframe').attr('src', '/scmmain.do');
		</c:if>
		<c:if test="${sessionScope['STAFFINFORMATION']['system_gubun'] ne 'scm'}">
			//$('.mainFrame').hide();
		</c:if>
	}
	
	// 상품리스트에서 신규등록클릭시
	function productReg() {
    	var link_html = "";
    	link_html = '<a href="/product/product/productDetail.do">상품 등록</a>';
    	$("#goodReg").html(link_html);
		$("#goodReg").trigger('click');
	}
	
	// 배송상태별 주문 리스트 이동
	// 출고지시 : 12403, 상품준비중 : 12404, 발송완료 : 12405
	function order_link(deli_status_cd) {
		toast(deli_status_cd);
    	alink_html = '<a href="/delivery/delivery/deliveryList.do?menu_id=10044&deli_status_cd='+ deli_status_cd+'">주문 배송 현황</a>';
    	$("#orderSearch").html(alink_html);
		$("#orderSearch").trigger('click');
	}
	// 발송지연 화면으로 이동
	function delayList_link(){
    	link_html = '<a href="/delivery/delivery/deliveryDelayList.do?menu_id=10045&deli_status_cd=Y">배송 지연 리스트</a>';
    	$("#delayList").html(link_html);
		$("#delayList").trigger('click');
	}
	// 클레임 리스트 화면으로 이동
	// 취소 : 2, 반품 : 3, 교환 : 4
	// claim_status_cd 반품:13703, 교환:13703
	function claimList_link(claim_status_cd,claim_typ){
    	link_html = '<a href="/claim/claim/claimList.do?menu_id=10047&claim_status_cd='+ claim_status_cd + '&claim_typ=' + claim_typ +'">클레임 리스트</a>';
    	$("#claimList").html(link_html);
		$("#claimList").trigger('click');
	}
	// 상품 리스트 화면으로 이동 _ 승인상태별
	// 승인대기 : 10601, 승인반려 : 10603
	function goodList1_link(aproval_typ_cd){
    	link_html = '<a href="/product/product/productList.do?menu_id=10013&aproval_typ_cd='+ aproval_typ_cd +'&reg_st_dt=">상품리스트</a>';
    	$("#goodSearch").html(link_html);
		$("#goodSearch").trigger('click');
	}
	// 상품 리스트 화면으로 이동 _ 판매상태별
	// 판매중 : 10501, 품절 : 10503, 판매종료 : 10504
	function goodList2_link(sell_st_cd){
    	link_html = '<a href="/product/product/productList.do?menu_id=10013&sell_st_cd='+ sell_st_cd +'">상품리스트</a>';
    	$("#goodSearch").html(link_html);
		$("#goodSearch").trigger('click');
	}
	// 기획전 리스트 화면으로 이동 _승인상태별
	// 승인대기 : 10601, 승인반려 : 10603
    function planList1_link(approve_cd){
    	link_html = '<a href="/exhibition/plan/exhibitionList.do?menu_id=10030&approve_cd='+ approve_cd +'">기획전 리스트</a>';
    	$("#planList").html(link_html);
		$("#planList").trigger('click');
	}
	// 기획전 리스트 화면으로 이동 _상태별
	// 진행중 : 2
    function planList2_link(plan_st_typ){
    	link_html = '<a href="/exhibition/plan/exhibitionList.do?menu_id=10030&plan_st_typ='+ plan_st_typ +'">기획전 리스트</a>';
    	$("#planList").html(link_html);
		$("#planList").trigger('click');
	}
	// 행사 리스트 화면으로 이동 _ 승인상태별
	//승인대기 : 1, 승인반려 : 3
	function couponList1_link(search_approve_cd){
    	link_html = '<a href="/promotion/coupon/couponList.do?menu_id=10036&search_approve_cd='+ search_approve_cd +'">쿠폰 행사 관리</a>';
    	$("#couponList").html(link_html);
		$("#couponList").trigger('click');
	}
	// 행사 리스트 화면으로 이동 _ 상태별
	//정상 : 1
	function couponList2_link(search_evn_st_typ){
    	link_html = '<a href="/promotion/coupon/couponList.do?menu_id=10036&search_evn_st_typ='+ search_evn_st_typ +'">쿠폰 행사 관리</a>';
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
				<h1 class="logo" style="cursor:pointer;"><a href="/home" style="display:none;">Home</a></h1>
				<div class="search-area">
				</div>
				<div class="logoin">
					<!-- span class="name">우수업체 <span>홍길동</span>님 안녕하세요</span-->

					<span class="name">
						
						<c:if test="${userInfo.staff_typ eq '1'}">시스템관리자</c:if>
						<c:if test="${userInfo.staff_typ eq '2'}">[${userInfo.vendor_nm}]지사</c:if>
						<c:if test="${userInfo.staff_typ eq '3'}">[${userInfo.vendor_nm}]</c:if>
						<span> ${userInfo.staff_nm}</span> 님 안녕하세요
					</span>
					<a href="#" id="btn_updatestaff">개인정보수정</a>
					<a href="#" id="btn_favorite">즐겨찾기수정</a>
					<a href="#" id="btn_logout">로그아웃</a>
					<a href="#"><span class="sitemap" id="btn_sitemap">사이트맵</span></a>
				</div>
				
				<div>
					<a href="/system/tms/tmsStatus" target="_blank" style="color:#ffffff; font-weight:bold;"> 프로그램게시판 바로가기>> </a>
				</div>
	
			</div>
	
			<div class="sitemap_layer" id="sitemap_layer">
				<div class="sitemap_header">
					<h1 class="header">Site map</h1>
				</div>
				<c:set var="TOP_CNT" value="0" />
				
				<c:forEach items="${_LIST}" var="_TOP" varStatus="j">
					<c:if test="${_TOP.LVL eq '1' }">
						<c:if test="${TOP_CNT%5 == 0}">
							<div class="sitemap_wrap">
						</c:if>
							<div class="sitemap_area">
								<h2 class="tit"><c:out value="${_TOP.MENU_NM}"/></h2>
					</c:if>
					<c:set var="L2_CNT" value="0" />
					<c:forEach items="${_LIST}" var="_LEFT" varStatus="k">
						<c:if test="${_LEFT.LVL eq '2' && _LEFT.UPMENU_ID eq _TOP.MENU_ID }">
							<c:if test="${L2_CNT == 0}">
									<ul class="sitemap_txt">
									<c:set var="L2_CNT" value="${L2_CNT+1}" />
							</c:if>
										<li class="secondDepth"><a href="<c:out value='${_LEFT.MENUURL_TXT}'/>${fn:indexOf(_LEFT.MENUURL_TXT,"?")<0?"?":"&"}menu_id=<c:out value="${_LEFT.MENU_ID}"/>"><c:out value="${_LEFT.MENU_NM}"/></a>
						</c:if>
						<c:if test="${_LEFT.LVL eq '2' && _LEFT.CNT eq '0' && _LEFT.UPMENU_ID eq _TOP.MENU_ID }">
									</li>
						</c:if>
				
				
						<c:if test="${_LEFT.LVL eq '2' && _LEFT.CNT ne '0' && _LEFT.UPMENU_ID eq _TOP.MENU_ID }">
							<c:set var="L3_CNT" value="0" />
							<c:forEach items="${_LIST}" var="_SUB" varStatus="i">	
								<c:if test="${L3_CNT == 0}">
										<ul>
										<c:set var="L3_CNT" value="${L3_CNT+1}" />
								</c:if>
								<c:if test="${_SUB.LVL eq '3' && _SUB.UPMENU_ID eq _LEFT.MENU_ID}">
									<li  class="thirdDepth"><a href="<c:out value="${_SUB.MENUURL_TXT}"/>${fn:indexOf(_SUB.MENUURL_TXT,"?")<0?"?":"&"}menu_id=<c:out value="${_SUB.MENU_ID}"/>"><c:out value="${_SUB.MENU_NM}"/></a></li>
								</c:if>
							</c:forEach>					
								</li>
							</ul>	
						</c:if>	
						
						
												
					</c:forEach>				
	
					<c:if test="${_TOP.LVL eq '1' }">
							</ul>
						</div>
					</c:if>
	
					<c:if test="${_TOP.LVL eq '1' }">
						<c:if test="${TOP_CNT%5 == 4}">
							</div>
						</c:if>
						<c:set var="TOP_CNT" value="${TOP_CNT+1}" />
					</c:if>
					
				</c:forEach>
					<button class="close" id="btn_closemap">닫기</button>
				</div>
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
							
							
							
						<c:forEach items="${_LIST}" var="_TOP" varStatus="j">
							<c:if test="${_TOP.LVL eq '1' }">
								<li class="firstDepth"><a href="#" class="admin"><c:out value="${_TOP.MENU_NM}"/><span></span></a></li>
								<li class="secondDepthArea" style="display:none;">
							</c:if>	
							<c:forEach items="${_LIST}" var="_LEFT" varStatus="k">
								<c:if test="${_LEFT.LVL eq '2' && _LEFT.UPMENU_ID eq _TOP.MENU_ID }">		
									<ul class="admin_wrap">
										<li class="secondDepth"><a href="<c:out value='${_LEFT.MENUURL_TXT}'/>${fn:indexOf(_LEFT.MENUURL_TXT,"?")<0?"?":"&"}menu_id=<c:out value="${_LEFT.MENU_ID}"/>"><c:out value="${_LEFT.MENU_NM}"/></a></li>								
								</c:if>		
								<c:if test="${_LEFT.LVL eq '2' && _LEFT.CNT ne '0' && _LEFT.UPMENU_ID eq _TOP.MENU_ID }">							
										<li class="thirdDepthArea" style="display:none;">
											<ul>
										<c:forEach items="${_LIST}" var="_SUB" varStatus="i">	
											<c:if test="${_SUB.LVL eq '3' && _SUB.UPMENU_ID eq _LEFT.MENU_ID}">
												<li class="thirdDepth"><a href="<c:out value="${_SUB.MENUURL_TXT}"/>${fn:indexOf(_SUB.MENUURL_TXT,"?")<0?"?":"&"}menu_id=<c:out value="${_SUB.MENU_ID}"/>"><c:out value="${_SUB.MENU_NM}"/></a></li>
											</c:if>	
										</c:forEach>													
											</ul>
										</li>
								</c:if>		
								<c:if test="${_LEFT.LVL eq '2' && _LEFT.UPMENU_ID eq _TOP.MENU_ID }">
									</ul>								
								</c:if>	
							</c:forEach>
							<c:if test="${_TOP.LVL eq '1' }">
								</li>
							</c:if>		
						</c:forEach>							
							</ul>
	
							<div class="admin_notice">
								<h2 class="tit">관리자 공지사항</h2>
									<c:if test="${not empty ntcList}">
										<table id="ntcList">
											<colgroup>
												<col width="75%">
												<col width="25%">
											</colgroup>
											<c:set var="new_notice" value=""/> 
											<c:forEach items="${ntcList}" var="ntc">
													<tr>
														<td><a href="#" ntcNum="${ntc.noticebbs_no}" class="${ntc.new_notice}">· ${ntc.title_txt}</a></td>
														<td class="${ntc.new_notice}">${ntc.reg_dt}</td>
													</tr>
													<c:if test="${ntc.new_notice eq 'new_notice'}">
														<c:set var="new_notice" value="new_notice"/> 			
													</c:if>
													
											</c:forEach>
											<input type="hidden" id="new_notice_value" value="${new_notice}"/>
										</table>
									</c:if>
	<!-- 							<ul> -->
	<!-- 								<li><a href="#"><span class="subject">시스템이 오픈 하였 시스템이 오픈 하였</span></a><span class="date">06-14</span></li> -->
	<!-- 								<li><a href="#"><span class="subject">시스템이 오픈 하였 시스템이 오픈 하였</span></a><span class="date">06-14</span></li> -->
	<!-- 								<li><a href="#"><span class="subject">시스템이 오픈 하였 시스템이 오픈 하였</span></a><span class="date">06-14</span></li> -->
	<!-- 							</ul> -->
							</div>
							
							<span class="alim asterisk">시스템은 1280x1024해상도에 최적화 되어 있습니다...</span>
						</div>
						
						<div class="favorites_menu">
							<div class="favorites inb_con" id="bookmark">
								<div class="favorites_wrap">
									<ul class="bullet_f6" id="bookmark_info">
									<c:set var="fav_index" value="0" />
									<c:forEach items="${_BLIST}" var="_BINFO" varStatus="j">
										<li class="thirdDepth" id="fav_index_${fav_index}"><a href="<c:out value='${_BINFO.menuurl_txt}'/>${fn:indexOf(_BINFO.menu_txt,"?")<0?"?":"&"}menu_id=<c:out value="${_BINFO.menu_id}"/>"><c:out value="${_BINFO.menu_nm}"/></a></li>
										<c:set var="fav_index" value="${fav_index+1}" />
										<!-- a href="javascript:deleteBookmark('${_BINFO.menu_id}')">X</a-->
									</c:forEach>
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
							<iframe src="http://naver.com" name="mainframe" width="100%" height="3000px" scrolling="no" frameborder="0" class="mainFrame" ></iframe>
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
	<div class="lypopWrap lypop_imgUp" id="pswChangLayerPop">
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
			<input type="hidden" id="system_gubun" name="system_gubun" value="${sessionScope['STAFFINFORMATION']['system_gubun']}" />
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
	
	
	<div class="lypopWrap lypop_bnimg" id="staffInfoLayerPop" >
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
			<input type="hidden" name="login_id" id="login_id" value="${userInfo.login_id}" />
			
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
								<td>${userInfo.staff_id}</td>
								<th scope="row">운영자명</th>
								<td>${userInfo.staff_nm}</td>
							</tr>					
							<tr>
								<th scope="row">로그인아이디</th>
								<td>${userInfo.login_id}</td>
								<th scope="row"><span class="starMark">필수입력 항목입니다.</span>비밀번호</th>
								<td><button class="btn_gray" id="btn_changepwd">비밀번호변경</button></td>
							</tr>					
							<tr>
								<th scope="row">운영자구분</th>
								<td>
									<c:if test="${userInfo.staff_typ eq '1'}">시스템관리자</c:if>
									<c:if test="${userInfo.staff_typ eq '2'}">지사</c:if>
									<c:if test="${userInfo.staff_typ eq '3'}">고객사</c:if>
								</td>
								<th scope="row">소속(업체명)</th>
								<td><c:if test="${userInfo.vendor_nm != null}">${userInfo.vendor_nm}</c:if></td>
							</tr>
							<tr>
								<th scope="row"><span class="starMark">필수입력 항목입니다.</span>휴대폰번호</th>
								<td><input type="text" id="mobile_txt" class="wid55 first"  name="mobile_txt" value="${userInfo.mobile_txt}"/></td>
								<th scope="row"><span class="starMark">필수입력 항목입니다.</span>이메일</th>
								<td><input type="text" id="email_txt" class="wid55" name="email_txt" value="${userInfo.email_txt}" /></td>
							</tr>
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
									<textarea name="comment_txt" id="comment_txt" rows="5"  class="tarea_mapInfo" ><c:out value="${userInfo.comment_txt}"/></textarea>
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
	<div class="lypopWrap lypop_bnimg" id="pwdExpiredLayer">
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
			
			<input type="hidden" id="system_gubun" name="system_gubun" value="${sessionScope['STAFFINFORMATION']['system_gubun']}" />
			
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
	<div class="favDiv" id="favDiv" >
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