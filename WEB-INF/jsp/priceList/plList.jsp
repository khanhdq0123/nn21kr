<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>단가등록현황</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-control" content="No-cache" />
<meta http-equiv="Pragma" content="No-cache" />
<meta name="Description" content="" />
<meta name="Keywords" content="" />

<%@include file="/common/include/header.jsp"%>

<script type="text/javascript">
								
	$(document).ready(function() {
		fnPriceList();
		
		fnEventBind();
		

		
	});

	
	
	function fnEventBind(){
		
		//저장
		$("#BTN_Save").on("click", function(){
			
			if($("#code").val() == ''){
				toast('항목명을 선택하세요');
				return false;
			}
			
			$.ajax({
				type: "POST",
				url: "/priceList/updatePlTag",
				data: $("#uForm").serialize(),
				dataType: 'json',
				contentType: 'application/x-www-form-urlencoded; charset=utf-8',
				success: function(data) {
					if(data.code == 0){
						//toast(data.msg);
						fnPriceList();
					} else {
						toast('저장이 실패되었습니다.');
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					toast(jqXHR.status);						
				}
			});
		});
		
		
		//삭제
		$("#BTN_Delete").on("click", function(){
			
			if($("#code").val() == ''){
				toast('항목명을 선택하세요');
				return false;
			}
			
			$.ajax({
				type: "POST",
				url: "/priceList/deletePlTag",
				data: $("#uForm").serialize(),
				dataType: 'json',
				contentType: 'application/x-www-form-urlencoded; charset=utf-8',
				success: function(data) {
					if(data.code == 0){
						//toast(data.msg);
						fnPriceList();
					} else {
						toast('삭제가 실패되었습니다.');
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					toast(jqXHR.status);						
				}
			});
		});
		
		//등록
		$("#BTN_New").on("click", function(){
			
			var code_nm1 = $("#code_nm1").val();
			var code_nm2 = $("#code_nm2").val();
			var code_nm3 = $("#code_nm3").val();
			
			var sort_seq3 = $("#sort_seq3").val();
			
			if(code_nm1 == ''){
				toast('항목명을 입력하세요');
				$("#code_nm1").focus();
				return false;
			}
			
			if(code_nm2 == ''){
				toast('항목명을 입력하세요');
				$("#code_nm2").focus();
				return false;
			}
			
			if(code_nm3 == ''){
				toast('항목명을 입력하세요');
				$("#code_nm3").focus();
				return false;
			}
			
			if(sort_seq3 == ''){
				toast('정렬순서를 입력하세요');
				$("#sort_seq3").focus();
				return false;
			}
			

			
			$.ajax({
				type: "POST",
				url: "/priceList/insertPlTag",
				data: $("#cForm").serialize(),
				dataType: 'json',
				contentType: 'application/x-www-form-urlencoded; charset=utf-8',
				success: function(data) {
					if(data.code == 0){
						//toast(data.msg);
						fnPriceList();
						fnFormReset();
					} else {
						toast('등록이 실패되었습니다.');
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					toast(jqXHR.status);						
				}
			});
		});
		
		
	}
	
	
	
	function fnPriceList(){

		$.ajax({
			type: "POST",
			url: "/priceList/plTagListJson",
			data: $("#rForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				var regionHtml="<tr>";
				var strCospan="";
				var glevel="";
				var i = 1;
				var j = 1;
				var strColClass = "";
				var beforeUpcode = "";
				var totalRows = 0;
				var tagCode = [];
				var s = 0;
				
				$.each(data.rows, function(key, d) {
					
					if(glevel != d.glevel && key != 0){
						regionHtml += "</tr>";
						
						if(d.glevel == 3) regionHtml += "<tr class='tag3'><th class='col1 tit'>항차 <br /><br /><input type='button' class='btn btn-primary btn-xs' id='btnSave' value='저장'></th><th>규격</th><th>체적</th>";
						else if(d.glevel == 2) regionHtml += "<tr><td class='col1' colspan='3'>계정 </td>";
						else if(d.glevel == 1) regionHtml += "<tr><td class='col1 row1' colspan='3'>구분</td>";
						
						//strColClass = "col1";
					}
					
					strCospan="";
					if(d.colspan > 0){
						strCospan = "colspan='" + d.colspan + "'";
						if(d.glevel == 2){
							totalRows += d.colspan;
						}
					}
		
					if(beforeUpcode != d.upcode){
						i = (i == 1)? 2 : 1;
					}
					
					if(d.glevel == 1){
						regionHtml += "<td " + strCospan + " class='" + strColClass + " row1' code='" + d.code + "' code_nm='" + d.code_nm + "' upcode='" + d.upcode + "' upcode_nm='" + d.upcode_nm + "' sort_seq='" + d.sort_seq + "' glevel='" + d.glevel + "'><b>" + d.code_nm + "</b></td>";
					} else if(d.glevel == 2){
						if(strCospan != "")
						regionHtml += "<td " + strCospan + " class='" + strColClass + " bg-color-th" + j + "' code='" + d.code + "' code_nm='" + d.code_nm + "' upcode='" + d.upcode + "' upcode_nm='" + d.upcode_nm + "' sort_seq='" + d.sort_seq + "' glevel='" + d.glevel + "'>" + d.code_nm + "</td>";
					} else if(d.glevel == 3){
						regionHtml += "<td " + strCospan + " class='" + strColClass + " bg-color-td" + i + "' code='" + d.code + "' code_nm='" + d.code_nm + "' upcode='" + d.upcode + "' upcode_nm='" + d.upcode_nm + "' sort_seq='" + d.sort_seq + "' glevel='" + d.glevel + "'>" + d.code_nm + "</td>";
						
						tagCode[s] = d.code;	//tagCode 저장
						s++;
					}

					j = (j == 1)? 2 : 1;
					
					beforeUpcode = d.upcode;
					strColClass = "";
					glevel = d.glevel;
				});
				
				regionHtml += "</tr>";
				
				/* 등록폼~ */
				regionHtml += "<tr>";
				regionHtml += "<td class='inp col1'><input type='text' name='pl_nm' id='pl_nm' value='' class='tit' /></td>";
				regionHtml += "<td class='inp '><input type='text' name='pl_standard' id='pl_standard' value='' class='' /></td>";
				regionHtml += "<td class='inp '><input type='text' name='pl_volume' id='pl_volume' value='' class='' /></td>";
				for(k=0;k < totalRows;k++){
					if(k==0){
						regionHtml += "<td class='inp col1'><input type='number' name='p_" + tagCode[k] + "' id='p_" + tagCode[k] + "' value='0' /></td>";
					} else {
						regionHtml += "<td class='inp'><input type='number' name='p_" + tagCode[k] + "' id='p_" + tagCode[k] + "' value='0' /></td>";
					}
				}
				regionHtml += "</tr>";
				/* ~등록폼 */

				
				
				
				
				
				
				
				
				
				$("#pl_list").html(regionHtml);
				

				
				
				fnPlList();
				
				
				$("#pl_list td input").on("click",function(){
					$(this).select();
				});
				
				$("#pl_list td").on("click",function(){
// 					$("#pl_list td").removeClass("on");
// 					$(this).addClass("on");
					
					//수정입력창
					$("#code").val($(this).attr("code"));
					$("#code_nm").val($(this).attr("code_nm"));
					$("#upcode").val($(this).attr("upcode"));
					$("#upcode_nm").val($(this).attr("upcode_nm"));
					$("#sort_seq").val($(this).attr("sort_seq"));
					
					//등록입력창
					var glevel = $(this).attr("glevel");
					if(glevel == 1){
						$("#code1").val($(this).attr("code"));
						$("#code_nm1").val($(this).attr("code_nm"));
						$("#sort_seq1").val($(this).attr("sort_seq"));
					} else if(glevel == 2){
						
						$("#code1").val($(this).attr("upcode"));
						$("#code_nm1").val($(this).attr("upcode_nm"));
		
						$("#code2").val($(this).attr("code"));
						$("#code_nm2").val($(this).attr("code_nm"));

					}
					
				});
				
				$("#btnSave").on("click",function(){
					
					
// 					toast(283);
					
// 					var pl_nm 		= $("#pl_nm").val();
// 					var pl_standard = $("#pl_standard").val();
// 					var pl_volume 	= $("#pl_volume").val();

					
// 					if(pl_nm == ''){
// 						toast('항차를 입력하세요');
// 						$("#pl_nm").focus();
// 						return false;
// 					}
					
// 					if(pl_standard == ''){
// 						toast('규격을 입력하세요');
// 						$("#pl_standard").focus();
// 						return false;
// 					}
					
// 					if(pl_volume == ''){
// 						toast('체적을 입력하세요');
// 						$("#pl_volume").focus();
// 						return false;
// 					}

// 					$.ajax({
// 						type: "POST",
// 						url: "/priceList/savePlInfo",
// 						data: $("#rForm").serialize(),
// 						dataType: 'json',
// 						contentType: 'application/x-www-form-urlencoded; charset=utf-8',
// 						success: function(data) {
// 							if(data.code == 0){
// 								//toast(data.msg);
// 								fnPriceList();

// 							} else {
// 								toast('등록이 실패되었습니다.');
// 							}
// 						},
// 						error: function(jqXHR, textStatus, errorThrown) {
// 							toast(jqXHR.status);						
// 						}
// 					});
				});

				
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	
	
	var fnPlList = function(){

		$.ajax({
			type: "POST",
			url: "/priceList/plListJson",
			data: $("#rForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {

				if(data.code == 0){
					//toast(data.msg);
					var html = '';
					
					$.each(data.rows, function(key, d) {
						
						console.log(d);
						
						html += "<tr>";
						html += "<td class='col1'>" + d.pl_nm + "</td>";
						html += "<td>" + d.pl_standard + "</td>";
						html += "<td>" + d.pl_volume + "</td>";
						html += "<td>" + d.p10101 + "</td><td>" + d.p10102 + "</td><td>" + d.p10103 + "</td><td>" + d.p10104 + "</td>";
						html += "<td>" + d.p10201 + "</td><td>" + d.p10202 + "</td><td>" + d.p10203 + "</td><td>" + d.p10204 + "</td>";
						html += "<td>" + d.p10301 + "</td><td>" + d.p10302 + "</td>";
						html += "<td>" + d.p10401 + "</td><td>" + d.p10402 + "</td><td>" + d.p10403 + "</td><td>" + d.p10404 + "</td><td>" + d.p10405 + "</td><td>" + d.p10406 + "</td>";
						html += "<td>" + d.p10501 + "</td>";
						
						html += "<td>" + d.p20101 + "</td><td>" + d.p20102 + "</td>";
						html += "<td>" + d.p20201 + "</td>";
						html += "<td>" + d.p20301 + "</td><td>" + d.p20302 + "</td><td>" + d.p20303 + "</td><td>" + d.p20304 + "</td>";
						
						html += "<td>" + d.p30101 + "</td><td>" + d.p30102 + "</td><td>" + d.p30103 + "</td><td>" + d.p30104 + "</td><td>" + d.p30105 + "</td>";
						html += "<td>" + d.p30201 + "</td><td>" + d.p30202 + "</td><td>" + d.p30203 + "</td><td>" + d.p30204 + "</td>";
						html += "<td>" + d.p30301 + "</td><td>" + d.p30302 + "</td><td>" + d.p30303 + "</td><td>" + d.p30304 + "</td>";
						html += "<td>" + d.p30401 + "</td><td>" + d.p30402 + "</td>";
						html += "<td>" + d.p30501 + "</td><td>" + d.p30502 + "</td>";
						
						html += "<td>" + d.p40101 + "</td><td>" + d.p40102 + "</td>";
						
						html += "</tr>";
						
					});

					//$("#pl_list").html($("#pl_list").html() + html);
					$("#pl_list").append(html); 

				} else {
					toast('data를 불러오지 못했습니다.');
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {

				//toast(jqXHR.status);						
			}
		});
	}
	
	
	var fnSetInfo = function(code,code_nm,upcode,upcode_nm,sort_seq){
		$("#code").val(code);
		$("#code_nm").val(code_nm);
		$("#upcode").val(upcode);
		$("#upcode_nm").val(upcode_nm);
		$("#sort_seq").val(sort_seq);
	}
	
	var fnFormReset = function(){
		//$("#cForm")[0].reset();
		$("#code_nm3").val('');
		$("#sort_seq3").val('');
	}
	

	function fn_f10(){
		toast(283);
		
		var pl_nm 		= $("#pl_nm").val();
		var pl_standard = $("#pl_standard").val();
		var pl_volume 	= $("#pl_volume").val();

		
		if(pl_nm == ''){
			toast('항차를 입력하세요');
			$("#pl_nm").focus();
			return false;
		}
		
		if(pl_standard == ''){
			toast('규격을 입력하세요');
			$("#pl_standard").focus();
			return false;
		}
		
		if(pl_volume == ''){
			toast('체적을 입력하세요');
			$("#pl_volume").focus();
			return false;
		}

		$.ajax({
			type: "POST",
			url: "/priceList/savePlInfo",
			data: $("#rForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code == 0){
					//toast(data.msg);
					fnPriceList();

				} else {
					toast('등록이 실패되었습니다.');
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}	
</script>

<style>
/* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

/* Firefox */
input[type=number] {
  -moz-appearance: textfield;
}

.vl {writing-mode: vertical-lr; letter-spacing:6px; width:30px;}



.tag-list .tag3 td {writing-mode: vertical-lr; letter-spacing:6px; width:23px; cursor:pointer;}
.tag-list td { cursor:pointer; }
.tag-list td:hover {background-color:yellow; color:blue;}
.tag-list td.on {background-color:orange; color:blue;}
.tag-list td input{width:52px; border:0;}
.tag-list .inp {padding:0 !important;}
.tag-list td input.tit {width:120px;}
</style>

</head>

<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">단가등록현황</h3>
			
			<span class="bullet6">단가관리 &gt; 단가등록현황</span>
		</div>
		
		
		<div class="mt20" style=" width:100%; height:700px; overflow-x:scroll;">
			<form id="rForm" name="rForm" method="post" action="#">
				<table class="layer_tbl2 tag-list wa" id="pl_list"></table>
			</form>
		<br/>
		</div>
		
		<div class="dp_category">
		

	
			
			
		</div>
		
		
		
		<br/>

			

	</div>
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>