<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="cl" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>검색</title>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp" />
	
	<form action="${ cl }/search" method="get" autocomplete="on" class="flex rounded-lg border-2 border-blue-500 overflow-hidden max-w-2xl mt-48 mx-auto font-[sans-serif]">
		<input type="text" name="searchTag" placeholder="검색어를 입력하세요" class="w-full outline-none bg-white text-gray-600 text-3xl px-5 py-3" required />
		<button type="submit" class="flex items-center justify-center bg-[#007bff] px-6">
        	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192.904 192.904" width="24px" class="fill-white">
            	<path d="m190.707 180.101-47.078-47.077c11.702-14.072 18.752-32.142 18.752-51.831C162.381 36.423 125.959 
            		0 81.191 0 36.422 0 0 36.423 0 81.193c0 44.767 36.422 81.187 81.191 81.187 19.688 0 37.759-7.049 
            		51.831-18.751l47.079 47.078a7.474 7.474 0 0 0 5.303 2.197 7.498 7.498 0 0 0 5.303-12.803zM15 81.193C15 
            		44.694 44.693 15 81.191 15c36.497 0 66.189 29.694 66.189 66.193 0 36.496-29.692 66.187-66.189 66.187C44.693 
            		147.38 15 117.689 15 81.193z">
            	</path>
          	</svg>
		</button>
	</form>
	
	<jsp:include page="/WEB-INF/common/footer.jsp" />
</body>
</html>