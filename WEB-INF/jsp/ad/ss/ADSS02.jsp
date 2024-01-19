<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript" src="/js<%=jsUrl%>.js"></script>
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header"></h3>
			<div class="btn-wrap">
				<input type="button" class="btn btn-success btn-sm" value="검색[F3]" id="btnSearch">
				<input type="button" class="btn btn-primary btn-sm" value="신규등록[F9]" id="btnNewPost">				
			</div>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->

			
			<div class="product_form">
				<form method="get" action="#" id="searchForm">
				<input type="hidden" name="board_typ" id="board_typ" value="3" />
				
					<fieldset>
						<legend>고객게시판</legend>
						<div class="product_tbl">
							<table cellspacing="0" cellpadding="0" class="tbl_type2 tbl_cell">
								<colgroup>
									<col width="100%" />
								</colgroup>
								<tbody>
									<tr>
										<td>
											<div class="tbl_wrap">
												<dl class="section">
													<dt>제목</dt>
													<dd>
														<input type="text" style="width: 50%;" id="title_txt" name="title_txt" maxlength="100"/>
													</dd>
													<dt>내용</dt>
													<dd>
														<input type="text" style="width: 50%;" id="regstaff_id" name="regstaff_id" maxlength="20"/>
													</dd>
												</dl>

												<dl class="section">
													<dt>등록일</dt>
													<dd class="cols">
														<span class="calendar">
															<input type="text" maxlength="10" class="datepicker" id="reg_dt_from" name="reg_dt_from"/>
														</span>
														&nbsp;~&nbsp; 
														<span class="calendar">
															<input type="text" maxlength="10" class="datepicker" id="reg_dt_to" name="reg_dt_to"/>
														</span>
														
														<span id="spnSetReg">
															<button type="button" class="btn_c6" id="btnRegSetToday">오늘</button>
															<button type="button" class="btn_c6" id="btnRegSetWeekago">1주일</button>
															<button type="button" class="btn_c6" id="btnRegSetMonthago">1개월</button>
														</span>
													</dd>
												</dl>

											</div>
											<div class="tbl_wrap active mark"></div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</fieldset>
				</form>
			</div>


			<div class="grid">
				<table id="list1"></table>
			</div>
		</div>
		<!-- //product_admin -->
	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>