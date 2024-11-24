package com.e.d.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.e.d.model.entity.ChatUserEntity;
import com.e.d.model.repository.ChatRoomRepository;
import com.e.d.model.repository.ChatUserRepository;

import jakarta.transaction.Transactional;

@Service
public class ChatUserService {
	
	@Autowired
	private ChatUserRepository userRepository;
	
	@Autowired
	private ChatRoomRepository roomRepository;
	
	 @Transactional
	    public void deleteUserAndRooms(int userid) {
	        ChatUserEntity user = userRepository.findById(userid)
	            .orElseThrow(() -> new IllegalArgumentException("Invalid user ID"));
	        
	        // ChatRoom 삭제
	        roomRepository.deleteByOwnername(user.getUsername());

	        // User 삭제
	        userRepository.delete(user);
	    }

}
