<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<jsp:include page="include/header.jsp"/>
<div class="container">
	<h2>게시글 작성</h2>
	<form action="/board/write" method="post">
		<div class="form-group">
			<label>제목</label> 
			<input type="text" class="form-control" name="title"> 
		</div>
		<div class="form-group">
			<label>작성자</label> 
			<input type="text" class="form-control" name="writer" value="${ loginuser.id }">
		</div>
		<div class="form-group">
			<label>내용</label>
			<textarea class="form-control" name="content" rows="6"></textarea>
		</div>
		<div class="float-right">
			<button type="submit" class="btn btn-dark">등록</button>
			<a class="btn btn-dark" href="/board/" role="button">취소</a>
		</div>
	</form>
</div>

<jsp:include page="include/footer.jsp"/>
