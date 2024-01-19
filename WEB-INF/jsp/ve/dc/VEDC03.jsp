<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>

	
	<script>
	
	$(document).ready(function(){
		
		$("#submitForm").validate({
			rules: {
				notice_typ: { required: true },
				title_txt: { required: true, maxlength: 100 },
			},
			messages: {
				title_txt: { required: "제목을 입력하세요", maxlength: jQuery.format("제목은 최대 {0} 글자 이하로 입력하세요." ) }
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);  
			},
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {

				alert(42);
				
				$('#btnSave').off('click');
				
				var iframeId = 'unique' + (new Date().getTime());  //generate a random id
				var iframe = $('<iframe src="javascript:false;" name="'+iframeId+'"/>');  //create an empty iframe
				iframe.hide();  //hide it
				$('#submitForm').attr('target',iframeId);  //set form target to iframe			
				
				iframe.appendTo('body');  //Add iframe to body
				form.action = '/ve/dc/VEDC01/insertBanner';
				form.method = 'post';
				form.submit();
				
				
				alert(55);
				
				iframe.load(function(e) {
					
		            var doc = getDoc(iframe[0]);
		            var docRoot = doc.body ? doc.body : doc.documentElement;
		            var data = docRoot.innerHTML;

					if (data == "0") {
						toast("등록하였습니다.");
						self.close();
					}else if (data == "-1") {
						toast("등록하신 첨부파일은 업로드 가능한 파일 확장자가 아닙니다");
					}
					else {
						ajaxError();
					}
		        });
			}
		});
		
	});
	
	
	function fn_f10(){
		
		if($("#inptFile0").val()==''){
			toast('파일을 선택하세요.');
			return false;
		}
		alert(23);
		$("#submitForm").submit();
	}
	

	
	</script>
	
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
<!-- 		<div class="history"> -->
<!-- 			<h3 class="header"></h3> -->
<!-- 			<div class="btn-wrap"> -->
<!-- 				<input type="button" class="btn btn-success btn-sm" value="검색[F3]" id="btnSearch"> -->
<!-- 				<input type="button" class="btn btn-primary btn-sm" value="신규등록[F9]" id="btnAdd">				 -->
<!-- 			</div> -->
<!-- 		</div> -->
		<!-- product_admin -->
		<div class="product_admin">
		
			<div class="radio-group">
                <div class="option"><input type="radio" id="rd_vedc01" name="rd_vedc" value="1"><label class="radio-container" for="rd_vedc01" onclick="location.href = '/ve/dc/VEDC01/page?js_url=/ve/dc/VEDC01';" >회사보드관리</label></div>
                <div class="option"><input type="radio" id="rd_vedc02" name="rd_vedc" value="2"><label class="radio-container" for="rd_vedc02" onclick="location.href = '/ve/dc/VEDC01/page2?js_url=/ve/dc/VEDC01';" >연결보드관리</label></div>
                <div class="option"><input type="radio" id="rd_vedc03" name="rd_vedc" value="3" checked="checked"><label class="radio-container" for="rd_vedc03">회사배너추가</label></div>
            </div>
		
			
			<div class="tagCover mt10">
				<div class="fl pd10" style="border:1px solid #ccc; width:calc(46% - 20px) !important; ">
					<h1>회사배너추가(738 X 130)</h1>

					<form action="#" id="submitForm" enctype="multipart/form-data">
						<fieldset>
							<legend></legend>
							<input type="hidden" name="mode" value="${mode}"/>
							<input type="hidden" name="doc_no" value="${info.doc_no}"/>
							<input type="hidden" id="hdnGridData1" name="staffs" />
							<input type="hidden" id="attachfile_txt" name="attachfile_txt" value="${info.attachfile_txt}"/>
							<div class="layer_contents">
								<table cellspacing="0" cellpadding="0" class="layer_tbl">
								<caption>${mode == "new" ? "관리자 게시판 등록 페이지" : "관리자 게시판 상세 페이지"}</caption>
									<colgroup>
										<col width="20%"/>
										<col width="70%"/>
										<col width="10%"/>
									</colgroup>
									<tbody>
										<tr>
											<th scope="row" rowspan="3">첨부파일</th>
											<td  id="tdAttachment" class="addD2">
												<input type="file" class="file_1" id="inptFile0" name="attachFile0" title="파일첨부" style="width: 40%"/>
												
											</td>
											<td>
												<input type="button" class="btn btn-primary btn-sm" value="SAVE" id="btnSave">
											</td>
										</tr>
									</tbody>
								</table>
							</div>
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