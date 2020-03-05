<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<jsp:include page="include/header.jsp"/>
<div class="container">
	<h2>게시글 수정</h2>
	<form action="/board/update" method="post">
		<input type="hidden" name="boardNo" value="${ board.boardNo }">
		<div class="form-group">
			<label>제목</label> 
			<input type="text" class="form-control" name="title" value="${ board.title }" > 
		</div>
		<div class="form-group">
			<label>작성자</label> 
			<input type="text" class="form-control" name="writer" value="${ board.writer }">
		</div>
		<div class="form-group">
			<label>내용</label>
			<textarea class="form-control" name="content" rows="6">${ board.content }</textarea>
		</div>
		<div class="float-right">
			<button type="submit" class="btn btn-dark">등록</button>
			<a class="btn btn-dark" href="/board/" role="button">취소</a>
		</div>
	</form>
</div>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<jsp:include page="include/footer.jsp"/>
