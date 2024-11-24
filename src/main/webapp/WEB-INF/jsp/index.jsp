<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="cl" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>채팅 애플리케이션</title>
</head>
<body>
    <jsp:include page="/WEB-INF/common/header.jsp" />

	<div class="p-5 max-w-5xl mx-auto flex p-4"> <!-- max-width: 1024px; min-width: 320px; -->
		<c:if test="${ not empty AllChatRoom }">
			<ul role="list" class="px-5 w-full block"> <!-- width: 384px; -->
	            <c:forEach var="room" items="${ AllChatRoom }">
	                <a href="${ cl }/chatroom?roomname=${ room.roomname }&ownername=${ room.ownername }&roomid=${ room.roomid }" class="flex justify-between gap-x-6 py-5 px-8 border-b-1 border-gray-300 hover:bg-gray-100">
	                    <div class="flex min-w-0 gap-x-4 py-2">
	                        <div class="min-w-0 flex-auto">
	                            <p class="text-xl font-semibold leading-6 text-gray-900">${ room.roomname }</p>
	                            <p class="mt-1 truncate text-xl leading-5 text-gray-500">${ room.roomnameinname }</p>
	                            <p class="mt-5 truncate text-xl leading-5 text-gray-500">${ room.ownername }</p>
	                        </div>
	                    </div>
	                </a>
	            </c:forEach>
	        	<div class="flex justify-center my-4" aria-label="Page navigation example">
			        <c:if test="${ not empty pageBar }">${ pageBar }</c:if>
			    </div>
	        </ul>
		</c:if>
	</div>
    
    <c:if test="${ empty AllChatRoom }">
        <h2 class="text-center text-3xl m-24">아무런 방도 있지 않음</h2>
    </c:if>
    
    <button type="button" onclick="onTop()" class="fixed bottom-16 right-0 inline-flex items-center justify-center p-0.5 mb-2 me-2 
    	overflow-hidden text-2xl font-medium text-gray-900 rounded-full group bg-gradient-to-br from-pink-500 to-orange-400 group-hover:from-pink-500 
    	group-hover:to-orange-400 hover:text-white dark:text-white focus:ring-4 focus:outline-none focus:ring-pink-200 dark:focus:ring-pink-800">
	    <span class="relative px-4 py-3 transition-all ease-in duration-75 bg-white dark:bg-gray-900 rounded-full group-hover:bg-opacity-0">
	        ▲
	    </span>
	</button>
	<button type="button" onclick="onBottom()" class="fixed bottom-0 right-0 inline-flex items-center justify-center p-0.5 mb-2 me-2 
		overflow-hidden text-2xl font-medium text-gray-900 rounded-full group bg-gradient-to-br from-pink-500 to-orange-400 group-hover:from-pink-500 
		group-hover:to-orange-400 hover:text-white dark:text-white focus:ring-4 focus:outline-none focus:ring-pink-200 dark:focus:ring-pink-800">
	    <span class="relative px-4 py-3 transition-all ease-in duration-75 bg-white dark:bg-gray-900 rounded-full group-hover:bg-opacity-0">
	        ▼
	    </span>
	</button>
	
	<script>
		function onTop() {window.scrollTo({ top: 0, behavior: 'smooth' })}
		function onBottom() {window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' })}
	</script>
	
    <jsp:include page="/WEB-INF/common/footer.jsp" />
</body>
</html>