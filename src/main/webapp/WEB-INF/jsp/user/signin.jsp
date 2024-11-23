<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="cl" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp" />

        <div class="mt-12 mx-auto max-w-md w-full bg-white p-8 rounded-lg border">
            <h2 class="text-2xl font-bold text-center mb-6">로그인</h2>
            <form action="${ cl }/signin" method="post" autocomplete="off">
                <div class="mb-4">
                    <label class="block text-gray-700" for="login-email">사용자 이름</label>
                    <input class="mt-1 block w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500" type="text" id="username" name="username" placeholder="사용자 이름을 입력하세요" required>
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700" for="login-password">비밀번호</label>
                    <input class="mt-1 block w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500" type="password" id="userpassword" name="userpassword" placeholder="비밀번호를 입력하세요" required>
                </div>
                <button class="w-full bg-blue-500 text-white p-2 rounded hover:bg-blue-600 transition duration-200" type="submit">로그인</button>
            </form>
            <p class="mt-4 text-center text-gray-600">아직 회원이 아니신가요? <a href="${ cl }/signup" class="text-blue-500 hover:underline">회원가입하기</a></p>
        </div>

	<jsp:include page="/WEB-INF/common/footer.jsp" />
</body>
</html>