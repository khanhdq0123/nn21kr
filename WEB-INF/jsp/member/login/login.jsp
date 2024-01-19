<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>IL Company</title>
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
		
// 		$("#loginBtn").click( function() {	
     
// 			$.ajax({
// 			    url: "/member/login/loginProcessPost",
// 			    data: $("#gForm").serializeArray(),
// 			    dataType: "json",
// 			    type: "POST",
// 			    async: true,
// 			    success: function (data,textStatus ) {
// 					if(textStatus == 'success') {
// 						if(data.code == '0') {
// 							location.href = '/admin';
// 						} else {
// 							toast(data.errorMsg);
// 						}
// 					}else{
// 						toast('에러가 발생하였습니다. 다시 시도하세요.');		                              	
// 				    }										        
//                  }
// 			});
			
// 		});
		
		$('#passwd').keydown(function(e) {
			if (e.keyCode == '13') {
				$('#loginBtn').trigger('click');
			}
		});
		
		
		$("#loginBtn").click( function() {

			var loginYn = '${loginYn}';
			var loginId = $("#login_id").val();
			
			LoadingWithLogin()
			
			$.ajax({
			    url: "/member/login/loginProcessStep1",
			    data: $("#gForm").serializeArray(),
			    dataType: "json",
			    type: "POST",
			    async: true,
			    success: function (returnData,textStatus ) {
			    	closeLoadingWithLogin()
					if(textStatus == 'success') {
						if(returnData.code == '0') {

							var authentication_yn = returnData.authentication_yn;

							authentication_yn = "N";	//핸드폰인증 임시로 체크안함. 오픈시 현재라인 삭제
							
							//핸드폰인증 
							if(authentication_yn == "N"){
								location.href = '/admin';
								return false;
							}
							
							var num = returnData.phoneNumber;
							var spnum = num.split('-');
							var dpnum = (spnum.length > 2) ? spnum[0] + '****' + spnum[2] : num.substr(0,3) + '****' + num.substr(7,4);
						
							 $('<option>').text(dpnum).val(num.replaceAll('-','')).appendTo('#in_authentication_no');
						
							 $("#in_authentication_no_txt").val(dpnum);
							 $("#in_authentication_no").val(num.replaceAll('-',''));
	
							$("#hd_login_id").val($("#login_id").val());
// 							$("#login_id").attr("disabled", true);
// 							$("#passwd").attr("disabled", true);

							if(returnData.code == '0') {
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
			
			$.getJSON("/member/login/loginProcessStep2?"
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
				$.getJSON("/member/login/loginProcessStep3?"
					, $("#gForm").serialize()+"&callback=?"
		              , function (returnData, textStatus){
							closeLoadingWithLogin()
							if(textStatus == 'success') {
								if(returnData.code == '0') {
									location.href = '/admin';
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
		
		/*
		$('#login_id').val('fixalot');
		$('#passwd').val('0000');
		$('#loginBtn').click();
		*/
		
		
		
		
	});

//<![CDATA[
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
//]]>


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

	var fnDeleteAuthenticationNo = function(){
		$.getJSON("/member/login/deleteAuthenticationNo?"
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
	    loadingImg +=" <img src='/images/ajax-loader.gif' style='display:block; position:absolute; top: 50%; left: 50%; margin-top:-24px; margin-left: -24px;'/>";
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

	//회원가입
	function fnJoinMembership(){
		CenterOpenWindow('/join/joinMembership', 'open', '1200', '760', 'scrollbars=yes, status=no');
	}
	
	
	
	
</script>

<script>

function fnSetAcc1(){
	var id = localStorage.getItem("adAccId");
	var pw = localStorage.getItem("adAccPw");
	$("#login_id").val(id);
	$("#passwd").val(pw);
}
function fnSetAcc2(){
	var id = localStorage.getItem("veAccId");
	var pw = localStorage.getItem("veAccPw");
	$("#login_id").val(id);
	$("#passwd").val(pw);
}
function fnSetAcc3(){
	var id = localStorage.getItem("cuAccId");
	var pw = localStorage.getItem("cuAccPw");
	$("#login_id").val(id);
	$("#passwd").val(pw);
}
</script>
</head>
<body>
	
<div id="wrap">
	<div id="header">
		<h1 class="logoin_logo sky"></h1>
	</div>

	<div id="contneiner">
		<!-- contenst -->
		<div id="main_contents">
			<div class="admin_logoin">
				<span class="tit" style="line-height:58px;">IL 
					<span onclick="fnSetAcc1();">Company</span> 
					<span onclick="fnSetAcc2();">Tranportation</span>  
					<span onclick="fnSetAcc3();">System</span> 
				</span>
				<div class="admin_content">
					<h2 style="color:#fff; font-size:28px;">
<!-- 					<img src="/images/txt_admin_logoin.png" alt="logoin" /> -->
					<s:message code="login.tit01" />
					</h2>
					<span class="entry"><s:message code="login.tit02" /></span>
					<form id = "gForm" name = "gForm">
					<input type="hidden" id="hd_login_id" name="hd_login_id" />
					
						<fieldset>
						<legend>관리자 아이디/비밀번호 입력</legend>
						
						
						<div class="logoin" style="position:relative !important;">					
							<a href="/member/login/login.do?lang=en" <c:if test="${lang eq 'en'}">class="on"</c:if> >English</a>
							<a href="/member/login/login.do?lang=ko" <c:if test="${lang eq 'ko'}">class="on"</c:if> >한국어</a>
							<a href="/member/login/login.do?lang=cn" <c:if test="${lang eq 'cn'}">class="on"</c:if> >中文</a>
						</div>
						
						<div class="logoin_form">
							<div class="logoin_wrap">
								<div class="logoin_entry">
									<label class="blind" for="a1">아이디</label>
									<input type="text" class="inp" id="login_id" name="login_id" style="width:274px;" value="${login_id}" }/>
									<label class="blind" for="a2">비밀번호</label>
									<input type="password" class="inp" id="passwd" name="passwd" style="width:274px;"  />
								</div>
								<input class="logoin_bt" type="button" id="loginBtn" name="loginBtn" value="<s:message code="login.tit03" />"/>
							</div>
							<span class="check"><input type="checkbox"  id="save_id"  name="save_id"  value="Y" <c:if test="${save_id == 'Y'}">checked="checked"</c:if> />
							<label class="int_space" for="save_id"><s:message code="login.tit04" /></label>
							
							<span class="int_space ml50 ul cp" onclick="fnJoinMembership();"><s:message code="login.tit05" /></span>
							
							<input type="hidden" name="system_gubun" id="system_gubun" value="admin" />
							
							
						</div>
						
						<div class="logoin_form blind" id="authentication_wrap">
							<label class="check">접속 시 등록된 휴대폰번호로 인증을 해주셔야 합니다.</label>
							
							<div class="logoin_wrap">
								<div class="" >
									<input type="hidden" name="in_authentication_no" id="in_authentication_no" value="admin" />
									<input type="text" class="inp readonly" id="in_authentication_no_txt" name="in_authentication_no_txt" style="width:246px; height:18px;" value="" readonly  }/>
									<input class="logoin_bt" type="button" id="reptAutheticationNoBtn" name="reptAutheticationNoBtn" value="인증번호 받기"  style="height:30px !important;" />	
								</div>
								<div class=" mt10">
									<input type="text" class="inp" id="authentication_no" name="authentication_no" style="width:246px; height:18px;" placeholder="인증번호 입력(5분 이내)"  />
									<input class="logoin_bt" type="button" id="autheticationBtn" name="autheticationBtn" value="인증확인"  style="height:30px !important;" />						
									<p id="counttime" class="check">남은시간  05분 00초</p>	
								</div>
							</div>
						</div>
				

						
					</fieldset>
				</form>
				


				
				</div>
				

			</div>
		

		</div>
		<!-- //contents -->
	
		<div class="ac mt10">
			주소 | 인천시 중구 신흥동 1가31-1번지 아이엘빌딩 3층	대표번호 | 032-722-8481	FAX | 032-765-8688
		</div>
		<div class="ac mt5">
			COPYRIGHT(C) International Logistics co,LTD. All RIGHTS RESERVED.
		</div>
	
	
	</div>
	<!-- //contneiner -->

	<!-- footer -->
	<div id="footer">
	</div>
	<!-- //footer -->

</div>

<div id="toast"></div></body>
</html>