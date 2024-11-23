document.addEventListener("DOMContentLoaded", () => {
	"use strict";
	roomnameFormat();
});

let sidebarOpen = false;

function toggleSidebar() {
    const sidebar = document.getElementById("sidebar");
    const mainContent = document.getElementById("main-content");
    sidebar.classList.toggle("-translate-x-full");
    sidebarOpen = !sidebarOpen;
    if (sidebarOpen) {
        mainContent.style.marginLeft = "16rem"; // Sidebar 너비에 맞게 조정
    } else {
        mainContent.style.marginLeft = "0";
    }
}

document.addEventListener("DOMContentLoaded", () => {
    if (!sidebarOpen) {
        toggleSidebar(); // 페이지 로드 시 사이드바 자동으로 열기
    }
});

function mainSideOpen() {
	const sidebar = document.getElementById('mainSidebar');
	sidebar.classList.remove('hidden', 'translate-x-full');
}
function mainSideClose() {
	const sidebar = document.getElementById('mainSidebar');
	sidebar.classList.add('hidden', 'translate-x-full');
}

const roomnameFormat = () => {
	const chatroomname = document.getElementById("chatroomname");
	var ww = window.innerWidth;
	if (ww < 500) {
		chatroomname.innerHTML = "";
	}
}