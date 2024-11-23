package com.e.d.config;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.e.d.model.entity.ChatMessageEntity;
import com.e.d.model.repository.ChatMessageRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class WebSocketHandler extends TextWebSocketHandler {

    private ObjectMapper mapper = new ObjectMapper().registerModule(new JavaTimeModule());  // LocalDateTime 직렬화/역직렬화 처리
    // 방별로 클라이언트 연결을 관리하는 Map
    private Map<Integer, Map<String, WebSocketSession>> roomClients = new HashMap<>();
    // 방별로 유저 목록을 관리하는 Map
    private Map<Integer, Set<String>> roomUsers = new HashMap<>();
    
    private ChatMessageRepository chatMessageRepository;

    public WebSocketHandler(ChatMessageRepository chatMessageRepository) {
        this.chatMessageRepository = chatMessageRepository;
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        log.info("클라이언트 접속! " + session.getId() + "가 접속함");
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        log.info("수신된 메시지 : " + message.getPayload());
        ChatMessageEntity msg = mapper.readValue(message.getPayload(), ChatMessageEntity.class);

        switch (msg.getType()) {
            case "enter":
                addClientToRoom(session, msg);  // 클라이언트 입장 처리
                break;
            case "chat":
                saveMessageAndBroadcast(msg);  // 채팅 메시지 전송 및 DB 저장
                break;
            case "exit":
                removeClientFromRoom(session, msg);  // 클라이언트 나가기 처리
                break;
        }
    }

    // 클라이언트 입장 처리
    private void addClientToRoom(WebSocketSession session, ChatMessageEntity msg) {
        int roomid = msg.getRoomid();
        roomClients.putIfAbsent(roomid, new HashMap<>());
        roomUsers.putIfAbsent(roomid, new HashSet<>());
        
        roomClients.get(roomid).put(msg.getSender(), session);
        roomUsers.get(roomid).add(msg.getSender());  // 유저 리스트에 추가
        
        msg.setData(msg.getSender() + "님이 입장하셨습니다.");
        broadcastSend(roomid, msg);  // 입장 메시지 전송
        
        sendUserList(roomid);  // 입장 후 유저 리스트 전송
    }

    // 채팅 메시지 저장 및 브로드캐스트
    private void saveMessageAndBroadcast(ChatMessageEntity msg) {
        // 채팅 내용이 msg.getData()에 들어 있는지 확인하고 사용
        if (msg.getData() == null || msg.getData().trim().isEmpty()) {
            log.error("메시지 내용이 비어 있습니다.");
            return; // 비어있는 메시지는 저장하지 않음
        }

        msg.setDateTime(LocalDateTime.now());
        log.info("저장할 메시지: " + msg);

        try {
            chatMessageRepository.save(msg); // DB에 메시지 저장
            log.info("메시지가 DB에 저장되었습니다.");
        } catch (Exception e) {
            log.error("DB에 메시지 저장 중 오류 발생: " + e.getMessage());
        }

        broadcastSend(msg.getRoomid(), msg);
    }

    // 클라이언트 퇴장 처리
    private void removeClientFromRoom(WebSocketSession session, ChatMessageEntity msg) {
        String username = null;
        int roomId = msg.getRoomid();

        // 나간 사용자를 확인하고 해당 사용자 이름을 가져오기
        Map<String, WebSocketSession> clientsInRoom = roomClients.get(roomId);
        for (Map.Entry<String, WebSocketSession> entry : clientsInRoom.entrySet()) {
            if (entry.getValue().equals(session)) {
                username = entry.getKey();
                clientsInRoom.remove(entry.getKey());
                break;
            }
        }

        if (username != null) {
            // 사용자가 나갔다는 메시지를 생성
            msg.setType("exit");
            msg.setSender("System");
            msg.setData(username + " 님이 나갔습니다.");

            // 나간 사용자에 대한 메시지 브로드캐스트
            broadcastSend(roomId, msg);

            // 유저 리스트에서 해당 사용자 제거
            roomUsers.get(roomId).remove(username);
            sendUserList(roomId);  // 유저 리스트 전송
        }
    }

    // 메시지를 채팅방에 있는 모든 클라이언트에게 브로드캐스트하는 메서드
    public void broadcastSend(int roomId, ChatMessageEntity message) {
        Map<String, WebSocketSession> clientsInRoom = roomClients.get(roomId);
        if (clientsInRoom != null) {
            for (WebSocketSession client : clientsInRoom.values()) {
                try {
                    TextMessage sendMsg = new TextMessage(mapper.writeValueAsString(message));
                    client.sendMessage(sendMsg);  // 클라이언트에게 메시지 전송
                } catch (Exception e) {
                    log.error("Error sending message to client: " + e.getMessage());
                }
            }
        }
    }

    // 유저 리스트를 클라이언트에 전송
    private void sendUserList(int roomId) {
        Set<String> users = roomUsers.get(roomId);
        if (users != null) {
            ChatMessageEntity userListMessage = new ChatMessageEntity();
            userListMessage.setType("userList");
            userListMessage.setRoomid(roomId);
            userListMessage.setData(String.join(", ", users)); // 유저 리스트를 문자열로 변환
            
            // 모든 클라이언트에 유저 리스트 전송
            broadcastSend(roomId, userListMessage);
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        roomClients.values().forEach(clientsInRoom -> clientsInRoom.values().remove(session));
        super.afterConnectionClosed(session, status);
    }
}
