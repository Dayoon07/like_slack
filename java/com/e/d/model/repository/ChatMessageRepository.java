package com.e.d.model.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.e.d.model.entity.ChatMessageEntity;

public interface ChatMessageRepository extends JpaRepository<ChatMessageEntity, Integer> {
	List<ChatMessageEntity> findByRoomid(int roomid);
}
