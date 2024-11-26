<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="cl" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${ chat.roomname } | ${ chat.ownername } | 이름추천</title>
    <script> let loggedInUsername = "${user.username}"; let roomid = "${chat.roomid}";</script>
</head>
<body>
    <div class="flex h-screen">
        <div id="sidebar" class="w-64 bg-gray-900 text-white px-4 scroll space-y-6 fixed h-full transform -translate-x-full">
		    <a href="${ cl }/" class="text-2xl border-b border-gray-700 font-bold text-center mt-4 pb-4 block">이름추천</a>	
		    <a href="${ cl }/profile/${ chat.ownername }" class="text-2xl font-bold text-left ml-2 block" target="_blank">${ chat.ownername } (관리자)</a>
		    
		    <nav class="space-y-4">
		        <c:if test="${ empty user }">
		            <ul class="space-y-2">
		                <li><a href="${ cl }/search" class="block py-2 px-4 text-gray-300 rounded hover:bg-gray-700">검색</a></li>
		                <li><a href="${ cl }/signin" class="block py-2 px-4 bg-blue-600 text-white rounded hover:bg-blue-700 text-center">로그인</a></li>
		                <li><a href="${ cl }/signup" class="block py-2 px-4 text-blue-600 border border-blue-600 rounded hover:bg-blue-600 hover:text-white text-center">회원가입</a></li>
		            </ul>
		        </c:if>
		        
		        <c:if test="${ not empty user }">
		            <details>
		                <summary class="py-2 px-4 text-gray-300 rounded hover:bg-gray-700 cursor-pointer">내 계정</summary>
		                <ul class="ml-4 space-y-2">
		                    <li><a href="${ cl }/profile/${ user.username }" class="block py-2 px-4 text-gray-300 rounded hover:bg-gray-700" target="_blank">${ user.username }님 프로필</a></li>
		                    <form action="${ cl }/logout" method="post" autocomplete="off" class="inline">
		                        <button type="submit" class="block py-2 px-4 text-left text-gray-300 w-full rounded hover:bg-gray-700">로그아웃</button>
		                    </form>
		                </ul>
		            </details>
		            <details>
		                <summary class="py-2 px-4 text-gray-300 rounded hover:bg-gray-700 cursor-pointer">채팅방 관리</summary>
		                <ul class="ml-4 space-y-2">
		                    <li><a href="${ cl }/create" class="block py-2 px-4 text-gray-300 rounded hover:bg-gray-700" target="_blank">방 만들기</a></li>
		                    <li><a href="${ cl }/myChatroom/${ user.userid }" class="block py-2 px-4 text-gray-300 rounded hover:bg-gray-700" target="_blank">내가 만든 채팅방</a></li>
		                </ul>
		            </details>
		            <details>
		                <summary class="py-2 px-4 text-gray-300 rounded hover:bg-gray-700 cursor-pointer">현재 접속 유저 : <span id="userCount"></span>명</summary>
		                <div id="user-list-container"></div>
		            </details>
		        </c:if>
		        
		        <button onclick="leaveChatRoom()" class="py-2 px-4 text-black rounded bg-gray-100 hover:bg-red-700 hover:text-white cursor-pointer absolute bottom-6 left-6 w-4/5">나가기</button>
		    </nav>
		</div>

        <div id="main-content" class="flex-1 flex flex-col bg-white ml-64">
            <div class="py-4 pr-4 bg-blue-900 text-white flex items-center justify-between" id="chatHeader">
            	<div class="flex items-center relative">
            		<button onclick="toggleSidebar()" class="bg-gray-900 text-white text-2xl absolute left-0" style="width: 60px; height: 60px;">☰</button>
                	<h2 class="text-lg font-semibold ml-20" id="chatroomname">${ chat.roomname } 채팅방</h2>
            	</div>
            	<div class="flex items-center">
                	<h2 class="text-lg font-semibold">방 고유 번호: ${ chat.roomid }</h2>
            		<input type="checkbox" id="chkbg" class="w-5 h-5 ml-5 cursor-pointer" onclick="blackAndWhite()">
            	</div>
            </div>

            <div class="flex-1 overflow-y-auto p-6 space-y-4" id="message-container"></div>

            <div class="p-4 bg-gray-100 border-t border-gray-300 flex items-center space-x-2" id="mf">
                <textarea id="chattext" rows="1" class="flex-1 p-3 rounded-lg bg-white border border-gray-300 focus:outline-none focus:ring-2 resize-none focus:ring-blue-500 placeholder-gray-400" placeholder="메시지를 입력하세요..."></textarea>
                <button type="submit" form="messageForm" class="h-full px-8 py-2 bg-blue-600 text-lg text-white rounded-lg hover:bg-blue-700">전송</button>
                <form id="messageForm" onsubmit="sendMessage(event)" class="hidden"></form>
            </div>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/common/footer.jsp" />
</body>
</html>

<!--
	<c:forEach var="message" items="${ messages }">
		<div class="flex items-start space-x-3">
        	<div>
            	<p class="text-sm font-semibold text-gray-700">${ fn:escapeXml(message.username) }</p>
                <p class="bg-gray-100 p-3 rounded-lg max-w-xs">${ fn:escapeXml(message.chattext) }</p>
			</div>
		</div>
	</c:forEach>
-->




