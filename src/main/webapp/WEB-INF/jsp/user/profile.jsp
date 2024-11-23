<%@page import="com.e.d.model.entity.ChatUserEntity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="cl" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>프로필 | ${ userProfile.username }</title>
	<style>
		 .modal {
            display: none; /* 기본적으로 모달을 숨김 */
        }
        .modal.flex {
            display: flex; /* flex로 설정하여 중앙 정렬 */
        }
        .hidden {
            display: none; /* 숨김 클래스 */
        }
	</style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp" />
	
	<c:if test="${ not empty userProfile }">
	    <c:if test="${ not empty sessionScope.user && userProfile.userid == sessionScope.user.userid }">
	    	<div class="mx-auto max-w-lg w-full border bg-white p-6 rounded-lg shadow-2xl" style="margin-top: 50px;">
		        <form action="${ cl }/updateUserInfo" method="post" autocomplete="off">
		        	<div class="flex items-center">
			            <div class="mb-3 flex">
			                <h2 class="text-2xl font-bold text-gray-800 mr-5">
			                	<input type="text" id="username" name="username" value="${ userProfile.username }"
			                		class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full 
			                		p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 
			                		dark:focus:border-blue-500" required>
			            	</h2>
			            </div>
			        </div>
			        <div class="flex items-center">
			            <div class="flex">
			                <h2 class="text-xl font-bold text-gray-800 mr-5">현재 상태 : ${ userProfile.status }</h2>
			            </div>
					</div>
					<ul role="list" class="divide-y divide-gray-100 mb-5">
				  		<li class="flex justify-between gap-x-6">
				    		<div class="flex min-w-0 gap-x-4">
								<div class="min-w-0 flex-auto">
				        			<p class="mt-1 truncate text-lg text-gray-500">
				        				<input type="text" id="useremail" name="useremail" value="${ userProfile.useremail }"
					                		class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full 
					                		p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 
					                		dark:focus:border-blue-500" required>
				        			</p>
				        			<p class="mt-1 truncate text-lg text-gray-500">${ userProfile.dateTime }</p>
				      			</div>
				    		</div>
				  		</li>
				  	</ul>
			        <div class="mb-4">
			            <p class="text-2xl text-gray-700 mt-4 pt-4 border-t-2 border-gray-500">
			            	<textarea name="userbio" id="userbio" rows="7" class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border 
			            		border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 
			            		dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 w-full resize-none" required>${ userProfile.userbio }</textarea>
			            </p>
			        </div>
			        <input type="hidden" name="userid" id="userid" value="${ userProfile.userid }" readonly required>
		            <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded transition duration-200">정보 수정</button>
		        </form>
		        <div class="flex justify-between mt-1">
		            <button id="openModal" class="bg-red-500 text-white p-2 px-4 rounded transition duration-200 ">
				        계정 삭제
				    </button>
				    <div id="myModal" class="modal fixed inset-0 bg-black bg-opacity-50 items-center justify-center">
				        <div class="bg-white rounded-lg shadow-lg w-96 mx-auto p-6">
				            <h2 class="text-xl font-bold mb-4">${ userProfile.username }님</h2>
				            <form action="${ cl }/userDelete/${ userProfile.userid }" method="post" autocomplete="off">
					            <p class="mb-4"><input type="hidden" id="userid" name="userid" value="${ userProfile.userid }" readonly required></p>
					            <p class="mb-4">계정을 삭제하시겠습니까?</p>
					            <div class="flex">
					            	<button type="button" id="closeModal" class="bg-blue-500 text-white p-2 px-4 rounded outline hover:outline-offset-2 transition duration-200 mr-5">
						                취소하기
						            </button>
					            	<button type="submit" class="bg-red-500 text-white p-2 rounded hover:bg-red-600 transition duration-200">
						                계정 삭제하기
						            </button>
				            	</div>
				            </form>
				        </div>
				    </div>
		        </div>
		    </div>
	    </c:if>
	    <c:if test="${ empty sessionScope.user || userProfile.userid != sessionScope.user.userid }">
	    	<div class="mx-auto max-w-2xl w-full bg-white p-6 rounded-lg shadow-2xl" style="margin-top: 50px;">
		        <div class="flex items-center"><div class="mb-3 flex"><h2 class="text-3xl font-bold text-gray-800 mr-5">${ userProfile.username }</h2></div></div>
		        <div class="flex items-center"><div class="flex"><h2 class="text-xl font-bold text-gray-800 mr-5">현재 상태 : ${ userProfile.status }</h2></div></div>
				<ul role="list" class="divide-y divide-gray-100 mb-5">
			  		<li class="flex justify-between gap-x-6">
			    		<div class="flex min-w-0 gap-x-4">
							<div class="min-w-0 flex-auto">
			        			<p class="mt-1 truncate text-lg text-gray-500">${ userProfile.useremail }</p>
			        			<p class="mt-1 truncate text-lg text-gray-500">${ userProfile.dateTime }</p>
			      			</div>
			    		</div>
			  		</li>
			  	</ul>
		        <div class="mb-4"><p class="text-2xl text-gray-700 mt-4 pt-4 border-t-2 border-gray-500">${ userProfile.userbio }</p></div>
		    </div>
	    </c:if>
	</c:if>
	
	<c:if test="${ empty userProfile }">
    	<p>사용자를 찾을 수 없습니다.</p>
	</c:if>
	
	<script>
		const modal = document.getElementById('myModal');
	    const openModalButton = document.getElementById('openModal');
	    const closeModalButton = document.getElementById('closeModal');
	
	    // 모달 열기
	    openModalButton.addEventListener('click', () => {
	        modal.classList.remove('hidden'); // 'hidden' 클래스를 제거하여 모달을 표시
	        modal.classList.add('flex'); // 모달을 flex로 설정하여 중앙 정렬
	    });
	
	    // 모달 닫기
	    closeModalButton.addEventListener('click', () => {
	        modal.classList.add('hidden'); // 'hidden' 클래스를 추가하여 모달을 숨김
	        modal.classList.remove('flex'); // 모달의 flex 속성 제거
	    });
	
	    // 모달 외부 클릭 시 닫기
	    modal.addEventListener('click', (e) => {
	        if (e.target === modal) { // 클릭한 요소가 모달인 경우
	            modal.classList.add('hidden');
	            modal.classList.remove('flex');
	        }
	    });
	</script>
	
	<jsp:include page="/WEB-INF/common/footer.jsp" />
</body>
</html>