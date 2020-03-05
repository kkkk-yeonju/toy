<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:choose>
				<c:when test="${fn:length(comments) > 0 }">
					<c:forEach var="comment" items="${ comments }">
						<div id="tr${ comment.commentNo }">
							<div class="row"
								style="text-align:left;margin:5px;border-bottom: solid 1px;padding-left:${ comment.depth * 20 }px">
								<div class="col" id='commentview${ comment.commentNo }'>
									${ comment.writer } &nbsp;&nbsp; [${ comment.regDate }] <br />
									<br />
									<div>${ comment.content }</div>
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
										<form id="recomment-form" class="row justify-content-center">
											<input type="hidden" name="commentNo" value="${comment.commentNo}"> 
											<input type="hidden" name="boardNo" value="${ board.boardNo }">
											<label>작성자</label><input type="text" name="writer"> 
											<textarea class="form-control col-8" name="content" rows="5"></textarea>

											<div class="col-2 button cart_button">
												<a id="write-recomment" href="#" class="btn-xs">작성</a>
											</div>
										</form>
									</div>

								</div>

								<div id='commentedit${ comment.commentNo }'
									style="display: none">
									${ comment.writer } &nbsp;&nbsp; [${ comment.regDate }] <br />
									<br />
									<form id="updateform${ comment.commentNo }">
										<input type="hidden" name="commentNo"
											value="${ comment.commentNo }" />
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
<jsp:include page="include/footer.jsp"/>