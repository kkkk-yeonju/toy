<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="include/header.jsp"/>
	<table class="table">
		<thead>
			<tr>
				<th scope="col">글번호</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">날짜</th>
			</tr>
		</thead>
		<tbody>
		<c:choose>
			<c:when test="${fn:length(boards) > 0 }">
				<c:forEach var="board" items="${ boards }" varStatus="status">
					<tr>
						<th scope="row">${ board.boardNo }</th>
						<td><a href="/board/detail/${board.boardNo}">${ board.title }</a></td>
						<td>${ board.writer }</td>
						<td><fmt:formatDate value="${ board.regDate }" pattern="YYYY-MM-dd" /></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<th colspan="4" class="text-center">등록된 글이 없습니다.</th>
				</tr>
			</c:otherwise>
		</c:choose>
		</tbody>
	</table>
	<div class="float-right">
		<a class="btn btn-dark" href="write" role="button">글작성</a>
	</div>

	<div class="container row justify-content-center" id="paginationBox">
			<ul class="pagination">
				<c:if test="${pagination.prev}">
					<li class="page-item">
						<a class="page-link" href="#" onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}', '${param.keyword}')">Previous</a>
					</li>
				</c:if>
				<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
					<li class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> ">
						<a class="page-link" href="#" onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}', '${param.keyword}')">${idx}</a>
					</li>
				</c:forEach>

				<c:if test="${pagination.next}">
					<li class="page-item">
						<a class="page-link" href="#" onClick="fn_next('${pagination.range}','${pagination.range}', '${pagination.rangeSize}', '${param.keyword}')">Next</a>
					</li>
				</c:if>
			</ul>
		</div>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">

	//이전 버튼 이벤트
	function fn_prev(page, range, rangeSize, keyword) {

		var page = ((range - 2) * rangeSize) + 1;
		var range = range - 1;
		var url = "${pageContext.request.contextPath}";

		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&keyword=" + keyword;

		location.href = url;

	}

	//페이지 번호 클릭
	function fn_pagination(page, range, rangeSize, keyword) {

		var url = "${pageContext.request.contextPath}";

		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&keyword=" + keyword;

		location.href = url;

	}

	//다음 버튼 이벤트
	function fn_next(page, range, rangeSize, keyword) {

		var page = parseInt((range * rangeSize)) + 1;

		var range = parseInt(range) + 1;

		var url = "${pageContext.request.contextPath}";

		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&keyword=" + keyword;

		location.href = url;
	}
	
</script>
<jsp:include page="include/footer.jsp"/>
