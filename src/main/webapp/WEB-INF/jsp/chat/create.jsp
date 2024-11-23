<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="cl" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>채팅 방 만들기</title>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp" />

	<div class="mx-auto max-w-md w-full bg-white border border-gray-300 p-8 rounded-lg shadow-md" style="margin-top: 100px;">
        <h2 class="text-2xl font-bold text-center mb-6">채팅 방 만들기</h2>
        <form action="${ cl }/create/createChatRoom" method="post" autocomplete="off">
        	<div class="mb-4">
                <label class="block text-gray-700" for="roomname">채팅 방 만든 사람</label>
                <input class="mt-1 block w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                	type="text" id="ownername" name="ownername" value="${ user.username }" readonly required>
            </div>
            <div class="mb-4">
                <label class="block text-gray-700" for="roomname">채팅 방 이름</label>
                <input class="mt-1 block w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                	type="text" id="roomname" name="roomname" placeholder="채팅 방 이름을 입력하세요" required>
            </div>
            <div class="mb-4">
                <label class="block text-gray-700" for="roomnameinname">채팅 방 설명</label>
                <textarea class="mt-1 block w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                	id="roomnameinname" name="roomnameinname" placeholder="채팅 방 설명을 입력하세요" style="resize: none;" rows="4" required></textarea>
            </div>
            <button class="w-full bg-blue-500 text-white p-2 rounded hover:bg-blue-600 transition duration-200" type="submit">방 만들기</button>
        </form>
        <p class="mt-4 text-center text-gray-600">이미 방이 있으신가요? <a href="#" class="text-blue-500 hover:underline">채팅 방 목록 보기</a></p>
    </div>

	<jsp:include page="/WEB-INF/common/footer.jsp" />
</body>
</html>