<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="include/header.jsp"/>
<div class="container">
	<h2>게시글</h2>
		<table class="table">
			<thead>
				<tr>
					<th scope="col">글번호</th>
					<td scope="col">${ board.boardNo }</td>
					<th scope="col">작성날짜</th>
					<td scope="col"><fmt:formatDate value="${ board.regDate }" pattern="YYYY-MM-dd" /></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="row">제목</th>
					<td colspan="3">${ board.title }</td>
				</tr>
				<tr>
					<th scope="row">작성자</th>
					<td colspan="3">${ board.writer }</td>
				</tr>
				<tr>
					<th scope="row">내용</th>
					<c:set var="enter" value="
" />
					<td colspan="3">${ fn:replace(board.content, enter, '<br>') }</td>
				</tr>
			</tbody>
		</table>
		<div class="float-right" >
			<a class="btn btn-dark" href="/board/" role="button">목록</a>
			<a class="btn btn-dark" href="/board/update/${ board.boardNo }" role="button">수정</a>
			<a class="btn btn-dark" href="/board/delete/${ board.boardNo }" role="button" onclick="return confirm(${ board.boardNo }+'번 글을 삭제하시겠습니까?');">삭제</a>
		</div>
		
		
		<!-- 댓글 작성 -->
		<form class="form-inline" name="commentform" id="commentform">
			<input type="hidden" name="boardNo" id="boardNo" value="${ board.boardNo }" />
			<input type="hidden" name="writer" id="comwriter" value="${ loginuser.id }"/>
		<!-- 	<div class="form-group">
				<label>작성자</label><input type="text" class="form-control" name="writer">
			</div> -->
			<div class="form-group mx-sm-3">
				<label>댓글 내용</label><input type="text" class="form-control" name="content">
			</div>
			<a class="btn btn-dark" role="button" id="writecomment" href="javascript:">댓글등록</a>
		</form>
		<hr>
		<!-- comment list -->
		<div id="comment-list" class="container">
			<h3>Comments</h3>
			<c:choose>
				<c:when test="${fn:length(comments) > 0 }">
					<c:forEach var="comment" items="${ comments }">
						<div id="tr${ comment.commentNo }">
							<div class="row"
								style="text-align:left;margin:5px;border-bottom: solid 1px;padding-left:${ comment.depth * 20 }px">
								<div class="col" id='commentview${ comment.commentNo }'>
									${ comment.writer } &nbsp;&nbsp; [${ comment.regDate }] <br />
									<br />
									<span>${ comment.content }</span>
									<div>
										<a class="editcomment" data-commentno='${ comment.commentNo }'
											href="javascript:">편집</a> &nbsp; 
										<a class="deletecomment"
											href="javascript:" data-commentno="${ comment.commentNo }">삭제</a>
									</div>
									<a class="recomment-link" data-commentno="${ comment.commentNo }"
										data-toggle="collapse" href="#collapse${ comment.commentNo }" role="button" 
										aria-expanded="false" aria-controls="collapse${ comment.commentNo }">댓글 쓰기</a>
									<!-- 대댓글 form -->
									<div class="collapse" id="collapse${ comment.commentNo }">
										<form id="recomment-form${ comment.commentNo }" class="row justify-content-center">
											<input type="hidden" name="commentNo" value="${comment.commentNo}"> 
											<input type="hidden" name="boardNo" value="${ board.boardNo }">
											<label>작성자</label><input type="text" name="writer"> 
											<textarea class="form-control col-8" name="content" rows="5"></textarea>

											<div class="col-2 button cart_button">
												<a id="write-recomment" class="btn btn-xs" role="button" data-commentno="${ comment.commentNo }">작성</a>
											</div>
										</form>
									</div>

								</div>

								<div id='commentedit${ comment.commentNo }'
									style="display: none">
									${ comment.writer } &nbsp;&nbsp; [${ comment.regDate }] <br />
									<br />
									<!-- 댓글수정form -->
									<form id="updateform${ comment.commentNo }">
										<input type="hidden" name="commentNo" value="${ comment.commentNo }" />
										<input type="text" name="writer" value="${ comment.writer }">
										<textarea name="content" style="width: 550px" rows="3"
											maxlength="200">${ comment.content }</textarea>
									</form>
									<br />
									<div>
										<a class="updatecomment" href="javascript:"
											data-commentno="${ comment.commentNo }">수정</a> &nbsp; 
										<a class="cancel" data-commentno="${ comment.commentNo }"
											href="javascript:">취소</a>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div>
						등록된 댓글이 없습니다.
					</div>
				</c:otherwise>
			</c:choose>
		</div>

	</div>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script> 
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">

$(function() {
	//var boardNo = $('#boardNo').val();
	$('#writecomment').on('click', function(event){
		//serialize() : <form>안에 포함된 입력 요소의 값을 이름=값&이름=값&...형식으로 만드는 함수 
		var formData = $('#commentform').serialize();
		var comwriter = $('#comwriter').val();

		$.ajax({
			url: "/board/write-comment",
			method: "POST",
			data: formData,
			success: function(data, status, xhr){
				$('#comment-list').load('/board/comment-list',
										{"boardNo" : ${board.boardNo}},
										function() {/* alert("댓글이 등록되었습니다"); */})
										
					/* 댓글작성자, 게시글작성자 -> 로그인 한 아이디로 어떻게 받지????(댓글작성자 어케받누) */
					if (socket) {
						// websocket에 보내기!! (comment,댓글작성자(id),게시글작성자(id),글번호)
						let socketMsg = "comment," + comwriter + "," + "${ board.writer }" + "," + ${ board.boardNo };
						console.debug("sssssssmsg>>", socketMsg)
						socket.send(socketMsg);
					}
			},
			error: function(xhr, status, err){
				alert(err);
			} 
		});

		var AlarmData = {
				"receiver" : '${board.writer}',
				"sender" : comwriter,
				"content" :  comwriter + "님이 <a id='alarm' href='/board/detail/"+ ${board.boardNo} +"'>" + ${ board.boardNo } + "</a>번 게시글에 댓글을 달았습니다!",
				"readCheck" : 0
		};

		//댓글 알림 DB저장
		$.ajax({
			url : "/board/saveAlarm",
			method: "POST",
			data : JSON.stringify(AlarmData),
			contentType: "application/json; charset=utf-8",
			dataType : 'text',
			success : function(data){
				/* if (socket) {
					// websocket에 보내기!! (comment,댓글작성자(id),게시글작성자(id),글번호)
					let socketMsg = "comment," + comwriter + "," + "${ board.writer }" + "," + ${ board.boardNo };
					console.debug("sssssssmsg>>", socketMsg)
					socket.send(socketMsg);
				} */
				console.log(AlarmData);
	 
			},
			error : function(err){
				console.log(err);
			}
		});
	});

		var currentCommentNo = -1;
		//$('.editcomment').on('click', function(event) {
		$('#comment-list').on('click', '.editcomment', function(event) { //comment-list한테 editcomment에게 이벤트 전달해줘
			commentNo = $(this).attr('data-commentno'); // $(event.target) == $(this)
			
			//이전에 편집중인 항목을 원래 상태로 복구
			if(currentCommentNo != -1){
				$('#commentview' + currentCommentNo).css('display', '');
				$('#commentedit' + currentCommentNo).css('display', 'none');
				
			}
			
			$('#commentview' + commentNo).css('display', 'none');
			$('#commentedit' + commentNo).css('display', '');
			currentCommentNo = commentNo;
		});
		
		//$('.cancel').on('click', function(event) {
		$('#comment-list').on('click', '.cancel', function(event) { //comment-list한테 cancel에게 이벤트 전달해줘
			commentNo = $(this).attr('data-commentno'); // $(event.target) == $(this)
			$('#commentview' + commentNo).css('display', '');
			$('#commentedit' + commentNo).css('display', 'none');			
			currentCommentNo = -1;
		});
		
		//$('.deletecomment').on('click', function(event){
		$('#comment-list').on('click', '.deletecomment', function(event) { //comment-list한테 deletecomment에게 이벤트 전달해줘
			commentNo = $(this).attr('data-commentno');
			$.ajax({
				url: "/board/delete-comment",
				method: "GET",
				data: "commentNo=" + commentNo,
				success: function(data, status, xhr){
					if(data == 'success'){
						$('#tr' + commentNo).remove();
						alert('삭제했습니다.');
					}else{
						alert('삭제 실패 1');
					}
				},
				error: function(xhr, status, err){
					alert('삭제 실패 2');
				}
			});
		});
		
		$('#comment-list').on('click', '.updatecomment', function(event) {
			//현재 클릭된 <a 의 data-commentno 속성 값 읽기
			var commentNo = $(this).attr('data-commentno');
			var content = $('#updateform' + commentNo + ' textarea').val();
			var inputData = $('#updateform' + commentNo).serialize();
			
			//ajax 방식으로 데이터 수정
			$.ajax({
				url: "/board/update-comment",
				method: "POST",
				data: inputData,
				success: function(data, status, xhr) {
					alert('댓글을 수정했습니다.');
					var span = $('#commentview' + commentNo + ' span');					
					span.html(content.replace(/\n/gi, '<br>'));
					//view-div는 숨기고, edit-div는 표시하기	
					$('#commentview' + commentNo).css('display', 'block');
					$('#commentedit' + commentNo).css('display', 'none');
				},
				error: function(xhr, status, err) {
					alert('댓글 수정 실패');
				}
			});
		});

		//대댓글 작성
		$('#comment-list').on('click', '#write-recomment',function(event) {

			var commentno = $(this).attr('data-commentno');

			//이걸 다른 방식으로 어떻게 표현하지?
			/* var content = $('#recomment-form'+commentno+'textarea').val();
			if (content.length == 0) return; */

			//그냥 recomment-form으로 했더니 첫번째 form만 인식하고 밑에는 인식 못해서 아이디 다 다르게 해줌
			var recommentData = $('#recomment-form'+commentno).serialize();
			
			$.ajax({
				url: "/board/write-recomment",
				method: "POST",
				data: recommentData,
				success: function(data, status, xhr) {
					alert('success');			
					//recomment-form 문서내의 모든 form 리셋		
					$('#recomment-form').each(function() {
						this.reset();
					});
					$("#comment-list").load('/board/comment-list', 
							{ "boardNo" : ${board.boardNo} }, 
							function() {})
					
				},
				error: function(xhr, status, err) {
					alert('fail');
				}
			});
		
		});	
			
		
});
</script>

<jsp:include page="include/footer.jsp"/>
