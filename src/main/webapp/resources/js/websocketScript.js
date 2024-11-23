let websocket;
let username = loggedInUsername;

window.onload = () => {
    if (username) {
        openChatting();
    } else {
        alert("로그인 후 채팅방에 입장할 수 있습니다.");
        history.back();
    }
};

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
    const $div = document.createElement("div");

    $div.classList.add("flex", "mb-2", message.sender === username ? "justify-end" : "justify-start");

    const $p = document.createElement("p");

    if (message.sender === username) {
        $p.classList.add("p-2", "rounded-lg", "max-w-xl", "bg-gradient-to-r", "from-cyan-500", "to-blue-500", "text-white", "text-lg", "text-lg");
    } else {
        $p.classList.add("p-2", "rounded-lg", "max-w-xl", "bg-gray-200", "text-black", "font-semibold", "text-lg");
    }

    $p.innerText = message.data;
    $div.appendChild($p);
    $container.appendChild($div);

    $container.scrollTop = $container.scrollHeight;
}

function sendMessage(event) {
    event.preventDefault(); // 폼 제출 방지
    console.log("sendMessage 함수 호출됨");

    const messageInput = document.getElementById("chattext");
    const messageText = messageInput.value.trim();
    console.log("입력된 메시지:", messageText);

    if (messageText) {
        const msg = new Message("chat", username, '', messageText);
        console.log("전송할 메시지 객체:", msg);
        websocket.send(JSON.stringify(msg)); // WebSocket을 통해 메시지 전송
        messageInput.value = ''; // 입력창 초기화
    } else {
        console.log("메시지가 비어 있습니다.");
    }
}

// 유저 리스트를 갱신하는 함수
function updateUserList(userList) {
    const $userListContainer = document.getElementById("user-list-container");
    $userListContainer.innerHTML = '';  // 기존 리스트 비우기

    const users = userList.split(", ");
    users.forEach(user => {
        const $userItem = document.createElement("div");
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
    constructor(type, sender, receiver, data) {
        this.type = type;
        this.sender = sender;
        this.receiver = receiver;
        this.data = data;
    }
}
