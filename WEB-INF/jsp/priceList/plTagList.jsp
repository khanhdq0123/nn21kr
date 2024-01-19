<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>단가항목 관리</title>
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
				$.each(data.rows, function(key, d) {
					
					if(glevel != d.glevel && key != 0){
						regionHtml += "</tr>";
						
						if(d.glevel == 3) regionHtml += "<tr class='tag3'>";
						else regionHtml += "<tr>";
						
						strColClass = "col1";
					}
					
					strCospan="";
					if(d.colspan > 0) strCospan = "colspan='" + d.colspan + "'";
		
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
					}

					j = (j == 1)? 2 : 1;
					
					beforeUpcode = d.upcode;
					strColClass = "";
					glevel = d.glevel;
				});
				
				regionHtml += "</tr>";

				$("#pl_list").html(regionHtml);
				
				$("#pl_list td").on("click",function(){
					$("#pl_list td").removeClass("on");
					$(this).addClass("on");
					
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

				
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
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
</script>

<style>

.vl {writing-mode: vertical-lr; letter-spacing:6px; width:30px;}



.tag-list .tag3 td {writing-mode: vertical-lr; letter-spacing:6px; width:23px; cursor:pointer;}
.tag-list td { cursor:pointer;}
.tag-list td:hover {background-color:yellow; color:blue;}
.tag-list td.on {background-color:orange; color:blue;}
</style>

</head>

<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">단가항목 관리</h3>
			
			<span class="bullet6">단가관리 &gt; 단가항목 관리</span>
		</div>
		
		
		<div class="mt20" style=" width:100%; overflow-x:scroll;">

			<table class="layer_tbl2 tag-list wa" id="pl_list"></table>
		
		</div>
		
		<div class="dp_category">
		

			<div class="fl w40p mt40">
				<div class="refer bullet6">
					<ul>
						<li>항목 수정</li>
					</ul>
					<div class="refer_bt">
						<div class="min_btn">
							<input type="button" class="btn btn-primary btn-sm" value="저장" id="BTN_Save">
							<input type="button" class="btn btn-danger btn-sm" value="삭제" id="BTN_Delete">
						</div>
					</div>
				</div>
				<form id="uForm" name="uForm" method="post" action="#">
				<input type="hidden" id="menu_id_s" name="menu_id_s" />
				<input type="hidden" id="levels" name="levels" />  
					<fieldset>
					<legend>메뉴 관리 상세</legend>
						<div class="product_tbl">
							<table cellspacing="0" cellpadding="0" summary="" class="tbl_type2">
							<caption>메뉴 관리 상세</caption>
								<colgroup>
									<col width="20%" />
									<col width="30%"/>
									<col width="15%" />
									<col width="35%"/>
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="upcode">상위항목</label></th>
										<td colspan="3">
											<input type="text" id="upcode" name="upcode" style="width:80px;" class="readonly" readonly="readonly" />
											<input type="text" id="upcode_nm" name="upcode_nm" style="width:240px;" class="readonly" readonly="readonly" />
										</td>
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="upmenu_id">항목</label></th>
										<td colspan="3">
											<input type="text" id="code" name="code" class="readonly" style="width:80px;" readonly="readonly" />
											<input type="text" id="code_nm" name="code_nm" style="width:240px;" />
										</td>
									</tr>
	
									<tr>
										<th scope="row"><label for="sort_seq"><span class="starMark">필수입력 항목입니다.</span>정렬순서</label></th>
										<td colspan="3">
											<input type="text" id="sort_seq" name="sort_seq" style="width:80px;" />
										</td>
									</tr>
	
								</tbody>
							</table>
						</div>
					</fieldset>
				</form>
			</div>

			<div class="fr w59p mt40">
				<div class="refer bullet6">
					<ul>
						<li>항목 등록</li>
					</ul>
					<div class="refer_bt">
						<div class="min_btn">
							<input type="button" class="btn btn-success btn-sm" value="등록" id="BTN_New">
						</div>
					</div>
				</div>
				<form id="cForm" name="cForm" method="post" action="#">
				<input type="hidden" id="menu_id_s" name="menu_id_s" />
				<input type="hidden" id="levels" name="levels" />  
					<fieldset>
					<legend>메뉴 관리 상세</legend>
						<div class="product_tbl">
							<table cellspacing="0" cellpadding="0" summary="" class="tbl_type2">
							<caption>메뉴 관리 상세</caption>
								<colgroup>
									<col width="15%" />
									<col width="25%"/>
									<col width="45%" />
									<col width="15%"/>
								</colgroup>
								<tbody>
									<tr>
										<th style="height:25px;">구분</th>
										<th>항목코드</th>
										<th>항목명</th>
										<th>정렬순번</th>
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="upcode">구분1</label>
										
										</th>
										<td class="ar">
											<input type="button" class="btn btn-primary btn-xs ml10" value="직접입력" onclick="$('#code1').val(''); $('#code_nm1').val(''); $('#code2').val(''); $('#code_nm2').val('');">
											<input type="text" id="code1" name="code1" style="width:80px;" class="readonly" readonly="readonly" />
										</td>
										<td>
											<input type="text" id="code_nm1" name="code_nm1" style="width:100%;" />
										</td>
										<td>
											<input type="text" id="sort_seq1" name="sort_seq1" style="width:80px;" />
										</td>
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="upcode">구분2</label></th>
										<td class="ar">
											<input type="button" class="btn btn-primary btn-xs ml10" value="직접입력" onclick="$('#code2').val(''); $('#code_nm2').val('');">
											<input type="text" id="code2" name="code2" style="width:80px;" class="readonly" readonly="readonly" />
										</td>
										<td>
											<input type="text" id="code_nm2" name="code_nm2" style="width:100%;" />
										</td>
										<td>
											<input type="text" id="sort_seq2" name="sort_seq2" style="width:80px;" />
										</td>
									</tr><tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span><label for="upcode">구분3</label></th>
										<td class="ar"></td>
										<td>
											<input type="text" id="code_nm3" name="code_nm3" style="width:100%;" />
										</td>
										<td>
											<input type="text" id="sort_seq3" name="sort_seq3" style="width:80px;" />
										</td>
									</tr>
	
								</tbody>
							</table>
						</div>
					</fieldset>
				</form>
			</div>


			
			
		</div>
		
		
		
		<br/>

			

	</div>
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>