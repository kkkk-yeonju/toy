<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
	<title>${ title }</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/board/resources/css/style.css">

</head>
<body>
<div class="container">
<div class="row justify-content-end py-3">
	<c:choose>
		<c:when test="${ empty loginuser }">
			<a class="pr-3" href="/board/account/login">로그인</a>
			<a href="/board/account/register">회원가입</a>
		</c:when>
		<c:otherwise>
		<c:choose>
			<c:when test="${ alarmCnt == 0 }">
				<div id="alarmCount"></div>
			</c:when>
			<c:otherwise>
				<div id="alarmCount" class="alarm_bedge">${ alarmCnt }</div>
			</c:otherwise>
		</c:choose>
			<a class="bell px-3" role="button"></a>
			<a class="pr-3" href="#">${ loginuser.id }님</a>
			<a href="/board/account/logout">로그아웃</a>
		</c:otherwise>
	</c:choose>
	</div>
	<div class="row justify-content-end">
		<div class="bubble" id="divToggle" style="display: none;" >
			<c:choose>
				<c:when test="${ fn:length(alarms) > 0 }">
					<c:forEach var="alarm" items="${ alarms }" varStatus="status">
						<div class="alarm_content py-2" id="alarm_content" data-alarmno="${ alarm.alarmNo }">
							${ alarm.content }
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="py-5 text-center" id="alarm_content">
						<b>알람이 없습니다.</b>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="alert alert-success" role="alert" id="socketAlert" style="display:none"></div>
</div>