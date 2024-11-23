package com.e.d.model.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.e.d.model.entity.ChatRoomEntity;

@Repository
public interface ChatRoomRepository extends JpaRepository<ChatRoomEntity, Integer> {
	List<ChatRoomEntity> findByRoomid(int roomid);
	Page<ChatRoomEntity> findAll(Pageable pageable); 
	List<ChatRoomEntity> findByOwnername(String ownername);  // 방 소유자명으로 방 조회
	List<ChatRoomEntity> findByRoomnameAndOwnernameAndRoomid(String roomname, String ownername, String roomid);
}