<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="cl" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
	
	<c:if test="${ not empty errorMessage }">
	    <div class="alert alert-danger">
	        ${ errorMessage }
	    </div>
	</c:if>

	<div class="mt-12 mx-auto max-w-md w-full bg-white p-8 rounded-lg border">
	    <h2 class="text-2xl font-bold text-center mb-6">회원가입</h2>
	    <form action="${ cl }/signup" method="post" autocomplete="off">
	        <div class="mb-4">
	            <label class="block text-gray-700" for="username">사용자 이름</label>
	            <input class="mt-1 block w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
	                type="text" id="username" name="username" placeholder="사용자 이름을 입력하세요" required>
	        </div>
	
	        <div class="mb-4">
	            <label class="block text-gray-700" for="useremail">이메일</label>
	            <input class="mt-1 block w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
	                type="email" id="useremail" name="useremail" placeholder="이메일을 입력하세요" required>
	        </div>
	
			<div class="mb-4">
		    	<label class="block text-gray-700" for="userpassword">비밀번호</label>
		        	<input class="mt-1 block w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
		            	type="password" id="userpassword" name="userpassword" placeholder="비밀번호를 입력하세요" required>
			</div>
			
			<div class="mb-4">
	        	<label class="block text-gray-700" for="userbio">사용자 소개말</label>
	            	<textarea class="mt-1 block w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
	                	id="userbio" name="userbio" placeholder="자기소개를 입력하세요" style="resize: none; height: 130px;" required></textarea>
			</div>
			
			<input type="hidden" name="status" id="status" readonly="readonly" required="required" value="offline">
			
	        <button class="w-full bg-blue-500 text-white p-2 rounded hover:bg-blue-600 transition duration-200" type="submit">가입하기</button>
	    </form>
	    <p class="mt-4 text-center text-gray-600">회원이신가요? <a href="${ cl }/signin" class="text-blue-500 hover:underline">로그인하기</a></p>
	</div>
	
	<script>
		document.addEventListener("DOMContentLoaded", function() {
		    "use strict";
	
		    const email = document.querySelector("#useremail");
		    const password = document.querySelector("#userpassword");
		    const form = document.querySelector("form"); // 특정 폼 선택
	
		    const emailReg = /^[a-z0-9]+@[a-z]+\.(com|net|org)$/;
		    const passwordReg = /^(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$/;
	
		    form.addEventListener("submit", (e) => {
		        if (!(emailReg.test(email.value))) { // email.value로 수정
		            alert("유효하지 않는 이메일 형식입니다.");
		            console.log(email.value);
		            e.preventDefault(); // 폼 제출 방지
		        }
		        if (!(passwordReg.test(password.value))) { // password.value로 수정
		            alert("비밀번호는 다음을 충족해야 합니다:\n" +
		                  "- 최소 8자 이상\n" +
		                  "- 소문자 1개 이상\n" +
		                  "- 숫자 1개 이상");
		            console.log(password.value);
		            e.preventDefault(); // 폼 제출 방지
		        }
		    });
		});
	</script>

	<jsp:include page="/WEB-INF/common/footer.jsp" />
</body>
</html>