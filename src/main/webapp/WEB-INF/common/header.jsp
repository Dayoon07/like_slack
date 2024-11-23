<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="cl" value="${ pageContext.request.contextPath }" />
	<header class="bg-white shadow-md">
        <div class="max-w-7xl mx-auto px-4 py-4 flex justify-between items-center">
            <a href="${ cl }/"><h1 class="text-xl font-bold text-gray-800">이름추천</h1></a>
            <nav>
                <c:if test="${ empty user }">
                	<ul class="flex space-x-6">
						<li class="text-gray-600 cursor-pointer">
							<a href="${ cl }/search">
								<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192.904 192.904" width="24px" class="fill-black">
					            	<path d="m190.707 180.101-47.078-47.077c11.702-14.072 18.752-32.142 18.752-51.831C162.381 36.423 125.959 
					            		0 81.191 0 36.422 0 0 36.423 0 81.193c0 44.767 36.422 81.187 81.191 81.187 19.688 0 37.759-7.049 
					            		51.831-18.751l47.079 47.078a7.474 7.474 0 0 0 5.303 2.197 7.498 7.498 0 0 0 5.303-12.803zM15 81.193C15 
					            		44.694 44.693 15 81.191 15c36.497 0 66.189 29.694 66.189 66.193 0 36.496-29.692 66.187-66.189 66.187C44.693 
					            		147.38 15 117.689 15 81.193z">
					            	</path>
					          	</svg>
							</a>
						</li>
	                    <li>
	                    	<a href="${ cl }/signin" class="px-6 py-2 text-[15px] rounded-md font-semibold text-white 
	                    		border-2 border-[#007bff] bg-[#007bff] hover:bg-[#004bff]">로그인</a>
	                    </li>
	                    <li>
	                    	<a href="${ cl }/signup" class="px-4 py-2 text-[15px] rounded font-semibold text-[#007bff] border-2 border-[#007bff] 
	                    		hover:bg-[#007bff] transition-all ease-in-out duration-300 bg-transparent hover:text-white">회원가입</a>
	                    </li>
	                </ul>
                </c:if>
                <c:if test="${ not empty user }">
                	<div class="flex items-center">
                		<p class="mr-5 text-lg m-0 p-0">${ user.username }님</p>
                		<button type="button" class="m-0 p-0 text-3xl" onclick="mainSideOpen()">&#9776;</button>
                	</div>
					<ul class="fixed top-0 right-0 bg-white/80 border backdrop-blur-sm hidden w-80 pt-3 min-h-full space-y-4 text-black transform 
						translate-x-full transition-all duration-300 ease-out" id="mainSidebar">
						<li onclick="mainSideClose()" class="text-4xl pl-5 pb-2 flex items-center cursor-pointer transition-all ease-in-out duration-300 hover:bg-gray-200">
							&times;
						</li>
					    <li class="cursor-pointer transition-all ease-in-out duration-300 bg-transparent hover:bg-gray-200 p-2">
					        <a href="${ cl }/search" class="flex items-center space-x-2">
					            <span class="text-xl font-semibold">검색</span>
					            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192.904 192.904" width="24px" class="fill-white">
					                <path d="m190.707 180.101-47.078-47.077c11.702-14.072 18.752-32.142 18.752-51.831C162.381 36.423 125.959 0 
					                	81.191 0 36.422 0 0 36.423 0 81.193c0 44.767 36.422 81.187 81.191 81.187 19.688 0 37.759-7.049 
					                	51.831-18.751l47.079 47.078a7.474 7.474 0 0 0 5.303 2.197 7.498 7.498 0 0 0 5.303-12.803zM15 81.193C15 
					                	44.694 44.693 15 81.191 15c36.497 0 66.189 29.694 66.189 66.193 0 36.496-29.692 66.187-66.189 
					                	66.187C44.693 147.38 15 117.689 15 81.193z">
					                </path>
					            </svg>
					        </a>
					    </li>
					    <li class="cursor-pointer transition-all ease-in-out duration-300 hover:bg-gray-200 p-2">
					        <a href="${ cl }/profile/${ user.username }" class="flex items-center space-x-2">
					            <span class="text-xl font-semibold">프로필</span>
					        </a>
					    </li>
					    <li class="cursor-pointer transition-all ease-in-out duration-300 hover:bg-gray-200 p-2">
					        <a href="${ cl }/create" class="flex items-center space-x-2">
					            <span class="text-xl font-semibold">방 만들기</span>
					        </a>
					    </li>
					    <li class="cursor-pointer transition-all ease-in-out duration-300 hover:bg-gray-200 p-2">
					        <a href="${ cl }/myChatroom/${ user.userid }" class="flex items-center space-x-2">
					            <span class="text-xl font-semibold">내 채팅방</span>
					        </a>
					    </li>
					    <form action="${ cl }/logout" method="post" autocomplete="off" class="cursor-pointer">
					        <button type="submit" class="w-full text-center px-4 py-2 text-xl font-semibold text-white bg-red-500 hover:bg-red-700">
					            로그아웃
					        </button>
					    </form>
					</ul>
                </c:if>
            </nav>
        </div>
    </header>