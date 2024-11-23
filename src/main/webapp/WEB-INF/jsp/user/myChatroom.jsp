<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="cl" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>${ userProfile.username }님 채팅방 리스트</title>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp" />
	
	<c:if test="${ not empty rooms }">
		<c:forEach var="myr" items="${ rooms }">
			<li>${ myr }</li>
		</c:forEach>
	</c:if>
	
	<c:if test="${ empty rooms }">
		<p class="text-3xl text-center mt-24">${ user.username }님이 만드신 방이 없습니다.</p>
	</c:if>
	
	<jsp:include page="/WEB-INF/common/footer.jsp" />
</body>
</html>