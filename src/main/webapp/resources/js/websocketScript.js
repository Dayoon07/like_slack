let websocket;
let username = loggedInUsername;
let r = roomid;

// 1:1 채팅 모달 관련 변수
let chatWithUser = ''; // 현재 채팅 중인 사용자
let privateChatWebSocket; // 1:1 채팅을 위한 WebSocket

window.onload = () => {
    if (username) {
        openChatting();
		webInfo();
    } else {
        alert("로그인 후 채팅방에 입장할 수 있습니다.");
        history.back();
    }
};

function webInfo() {
	console.log(`채팅방의 pk : ${r} \n 서버 정보 :`);
	console.log(window.location);
}

const openChatting = () => {
    websocket = new WebSocket("ws://localhost:8080/ws/chatroom");

    websocket.onopen = () => {
        console.log("WebSocket 연결됨");
        const msg = new Message("enter", username, '', '');  // 입장 메시지 보내기
        websocket.send(JSON.stringify(msg));
    };

    websocket.onmessage = (msg) => {
        const message = JSON.parse(msg.data);
        switch (message.type) {
            case "enter":
                appendEnterMessage(message);
                break;
            case "chat":
                appendMessage(message);
                break;
            case "exit":
                exitChatRoom(message);
                break;
            case "userList":
                updateUserList(message.data);
                break;
        }
    };
};

function appendEnterMessage(message) {
    const $container = document.getElementById("message-container");
    const $div = document.createElement("div");

    $div.classList.add("flex", "mb-2", "justify-center");  // 입장 메시지는 중앙에 표시

    const $p = document.createElement("p");
    $p.classList.add("text-xl", "font-bold", "text-green-500");  // 입장 메시지 스타일

    $p.innerText = message.data;  // message.data에 사용자 입장 메시지가 포함됨
    $div.appendChild($p);
    $container.appendChild($div);

    $container.scrollTop = $container.scrollHeight;
}

function appendMessage(message) {
    const $container = document.getElementById("message-container");

    // 메시지 전체 영역
    const $messageWrapper = document.createElement("div");
    $messageWrapper.classList.add("flex", "items-start", "mb-4");
    if (message.sender === username) {
        $messageWrapper.classList.add("justify-end");
    } else {
        $messageWrapper.classList.add("justify-start");
    }

    // 프로필 이미지 영역 (슬랙 스타일을 위해 필요)
    if (message.sender !== username) {
        const $profileDiv = document.createElement("div");
        $profileDiv.classList.add("w-10", "h-10", "rounded-full", "bg-gray-300", "flex", "items-center", "justify-center", "mr-3");

        const $profileText = document.createElement("span");
        $profileText.classList.add("text-lg", "font-bold", "text-white");
        $profileText.innerText = message.sender[0].toUpperCase(); // 이름 첫 글자
        $profileDiv.appendChild($profileText);
        $messageWrapper.appendChild($profileDiv);
    }

    // 메시지 내용 영역
    const $contentDiv = document.createElement("div");
    $contentDiv.classList.add("flex", "flex-col", "max-w-xl", "space-y-1");

    // 사용자 이름과 시간
    const $headerDiv = document.createElement("div");
    $headerDiv.classList.add("flex", "items-center", "space-x-2");

    const $username = document.createElement("span");
    $username.classList.add("font-bold", "text-gray-800");
    $username.innerText = message.sender;

    const $time = document.createElement("span");
    $time.classList.add("text-sm", "text-gray-500");
    $time.innerText = `[${message.time}]`;

    $headerDiv.appendChild($username);
    $headerDiv.appendChild($time);

    // 메시지 본문
    const $messageText = document.createElement("p");

    // 메시지 스타일 설정 (조건적으로 클래스 적용)
    if (message.sender === username) {
        $messageText.classList.add(
            "p-2",
            "rounded-lg",
            "max-w-xl",
            "text-lg",
            "font-semibold",
            "bg-gradient-to-r",
            "from-cyan-500",
            "to-blue-500",
            "text-white"
        );
    } else {
        $messageText.classList.add(
            "p-2",
            "rounded-lg",
            "max-w-xl",
            "text-lg",
            "font-semibold",
            "bg-gray-200",
            "text-black"
        );
    }
    $messageText.innerText = message.data;

    // 구성 요소 조립
    $contentDiv.appendChild($headerDiv);
    $contentDiv.appendChild($messageText);
    $messageWrapper.appendChild($contentDiv);
    $container.appendChild($messageWrapper);

    // 스크롤 조정
    $container.scrollTop = $container.scrollHeight;
}

function sendMessage(event) {
    event.preventDefault(); // 폼 제출 방지
    console.log("sendMessage 함수 호출됨");

    const messageInput = document.getElementById("chattext");
    const messageText = messageInput.value.trim();
    console.log("입력된 메시지:", messageText);

    if (messageText) {
        const now = new Date();
        const time = now.toLocaleTimeString();  // 현재 시간을 HH:MM:SS 형식으로 가져옴
        const msg = new Message("chat", username, '', messageText, time);
        console.log("전송할 메시지 객체:", msg);
        websocket.send(JSON.stringify(msg)); // WebSocket을 통해 메시지 전송
        messageInput.value = ''; // 입력창 초기화
    } else {
        console.log("메시지가 비어 있습니다.");
    }
}

// 사용자 리스트를 갱신하는 함수 (수정)
function updateUserList(userList) {
    const $userListContainer = document.getElementById("user-list-container");
    $userListContainer.innerHTML = '';  // 기존 리스트 비우기

    const users = userList.split(", ");
	const userCount = users.length;
	document.getElementById("userCount").innerHTML = userCount;
	
    users.forEach(user => {
        const $userItem = document.createElement("div");
		
		$userItem.classList.add("w-full", "h-10", "px-2", "px-5", "text-lg", "bg-gray-900",
			"text-white", "rounded-lg", "flex", "items-center", "hover:bg-gray-700", "cursor-pointer"
		);
		
		$userItem.innerText = user;
        $userListContainer.appendChild($userItem);
    });
}

window.onbeforeunload = () => {
    if (websocket && websocket.readyState === WebSocket.OPEN) {
        const msg = new Message("exit", username, '', `${username}님이 퇴장하셨습니다.`);
        websocket.send(JSON.stringify(msg));
        websocket.close();
    }
};

function leaveChatRoom() {
    if (websocket && websocket.readyState === WebSocket.OPEN) {
        const msg = new Message("exit", username, '', `${username}님이 채팅방을 떠났습니다.`);
        websocket.send(JSON.stringify(msg));
        websocket.close();
    }
    exitChatRoom({ data: `${username}님이 채팅방을 떠났습니다.` });
    window.location.href = "/";
    alert(`${roomid}번 방을 나갔습니다.`);
}

function exitChatRoom(message) {
    const $container = document.getElementById("message-container");
    const $div = document.createElement("div");

    $div.classList.add("flex", "mb-2", "justify-center");

    const $p = document.createElement("p");
    $p.classList.add("p-2", "rounded-lg", "max-w-xl", "text-red-600", "font-bold", "text-lg");

    $p.innerText = message.data;
    $div.appendChild($p);
    $container.appendChild($div);

    $container.scrollTop = $container.scrollHeight;
}

class Message {
    constructor(type, sender, receiver, data, time) {
        this.type = type;
        this.sender = sender;
        this.receiver = receiver;
        this.data = data;
		this.time = time;
    }
}
