<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title></title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-control" content="No-cache" />
<meta http-equiv="Pragma" content="No-cache" />
<meta name="Description" content="" />
<meta name="Keywords" content="" />

<%@include file="/common/include/header.jsp"%>
<script type="text/javascript">
/* 타이머 관련 members */
var timer;
var hours = 0;
var minutes = 5;
var seconds = 0;
var interval;


$(document).ready(function() {
	//LoadingWithLogin()
	//setTimeout(closeLoadingWithLogin(), 5000);
	
	$("#loginBtn").click( function() {
		console.log("init loginBtn")
		var loginYn = '${loginYn}';
		var loginId = $("#login_id").val();

		
		LoadingWithLogin()
		
		$.ajax({
		    url: "/member/login/loginProcessStep1.do",
		    data: $("#gForm").serializeArray(),
		    dataType: "json",
		    type: "POST",
		    async: true,
		    success: function (returnData,textStatus ) {
		    	closeLoadingWithLogin()
				if(textStatus == 'success') {
					if(returnData.code == '0') {

						console.log(returnData.phoneNumberList);
						//var phoneNumberList[] = returnData.phoneNumberList;
						
						returnData.phoneNumberList.forEach (function (el, index) {
							console.log('element', index, el);
							if(el.mobil_txt.length > 9){
								var num = el.mobil_txt;
								var spnum = num.split('-');
								var dpnum = (spnum.length > 2) ? spnum[0] + '****' + spnum[2] : num.substr(0,3) + '****' + num.substr(7,4);
							
								 $('<option>').text(dpnum).val(num.replaceAll('-','')).appendTo('#in_authentication_no');
							}							  
						});

						$("#hd_login_id").val($("#login_id").val());
						$("#login_id").attr("disabled", true);
						$("#passwd").attr("disabled", true);

						if(returnData.code == '0') {
							if(returnData.msg != "" && returnData.msg > 0) toast("회수지시 미확인건이 있습니다. 대상 클레임건 확인 후 택배회수접수를 진행해 주시기 바랍니다.");
								$("#authentication_wrap").removeClass("blind");
						} else {
							toast(returnData.msg);
						}
					} else {
						toast(returnData.errorMsg);
					}
				}else{
					toast('에러가 발생하였습니다. 다시 시도하세요.');		                              	
			    }										        
             }
		});		
		return;
	});

	$("#reptAutheticationNoBtn").click( function() {

		if($("#in_authentication_no").val() == ''){
			toast('휴대폰번호를 선택해주세요'); 
			return false;
		}
		
		$.getJSON("/member/login/loginProcessStep2.do?"
			, $("#gForm").serialize()+"&callback=?"
              , function (returnData, textStatus){

					if(textStatus == 'success') {
						
						toast('인증번호가 발송되었습니다.');
						fnCountDown();
					}else{
						toast('에러가 발생하였습니다. 다시 시도하세요.');		                              	
				    }		
                }
         );
		return;
	});

	$("#autheticationBtn").click( function() {

	if($("#authentication_no").val().length < 6){
		toast('인증번호 6자리를 입력하세요!');	
		$("#authentication_no").focus();
		return false;
	}
	LoadingWithLogin()
		$.getJSON("/member/login/loginProcessStep3.do?"
			, $("#gForm").serialize()+"&callback=?"
              , function (returnData, textStatus){
					closeLoadingWithLogin()
					if(textStatus == 'success') {
						if(returnData.code == '0') {
							location.href = '/scm.do';
						} else {
							toast(returnData.msg);
						}
					}else{
						toast('에러가 발생하였습니다. 다시 시도하세요.');		                              	
				    }		
                }
         );
		return;
	});


	
	$('#passwd').keydown(function(e) {
		if (e.keyCode == '13') {
			$('#loginBtn').trigger('click');
		}
	});
});

$(function(){
	$("#info_tab div").hide();
	$("#info_tab div:eq(0)").show();

	$("#info_tab h3 a").bind("mouseover focus",function(){
		$("#info_tab div").hide();
		$(this).parent().next().show();

		//버튼색상활성화
		$("#info_tab h3 img").each(function(){
			$(this).attr("src",$(this).attr("src").replace("on.gif","off.gif"));
		})

		$(this).children().attr("src",
		$(this).children().attr("src").replace("off.gif","on.gif"));
	})
})

var fnDeleteAuthenticationNo = function(){
	$.getJSON("/member/login/deleteAuthenticationNo.do?"
			, $("#gForm").serialize()+"&callback=?"
	        , function (returnData, textStatus){

					if(textStatus == 'success') {
						if(returnData.code == '0') {
							//인증번호 삭제 성공
						} else {
							//toast(returnData.msg);
						}
						
					}else{
						toast('에러가 발생하였습니다. 다시 시도하세요.');		                              	
				    }		
						        
	          }
	   );
}

function LoadingWithLogin() {

    //화면의 높이와 너비를 구합니다.
    var maskHeight = $(document).height();
    var maskWidth  = window.document.body.clientWidth;

    //화면에 출력할 마스크를 설정해줍니다.
    var mask       ="<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
    var loadingImg ='';
      
    loadingImg +="<div id='loadingImg'>";
    loadingImg +=" <img src='https://sgi.gzcdn.net/etc/adminloading.gif' style='display:block; position:absolute; top: 50%; left: 50%; margin-top:-24px; margin-left: -24px;'/>";
    loadingImg +="</div>"; 
  
    //화면에 레이어 추가
    $('body')
        .append(mask)
        .append(loadingImg)
        
    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채웁니다.
    $('#mask').css({
            'width' : maskWidth
            ,'height': maskHeight
            ,'opacity' :'0.3'
    });
  
    //마스크 표시
    $('#mask').show();  
  
    //로딩중 이미지 표시
    $('#loadingImg').show();
}


function closeLoadingWithLogin() {
    $('#mask, #loadingImg').hide();
    $('#mask, #loadingImg').empty(); 
}

</script>
</head>
<body>
	
<div id="wrap">
	<!-- header -->
	<div id="header">
		<h1 class="logoin_logo"><img src="" alt="" /></h1>
	</div>
	<!-- //header -->

	<!-- contneiner -->
	<div id="contneiner">
		<!-- contenst -->
		<div id="main_contents">
			<div class="supplier_logoin">
				<div class="supplier_tit">
					<span class="tit"><em>SCM</em></span>
					<span class="supplier_txt"><img src="/images/txt_logoin.gif" alt="LOGIN" /></span>
				</div>
				<div class="supplier_content">
					<h2><img src="/images/txt_supplierlogoin.png" alt="공급사 로그인" /></h2>
					<form  id = "gForm" name = "gForm">
					<input type="hidden" id="hd_login_id" name="hd_login_id" />
						<fieldset>
						<legend>관리자 아이디/비밀번호 입력</legend>
							<div class="logoin_form">
								<span class="logoin_txt">공급사 아이디/비밀번호를 입력해 주세요</span>
								<div class="logoin_wrap">
									<div class="logoin_entry">
										<label class="blind" for="a1">아이디</label>
										<input type="text" class="inp" id="login_id" name="login_id" style="width:274px;" value="${login_id}" placeholder="ID"}/>
										<label class="blind" for="a2">비밀번호</label>
										<input type="password" class="inp" id="passwd" name="passwd" style="width:274px;" placeholder="PW" />
									</div>
									<input class="logoin_bt" type="button" id="loginBtn" name="loginBtn" value="로그인"/>
								</div>
								<span class="check"><input type="checkbox"  id="save_id"  name="save_id"  value="Y" <c:if test="${save_id == 'Y'}">checked="checked"</c:if> />
								<label class="int_space" for="save_id">아이디저장</label>
								
								
								<div class="logoin_wrap blind" id="authentication_wrap">
									<div class="logoin_entry type2">
										<span class="logoin_txt">접속 시 등록된 휴대폰번호로 인증을 해주셔야 합니다.</span>
										<label class="blind" for="in_authentication_no_mask">인증번호</label>
										
										<select name="in_authentication_no" id="in_authentication_no" style="width:281px;">
											<option value="">휴대전화번호 선택</option>
										</select>
										
<!-- 										<input type="hidden" id="in_authentication_no" name="in_authentication_no" value="" /> -->
<!-- 										<input type="text" class="inp" id="in_authentication_no_mask" name="in_authentication_no_mask" vlaue="" readonly disabled="disabled" style="width:274px;"/> -->
										
										
										
										<input class="authBtn" type="button" id="reptAutheticationNoBtn" name="reptAutheticationNoBtn" value="인증번호 받기"/>		
										<label class="blind" for="authentication_no">인증번호</label>
										<input type="text" class="inp" id="authentication_no" name="authentication_no" style="width:274px;" placeholder="인증번호 입력(5분 이내)"  />
										<input class="authBtn" type="button" id="autheticationBtn" name="autheticationBtn" value="인증확인"/>						
										<p id="counttime">남은시간  05분 00초</p>		
									</div>
								</div>
								
								<input type="hidden" name="system_gubun" id="system_gubun" value="scm"></input>
							</div>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
		<!-- //contents -->
	</div>
	<!-- //contneiner -->

	<!-- footer -->
	<div id="footer">

	</div>
	<!-- //footer -->

</div>
</div>

<style type="text/css">
#popup_170508 {position:fixed; top:0; left:50%; margin-left:-500px; z-index:1000;}
.logoin_entry.type2{width:100%;margin-top:10px;}
.logoin_form .logoin_entry input.authBtn{width:92px; height: 32px; margin-bottom: 5px; padding: 7px 0 7px 5px; border: 0; background: #3a769f; color: #fff;}
</style>
<script>


var fnCountDown = function(){
	if(hours > 0 || minutes > 0 || seconds > 0){
		interval = setInterval(function(){

			seconds -= 1;

			if(seconds < 0 && minutes > 0 && hours > 0){
				minutes -= 1;
				seconds = 59;
			} else if(seconds < 0 && minutes == 0 && hours > 0){
				hours -= 1;
				minutes = 59;
				seconds = 59;
			} else if (seconds < 0 && minutes > 0 && hours ==0){
				hours = 0;
				minutes -= 1;
				seconds = 59;
			}

			if(hours > 0 && hours < 10 && ((hours + '').length != 2)) hours = '0' + hours;

			if((minutes < 10) && ((minutes + '').length < 2)) minutes = '0' + minutes;

			if(seconds < 10 && seconds.length != 2) seconds = '0' + seconds;

			if(hours > 0) {hoursN = hours + ':';} else {hoursN = '';}

			$('#counttime').html('남은시간 ' + hoursN + minutes + '분 ' + seconds + '초');


			if(hours == 0 && minutes == 0 && seconds == 0) {
				clearInterval(interval);
				$('#authentication_wrap').addClass('blind');
				fnDeleteAuthenticationNo();	//인증번호 삭제
			}
		}, 1000);
	}
}



function fclose() {
	$("#popup_170508").hide();
}
</script>
<!-- <div id="popup_170508">
	<div class="inner">
		<img src="http://gi.gzcdn.net/images/etc/popup_img_170508.jpg" alt="" border="0" usemap="#Map" id="pop_img" />
        <map name="Map" id="Map">
			<area shape="rect" coords="642,24,675,56"   href="javascript:fclose();"/>
			<area shape="rect" coords="157,762,544,820" href="http://gi.gzcdn.net/images/etc/contract_finally.zip" />
        </map>
	</div>
</div> -->
<!-- 
<div id="popup_170508">
	<div class="inner">
		<img src="http://gi.gzcdn.net/images/etc/popup_img_170508.jpg" alt="" border="0" usemap="#Map" id="pop_img">
		<map name="Map" id="Map">
			<area shape="rect" coords="642,49,674,82" href="javascript:fclose();">
			<area shape="rect" coords="156,773,546,837" href="http://gi.gzcdn.net/images/etc/contract_finally.zip">
		</map>
	</div>
</div>
-->
<div id="toast"></div></body>
</html>