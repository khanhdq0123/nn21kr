<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />

<%-- design ui --%>
<link rel="stylesheet" type="text/css" href="/css/base.css" />
<link rel="stylesheet" type="text/css" href="/css/common.css" />
<link rel="stylesheet" type="text/css" href="/css/contents.css" />
<link rel="stylesheet" type="text/css" href="/css/addcss.css" />
<link rel="stylesheet" type="text/css" href="/css/font-awesome.css" />

<%-- jqGrid CSS --%>
<link rel="stylesheet" type="text/css" href="/common/jqgrid/themes/redmond/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="/common/jqgrid/themes/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="/common/jqgrid/themes/ui.multiselect.css" />

<%-- jQuery File Upload CSS --%>
<link rel="stylesheet" type="text/css" href="/common/fileupload/fileupload.css" />

<%-- jQuery --%>
<script type="text/javascript" src="/common/js/jquery-1.11.0.min.js"></script>
<%-- jQuery UI --%>
<script type="text/javascript" src="/common/js/jquery-ui-1.8.23.custom.min.js"></script>

<%-- jqGrid --%>
<script type="text/javascript" src="/common/jqgrid/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="/common/jqgrid/js/grid.locale-kr.js"></script>
<script type="text/javascript" src="/common/jqgrid/js/jquery.contextmenu.js"></script>
<script type="text/javascript" src="/common/jqgrid/js/jquery.tablednd.js"></script>
<script type="text/javascript" src="/common/jqgrid/js/ui.multiselect.js"></script>
<script type="text/javascript" src="/common/jqgrid/js/jquery.layout.js"></script>
<script type="text/javascript" src="/common/js/jqgrid-common.js"></script>

<%-- jQuery File Download --%>
<script type="text/javascript" src="/common/js/jquery.fileDownload.js"></script>

<%-- jQuery File Upload --%>
<script type="text/javascript" src="/common/fileupload/vendor/jquery.ui.widget.js"></script>
<script type="text/javascript" src="/common/fileupload/jquery.iframe-transport.js"></script>
<script type="text/javascript" src="/common/fileupload/jquery.fileupload.js"></script>

<%-- jQuery Validation --%>
<script type="text/javascript" src="/common/validation/jquery.validate.min.js"></script>
<script type="text/javascript" src="/common/validation/lib/jquery.mockjax.js"></script>
<script type="text/javascript" src="/common/validation/localization/messages_ko.js"></script>
<script type="text/javascript" src="/common/validation/jquery.ui.datepicker.validation.min.js"></script>

<%-- jQuery File Validation --%>
<script type="text/javascript" src="/common/validation/file/filesize.js"></script>

<%-- Json Utility --%>
<script type="text/javascript" src="/common/js/json2.js"></script>

<%-- Naver Smart Editor --%>
<script type="text/javascript" src="/common/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<%-- Spring Tags --%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%-- JSTL Tags --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<%-- File Image --%>
<script type="text/javascript" src="/common/js/jquery.filestyle.js"></script>

<%-- Layer Center --%>
<script type="text/javascript" src="/common/js/jquery.center.js"></script>

<%-- Element Resize Plugin --%>
<script type="text/javascript" src="/common/js/jquery.resize.min.js"></script>

<%-- DNS Information --%>
<script type="text/javascript">
<%
String jsUrl = request.getParameter("js_url");
%>
var screenId = '<%= request.getParameter("screen_id")%>';
var screenName = '<%= request.getParameter("menu_nm")%>';
var jsUrl = '<%=jsUrl%>';



/* 공통변수 */
var _staff_typ = "${sessionScope['STAFFINFORMATION']['staff_typ']}";
var _staff_id = "${sessionScope['STAFFINFORMATION']['staff_id']}";
var _vendor_no = "${sessionScope['STAFFINFORMATION']['vendor_no']}";	
var _vendor_nm = "${sessionScope['STAFFINFORMATION']['vendor_nm']}";	
var _vendor_enm = "${sessionScope['STAFFINFORMATION']['vendor_enm']}";
var _vendor_typ = "${sessionScope['STAFFINFORMATION']['vendor_typ']}";

var titVendorNm = "";

if(_staff_typ == 1){
	titVendorNm = "지사";
} else if(_staff_typ == 2){
	titVendorNm = "고객사";
}

/* ~공통변수 */






	//  ajax error 
	function ajaxError() {
		toast('서버에서 오류가 발생하였거나 네트워크에 문제가 있습니다.');
	}
	
	// jquery validation error
	function showValidationError(form, validator) {
		 var errors = validator.numberOfInvalids();
         if (errors) {
             toast(validator.errorList[0].message);
             validator.errorList[0].element.focus();
         }
	}
		
	$(document).ready(function () {
		
		$(".content_wrap .history .header").html(screenName + ' [' + screenId + ']');
		
		// 윈도우 Resize시 grid 넓이 변경
		$(window).bind('resize', function() {
		    resizeApp();
		}).trigger('resize');
		
		// 달력 형태 정의		
		$.datepicker.setDefaults({
			dateFormat : "yy-mm-dd",  
			showOn : "both",
			buttonImage : "/images/btn_calendar.gif",
			buttonImageOnly : true,  
			changeMonth : true,  // 월 변경이 가능한 좌우 화살표 키 추가
			changeYear : true,   // 년 변경이 가능한 좌우 화살표 키
		    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    dayNames: ['일','월','화','수','목','금','토'],
		    dayNamesShort: ['일','월','화','수','목','금','토'],
		    dayNamesMin: ['일','월','화','수','목','금','토']
	    });
		
		$(".datepicker").datepicker();	
		$(".datepicker2").datepicker();
		$(".datepicker3").datepicker();
		// .datepicker 클래스의 날짜를 오늘 날짜로 세팅
		<c:set var="now" value="<%=new java.util.Date()%>" />
		$(".datepicker").datepicker('setDate','<fmt:formatDate pattern="yyyy-MM-dd" value="${now}" />');
		$(".datepicker").parents('.calendar').parent().each(function (){
			if($(this).find('.datepicker').length == 2) {
				var fromDtObj = $(this).find('.datepicker').eq(0).attr('id');
				var toDtObj = $(this).find('.datepicker').eq(1).attr('id');
				
				setSearchDate(fromDtObj, toDtObj, 'weekago');
				
				$("#" + fromDtObj).prop('defaultValue', $("#" + fromDtObj).val());
				$("#" + toDtObj).prop('defaultValue', $("#" + toDtObj).val());
			}
		});
		// 기간을 오늘부터 오늘까지 추가
		$(".datepicker3").datepicker('setDate','<fmt:formatDate pattern="yyyy-MM-dd" value="${now}" />');
		$(".datepicker3").parents('.calendar').parent().each(function (){
			if($(this).find('.datepicker3').length == 2) {
				var fromDtObj = $(this).find('.datepicker3').eq(0).attr('id');
				var toDtObj = $(this).find('.datepicker3').eq(1).attr('id');
				
				setSearchDate(fromDtObj, toDtObj, 'today');
				
				$("#" + fromDtObj).prop('defaultValue', $("#" + fromDtObj).val());
				$("#" + toDtObj).prop('defaultValue', $("#" + toDtObj).val());
			}
		});

		
		$('#searchForm').find('input[type=text]').keypress(function (event){
			var keycode = (event.keyCode ? event.keyCode : event.which);
	        if(keycode == '13'){
	        	$('button.search').trigger('click');  
	        	event.preventDefault();
	        }
		});
		// 파일 찾기 형태 정의
		$("input.file_1").filestyle({
		          image: "/images/bg_attached_file.gif",
		          imageheight : 22,
		          imagewidth : 22,
		          disabled : true
		});
		
		// iframe 컨텐츠의 높이에 따라 iframe height 자동 조정		
		if($(window.frameElement).length>0)	{
			var iframeContent = $(window.frameElement).contents().find("body");
			
			// 최초 iframe 높이 자동 조정
			$(window.frameElement).height(iframeContent.height()+50);		
			
			// iframe 내의 내용이 바뀔시 높이 자동 조정
			iframeContent.resize(function(){
				$(window.frameElement).height($(this).height()+50);
			});
		}	
		
		// 즐겨찾기 버튼을 눌렀을 경우
		var menu_id = '<c:out value="${param.menu_id}"/>'; 
		
		$(".bmarkadd").bind("click", function(event){
			event.preventDefault();
			if(menu_id != '') {
				//toast('메뉴아이디:'+ menu_id +' 북마크');
				$.ajax({
					type: "POST",
					url: "/system/staff/insertBookmarkJson.do?menu_id="+menu_id,
					data: '',
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						if(data.code == '0') {
							toast(data.msg);
							parent.$("#bookmark_info").click();
							//parent.reloadBookmark();
							//popupColse();
							//$(location).attr("href", "/promotion/coupon/couponDtlPopup.do?evncoupon_no="+data.evncoupon_no); 
						}else if(data.code == "-1"){
							toast(data.msg);
						}
					},
					error: function(jqXHR, textStatus, errorThrown) {
						toast("오류가 발생했습니다" + ' ' + textStatus.msg);						
					}
				});
			}						
		});				
		
		$.validator.addMethod(
				"phone"
				, function(value,element){
					return /^0\d{1,2}-[1-9]\d{2,3}-\d{4}$/.test(value);
				  }
				, "숫자와 '-'로 전화번호 형식으로 입력하세요."
		);
		

	});
	
	// .grid .girdArea class를 가진 div 내의 그리드들의 resize 수행
	function resizeApp() {	   
				
	    $(".grid:visible .ui-jqgrid-btable").each(function (index) {	    	
	        var container = $(this).closest(".grid");	
	        resizeGrid(container, this);	        
	    });
	}
	
	function resizeGrid(container, grid) {
		var minWidth;
					
        if(typeof container.attr('min') != "undefined") {
        	minWidth = container.attr('min');
        } else minWidth = 80;
        
        if(container.width()>minWidth) {
	        $(grid).jqGrid().setGridWidth(container.width()-2);		
        } else {
        	$(grid).jqGrid().setGridWidth(minWidth);
        }
                
        var groupHeaders = $(grid).jqGrid("getGridParam", "groupHeader");
        if (groupHeaders != null) {
            $(grid).jqGrid("destroyGroupHeader").jqGrid("setGroupHeaders", groupHeaders);
        }
        
        
        
	}
	
	function getId(){
		return "nn21";
	}
	
	// Tab 갯수
	var MAX_TAB_CNT = 20;
	
	var FRONT_DNS = '<s:eval expression="@conf['DNS.FRONT']"/>';
	
	
	
	
	//toast message
	function fillWidth(elem, timer, limit) {
		if (!timer) { timer = 3000; }	
		if (!limit) { limit = 100; }
		var width = 1;
		var id = setInterval(frame, timer / 100);
			function frame() {
			if (width >= limit) {
				clearInterval(id);
			} else {
				width++;
				//elem.style.width = width + '%';
			}
		}
	};

	function toast(msg, timer) {

		if (!timer) { timer = 1500; }
//		var $elem = $("<div class='toastWrap'><span class='toast'>" + msg + "<b></b><div class='timerWrap'><div class='timer'></div></div></span></div>");
		var $elem = $("<div class='toastWrap'><span class='toast'>" + msg + "</span></div>");
		$("#toast").prepend($elem); //top = prepend, bottom = append
		$elem.slideToggle(100, function() {
			$('.timerWrap', this).first().outerWidth($elem.find('.toast').first().outerWidth() - 10);
			if (!isNaN(timer)) {
				fillWidth($elem.find('.timer').first()[0], timer);
				setTimeout(function() {
					$elem.fadeOut(function() {
						$(this).remove();
					});
				}, timer);			
			}
		});
	}
	
	
	
	
</script>
<%-- design ui --%>
<script type="text/javascript" src="/common/js/jquery.treeview.js"></script>
<script type="text/javascript" src="/common/js/jquery.cookie.js"></script>
<%-- design ui --%>

<%-- Common Java Script --%>
<script type="text/javascript" src="/common/js/common.js"></script>

<%-- Link --%>
<script type="text/javascript" src="/common/js/link.js"></script>

<%-- Grid Link CSS --%>
<style type="text/css">
 /* jqGrid Link Underline */
.ui-jqgrid-btable a:link {text-decoration: underline;}      /* unvisited link */
.ui-jqgrid-btable a:visited {text-decoration: underline;}   /* visited link */
.ui-jqgrid-btable a:hover {text-decoration: underline;}  	/* mouse over link */
.ui-jqgrid-btable a:active {text-decoration: underline;}  	/* selected link */

/* jqGrid Header Column Height */
.ui-jqgrid .ui-jqgrid-htable th {
    height: 25px;
}
/* jqGrid Row Height */
.ui-jqgrid tr.jqgrow td{
    height: 23px;
}
 </style>
