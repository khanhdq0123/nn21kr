<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript">
		var statsTypList = "<c:out escapeXml="false" value="${applicationScope['GRIDCODELIST']['11200']}"/>";
	</script>
	<script type="text/javascript" src="/js<%=jsUrl%>.js"></script>
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header"></h3>
			<div class="btn-wrap">
				<input type="button" class="btn btn-success btn-sm" value="검색[F3]" id="btnSearch">
<!-- 				<input type="button" class="btn btn-primary btn-sm" value="신규등록[F9]" id="btnAdd">				 -->
			</div>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form method="post" id="searchForm" name="searchForm" action="#">
				
					<fieldset>
					<legend>검색조건</legend>
						<div class="product_tbl">

							<div style="padding:10px;">
								<div class="radio-group">
<!-- 					                <div class="option"><input type="radio" id="rd_ord_typ" name="s_ord_typ" value=""><label class="radio-container" for="rd_ord_typ">전체</label></div> -->
					                <div class="option"><input type="radio" id="s_msg_typ11" name="s_msg_typ1" value="1" checked="checked"><label class="radio-container" for="s_msg_typ11">안내</label></div>
					                <div class="option"><input type="radio" id="s_msg_typ12" name="s_msg_typ1" value="2"><label class="radio-container" for="s_msg_typ12">수입</label></div>
					                <div class="option"><input type="radio" id="s_msg_typ13" name="s_msg_typ1" value="3"><label class="radio-container" for="s_msg_typ13">수출</label></div>
					                <div class="option"><input type="radio" id="s_msg_typ14" name="s_msg_typ1" value="4"><label class="radio-container" for="s_msg_typ14">비용</label></div>
					                <div class="option"><input type="radio" id="s_msg_typ15" name="s_msg_typ1" value="5"><label class="radio-container" for="s_msg_typ15">명세</label></div>
					                <div class="option"><input type="radio" id="s_msg_typ16" name="s_msg_typ1" value="6"><label class="radio-container" for="s_msg_typ16">원산지</label></div>
					                <div class="option"><input type="radio" id="s_msg_typ17" name="s_msg_typ1" value="7"><label class="radio-container" for="s_msg_typ17">직출</label></div>
					                <div class="option"><input type="radio" id="s_msg_typ18" name="s_msg_typ1" value="8"><label class="radio-container" for="s_msg_typ18">deleted</label></div>
					            </div>
					            <div class="radio-group ml20">
					                <div class="option"><input type="radio" id="s_msg_typ21" name="s_msg_typ2" value="" checked=""><label class="radio-container" for="s_msg_typ21">ALL</label></div>
					                <div class="option"><input type="radio" id="s_msg_typ22" name="s_msg_typ2" value="1"><label class="radio-container" for="s_msg_typ22">A</label></div>
					                <div class="option"><input type="radio" id="s_msg_typ23" name="s_msg_typ2" value="2"><label class="radio-container" for="s_msg_typ23">B</label></div>
					                <div class="option"><input type="radio" id="s_msg_typ24" name="s_msg_typ2" value="3"><label class="radio-container" for="s_msg_typ24">C</label></div>
					                <div class="option"><input type="radio" id="s_msg_typ25" name="s_msg_typ2" value="4"><label class="radio-container" for="s_msg_typ25">D</label></div>
					            </div>
								<div class="radio-group ml20">
									<div class="option"><input type="radio" id="s_msg_target1" name="s_msg_target" value="" checked=""><label class="radio-container" for="s_msg_target1">ALL</label></div>
					                <div class="option"><input type="radio" id="s_msg_target2" name="s_msg_target" value="S"><label class="radio-container" for="s_msg_target2">Shipper</label></div>
					                <div class="option"><input type="radio" id="s_msg_target3" name="s_msg_target" value="C"><label class="radio-container" for="s_msg_target3">Consignee</label></div>
					            </div>
					            <div class="radio-group ml20">
					                <div class="option"><input type="radio" id="s_msg_lan1" name="s_msg_lan" value="" checked=""><label class="radio-container" for="s_msg_lan1">ALL</label></div>
					                <div class="option"><input type="radio" id="s_msg_lan2" name="s_msg_lan" value="EN"><label class="radio-container" for="s_msg_lan2">EN</label></div>
					                <div class="option"><input type="radio" id="s_msg_lan3" name="s_msg_lan" value="KR"><label class="radio-container" for="s_msg_lan3">KR</label></div>
					                <div class="option"><input type="radio" id="s_msg_lan4" name="s_msg_lan" value="CN"><label class="radio-container" for="s_msg_lan4">CN</label></div>
					                <div class="option"><input type="radio" id="s_msg_lan5" name="s_msg_lan" value="VN"><label class="radio-container" for="s_msg_lan5">VN</label></div>
					            </div>
							</div>						
			
						</div>
					</fieldset>
				</form>
			</div>
			
			
			<div class="two-block-wrap">
				<div class="left" style="width:calc(100% - 400px);">
					<div class="grid">
						<table id="list1"></table>
					</div>
				</div>
				<div class="right" style="width:400px;">

					<div class="btn-wrap ml10 mt10 ar">
						<input type="button" class="btn btn-info btn-xs" value="new" id="btnNew">
						<input type="button" class="btn btn-primary btn-xs" value="저장" id="btnSave"> 
						<input type="button" class="btn btn-danger btn-xs" value="삭제" id="btnDelete">		
					</div>
				
					<form method="post" id="inputForm" name="inputForm" action="#">
						<input type="hidden" id="msg_no" name="msg_no" value="" />
						<fieldset>
						
							<table cellspacing="0" cellpadding="0" summary="" class="tbl_type2 ml10 mt10">
								<caption></caption>
								<colgroup>
									<col width="15%">
									<col width="85%">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>Type1</th>
										<td>
											<select id="msg_typ1" name="msg_typ1">
												<option value="1">안내</option>
												<option value="2">수입</option>
												<option value="3">수출</option>
												<option value="4">비용</option>
												<option value="5">명세</option>
												<option value="6">원산지</option>
												<option value="7">직출</option>
												<option value="8">deleted</option>
											</select>
										</td>
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>Type2</th>
										<td>
											<input type="radio" id="msg_typ21" name="msg_typ2" value="A" checked="checked"><label class="int_space" for="msg_typ21">A</label>
											<input type="radio" id="msg_typ22" name="msg_typ2" value="B"><label class="int_space" for="msg_typ22">B</label>
											<input type="radio" id="msg_typ23" name="msg_typ2" value="C"><label class="int_space" for="msg_typ23">C</label>
											<input type="radio" id="msg_typ24" name="msg_typ2" value="D"><label class="int_space" for="msg_typ24">D</label>
										</td>
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>Target</th>
										<td>
											<input type="radio" id="msg_target1" name="msg_target" value="S" checked="checked"><label class="int_space" for="msg_target1">Shipper</label>
											<input type="radio" id="msg_target2" name="msg_target" value="C"><label class="int_space" for="msg_target2">Consignee</label>
										</td>
									</tr>
									<tr>
										<th scope="row"><span class="starMark">필수입력 항목입니다.</span>Lang</th>
										<td>
											<input type="radio" id="msg_lan1" name="msg_lan" value="EN" checked="checked"><label class="int_space" for="msg_lan1">EN</label>
											<input type="radio" id="msg_lan2" name="msg_lan" value="KR"><label class="int_space" for="msg_lan2">KR</label>
											<input type="radio" id="msg_lan3" name="msg_lan" value="CN"><label class="int_space" for="msg_lan3">CN</label>
											<input type="radio" id="msg_lan4" name="msg_lan" value="VN"><label class="int_space" for="msg_lan4">VN</label>
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="msg_content">Message</label></th>
										<td>
											<textarea name="msg_content" rows="8" cols="20" id="msg_content" style="width:315px;"></textarea>
										</td>
									</tr>
								</tbody>
							</table>
						
						
						





						</fieldset>
					</form>
				</div>
			</div>


		</div>
		<!-- //product_admin -->
	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>