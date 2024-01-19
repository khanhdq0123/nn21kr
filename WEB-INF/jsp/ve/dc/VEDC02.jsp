<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>
	<script type="text/javascript" src="/js<%=jsUrl%>.js"></script>
	<script>
	$(document).ready(function(){
		
		$("#btnSet").on("click",function(){
			location.href = "/ve/dc/VEDC01/page";
		});


		fnEventBind();
	
		fnGetCateList();	//카테고리 리스트	

	});	
	
	function fnEventBind(){
		
		//카테고리수정 취소
		$("#btnCancelUpdateCate").on("click",function(){
			
			$("#btnAddCate").removeClass("dpn");
			$("#btnUpdateCate").addClass("dpn");
			$("#btnCancelUpdateCate").addClass("dpn");			
			
			$("#board_cate_nm").val("");
			$("#board_cate_no").val("");
		});
		
		//게시판수정 취소
		$("#btnCancelUpdateBoard").on("click",function(){
			
			$("#btnAddBoard").removeClass("dpn");
			$("#btnUpdateBoard").addClass("dpn");
			$("#btnCancelUpdateBoard").addClass("dpn");	

			$("#board_nm").val("");
			$("#board_no").val("");
			
			$("#s_board_cate_no").attr("disabled",false);
			
		});
		
		//카테고리 추가
		$("#btnAddCate").on("click",function(){
			fnAddCate();
		});
		
		//게시판 추가
		$("#btnAddBoard").on("click",function(){
			fnAddBoard();
		});
		
		//카테고리 수정
		$("#btnUpdateCate").on("click",function(){
			fnUpdateCate();
		});
		
		//게시판 수정
		$("#btnUpdateBoard").on("click",function(){
			fnUpdateBoard();
		});
	
	}		

	function fnGetCateList(){
	
		$.ajax({
			type: "POST",
			url: '/ve/dc/VEDC01/selectBoardCate',
			data: $("#submitForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				
				var _opt = '<option value="">Category</option>';
				var _html = '';
				
				$(data.rows).each(function(i,d){
					
					_opt += '<option value="' + d.board_cate_no + '">' + d.board_cate_nm + '</option>';
					
					
					
					_html +='					<table border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#708090" style="border-collapse:collapse;width:570px;background-color:#FFFFFF; margin-bottom:10px;">';
					_html +='						<tbody>';
					_html +='							<tr>';
					_html +='								<td bgcolor="#D1E3E5" align="center" style="height:35px; ">';
					_html +='									<b>' + d.board_cate_nm + '</b>';
					_html +='									</td>';
					_html +='									<td bgcolor="#D1E3E5" style="width:280px; padding-left:5px;">';
					if(i != 0)
					_html +='									<input type="button" onclick="fnUpdateCateSeqMinus(' + d.board_cate_no + ',' + (i - 1) + ');" value="↑ up" class="btn btn-close btn-xs" >';
					if(i < data.rows.length-1)
					_html +='									<input type="button" onclick="fnUpdateCateSeqPlus(' + d.board_cate_no + ',' + (i + 1) + ');" value="↓ down" class="btn btn-close btn-xs" >';
					_html +='									<input type="button" onclick="fnSetModifyCate(' + d.board_cate_no + ',\'' + d.board_cate_nm + '\');" value="수정" class="btn btn-primary btn-xs" >';
					_html +='									<input type="button" onclick="fnDeleteCate(' + d.board_cate_no + ');"  value="삭제" class="btn btn-danger btn-xs" >';
					_html +='								</td>';
					_html +='							</tr>';
					
					$(d.boardList).each(function(i2,d2){
					
						_html +='							<tr>';
						_html +='								<td bgcolor="#F0F5F6" align="left" style="height:30px; padding-left:5px;">';
						_html +='									<input type="checkbox" onclick="CheckChageOrder();">' + d2.board_nm + '</td>';
						_html +='									<td style="padding-left:5px; width:280px;">';
						if(i2 != 0)
						_html +='									<input type="button" onclick="fnUpdateBoardSeqMinus(' + d.board_cate_no + ',' + d2.board_no + ',' + (i2 - 1) + ');" value="↑" class="btn btn-close btn-xs" >';
						if(i2 < d.boardList.length-1)
						_html +='									<input type="button" onclick="fnUpdateBoardSeqPlus(' + d.board_cate_no + ',' + d2.board_no + ',' + (i2 + 1) + ');" value="↓" class="btn btn-close btn-xs" >';
						_html +='									<input type="button" onclick="PopOpen();" value="권한" class="btn btn-primary btn-xs" >';
						_html +='									<input type="button" onclick="PopOpen();" value="글머리" class="btn btn-primary btn-xs" >';
						_html +='									<input type="button" onclick="fnSetModifyBoard(' + d.board_cate_no + ',' + d2.board_no + ',\'' + d2.board_nm + '\');" value="수정" class="btn btn-primary btn-xs" >';
						_html +='									<input type="button" onclick="fnDeleteBoard(' + d2.board_no + ');" value="삭제" class="btn btn-danger btn-xs" >';
						_html +='								</td>';
						_html +='							</tr>';
						
					});
					
					_html +='						</tbody>';
					_html +='					</table>';
					
				});
				
				$("#boardMngWrap").html(_html);
				$("#s_board_cate_no option").remove();
				$("#s_board_cate_no").append(_opt);
		
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}

	

	//카테고리 수정
	function fnSetModifyCate(c,n){
		
		$("#board_cate_no").val(c);
		$("#board_cate_nm").val(n);
		
		$("#btnAddCate").addClass("dpn");
		$("#btnUpdateCate").removeClass("dpn");
		$("#btnCancelUpdateCate").removeClass("dpn");

	}
	
	//게시판 수정
	function fnSetModifyBoard(c1,c2,n){
		$("#s_board_cate_no").val(c1);
		$("#board_no").val(c2);
		$("#board_nm").val(n);
		
		$("#s_board_cate_no").attr("disabled",true);
		
		$("#btnAddBoard").addClass("dpn");
		$("#btnUpdateBoard").removeClass("dpn");
		$("#btnCancelUpdateBoard").removeClass("dpn");
		
	}
	
	
	function fnUpdateCateSeqPlus(board_cate_no, seq){
		
		var data = {};
		data.board_cate_no = board_cate_no;
		data.board_cate_typ = 2;
		data.seq = seq;
		
		$.ajax({
			type: "POST",
			url: '/ve/dc/VEDC01/updateBoardCateSeqPlus',
			data: data,
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code != '0') {
					toast('저장 되었습니다.');
					fnGetCateList();
				} else {
					toast('저장이 실패되었습니다.');
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	function fnUpdateCateSeqMinus(board_cate_no, seq){
		
		var data = {};
		data.board_cate_no = board_cate_no;
		data.board_cate_typ = 2;
		data.seq = seq;
		
		$.ajax({
			type: "POST",
			url: '/ve/dc/VEDC01/updateBoardCateSeqMinus',
			data: data,
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code != '0') {
					toast('저장 되었습니다.');
					fnGetCateList();
				} else {
					toast('저장이 실패되었습니다.');
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
		
	}
	
	function fnUpdateBoardSeqPlus(board_cate_no,board_no, seq){
		
		var data = {};
		data.board_cate_no = board_cate_no;
		data.board_no = board_no;
		data.seq = seq;
		
		$.ajax({
			type: "POST",
			url: '/ve/dc/VEDC01/updateBoardSeqPlus',
			data: data,
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code != '0') {
					toast('저장 되었습니다.');
					fnGetCateList();
				} else {
					toast('저장이 실패되었습니다.');
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	function fnUpdateBoardSeqMinus(board_cate_no,board_no, seq){
		
		var data = {};
		data.board_cate_no = board_cate_no;
		data.board_no = board_no;
		data.seq = seq;
		
		$.ajax({
			type: "POST",
			url: '/ve/dc/VEDC01/updateBoardSeqMinus',
			data: data,
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code != '0') {
					toast('저장 되었습니다.');
					fnGetCateList();
				} else {
					toast('저장이 실패되었습니다.');
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
		
	}
	
	function fnUpdateCate(){
		
		if($("#board_cate_nm").val() == ''){
			toast('제목을 입력하세요!');
			$("#board_cate_nm").focus();
			return;
		}
		
		$.ajax({
			type: "POST",
			url: '/ve/dc/VEDC01/updateBoardCate',
			data: $("#submitForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code != '0') {
					toast('저장 되었습니다.');
					fnGetCateList();
				} else {
					toast('저장이 실패되었습니다.');
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}

	function fnUpdateBoard(){
	
		if($("#board_nm").val() == ''){
			toast('제목을 입력하세요!');
			$("#board_nm").focus();
			return;
		}
		
		if($("#s_board_cate_no").val() == ''){
			toast('카테고리를 선택하세요!');
			return;
		}
				
		var data = {};
		data.board_cate_no = $("#s_board_cate_no").val();
		data.board_nm = $("#board_nm").val();
		data.board_no = $("#board_no").val();
		//data.seq = 99;
		
		$.ajax({
			type: "POST",
			url: '/ve/dc/VEDC01/updateBoardMst',
			data: data,
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code != '0') {
					toast('저장 되었습니다.');
					fnGetCateList();
	
				} else {
					toast('저장이 실패되었습니다.');
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	

	function fnAddCate(){
	
		if($("#board_cate_nm").val() == ''){
			toast('제목을 입력하세요!');
			$("#board_cate_nm").focus();
			return;
		}
		
		$.ajax({
			type: "POST",
			url: '/ve/dc/VEDC01/insertBoardCate',
			data: $("#submitForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code != '0') {
					toast('저장 되었습니다.');
					fnGetCateList();
				} else {
					toast('저장이 실패되었습니다.');
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}

	function fnAddBoard(){
	
		if($("#board_nm").val() == ''){
			toast('제목을 입력하세요!');
			$("#board_nm").focus();
			return;
		}
		
		if($("#s_board_cate_no").val() == ''){
			toast('카테고리를 선택하세요!');
			return;
		}
		
		toast($("#s_board_cate_no").val());
		
		var data = {};
		data.board_cate_no = $("#s_board_cate_no").val();
		data.board_nm = $("#board_nm").val();
		data.seq = 99;
		
		$.ajax({
			type: "POST",
			url: '/ve/dc/VEDC01/insertBoardMst',
			data: data,
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code != '0') {
					toast('저장 되었습니다.');
					fnGetCateList();
	
				} else {
					toast('저장이 실패되었습니다.');
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	
	
	</script>	
</head>
<body class="sky">

<form id="submitForm" name="submitForm">
<input type="hidden" name="vendor_no" 		id="vendor_no" value="${vendor_no}" />
<input type="hidden" name="board_cate_typ" 		id="board_cate_typ" value="2" />

	<!-- content_wrap -->
	<div class="content_wrap">

		<div class="product_admin">

			<div class="radio-group">
                <div class="option"><input type="radio" id="rd_vedc01" name="rd_vedc" value="1"><label class="radio-container" for="rd_vedc01" onclick="location.href = '/ve/dc/VEDC01/page?js_url=/ve/dc/VEDC01';" >회사보드관리</label></div>
                <div class="option"><input type="radio" id="rd_vedc02" name="rd_vedc" value="2" checked="checked"><label class="radio-container" for="rd_vedc02">연결보드관리</label></div>
                <div class="option"><input type="radio" id="rd_vedc03" name="rd_vedc" value="3"><label class="radio-container" for="rd_vedc03" onclick="location.href = '/ve/dc/VEDC01/page3?js_url=/ve/dc/VEDC01';" >회사배너추가</label></div>
            </div>
			
			<div class="tagCover mt10">
				<div class="fl pd10" style="border:1px solid #ccc; width:calc(46% - 20px) !important; ">
					<h1>Board Management(메인화면 노출용 게시판은 체크하세요)</h1>
					<div id="boardMngWrap" ></div>
				</div>
				<div class="fr pd10" style="border:1px solid #ccc; width:calc(50% - 20px) !important; ">
					<h1>Category Setting</h1>
					<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl" style="border-top: 0px;">
						<caption> 정보</caption>
							<colgroup>
								<col width="20%">
								<col width="80%">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><label>제목</label></th>
									<td>
										<input type="text" id="board_cate_nm" name="board_cate_nm" value="" style="width:65%" maxlength="50" required="">
										<input type="button" class="btn btn-primary btn-sm" value="카테고리 추가" id="btnAddCate">
										<input type="button" class="btn btn-primary btn-sm dpn" value="카테고리 수정" id="btnUpdateCate">
										<input type="button" class="btn btn-close btn-sm dpn" value="취소" id="btnCancelUpdateCate">
										<input type="text" name="board_cate_no" 			id="board_cate_no" value="" />
									</td>
								</tr>
						</tbody>
					</table>
					
					<h1 class="mt20">Board Setting</h1>
					<table cellspacing="0" cellpadding="0" summary="" class="layer_tbl" style="border-top: 0px;">
						<caption> 정보</caption>
							<colgroup>
								<col width="20%">
								<col width="80%">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><label>제목</label></th>
									<td>
										<input type="text" id="board_nm" name="board_nm" value="" style="width:65%" maxlength="50" required="">
										<input type="button" class="btn btn-primary btn-sm" value="게시판 추가" id="btnAddBoard">
										<input type="button" class="btn btn-primary btn-sm dpn" value="게시판 수정" id="btnUpdateBoard">
										<input type="button" class="btn btn-close btn-sm dpn" value="취소" id="btnCancelUpdateBoard">
									</td>
								</tr>
								<tr>
									<th scope="row"><label>카테고리</label></th>
									<td>
										<input type="text" name="board_no" 			id="board_no" value="" />
										<select id="s_board_cate_no" name="s_board_cate_no">
											<option value="">Category</option>
										</select>
									
									</td>
								</tr>
						</tbody>
					</table>
	
				</div>
			</div>

		</div>
	</div>
</form>

	<!-- //content_wrap -->
 <div id="toast"></div></body>

<script>
function fnDeleteBoard(v){
	
	var data = {};
	data.board_no = v;
	
	$.ajax({
		type: "POST",
		url: '/ve/dc/VEDC01/deleteBoardMst',
		data: data,
		dataType: 'json',
		contentType: 'application/x-www-form-urlencoded; charset=utf-8',
		success: function(data) {
			if(data.code != '0') {
				toast('삭제 되었습니다.');
				fnGetCateList();
			} else {
				toast('삭제가 실패되었습니다.');
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			toast(jqXHR.status);						
		}
	});
	
}

function fnDeleteCate(v){
	
	var data = {};
	data.board_cate_no = v;
	
	$.ajax({
		type: "POST",
		url: '/ve/dc/VEDC01/deleteBoardCate',
		data: data,
		dataType: 'json',
		contentType: 'application/x-www-form-urlencoded; charset=utf-8',
		success: function(data) {
			if(data.code != '0') {
				toast('삭제 되었습니다.');
				fnGetCateList();
			} else {
				toast('삭제가 실패되었습니다.');
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			toast(jqXHR.status);						
		}
	});
	
}

</script>

</html>