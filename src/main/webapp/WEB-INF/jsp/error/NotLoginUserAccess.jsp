<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="cl" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>${ errorMessage }</title>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp" />
	
	<h1 class="text-center text-black text-3xl mt-32">${ errorMessage }</h1><br><br>
	<div class="w-40 h-12 max-w-md mx-auto">
		<a href="${ cl }/">
			<button class="relative inline-flex items-center justify-center p-0.5 mb-2 me-2 overflow-hidden text-2xl font-medium text-gray-900 rounded-lg bg-black">
				<span class="relative px-5 py-2.5 transition-all ease-in duration-75 dark:bg-gray-900 rounded-md hover:bg-opacity-0 bg-white hover:text-white">
					돌아가기
				</span>
			</button>
		</a>
	</div>	
	
	<jsp:include page="/WEB-INF/common/footer.jsp" />
</body>
</html>